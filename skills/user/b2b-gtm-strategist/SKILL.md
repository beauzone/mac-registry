---
name: b2b-gtm-strategist
version: 2.3.0
deprecated: true
superseded_by: gtm-strategist
---
<!--
SKILL_VERSION: 2.3.0
SKILL_UPDATED: 2026-04-23
DEPRECATED: true
SUPERSEDED_BY: gtm-strategist@2.0.0
-->

# B2B GTM Strategist (Deprecated)

> **NOTICE — Consolidated into GTM Strategist v2.0.0**
>
> This skill has been superseded by the unified **GTM Strategist** (v2.0.0), which combines all B2B capabilities with full B2C coverage (DTC, marketplace, subscription, omnichannel, retail) in a single skill.
>
> **Install the unified skill:**
> ```bash
> mkdir -p ~/.claude/skills/gtm-strategist/references
> curl -sL https://raw.githubusercontent.com/beauzone/mac-registry/main/skills/user/gtm-strategist/SKILL.md \
>   -o ~/.claude/skills/gtm-strategist/SKILL.md
> ```
>
> **Your brand packs migrate automatically.** The unified skill checks `~/.claude/skills/gtm-strategist/companies/` first, then falls back to `~/.claude/skills/b2b-gtm-strategist/companies/` — so existing brand packs continue to work during transition.
>
> **This skill will continue to function normally** during the transition period. No action required until you're ready to switch.

---

## What's New in GTM Strategist v2.0.0

- **B2C domain coverage** — DTC, consumer apps, subscription, marketplace, retail, omnichannel
- **29 new B2C frameworks** across consumer acquisition, brand experience, commerce/channel, consumer insights, and retention/lifecycle
- **Three-type persona system** — B2B Buyer Personas + B2C Operator Personas + Consumer Archetypes
- **Dual-track stage model** — B2B Track (Pre-seed → Enterprise) + B2C Track (Pre-Launch → Mature)
- **Hybrid business model support** — marketplace, platform, freemium with dual audiences
- **Automatic domain detection** — Q5 determines B2B/B2C/Hybrid; all routing adjusts accordingly
- **Unified reference library** — all frameworks, personas, templates, and chaining sequences in one skill

---

## Migration Guide

### Brand Pack Migration (Automatic Fallback)

Your existing brand packs at `~/.claude/skills/b2b-gtm-strategist/companies/` continue to work. The unified skill checks both locations:

1. `~/.claude/skills/gtm-strategist/companies/{company_id}/` (new location)
2. `~/.claude/skills/b2b-gtm-strategist/companies/{company_id}/` (fallback — current location)

When you're ready to consolidate:
```bash
mv ~/.claude/skills/b2b-gtm-strategist/companies/* ~/.claude/skills/gtm-strategist/companies/
```

### Invoking the New Skill

Replace `/b2b-gtm-strategist` with `/gtm-strategist`. The intake questionnaire is identical through Q4; Q5 adds the business model question that routes B2B vs B2C analysis.

---

## Full B2B Functionality (Unchanged)

All B2B GTM Strategist capabilities are preserved in the unified skill:

- 51 B2B strategy frameworks across 6 categories (positioning, GTM motions, competitive, revenue, messaging, governance)
- 44 B2B buyer personas (b2b-tech) + 42 marketing department personas
- 30 governance/compliance personas (governance-legal, regulated-industries, governance-audit)
- 18 anti-fraud personas
- 14 B2B templates (board deck, exec memo, quarterly strategy, messaging workbook, etc.)
- Gartner chaining sequences (Positioning Path, GTM Path, Proof & Brand Path)
- Stage-specific guidance (Pre-seed through Enterprise)
- Brand pack system with company-specific context

---

## This Skill Will Stop Receiving Updates

`b2b-gtm-strategist` will not receive new frameworks, personas, or feature updates. All future development is in `gtm-strategist`.

---

*B2B GTM Strategist v2.3.0 — Final release. Superseded by GTM Strategist v2.0.0.*
