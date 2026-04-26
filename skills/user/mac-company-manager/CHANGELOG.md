# Changelog — MaC Company Manager

## v1.0.0 — 2026-04-25

Initial release.

**What's included:**

- **SKILL.md** — Full company onboarding skill (§0–§12)
  - Session startup: self-update check, MaC MCP detection, installed pack scan,
    legacy pack detection (kymata-document-creator, b2b-gtm-strategist,
    gtm-strategist paths)
  - 8-phase company creation flow: identity, brand, messaging, audiences,
    research, templates, writer profiles, finalization
  - Brand pack export with parent company_id reference
  - Collision handling: version comparison, no silent overwrite
  - Update workflows: re-run specific interview sections, version increment
  - Template conversion: PPTX → manifest.json + content-schema.json + copy-prompt.md
  - PDF brand guidelines extraction → visual-identity.yaml draft
  - Legacy migration: brand-pack.yaml field mapping to MaC schema structure
  - Validation: required files, schema compliance, cross-reference integrity
  - Sync/refresh/offline asset management

- **scripts/extract_pptx_template.py** — PPTX template extraction script
  - Reads all slides using python-pptx
  - Extracts text shapes, image placeholders, tables
  - Calculates max_chars from physical dimensions and font size
  - Generates manifest.json, content-schema.json, copy-prompt.md
  - Copies source PPTX alongside generated specs

- **scripts/extract_brand_from_pdf.py** — PDF brand guidelines extractor
  - Extracts hex colors, RGB values, Pantone references
  - Detects font families from common font name list
  - Extracts logo usage rules and clear space specifications
  - Generates draft visual-identity.yaml for review

- **references/schema-summary.md** — Quick reference for all MaC schema fields
  - Covers: company.yaml, voice.yaml, tone-guidelines.yaml, terminology.yaml,
    visual-identity.yaml, positioning-framework.yaml, messaging-pillars.yaml,
    value-propositions.yaml, proof-points.yaml, competitive-positioning.yaml,
    icp.yaml, persona.yaml, writer-profile.yaml, pack.yaml
