---
name: document-creator
version: 1.5.1
description: "DEPRECATED — This skill has been renamed and upgraded to mac-content-creator v2.0.0. Please update your installation."
---

<!--
SKILL_VERSION: 1.5.1
SKILL_UPDATED: 2026-04-25
DEPRECATED: true
SUPERSEDED_BY: mac-content-creator
-->

# Document Creator — DEPRECATED

> ⚠️ **This skill has been renamed and upgraded.**
>
> **document-creator** is now **MaC Content Creator v2.0.0**
>
> **What's new in v2.0.0:**
> - Shared company pack path: reads brand context from `~/.claude/mac/companies/`
> - MaC MCP server detection: uses governed brand context if connected
> - Full MaC schema support: company.yaml + brand specs + audiences
> - Writer profile voice calibration
> - Registry self-update on session start
> - All v1.5.0 functionality preserved (templates, icons, Remotion, OOXML)
>
> **To install the updated skill:**
> ```
> # Download the new skill from the registry:
> # https://raw.githubusercontent.com/beauzone/mac-registry/main/skills/user/mac-content-creator/SKILL.md
> # Save to: ~/.claude/skills/mac-content-creator/SKILL.md
> ```
>
> **To migrate your company packs:**
> ```bash
> cp -r ~/.claude/skills/document-creator/companies/ ~/.claude/mac/companies/
> ```
> Your existing brand packs (including Kymata) are fully supported in the new skill
> via backward-compatible `brand-pack.yaml` format.

## This skill still works during transition

All document creation features from v1.5.0 continue to function. You do not need to
migrate immediately. However, new features (MaC schema support, writer profiles, MCP
integration) are only available in mac-content-creator.

## Operating model

### Inputs
- **deliverable type**: pptx | docx | xlsx | pdf | md | txt | rtf | video (remotion)
- **content**: outline, draft text, tables/data, or an upstream spec
- **brand context** (optional): company name or company_id

### Multi-company precedence
1) `companies/<company_id>/brand-pack/`
2) `user/brand-pack/`
3) `system/brand-pack/`

### Renderers
See mac-content-creator for full renderer documentation. All renderers (PPTX, DOCX,
XLSX, PDF, Remotion video, icon system) work identically in this version.
