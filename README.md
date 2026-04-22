# mac-registry

Public distribution registry for Marketing as Code — a reference architecture that applies software engineering principles to AI-native marketing operations.

## What this is

This registry distributes the public system-level assets that power the B2B GTM Strategist skill and other MaC-compatible tools. Assets are automatically synced here from the private MaC development repository whenever changes are made.

## What's in this registry

| Directory | Contents |
| --- | --- |
| `frameworks/system/` | 51 analytical B2B GTM frameworks |
| `personas/` | 41+ B2B SME buyer personas (Cybersecurity, IT, Anti-fraud, Marketing, Governance, Regulated Industries) |
| `templates/system/` | 15 document templates (board decks, battlecards, messaging frameworks, etc.) |
| `writer-profiles/system/` | 12 system writer profiles (literary archetypes, communication archetypes, use-case profiles) |
| `schemas/` | Schema definitions for personas, frameworks, products, and writer profiles |
| `config/` | Registry manifest — authoritative asset catalog consumed by skills at runtime |

## Who uses this

- B2B GTM Strategist Claude Skill — fetches frameworks, personas, templates, and writer profiles from this registry at session start
- MaC-compatible tools — any tool that reads the registry manifest at `config/registry-manifest.yaml`

## What is NOT here

Company-specific data never appears in this registry:

- Company brand specs, messaging, or product catalogs
- Individual writer profiles (always private)
- Generated content artifacts
- Marketing Decision Records (MDRs)
- Application code

## Sync

Assets are pushed here automatically by the `sync-to-registry` GitHub Actions workflow in the private MaC development repository on every push to `main`.
