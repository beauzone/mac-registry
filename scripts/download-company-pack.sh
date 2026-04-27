#!/bin/bash
# Downloads a company pack from the mac-registry
# Usage: download-company-pack.sh <company-id> [--token <token>]
#
# The token is read from ~/.claude/mac/registry-token if not passed on the CLI.
# On success, the pack is installed to ~/.claude/mac/companies/<company-id>/
# and a .registry-meta.yaml sidecar is written.

set -e

COMPANY_ID="$1"
TOKEN=""

# Parse optional --token flag
shift || true
while [[ $# -gt 0 ]]; do
  case "$1" in
    --token) TOKEN="$2"; shift 2 ;;
    *) shift ;;
  esac
done

# Fall back to stored token
if [ -z "$TOKEN" ]; then
  TOKEN_FILE="$HOME/.claude/mac/registry-token"
  if [ -f "$TOKEN_FILE" ]; then
    TOKEN=$(cat "$TOKEN_FILE")
  fi
fi

if [ -z "$COMPANY_ID" ]; then
  echo "Usage: download-company-pack.sh <company-id> [--token <token>]"
  exit 1
fi

if [ -z "$TOKEN" ]; then
  echo "Error: No registry token found. Store your token at ~/.claude/mac/registry-token"
  echo "       or pass it with --token <token>"
  exit 1
fi

REPO="beauzone/mac-registry"
BASE_PATH="company-packs/$COMPANY_ID"
DEST="$HOME/.claude/mac/companies/$COMPANY_ID"
API_BASE="https://api.github.com/repos/$REPO/contents"

echo "Downloading company pack: $COMPANY_ID"
echo "Source: $REPO/$BASE_PATH"
echo "Destination: $DEST"
echo ""

# Validate token before proceeding
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" \
  -H "Authorization: Bearer $TOKEN" \
  "https://api.github.com/repos/$REPO")
if [ "$HTTP_STATUS" != "200" ]; then
  echo "Error: Token validation failed (HTTP $HTTP_STATUS)."
  echo "Check that your token has Contents read access to $REPO."
  exit 1
fi

mkdir -p "$DEST"

# Recursively download a directory from the GitHub Contents API
download_dir() {
  local api_path="$1"
  local local_base="$2"

  local contents
  contents=$(curl -sf \
    -H "Authorization: Bearer $TOKEN" \
    -H "Accept: application/vnd.github+json" \
    "$API_BASE/$api_path") || {
    echo "  ✗ Failed to list $api_path"
    return 1
  }

  # Parse items with python3 (available on macOS and most Linux)
  echo "$contents" | python3 - <<'PYEOF' "$BASE_PATH" "$local_base" "$TOKEN" "$API_BASE"
import json, sys, os, subprocess

base_path = sys.argv[1]
local_base = sys.argv[2]
token = sys.argv[3]
api_base = sys.argv[4]

items = json.load(sys.stdin)
if not isinstance(items, list):
    print(f"ERROR: {json.dumps(items)}", file=sys.stderr)
    sys.exit(1)

for item in items:
    rel_path = item["path"].replace(base_path + "/", "", 1)
    local_path = os.path.join(local_base, rel_path)
    if item["type"] == "dir":
        os.makedirs(local_path, exist_ok=True)
        # Recurse: shell out to list the subdir
        result = subprocess.run(
            ["curl", "-sf",
             "-H", f"Authorization: Bearer {token}",
             "-H", "Accept: application/vnd.github+json",
             f"{api_base}/{item['path']}"],
            capture_output=True, text=True
        )
        sub_items = json.loads(result.stdout)
        for sub in sub_items:
            sub_rel = sub["path"].replace(base_path + "/", "", 1)
            sub_local = os.path.join(local_base, sub_rel)
            if sub["type"] == "dir":
                os.makedirs(sub_local, exist_ok=True)
            elif sub["type"] == "file":
                os.makedirs(os.path.dirname(sub_local), exist_ok=True)
                print(f"  ↓ {sub_rel}")
                dl = subprocess.run(
                    ["curl", "-sf",
                     "-H", f"Authorization: Bearer {token}",
                     "-H", "Accept: application/vnd.github.raw",
                     f"{api_base}/{sub['path']}"],
                    capture_output=True
                )
                with open(sub_local, "wb") as f:
                    f.write(dl.stdout)
    elif item["type"] == "file":
        os.makedirs(os.path.dirname(local_path) or ".", exist_ok=True)
        print(f"  ↓ {rel_path}")
        dl = subprocess.run(
            ["curl", "-sf",
             "-H", f"Authorization: Bearer {token}",
             "-H", "Accept: application/vnd.github.raw",
             f"{api_base}/{item['path']}"],
            capture_output=True
        )
        with open(local_path, "wb") as f:
            f.write(dl.stdout)
PYEOF
}

# Fetch manifest to get the installed version
MANIFEST_JSON=$(curl -sf \
  -H "Authorization: Bearer $TOKEN" \
  -H "Accept: application/vnd.github.raw" \
  "$API_BASE/company-packs/manifest.yaml") || MANIFEST_JSON=""

REGISTRY_VERSION="unknown"
if [ -n "$MANIFEST_JSON" ]; then
  REGISTRY_VERSION=$(echo "$MANIFEST_JSON" | python3 -c "
import sys, re
content = sys.stdin.read()
# Find the version for our company
in_pack = False
for line in content.splitlines():
    if f'id: $COMPANY_ID' in line or f\"id: '$COMPANY_ID'\" in line:
        in_pack = True
    if in_pack and 'version:' in line:
        m = re.search(r'version:\s*[\"\\']?([\\d.]+)[\"\\']?', line)
        if m:
            print(m.group(1))
            break
" 2>/dev/null || echo "unknown")
fi

download_dir "$BASE_PATH" "$DEST"

# Write registry metadata sidecar
cat > "$DEST/.registry-meta.yaml" << EOF
registry:
  source: $REPO
  installed_at: "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  installed_version: "$REGISTRY_VERSION"
  manifest_version: "1.0.0"
  last_update_check: "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
EOF

echo ""
echo "✓ Company pack '$COMPANY_ID' installed to $DEST"
echo "  Version: $REGISTRY_VERSION"
