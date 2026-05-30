# ScholarEval: TETHYS Data Paper v2

**Manuscript:** `main_v2.tex` — "High-resolution monthly sectoral water demands for the U.S. over 1980–2100"
**Venue:** Scientific Data (data descriptor)
**Date:** 2026-05-28
**Companion:** `TETHYS_data_paper_v3-review.md` (qualitative peer review of compiled v3 PDF)

This evaluation applies the ScholarEval framework dimension-by-dimension. Scoring is on a 5-point scale, calibrated to the genre (data descriptor, not a hypothesis-driven primary research article). The ScholarEval is intended to complement, not duplicate, the qualitative review already on file.

---

## Dimension Scores

| # | Dimension | Score | One-line judgment |
|---|---|:---:|---|
| 1 | Problem formulation & dataset rationale | **4** | Gap is real, framing of contribution is precise; Table 1 carries the argument |
| 2 | Literature positioning | **3.5** | Adequate for a data paper; existing-dataset review is thin and reviewer 1 already flagged this |
| 3 | Methodology & workflow design | **4** | Equations are reconciled with code; piecewise/clip choices are honest but unjustified |
| 4 | Input data & sources | **4** | Inputs are credible and pinned in YAML; upstream component versioning is uneven |
| 5 | Analysis & technical validation | **2.5** | Validation is structurally sound but statistically thin for Scientific Data |
| 6 | Data records & figures | **3.5** | Records are well-organized; central figures lack statistical anatomy |
| 7 | Scholarly writing | **4** | Clear, tight, appropriately formal; abstract over-promises aggregate accuracy |
| 8 | Citations & references | **3** | Several `RN##` placeholder keys, two TODO refs, one in-review reference |
|  | **Aggregate (unweighted)** | **3.6** | |
|  | **Aggregate (validation-weighted, ×1.5 on Dim. 5)** | **3.5** | |

Validation-weighted aggregate weights Dimension 5 ×1.5 because technical validation is the central deliverable of a Scientific Data descriptor. The lower weighted score reflects that a strong dataset paper needs more than Pearson r and a single CONUS percent.

**Recommendation: minor-to-moderate revision.** The dataset itself is publishable; the descriptor needs a tighter validation section and corrected abstract framing before submission.

---

## Dimension 1 — Problem formulation & dataset rationale (4/5)

### Strengths
- The contribution is articulated as six concrete advances over Khan et al. 2023, each tied to a specific upstream model component (GCAM-USA, CERF, Demeter, Jones-O'Neill SSPs, TGW-WRF, USGS anchoring). This is harder to do well than it looks.
- Table 1 (lines 86–98) is the right move for a data descriptor: it forces the contribution into a comparable form rather than claiming novelty rhetorically.
- The 1/8° CONUS scope is appropriate for the stated downstream uses (mosartwmpy routing, basin-scale scarcity, sectoral tradeoffs).

### Weaknesses
- The opening paragraph (line 62) leads with a 322 Bgal/day figure with no anchor to the dataset's purpose. Reviewer 1 flagged the same thing. An "agenda-setting" hook would land better.
- The phrase "Future water demand projections typically inherit the coarse spatial and temporal scales of the integrated assessment models" (line 46) is true but generic. The sentence that immediately follows it does the actual work; the generic sentence could go.
- Audience is implicit. Data descriptors benefit from naming user communities explicitly (water managers, IAM modelers, mosartwmpy/MOSART users, scarcity researchers). Reviewer 1 issue 18.

### Checklist
- [x] Gap identified (high-res, multi-sector, scenario-consistent CONUS dataset)
- [x] Contribution differentiated (Table 1)
- [x] Scope feasible and demonstrated
- [ ] User community named explicitly
- [ ] Significance hook in first 3 sentences

---

## Dimension 2 — Literature positioning (3.5/5)

### Strengths
- The downscaling-chain references (Khan 2023, Vernon 2018/2021, Jones-O'Neill 2016, Jolly 2005, Moore 2015, Roy 2005, Wada 2011) are appropriate primary sources for each method choice and they each get cited at the point of use.
- Hadjimichael 2023 and Graham 2020 anchor the demand-side-scarcity argument with current refs.

### Weaknesses
- The existing-dataset review is one paragraph plus Table 1. For a venue like Scientific Data, where reviewers expect "what does this dataset enable that prior datasets cannot," a dedicated paragraph reviewing Huang 2018, Wada 2017, van Vliet 2021, and Khan 2023 with their specific limitations would strengthen the case. Reviewer 1 raised this verbatim.
- Several references resolve to opaque keys (`RN1`, `RN6`, `RN9`, `RN12`, `RN13`, `RN15`). Whatever these are, they should be replaced with author-year keys before submission so the bibliography is human-readable in source form.
- The historical context for water-demand downscaling (e.g., Voss 2009, Wada 2014, Hejazi 2014) is not engaged. Not all of it needs to be in the descriptor, but the lineage is currently invisible.

### Checklist
- [x] Foundational works cited at point of use
- [x] Recent literature represented
- [ ] Existing-dataset paragraph beyond Table 1
- [ ] Citation key cleanup
- [ ] Lineage of downscaling methods visible

---

## Dimension 3 — Methodology & workflow design (4/5)

### Strengths
- The downscaling chain is described phase by phase (preprocessing → spatial → temporal → source-share adjustment) with equations matched to code locations (`scripts/0_preprocessing/gsi_nersc/` etc.). The `EQUATIONS_AUDIT.md` companion file documents per-equation reconciliation, which is unusual rigor for this genre.
- The "frankenstein" caveat (line 234) honestly names the modular-coupling compromise. This is the right epistemic posture for a multi-model dataset and avoids overclaiming co-calibration.
- The CERF-based electricity proxy (line 146) is a real methodological advance over population-as-proxy and is well-justified.

### Weaknesses
- **Eq. 5 thresholds (HDD ≥ 650, CDD ≥ 450).** Hard discontinuities at fixed thresholds will produce step changes in cells that cross under warming (rcp85hotter 2090–2100). The threshold convention is attributed to Huang 2018 but no sensitivity test is shown. Reviewer 1 issue 6 covers this.
- **Eq. 8 source-share clip.** The `min(·,1)` clip is one-sided, applied only to cells in 𝓜, and does not renormalize the basin-level mass balance. The asymmetry biases historical-anchored cells toward lower renewable shares relative to un-anchored cells. Reviewer 1 issue 5.
- **Linear interpolation between 5-year GCAM steps.** Acknowledged on line 303 for irrigation interannual variability, but not promoted to a Limitation. Important for users computing drought-year statistics.
- **Simplified GSI.** Dropping the VPD term from Jolly 2005 is justified by alignment with Moore 2015 but VPD is the binding constraint in humid climates (Reviewer 1 issue 10's flavor; Limitation bullet exists, line 370).

### Checklist
- [x] Methods aligned with downstream use cases
- [x] Equations specified completely
- [x] Code-equation reconciliation documented
- [x] Limitations acknowledged in dedicated section
- [ ] Threshold sensitivity tested
- [ ] Source-share mass balance verified

---

## Dimension 4 — Input data & sources (4/5)

### Strengths
- Inputs span the IM3 stack (GCAM-USA, Demeter, CERF, TGW-WRF) and external authoritative datasets (Jones-O'Neill SSPs, GLW3, GPPD, USGS). Each is cited and most have DOIs.
- Tethys YAML configs are archived per scenario, which pins the downscaling-package version exactly. This is best-in-class reproducibility for the Tethys side.
- The historical-baseline construction (2015 GPPD + IM3 experiment B inventory, line 146) is documented at sufficient granularity.

### Weaknesses
- Two `\cite{TODO-TGW-WRF}` placeholders remain (lines 112, 428). The TGW-WRF primary reference must be added before submission. The header note in `main_v2.tex` already flags this.
- Bracken et al. 2025 GODEEEP-hydro reference is also flagged as missing in the file header. Either include it or remove the dependency.
- Upstream-component version pinning is uneven. Tethys is pinned in YAMLs; Demeter, CERF, GCAM-USA, GLW3, GPPD, Jones-O'Neill are not consistently pinned to a commit/DOI/version. Reviewer 1 issue 19.
- Reference 9 (Zhao "in-review 2026") needs a preprint DOI or de-emphasis (Reviewer 1 issue 22).

### Checklist
- [x] Sources credible
- [x] Tethys version pinned
- [ ] All upstream components version-pinned
- [ ] All TODO references resolved
- [ ] In-review references either replaced with preprint DOI or supported by additional refs

---

## Dimension 5 — Analysis & technical validation (2.5/5)

This is the lowest-scoring dimension and the one most likely to attract reviewer pushback at Scientific Data. The structure of the validation is right (CONUS annual → HUC6 spatial → seasonal cycle → inter-scenario), but the statistical content is thin.

### Strengths
- The coarse-to-fine validation arc is logically correct and visually well-organized.
- HUC6 percent-difference distributions (Fig. 4) and per-cell HUC6 maps (Fig. 5) together show both magnitude and spatial structure of bias.
- The seasonal-cycle figure (Fig. 7) is the right diagnostic for a monthly product.

### Weaknesses (severity-ordered)
1. **Sector-level vs. aggregate framing.** The abstract claim "within 10% at CONUS scale" is true only because Domestic (~−45% bias) and Electricity (~−30% bias) at HUC6 partially cancel. The body acknowledges this tension; the abstract does not. Reviewer 1 issue 1. **This is the most consequential single change.**
2. **Metric set is narrow.** Only Pearson r and CONUS-scale percent agreement. No NSE/KGE, no NRMSE, no MBE, no Spearman, no concordance correlation, no bias decomposition. Pearson r is invariant to multiplicative bias and is dominated by a few large basins. Reviewer 1 issue 2.
3. **No uncertainty on validation statistics.** Pearson r values are reported without CIs or n; HUC6 spatial autocorrelation will inflate effective n. Reviewer 1 issue 3.
4. **No diagnosis of the −45% Domestic bias.** The Wada R-coefficient attribution (line 342) is asserted, not demonstrated. Reviewer 1 issue 4.
5. **Box-plot statistics underspecified.** n, whisker rule, and percent-difference denominator are unstated in Figs. 4 and 7 captions. Reviewer 1 issue 7.
6. **No phase/amplitude metric for Fig. 7** despite visible phase differences in Electricity.
7. **2020 historical→future discontinuity gets one sentence.** Material for trend-spanning users. Reviewer 1 issue 8.

### What would move this score to 4
A Technical Validation section that includes: (a) a per-sector × demand-type validation table with n, Pearson r with bootstrap CI (block-bootstrap by HUC2), Spearman ρ, NSE/KGE with α/β/r decomposition, MBE, NRMSE, and median absolute percent error with IQR; (b) for the seasonal cycle, monthly RMSE and a phase metric; (c) explicit acknowledgment of compensating sector biases in the abstract. The underlying outputs to compute these already exist in `validation/`.

### Checklist
- [x] Validation structure (coarse → fine, total → seasonal)
- [x] Validation reference dataset (USGS) appropriate
- [ ] Metric set adequate for genre
- [ ] CIs on reported correlations
- [ ] Spatial-autocorrelation–aware n
- [ ] Sector-level framing in abstract

---

## Dimension 6 — Data records & figures (3.5/5)

### Strengths
- File schema is clean and documented with a CDL excerpt (Fig. 2). The naming convention (`<Sector>_<demand_type>[_monthly].nc`) is readable and machine-parseable.
- Per-scenario YAMLs alongside data files is the right reproducibility pattern.
- Conveyance-loss variants are flagged via filename suffix.

### Weaknesses
- `gridded_runoff_shares.nc` documentation is thin — the per-cell, per-year `s^adj` definition is in the manuscript but the netCDF metadata (units, valid range, fill value, mask interpretation) should also be readable from the file itself.
- Conveyance-loss formulation, rate, and spatial variation are not documented (Reviewer 1 issue 20).
- Fig. 9 (dominant-sector map) appears without textual reference (Reviewer 1 issue 21).
- Fig. 1 (workflow) precedes the introduction of Demeter, CERF, etc., without forward reference; reorganizing so the figure caption resolves all acronyms would help.

---

## Dimension 7 — Scholarly writing (4/5)

### Strengths
- Tight, appropriately formal voice. Few wasted words. Strong sectional organization that mirrors Scientific Data conventions (Background & Summary → Methods and Data → Data Records → Technical Validation → Usage Notes).
- Equations are introduced with operational context, not dropped in cold.
- Honest framing in the "frankenstein" paragraph and Limitations section. The candor is the right register for a multi-model descriptor.

### Weaknesses
- The abstract overpromises (see Dimension 5). One sentence on sector-level findings would correct this.
- "Frankenstein" is colloquial in a formal manuscript (Reviewer 1 issue 17). "Modular" or "component-coupled" reads better.
- A handful of inline reviewer comments remain in the source (`% COMMENT ...`). These should be resolved or suppressed before submission.
- A few small typos: "scnearios" (line 112), "validates well... and that supports detailed scenario" (line 417, sentence appears truncated), "CERF CERF" (line 446).
- Title's "1980–2100" masks the 2019/2020 split. Acceptable as is, but "1980–2099 across historical and eight future scenarios" is more accurate (Reviewer 1 issue 15).

---

## Dimension 8 — Citations & references (3/5)

### Strengths
- 34 unique citation keys, all at point of use.
- Most refs have DOIs (visible in the bib files).
- Two bibliography files present (`paper.bib`, `Tethys.bib`) with the manuscript pointed at `Tethys`.

### Weaknesses
- **Six `RN##` keys** (`RN1, RN6, RN9, RN12, RN13, RN15`). These appear to be EndNote/Mendeley import artifacts. Replace with author-year-keyword keys.
- **Two `TODO-TGW-WRF` placeholders** must be resolved.
- **One in-review reference** (Zhao 2026) needs a preprint DOI.
- Using two .bib files invites desync; the `\bibliography{Tethys}` line at the end means `paper.bib` is silently unused. Consolidate or document why both exist.

---

## Cross-Cutting Strengths

- The dataset is genuinely useful and its contribution over Khan 2023 is concrete and quantifiable.
- Reproducibility infrastructure (Tethys YAMLs, integration metarepo, MSD-Live archive, code links) is strong.
- The `EQUATIONS_AUDIT.md` companion document is best-in-class transparency.
- Limitations section is honest and specific, not generic.

## Cross-Cutting Weaknesses

- Validation rigor lags the rest of the paper.
- Several pre-submission cleanups remain (TODO refs, `RN##` keys, inline `% COMMENT` markers, two .bib files).
- Sector-level bias framing in the abstract sets up a credibility hit if a reviewer reads only Fig. 4.

---

## Priority-Ranked Revision List

### Pre-submission (must do)

1. Rewrite the abstract to lead with sector-level HUC6 findings and qualify the "within 10%" claim as CONUS-aggregate that reflects partial cancellation of opposing sector biases. (Dim. 5, Dim. 7)
2. Add a per-sector × demand-type validation table with proper metrics (Pearson r + bootstrap CI, Spearman ρ, NSE or KGE with α/β/r decomposition, MBE, NRMSE, median APE with IQR). (Dim. 5)
3. Resolve `\cite{TODO-TGW-WRF}` and the GODEEEP-hydro placeholder. (Dim. 4, Dim. 8)
4. Replace `RN##` citation keys with author-year-keyword form. (Dim. 8)
5. Clean inline `% COMMENT` markers from the source. (Dim. 7)
6. Fix small typos: "scnearios", truncated sentence near line 417, "CERF CERF" at line 446. (Dim. 7)

### Strongly recommended

7. Quantify Eq. 8 clip behavior (cell fraction in 𝓜, fraction where clip binds, basin-level mass-balance residuals). (Dim. 3)
8. Eq. 5 threshold sensitivity (perturb (650, 450) and report monthly CONUS Electricity demand spread; map cells within ±20% of threshold under historical and rcp85hotter 2090–2100). (Dim. 3)
9. Diagnose the −45% Domestic bias — units, GCAM-USA total, or downscaling artifact. (Dim. 5)
10. Promote 2020 historical→future discontinuity to a Limitations bullet with magnitude. (Dim. 3)
11. Add Limitations bullet on 5-year GCAM linear interpolation suppressing interannual variability. (Dim. 3)
12. Expand existing-dataset paragraph (Huang 2018, Wada 2017, van Vliet 2021, Khan 2023) beyond Table 1. (Dim. 2)

### Editorial

13. State n, whisker rule, and percent-difference denominator in Figs. 4 and 7 captions. (Dim. 6)
14. Add explicit user-community paragraph in Usage Notes. (Dim. 1)
15. Document conveyance-loss formulation. (Dim. 6)
16. Add in-text reference to Fig. 9. (Dim. 6)
17. Replace "frankenstein" with "modular" or "component-coupled". (Dim. 7)

---

## Publication-Readiness Assessment

**Target venue:** Scientific Data.
**Current state:** Not yet ready. The dataset and methodology meet the venue's bar; the validation section and abstract framing do not.
**Estimated effort to readiness:** 2–4 weeks of focused revision, primarily on the validation table (item 2) and abstract rewrite (item 1). The other items are smaller.
**Risk if submitted as-is:** A statistically literate reviewer reads Fig. 4, sees the −45% Domestic bias, returns to the abstract, and the credibility of the whole submission is harder to recover from than if the abstract had set expectations correctly upfront.

---

## Notes on Methodology of This Evaluation

- Source read: `main_v2.tex` (457 lines) and `paper.bib` / `Tethys.bib` headers.
- Companion review on file (`TETHYS_data_paper_v3-review.md`) was consulted to avoid duplicating qualitative commentary; cross-references to issue numbers in that document are explicit.
- Scoring is calibrated to the data-descriptor genre, not a primary research article. Dimensions involving hypothesis testing, control groups, or causal inference are not applicable and were reframed as "input data," "technical validation," etc.
- Aggregate scores are reported both unweighted and with Dim. 5 weighted ×1.5 to reflect the centrality of validation in this venue.

## Citation

Moussa, H. N., Da Silva, P. Q., Adu-Ampratwum, D., East, A., Lu, Z., Puccetti, N., Xue, M., Sun, H., Majumder, B. P., & Kumar, S. (2025). *ScholarEval: Research Idea Evaluation Grounded in Literature*. arXiv:2510.16234.
