#!/usr/bin/env python3
"""
Updates skill version and updated_at in registry-manifest.yaml
to match the version declared in a SKILL.md.

Usage:
    python3 update-skill-version.py --skill gtm_strategist --version 2.0.1 --date 2026-04-23
    python3 update-skill-version.py --skill b2b_gtm_strategist --version 2.3.1 --date 2026-04-23
"""

import argparse
import re
from pathlib import Path

MANIFEST_PATH = Path("config/registry-manifest.yaml")


def update_manifest(skill_key: str, version: str, date: str) -> None:
    content = MANIFEST_PATH.read_text()

    # Match the skill block: skills:\n  <skill_key>:\n    version: "x.y.z"\n    updated_at: "..."
    updated = re.sub(
        rf'(skills:\s*\n(?:.*\n)*?\s+{re.escape(skill_key)}:\s*\n(?:.*\n)*?\s+version:\s*")([^"]+)(")',
        lambda m: m.group(1) + version + m.group(3),
        content,
        count=1
    )
    updated = re.sub(
        rf'(skills:\s*\n(?:.*\n)*?\s+{re.escape(skill_key)}:\s*\n(?:.*\n)*?\s+updated_at:\s*")([^"]+)(")',
        lambda m: m.group(1) + date + m.group(3),
        updated,
        count=1
    )

    if updated == content:
        print(f"WARNING: No changes made — skill key '{skill_key}' not found or already up to date.")
    else:
        MANIFEST_PATH.write_text(updated)
        print(f"Updated manifest: skills.{skill_key}.version={version}, updated_at={date}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--skill", required=True, choices=["gtm_strategist", "b2b_gtm_strategist"],
                        help="Skill key in the manifest skills: map")
    parser.add_argument("--version", required=True)
    parser.add_argument("--date", required=True)
    args = parser.parse_args()
    update_manifest(args.skill, args.version, args.date)
