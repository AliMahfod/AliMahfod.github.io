# PyProg2026Lab1 — Lab 1 static site (MkDocs + GitHub Pages)

Laboratory portfolio site built with [MkDocs](https://www.mkdocs.org/) and published via [GitHub Pages](https://docs.github.com/en/pages) from the `/docs` folder on branch `main`.

## Theme choice

**Material for MkDocs** is used because it:

- Provides clear hierarchy (tabs, sections, top navigation) suitable for a multi-page portfolio
- Includes built-in search and readable typography for long lab reports
- Supports light/dark mode without extra configuration
- Is widely documented and maintained for documentation-style sites

## Project structure

```
├── .gitignore
├── README.md
├── steps-to-deliver.md
├── docs/                 # built static site (GitHub Pages root)
└── source/
    ├── mkdocs.yml
    └── docs/             # Markdown sources
```

## Local development

```bash
python -m venv .venv
.venv\Scripts\activate
pip install mkdocs mkdocs-material
cd source
mkdocs serve
mkdocs build -d ../docs
```

Run `mkdocs build` from the `source` directory so output is written to `docs/` at the repository root.

## Report

**Name:** Ali Mahfod

**P3123 — Static site (Lab 1)**

| Item | Link |
|------|------|
| Repository (sources) | [https://github.com/AliMahfod/AliMahfod.github.io](https://github.com/AliMahfod/AliMahfod.github.io) |
| Published site | [https://AliMahfod.github.io/](https://AliMahfod.github.io/) |

**GitHub Pages settings:** Source = **Deploy from a branch**, Branch = **main**, Folder = **/docs**.
