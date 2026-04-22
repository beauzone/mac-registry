# mac-registry

Public distribution registry for [Marketing as Code](https://github.com/beauzone/marketing-as-code) — a reference architecture that applies software engineering principles to AI-native marketing operations.

## What this is

This registry distributes the public system-level assets that power the B2B GTM Strategist skill and other MaC-compatible tools. Assets are automatically synced here from the private MaC development repository whenever changes are made to `main`.

## Contents

| Directory | Contents |
|---|---|
| `frameworks/system/` | 51 analytical B2B GTM frameworks |
| `personas/` | 41+ B2B SME buyer personas (Cybersecurity, IT, Anti-fraud, Marketing, Governance, Regulated Industries) |
| `templates/system/` | 15 document templates (board decks, battlecards, messaging frameworks, and more) |
| `writer-profiles/system/` | 12 system writer profiles — literary archetypes, communication archetypes, use-case profiles |
| `schemas/` | Schema definitions for personas, frameworks, products, and writer profiles |
| `config/` | Registry manifest — authoritative asset catalog consumed by skills at runtime |

## Who uses this

- **B2B GTM Strategist Claude Skill (v2.1.0+)** — fetches frameworks, personas, templates, and writer profiles from this registry at session start via `config/registry-manifest.yaml`
- **MaC-compatible tools** — any tool that reads the registry manifest

## Remote base URL

Skills and tools reference assets using:
```
https://raw.githubusercontent.com/beauzone/mac-registry/main
```

## What is NOT here

Company-specific data never appears in this registry:
- Company brand specs, messaging, or product catalogs
- Individual writer profiles (always private to the company/user)
- Generated content artifacts
- Marketing Decision Records (MDRs)
- Application code
- B2C personas (distributed via the B2C GTM Strategist skill separately)

## Sync

Assets are pushed here automatically by the `sync-to-registry` GitHub Actions workflow in the private `beauzone/marketing-as-code` development repository on every push to `main` that affects the synced directories.

## License

Assets in this registry are released under the MIT License unless otherwise noted in the individual file.
