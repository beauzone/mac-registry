#!/usr/bin/env python3
"""
Updates skill.version and skill.updated_at in registry-manifest.yaml
to match the version declared in SKILL.md.

Usage:
    python3 update-skill-version.py --version 1.1.0 --date 2026-04-22
"""

import argparse
import re
from pathlib import Path

MANIFEST_PATH = Path("config/registry-manifest.yaml")


def update_manifest(version: str, date: str) -> None:
    content = MANIFEST_PATH.read_text()

    # Update skill.version
    content = re.sub(
        r"(skill:\n(?:.*\n)*?  version: )\".*?\"",
        lambda m: m.group(0).rsplit('"', 2)[0] + f'"{version}"',
        content,
        count=1
    )

    # Update skill.updated_at
    content = re.sub(
        r"(skill:\n(?:.*\n)*?  updated_at: )\".*?\"",
        lambda m: m.group(0).rsplit('"', 2)[0] + f'"{date}"',
        content,
        count=1
    )

    MANIFEST_PATH.write_text(content)
    print(f"Updated manifest: skill.version={version}, skill.updated_at={date}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--version", required=True)
    parser.add_argument("--date", required=True)
    args = parser.parse_args()
    update_manifest(args.version, args.date)
