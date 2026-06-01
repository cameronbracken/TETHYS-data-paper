---
workflow: writing
style: general
phase: review
project_root: /Users/brac840/projects/im3/water-scarcity/tethys-data-paper-review
bibliography: references/sources.bib
precis: .planning/PRECIS.md
outline: .planning/OUTLINE.md
edits_since_verify: 0
verify_threshold: 10
skill_stack:
  - writing
  - writing-general
draft_source: /Users/brac840/projects/im3/water-scarcity/tethys-data-paper/main_v3.tex
---

# Active Workflow

## Context

This workspace exists to run the `workflows:writing-review` workflow against
`tethys-data-paper/main_v3.tex` (which lives on a Dropbox/Overleaf symlink and
should not be polluted with `.planning/` artifacts). The single LaTeX file has
been split into per-section markdown drafts under `drafts/` to satisfy the
workflow's discovery requirements.

## Phase

`phase: review` — review-only run. No drafting, no revision in this workspace.
Findings will be rendered to `.planning/REVIEW.md` and propagated back to the
Overleaf project as a markdown review artifact.

## Notes

- Drafts under `drafts/` are LaTeX excerpts copied from `main_v3.tex` with line
  numbers preserved in the file metadata so `location: file:line` resolves to
  the original `main_v3.tex` lines.
- Outlines under `outlines/` are skeleton scaffolds derived from the
  `OUTLINE.md` structure.
- `references/sources.bib` is a copy of the Overleaf `Tethys.bib`.
