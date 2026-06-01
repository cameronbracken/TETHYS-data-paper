---
status: validated
phase: review
date: 2026-05-29
---

# Claim Validation

## Context

This workspace runs `workflows:writing-review` against an existing draft
(`tethys-data-paper/main_v3.tex`). The Leg-1 claim-validation gate is satisfied
manually here because the draft is a finished manuscript whose claim coverage
has already been audited in two prior reviews
(`tethys-data-paper/reviews/TETHYS_data_paper_v3-review.md` and
`tethys-data-paper/reviews/TETHYS_data_paper_v3-review-2026-05-28-fresh.md`).

## Coverage

Each PRECIS claim maps to a section of the LaTeX draft:

| Claim   | Where in main_v3.tex                                  |
|---------|-------------------------------------------------------|
| CLAIM-01 | Background & Summary (lines 56–64)                   |
| CLAIM-02 | Methods and Data (lines 93–221)                      |
| CLAIM-03 | Data Records (lines 224–279)                          |
| CLAIM-04 | Technical Validation (lines 282–362)                  |
| CLAIM-05 | Improvements over previous version (lines 400–416)    |
| CLAIM-06 | Limitations (lines 364–374)                           |

## Verdict

`validated` -- every PRECIS claim has a backing section in the draft. The
purpose of this run is review of *how well* each section advances its claim,
not whether the claim is covered at all.
