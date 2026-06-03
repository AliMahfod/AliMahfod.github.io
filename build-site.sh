#!/usr/bin/env bash
set -e
cd "$(dirname "$0")/source"
../.venv/bin/mkdocs build -d ../docs 2>/dev/null || ../.venv/Scripts/mkdocs build -d ../docs
touch ../docs/.nojekyll
