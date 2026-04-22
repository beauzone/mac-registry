# Agent Instructions — mac-registry

This file instructs AI agents (Claude Code, Copilot, and others) on the rules
for working in this repository. Read this file before making any changes.

---

## General Rules

- Never commit directly to `main`. Use a branch and PR unless explicitly
  instructed otherwise by the user.
- Always run a YAML validity check before committing any `.yaml` file.
- Never delete existing content unless explicitly instructed.
- Preserve all comments in YAML files — they are load-bearing documentation.

---

## SKILL.md Versioning — REQUIRED

The file `skills/user/b2b-gtm-strategist/SKILL.md` contains a version comment
near the top of the file:

```
<!--
SKILL_VERSION: 1.0.0
SKILL_UPDATED: 2026-04-22
-->
```

### Rules

1. **Any commit that modifies `SKILL.md` MUST include a version bump.**
   Do not commit changes to `SKILL.md` without updating `SKILL_VERSION`.

2. **Follow semver rules for the bump type:**

   | Change type | Bump | Example |
   |---|---|---|
   | New section, major rewrite, structural change | MINOR | 1.0.0 → 1.1.0 |
   | Copy fix, typo, clarification, small addition | PATCH | 1.0.0 → 1.0.1 |
   | Breaking change to skill behavior or schema | MAJOR | 1.0.0 → 2.0.0 |

3. **Also update `SKILL_UPDATED`** to today's date in `YYYY-MM-DD` format.

4. **You do NOT need to manually update `registry-manifest.yaml`.**
   The GitHub Action `sync-skill-version.yml` reads the new `SKILL_VERSION`
   from `SKILL.md` and updates the manifest automatically after your push.

### Example — correct commit

```
<!--
SKILL_VERSION: 1.1.0
SKILL_UPDATED: 2026-05-01
-->
```

Commit message: `feat: add §18 competitive intelligence auto-research mode`

### What happens if you forget

A GitHub Action safety net will detect the missing bump and auto-apply a
patch version increment. Your changes will still ship, but the auto-bump
commit will appear in the history. Bump it yourself to keep the log clean.

---

## registry-manifest.yaml Rules

- The `skill:` block near the top of the manifest is auto-maintained by
  GitHub Actions. Do not edit `skill.version` or `skill.updated_at` manually.
- Asset entries (`frameworks`, `personas`, `templates`, `writer_profiles_system`)
  each have `version` and `updated_at` fields. Bump these when you update the
  corresponding asset YAML file. Follow the same semver rules as above.
- Never remove the versioning comment block at the top of the manifest.

---

## Adding New Assets

When adding a new asset (framework, persona, template, writer profile):

1. Add the YAML file to the correct directory
2. Add the entry to `registry-manifest.yaml` under the correct family
3. Include `version: "1.0.0"` and `updated_at: "YYYY-MM-DD"` in the entry
4. Bump `manifest.version` by a MINOR version (e.g. `0.2.0` → `0.3.0`)
5. Update `manifest.last_updated` to today's date

---

## Commit Message Convention

```
type: short description

Types: feat | fix | chore | docs | refactor
Examples:
  feat: add cybersecurity-devsecops persona
  fix: correct positioning framework section headers
  chore: bump SKILL_VERSION to 1.1.0
  docs: update AGENTS.md versioning rules
```
