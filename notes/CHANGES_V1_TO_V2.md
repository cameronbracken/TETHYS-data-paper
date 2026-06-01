# `main.tex` (v1) → `main_v2.tex` (v2) -- changes for coauthor review

This file summarises what changed between the existing draft (`main.tex`,
preserved unchanged) and the second draft (`main_v2.tex`). Companion
documents in this directory:

- `EQUATIONS_AUDIT.md` -- per-equation reconciliation of paper vs. code, with every mismatch and how it was resolved.
- `STYLE_NOTES.md` -- distilled voice/structure from three Bracken *Scientific Data* descriptors that informed v2.

All v2 content derives from the actual code in `tethys-code/` and
`tethys_integration_metarepo/` (post-cleanup, on branch
`metarepo-cleanup`). Cite anything unexpected against those repos and
the audit doc.

## Executive summary

| Area | v1 status | v2 status |
|---|---|---|
| Title | Keep | Unchanged |
| Abstract | Placeholder (``... and xxx scenarios``) | Rewritten: 9 sentences, opens with USGS 322 Bgal/day baseline, closes with MSD-Live URL |
| Background & Summary | 4 paragraphs, thin lit review | 3 paragraphs + new Table 1 comparing this dataset to Huang 2018, Khan 2023, van Vliet 2021, Wada 2017 |
| Methods subsections | 5 | 7 (added **Preprocessing of climate forcing** and **Gridded renewable vs non-renewable source shares**) |
| Equation count | 7 | 8 (irrigation rewritten from scratch; electricity cases-block added; source-shares equation added; GSI components added) |
| Figures | 7 | 8 (new `val6-scenarios-annual-conus-timeseries.png`) |
| Tables | 2 | 3 (new Table 1 comparing prior datasets) |
| Technical Validation | 1 section, 3 subsections implicit | 1 section, 5 subsections: CONUS annual → HUC6 spatial → HUC6 scatter → Seasonal cycle → Inter-scenario consistency |
| Limitations | Commented out | Expanded to 6-point bulleted list |
| Improvements over previous version | Bulleted stub (numbered 1–8 with terse phrasing) | 6 prose paragraphs + a closing paragraph on refreshed USGS validation |
| Usage Notes | Blank | `xarray` snippet + HUC aggregation pointer + unit conversion constants |
| Code availability | Placeholder paragraph | Itemised list with URLs for Tethys, integration metarepo, Demeter, CERF, TGW |
| Author contributions | `TODO` | Drafted template per CRediT (coauthors to edit) |

Total change: ~95% rewrite. About 15 sentences of v1 prose are retained verbatim; the rest is new text that hews closer to Cameron's *Scientific Data* register.

## Equation changes (see `EQUATIONS_AUDIT.md` for full reasoning)

### Eq. 2 -- Irrigation monthly weight -- **COMPLETELY REWRITTEN**

v1 had
```
weight_month = |1/(P − PET)|   if P > PET
             = |P − PET|       if P ≤ PET
```
This does not match the code and is mathematically pathological (reciprocal diverges as P → PET from above). The code computes
```
w_m = (Δ_m · G_m / N_m)  /  Σ_k (Δ_k · G_k / N_k)
```
where `Δ_m = max(PET_m − P_m, 0)`, `G_m` is a monthly growing-season index, and `N_m` is month length. The v2 draft uses this form (Eq. 4) and adds the GSI component formulas (Eqs. 1–2) to document how `G_m` is built from daily Tmin and daylength.

**Implication for the dataset:** no change -- the code was always correct; only the paper's description was wrong.

### Eqs. 3–6 -- Electricity HDD/CDD thresholds -- **SWAPPED to match code**

v1 said "HDD > 450 and CDD > 650". The code (`tethys-code/tethys/tdmethods/electricity.py:29–34`) uses HDD ≥ 650 and CDD ≥ 450. v2 swaps the thresholds and rewrites the four piecewise equations as a single cases-block (Eq. 5) and a single demand equation (Eq. 6), citing Huang et al. 2018.

**Implication:** if Huang 2018 actually says (450, 650), then the code has a bug and our dataset is affected in border-climate cells. I recommend we verify Huang's original thresholds as a follow-up; the v2 draft documents whatever the code does.

### Eq. 7 -- Domestic -- **UNCHANGED (matches code)**

v2 keeps the same equation, adds a sentence clarifying that `R` is region-level amplitude (the code variable is `amplitude`; v1 used `R_cell` which was a slight misnomer since the coefficient is not strictly per-cell).

### Runoff-share adjustment -- **NEW EQUATION ADDED**

v1 had only prose describing the basin-level split. v2 adds Eq. 7 (USGS-anchored ratio adjustment) to document the `adjust_runoff_shares_method2_kazi.py` implementation explicitly:
```
s_adj[c,y] = min(1, s_USGS[c] · s_GCAM[c,y] / s_GCAM[c,2015])   for c in M
s_adj[c,y] = s_GCAM[c,y]                                        otherwise
```

## New figure and its caption

`val6-scenarios-annual-conus-timeseries.png` -- generated from
`tethys_integration_metarepo/validation/5c-scenarios-timeseries.R`.

4 panels (Domestic, Electricity, Irrigation, Total), x = year, y = annual CONUS demand (km³/yr), historical in black (1975–2015) + 8 futures (2020–2100) encoded by color (RCP), linetype (SSP), and line width (cooler/hotter climate sample). Reads from `/Volumes/data/tethys/output_adjusted_usgs_method2/`.

Placed in **Technical Validation → Inter-scenario consistency** (new subsection).

## Author list and affiliations -- FLAGGED FOR YOU

v1 had:
- `\affil[4]{Cornell}` (no author assigned to [4])
- `\affil[3]` used for two different institutions (University of Washington and by assignment to Isaac Thompson)

v2 consolidates to three affiliations:
1. Pacific Northwest National Laboratory (Richland, WA)
2. Joint Global Change Research Institute, PNNL (College Park, MD)
3. University of Washington, Seattle

I kept Isaac Thompson tagged as `[2]` (JGCRI) based on the JGCRI/PNNL affiliation pattern for GCAM-side coauthors, and I did not add a Cornell affiliation since no v1 author needed it. **Please verify** that Isaac's affiliation is correct; if he is at Cornell, add a fourth affil and tag him accordingly.

## Things I did NOT change

- `flow-chart.pdf` is referenced as Fig 1 (unchanged from v1). The file `flow-chart2.pdf` is a newer-looking variant in the directory but is not referenced by v1 or v2. If you want to swap, it's a one-line change.
- `paper.bib` -- v2 still uses `Tethys.bib` (same as v1). Keys used: all of v1's plus `TODO-TGW-WRF` (placeholder for the TGW-WRF primary reference, which is missing from `Tethys.bib`).
- Author order -- preserved from v1.
- `wlscirep.cls` and other SciData template files -- unchanged.
- `\linenumbers` is on for coauthor review. Remove before final submission.

## Open items for coauthors

1. **TGW-WRF reference.** Please point me to the primary citation for the Thermodynamic Global Warming downscaled dataset. I used `\cite{TODO-TGW-WRF}` at L97 and L398 so it's easy to grep. Will add to `Tethys.bib` once resolved.
2. **Huang 2018 verification.** Worth a check on the HDD/CDD threshold convention in the original Huang et al. 2018 paper. See `EQUATIONS_AUDIT.md` § "Eqs. 3–6" for context.
3. **Conveyance losses.** L139–152 of v1 had commented-out discussion about state sums differing from GCAM USA totals by ~0.83. v2 mentions conveyance losses in Limitations but does not discuss the correction in detail. If this is a material caveat that needs elaboration, let me know.
4. **Coauthor contributions.** I filled in the contributions statement with a CRediT-style template based on my best read of git history and the integration metarepo commits. Please edit freely.
5. **MSD-Live DOI.** The URL `https://data.msdlive.org/uploads/p4xce-e8822` is pulled from the v1 draft. Please confirm it still resolves and that there is no newer/canonical DOI.

## Build verification

Clean build:
```
cd tethys-data-paper
latexmk -pdf main_v2.tex
```
Result on my machine (May 2026, TeX Live 2026): 14 typeset pages, 2.3 MB PDF, 1 expected warning only (`Citation 'TODO-TGW-WRF' undefined`).

## Where the supporting work lives

- **Draft paper:** `tethys-data-paper/main_v2.tex`
- **Compiled PDF:** `tethys-data-paper/main_v2.pdf`
- **Equations reconciliation:** `tethys-data-paper/EQUATIONS_AUDIT.md`
- **Style notes:** `tethys-data-paper/STYLE_NOTES.md`
- **This file:** `tethys-data-paper/CHANGES_V1_TO_V2.md`
- **Cleaned metarepo:** branch `metarepo-cleanup` in `tethys_integration_metarepo/` (local only; see `docs/CLEANUP.md` and `PIPELINE.md` there)
- **New figure script:** `tethys_integration_metarepo/validation/5c-scenarios-timeseries.R`
