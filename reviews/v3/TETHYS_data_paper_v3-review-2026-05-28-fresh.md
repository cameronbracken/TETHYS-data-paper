# Independent Review: TETHYS CONUS Data Paper (v2 / PDF v3)

**Manuscript:** "High-resolution monthly sectoral water demands for the U.S. over 1980–2100"
**File reviewed:** `main_v2.tex` (455 lines, source); compiled PDF `TETHYS_data_paper_v3.pdf` (2026-05-28)
**Target venue:** *Scientific Data* (data descriptor; uses `wlscirep.cls`)
**Reviewer:** Independent, AI-assisted (Claude Opus 4.7)
**Date:** 2026-05-28
**Note on independence:** Drafted without reading the prior `TETHYS_data_paper_v3-review.md` in the same folder.

---

## Overall Assessment

**Recommendation: Major revision.**

This is a useful and reasonably well-scoped multi-sector water-demand data descriptor with a clear contribution: the first publicly available CONUS-resolved (1/8°) monthly multi-sector dataset combining GCAM-USA state demands, CERF-sited thermoelectric, SSP-aware population, scenario-consistent climate forcing, and USGS-anchored renewable/non-renewable attribution, across one historical and eight future RCP×TGW×SSP scenarios. Table 1 makes the contribution beyond Khan et al. 2023 explicit and credible.

I am recommending major revision, not minor, for three reasons that I do not see addressable through editorial polish alone:

1. **The headline validation claim is misleading.** The abstract advertises "agreement … within 10% at CONUS scale and correlations between 0.71 and 0.95 at HUC6," but Fig. 4 (HUC6 percent-difference boxplots) and lines 303 and 322 show sector-level biases that span roughly **−75% to +25%**. The 10% CONUS-scale agreement is partly the result of opposite-signed sector biases canceling. This is acknowledged in the body but not in the abstract, the "Improvements" closer (line 417), or any of the section-level summaries -- and a reader who only reads the abstract will form a materially incorrect view of the dataset's accuracy.
2. **Validation is statistically thin for *Scientific Data*.** Pearson r values are reported to two-three significant figures with no n, no confidence intervals, no significance test; no RMSE / KGE / NSE / MBE / Spearman is reported; no test of residual spatial autocorrelation despite obvious regional clustering in Fig. 5 (lines 322); no quantification of how often the Eq. 8 clip binds, of basin-level mass balance after the clip, or of the Eq. 5 HDD/CDD threshold sensitivity. *Scientific Data* readers expect a complete metric panel for a descriptor.
3. **Several methodological choices are presented but not characterized.** The Eq. 8 `min(·,1)` clip is asymmetric (caps amplification but not attenuation) and not mass-conserving at basin scale, yet its impact is unreported. The Eq. 5 thresholds (HDD ≥ 650, CDD ≥ 450) are attributed to Huang et al. 2018 but no sensitivity is shown. The conveyance-loss `_with_losses` files are mentioned twice without their actual loss formulation. Each of these is a small text addition individually; together they amount to a real characterization gap.

These are addressable using outputs the team already has -- none requires re-running a scenario. Once addressed, the dataset itself is solid and the contribution is clearly publishable in *Scientific Data*.

The honest treatment of the "frankenstein" coupling caveat (line 234), the explicit clip in Eq. 8, and the limitation list are exemplary for a descriptor and should be retained verbatim through revision.

---

## Major Issues

### M1. Abstract overstates aggregate agreement that masks sector-level bias

**Where:** Abstract (lines 46–48); closing claim of "Improvements" section (line 417); contradicted in body at lines 303, 322, and 342.

The abstract states "agreement in annual total demand within 10% at CONUS scale and correlations between 0.71 and 0.95 at HUC6." Lines 303, 322, and 342 establish that:

- HUC6 percent differences span roughly −75% to +25% across sectors (Fig. 4).
- Domestic shows "broadly consistent positive bias across months" attributable to the static `R` amplitude in Eq. 9 (line 342).
- Eastern Electricity overestimates and western Irrigation underestimates are sign-opposite (line 322).

The CONUS 10% agreement is therefore an aggregate that is partly produced by canceling sector-level errors. A naive reader will infer 10% applies at the sector level; it does not.

**Recommendation.** Rewrite the validation sentence in the abstract to lead with sector-level findings, e.g.: *"Annual CONUS totals agree with USGS within ~10%, with HUC6-scale percent differences ranging from approximately X% (Sector) to Y% (Sector); HUC6 spatial-pattern correlations range 0.71 (Domestic) to 0.95 (Irrigation), with aggregate CONUS agreement reflecting partial cancellation of opposing sector biases."* Replace placeholder X/Y with values read directly off Fig. 4 (the median per-sector percent difference, not the extremes). Add one sentence in the closing paragraph of "Improvements over previous version" explicitly stating that aggregate-scale agreement masks sector-level bias.

### M2. Validation statistical panel is incomplete for a *Scientific Data* descriptor

**Where:** All of Technical Validation (lines 297–360); especially Fig. 6 caption (line 336) and the implicit metric in line 322.

The validation reports two metrics: a "within 10%" CONUS percent agreement (no uncertainty) and Pearson r per sector at HUC6 (no n, no CI, no significance test). Pearson r on aggregated HUC6 data is inflated by a few large basins (visible in Fig. 6's regression structure), invariant to multiplicative bias, and conflates spatial pattern with magnitude.

For a *Scientific Data* descriptor a reader expects, at minimum:

- Sample size (number of HUC6s) per sector.
- Either bootstrap or analytic 95% confidence intervals on r.
- A bias-aware metric: NSE or KGE (with α/β/r decomposition) or NRMSE; MBE and median absolute percent error with IQR.
- A rank-based companion: Spearman ρ.
- Acknowledgment of spatial autocorrelation. The regional clustering in Fig. 5 implies inflated effective n. At a minimum, report Moran's I on residuals; better, block-bootstrap by HUC2.
- For seasonal cycles (Fig. 7), a phase metric (e.g., circular correlation of month-of-peak, or RMSE between standardized cycles).

**Recommendation.** Add a single Validation Metrics table (Table 3 or 4) with rows = (sector × demand-type) and columns: n_HUC6, Pearson r [95% CI], Spearman ρ, MBE, NRMSE, KGE [α, β, r], median |%diff| with IQR. Add one sentence noting Moran's I on residuals and one sentence on whether the effective n changes the headline-r interpretation.

### M3. Eq. 8 `min(·,1)` clip is asymmetric and uncharacterized

**Where:** Eq. 8 (lines 222–229); discussion (line 230).

The renewable-share adjustment caps amplification (`min(1, …)`) when the GCAM 2015 baseline is small but does not floor attenuation when the ratio is < 1. Three concrete consequences are not characterized in the manuscript:

- **Mass balance.** When the cell-level clip binds, the implicit non-renewable share at that cell becomes 0 (because the whole adjusted share is already 1). Basin-level renewable totals can therefore drift away from the GCAM basin-level split. The text on line 230 ("anchored in place where observable") is silent on this drift.
- **Asymmetry.** The same clip is not applied to ratios less than 1, so a cell whose 2015 GCAM baseline was small but whose observable 2015 USGS share is high will see its adjusted future share *attenuated* freely while another cell with the same modeled drift but observable amplification gets capped. This biases the historical-anchored cell population.
- **Coverage of 𝓜.** The fraction of cells in 𝓜 (i.e., with both `s^GCAM_2015 > 0` and `s^USGS` available) is never reported. Without that the reader cannot judge whether Eq. 8 affects 5% or 95% of the grid.

**Recommendation.** Add three numbers to the manuscript (a single sentence each, plus one figure or a row in the Limitations list):
1. Fraction of 1/8° cells in 𝓜.
2. Fraction of cells in 𝓜 in which the clip binds (per scenario or aggregated).
3. Basin-level mass-balance residual (CONUS-mean and 95th-percentile) before and after Eq. 8.
Also justify the asymmetry -- was it deliberate, and what is the sign of the residual error? If not deliberate, either symmetrize the clip or document the trade-off.

### M4. Eq. 5 thresholds (HDD ≥ 650, CDD ≥ 450) are attributed but not characterized

**Where:** Eq. 5 (line 196); attribution to Huang et al. 2018 (line 208).

The thresholds are imported from a 2018 global paper into a CONUS application without sensitivity analysis. The fourth case (uniform `1/12`) collapses cells that fail both thresholds; how many CONUS cells does this affect? The third case (CDD-only) approximates HDD by CDD, which is a strong assumption in low-HDD warm climates where the heating share `p_heat` from GCAM-USA is small but nonzero.

**Recommendation.** One sentence: "X% of cells fall in the four-case partition as (case-1, case-2, case-3, case-4) = (.., .., .., ..) over the historical period; sensitivity of the CONUS monthly cycle to varying the thresholds by ±50% is shown in Supplementary Fig. S1." If a sensitivity figure would be too much, at minimum report the partition fractions and one bounding alternative (e.g., halving both thresholds).

### M5. Domestic −45% (or larger) bias attribution is asserted, not demonstrated

**Where:** Line 342: "this reflects the R amplitude coefficient … which was calibrated to aggregate USGS demand rather than to the post-2015 public-supply subset."

This is plausible and is the single most important Limitation for users of the Domestic sector -- but it is asserted in one sentence without a diagnostic. Whether the bias is correctable (a known regional offset) or structural (the R coefficient is wrong for the variable Tethys outputs) is what determines reuse. As written, a downstream user cannot tell.

**Recommendation.** Either (a) include a diagnostic plot of monthly Tethys/USGS Domestic ratio vs. R or vs. annual mean temperature anomaly -- this would either confirm the R-coefficient story or refute it; or (b) soften the language to "consistent with" and add the diagnostic to a separate Limitations bullet, and explicitly document that users requiring unbiased Domestic absolute magnitudes should rescale to USGS.

### M6. Fig. 8 (inter-scenario consistency) lacks any uncertainty envelope

**Where:** Fig. 8 (line 357); discussion line 353.

Eight future scenarios are shown as deterministic single trajectories with no envelope across the climate sample (cooler/hotter), the SSP, or the RCP. The dataset is explicitly framed as "scenario-plausible" (line 234), and the eight-scenario factorial is the central novelty of the descriptor -- yet the figure communicates point estimates only. With only two TGW samples per RCP, an honest envelope is hard to construct, but at minimum the cooler/hotter spread should be shaded per RCP.

**Recommendation.** Add shaded ranges (cooler/hotter) per RCP in Fig. 8, or -- if the visual gets too busy -- add a small panel showing `(hotter−cooler)/cooler` for each scenario pair. State in the figure caption that the spread is illustrative, not a UQ.

### M7. Reference framing in Background is incomplete relative to Table 1

**Where:** Background & Summary (lines 59–73); Table 1 (lines 83–99).

Table 1 lists Huang 2018, Khan 2023, van Vliet 2021, Wada 2017 as the comparison set, but the text only really discusses Khan 2023 in Methods. Huang 2018 is cited only for Eq. 5 thresholds, and van Vliet / Wada are cited generically in the lead. A reader looking at Table 1 will want, in 2–3 sentences in the Background, an explicit articulation of *what* this dataset adds beyond each row of Table 1, not just beyond Khan 2023. Author comments embedded in the source (lines 61, 66) flag this gap and indicate the team already plans to address it.

**Recommendation.** Add a short paragraph after Table 1 captioning: for each row, one sentence on the limitation this dataset addresses (e.g., Huang 2018: historical only; Wada 2017: 0.5° global, 4 sectors; van Vliet 2021: country/basin annual). The existing source comments outline the right structure.

### M8. Six opaque cite keys (`RN1, RN6, RN9, RN12, RN13, RN15`) reduce the reader's ability to verify claims

**Where:** Throughout -- `RN1` (line 62 GCAM), `RN6, RN9, RN12` (line 62 background of water-demand drivers), `RN13, RN15` (line 67 hydrology models).

These keys exist in `Tethys.bib` (verified) but their identity is not visible in the manuscript source. They appear in load-bearing background claims (e.g., "demand-side drivers, not supply-side limits, dominate most projected shifts in water scarcity"). A reader of the .tex (a coauthor, journal copy editor, or future maintainer) cannot tell what is being cited without bib lookup. This is a maintainability problem and a reproducibility minor.

**Recommendation.** Rename the six keys to author-year style consistent with the rest of the bib (e.g., `Wada_2016`, `Huang_2018b`, etc.). The Citation Audit table below lists each `RN*` key's resolved identity to facilitate the rename.

---

## Minor Issues

### m1. Abstract numerical figure 322 Bgal/day is from an undated USGS source

**Where:** Line 46 ("Water demand in the United States totals roughly 322 Bgal day⁻¹").

No citation is given. This number is likely from USGS Circular 1492 (Dieter et al. 2018, 2015 estimates) or the Skinner et al. 2025 update already cited elsewhere. Cite it.

### m2. Manuscript title appears twice (lines 24–25), one commented out

**Where:** Lines 24 (commented) and 25 (active).

Cosmetic. Pick one before submission.

### m3. Author affiliation footer mixes corresponding-author marks with affiliation indices

**Where:** Lines 27–42.

Two corresponding authors with `[1*]` and `[2*]` is unusual; *Scientific Data* normally permits only one corresponding author. Verify against the journal's instructions before submission.

### m4. Equation 1 GSI clip for `g(L_d)` uses the wrong upper bound for high latitudes

**Where:** Eq. 1 (line 117–118): `g(L_d) = min(max(L_d − 10, 0), 1)`.

This clamps daylength contribution to a 10–11 hour window, then to 1. For polar-summer cells the formula is fine, but this is also the formulation that was reported as "simplified version of Jolly et al." (line 115) -- any difference from Jolly's original (which uses 10 and 11 explicitly) should be flagged.

**Recommendation.** Either confirm the formula matches the cited Moore_2015 simplification (in which case state so) or add a one-line note that the daylight upper-clamp differs.

### m5. Eq. 7 nomenclature: is `s^USGS_c` a withdrawal share or a use share?

**Where:** Eq. 8 setup (lines 221–230).

USGS reports both groundwater and surface-water *withdrawals* (Dieter 2018, Skinner 2025). The text says "USGS observations" without specifying whether the share is computed from withdrawals or consumptive use. If GCAM's renewable-share split is on withdrawals and USGS is being used on the same basis, say so explicitly.

### m6. Fig. 1 caption acronyms (HUC2, GSI, HDD/CDD, etc.) not defined

**Where:** Fig. 1 caption (line 79).

Spell out HUC2, PET, HDD, CDD, GSI, GLW, CERF, SSP, RCP, TGW-WRF on first use in the caption. Source has an explicit author comment to do this (line 74). Apply broadly to all figures.

### m7. Fig. 4 discrepancy with abstract claim should be addressed in figure caption

**Where:** Fig. 4 caption (line 317); abstract claim (line 47).

If the abstract retains the "10% at CONUS" framing (per M1's recommendation), Fig. 4's caption should explicitly explain why HUC6 spans −75% to +25% -- that the CONUS aggregate is the result of partially-canceling sector errors. This is also flagged in a source comment at line 312.

### m8. Fig. 7 Domestic seasonal cycle: phase mismatch is visible but unaddressed

**Where:** Fig. 7; description at line 342.

The Domestic seasonal cycle in the figure shows a magnitude bias *and* an apparent phase offset. The text discusses the magnitude only.

### m9. Inter-scenario discontinuity at 2020 is acknowledged but its magnitude is not

**Where:** Line 353.

"The discontinuity at 2020 between the historical and future lines reflects the switch …" -- but the magnitude of the discontinuity is never given. A user splicing historical-future records will want to know this number per sector.

### m10. Conveyance-loss variant under-documented

**Where:** Line 243 (`_with_losses` filename mention); Limitations line 371.

What loss rate? Constant or spatially varying? Source? Two sentences would close this.

### m11. "PIPELINE.md" referenced in Code availability is repo-internal

**Where:** Line 431.

Reference to a specific file within the integration meta-repo will rot. Source already has an author comment to genericize this. Make it "see the README of the integration meta-repository."

### m12. Fig. 9 (dominant-sector map) has no in-text reference

**Where:** Fig. 9 (lines 392–397); appears after "Usage Notes" header without text pointing the reader to it.

### m13. References to "scenario YAMLs included" in code-availability section need a path

**Where:** Line 245.

Within each scenario directory at MSD-Live? Confirm and state.

### m14. Eq. 9 (Domestic monthly) -- what happens when `T_max - T_min` is small (Hawaii-like)?

**Where:** Eq. 9 (line 214).

CONUS includes coastal cells (Pacific NW coastal, FL, etc.) where `T_max - T_min` is small. The amplitude of the temperature normalization is then large, amplifying R. Confirm that this is bounded; if not, note as a limitation.

### m15. Skinner 2025 citation appears 3× and is asked to do a lot of work

**Where:** Lines 299, 303, 417.

Used as evidence for: (a) "three sectors account for >90% of CONUS water demand," (b) electricity withdrawal trend, (c) "refreshed January 2025 USGS water-use record." This is fine if Skinner 2025 actually establishes all three; if not, supplement with the appropriate USGS Circular.

### m16. Linear interpolation of decadal SSP population across 10-year intervals is not validated

**Where:** Line 150.

Linear interpolation is the standard choice but introduces piecewise-linear kinks at decadal boundaries. Worth one sentence noting whether kinks are visible in CONUS Domestic time series.

### m17. The `\bibliography{Tethys}` directive points at the 270-KB Tethys.bib

**Where:** Line 455.

This is a Zotero-style export. Two .bib files (`paper.bib` 17.5 KB, `Tethys.bib` 270 KB) coexist in the folder. Coauthors handed off between the two could end up editing the wrong one. Recommend deleting `paper.bib` if it is no longer used, or annotating both with a top-level comment indicating which is canonical.

### m18. Author contributions are templated with placeholder text

**Where:** Lines 440–449. Self-flagged as TODO. Resolve before submission.

---

## Editorial / Polish

- **Line 14**: ASCII corruption in the comment-rule (`-ÅÎÅ-`). Cosmetic, but visible in the source.
- **Line 39**: "College Park, MD" -- JGCRI is at PNNL/UMD; verify the affiliation string.
- **Line 46**: "low-emission" vs. "lower-emissions" -- inconsistent across the paper.
- **Line 48**: "Future scenarios represent a wide yet plausible range …" -- the abstract sentence runs long; consider splitting.
- **Line 62**: "demand-side drivers, not supply-side limits, dominate most projected shifts in water scarcity" -- strong claim; check that `RN12` and `RN6` actually support both directions of this. The distinction is contested in some recent literature.
- **Line 102**: Section heading "Methods and Data" -- *Scientific Data* descriptors usually use "Methods" only.
- **Line 112**: "scnearios" → "scenarios".
- **Line 146**: "Capacity Expansion Regional Feasibility (CERF)" -- the model is more commonly cited as "Capacity Expansion Regional Feasibility" but check Vernon 2021 for the exact expansion.
- **Line 154**: "Mapping of GCAM sectors to GLW animals follows Table~\ref{tab:livestock}" -- table is fine, but consider renaming animals to match GCAM sectors (Sheep+Goat, etc.) for visual consistency.
- **Line 183**: Eq. 6 has a stray `\quad` before the comma. Check rendering.
- **Line 199**: Case 3 condition `H_y < 650 and C_y ≥ 450` returns `(CDD/C_y, CDD/C_y)` -- this assigns the cooling distribution to *both* heating and cooling shares. Confirm this matches code; the body text on line 208 says "collapse onto whichever signal is non-trivial", but a heating-share `p_heat` modulated by a cooling-pattern `\hat h_m` is unusual. Worth a sanity-check sentence.
- **Line 240**: MSD-Live link is a `data.msdlive.org/uploads/` upload path, not a DOI. Replace with the DOI before submission. Already self-flagged at line 239.
- **Line 242**: "and permanently on MSD-Live" is partial sentence; rewrite.
- **Line 387**: Conversion `1 km³ yr⁻¹ ≈ 723.8 MGD` -- the existing pipeline code uses `264172.05124/365 = 723.760` MGD. The text rounds to 723.8 -- check if 723.76 is more accurate.
- **Line 415**: "16x improvement in areal resolution" is correct (4²=16) but conflict with "factor-of-four improvement in each dimension" -- clarify "factor of four per dimension, sixteen by area."
- **Line 417**: Sentence "supports detailed scenario." is truncated.
- **Line 446**: "K.M. Developed CERF CERF--Tethys integration" -- duplicate "CERF".

---

## Strengths Worth Noting

- **Table 1** is a strong piece of motivation. Clear, comparable, and convincing.
- **Sec. "Improvements over previous version"** (lines 401–417) is the right structure for a *Scientific Data* descriptor. Each numbered improvement maps to a specific Methods subsection.
- **Honest limitations.** The "frankenstein" caveat (line 234), the explicit `min(·,1)` clip in Eq. 8, the conveyance-loss variant disclosure, and the static-livestock acknowledgement set the right standard for a multi-input descriptor.
- **FAIR alignment** is strong: MSD-Live archive, scenario YAMLs, GitHub repos, packaged CLI (`pip install tethys-downscale`).
- **Equation development** for irrigation (Eqs. 1–4) and electricity (Eqs. 5–6) is well-grounded -- the reader can reproduce the math from the text alone.
- **Resolution refinement narrative** (1/2° → 1/8°, with proxy refinement at finer grain) is the right way to motivate a CONUS dataset over a global one.

---

## Citation Audit (cite keys used in `main_v2.tex`)

All 30 keys resolve to entries in `Tethys.bib`. The audit below flags maintainability and completeness issues only -- no key is genuinely missing **except `TODO-TGW-WRF`** which is a literal placeholder.

| Key | First-line resolved | Action |
|---|---|---|
| `Abeshu_2023` | (verify Tethys.bib) | OK if author-year style |
| `BIJL201675` | Bijl et al. 2016 | Rename to `Bijl_2016` for consistency |
| `Binsted_2022` | Binsted et al. 2022 | OK |
| `Gilbert2018` | Gilbert et al. 2018 (GLW3) | OK |
| `Graham_2020` | Graham et al. 2020 | OK |
| `HADJIMICHAEL23` | Hadjimichael et al. 2023 | Rename to `Hadjimichael_2023` |
| `hess-17-4555-2013` | HESS auto-key | Rename to lead-author year (consistency) |
| `hess-22-2117-2018` | Huang et al. 2018 | Rename to `Huang_2018` |
| `Jolly_2005` | Jolly et al. 2005 | OK |
| `Jones_2016` | Jones & O'Neill 2016 | OK |
| `Jones_2024` | Jones et al. 2024 | OK |
| `Khan2023` | Khan et al. 2023 | OK |
| `Moore_2015` | Moore et al. 2015 | OK |
| `RN1` | Calvin et al. 2019, *Geosci. Model Dev.* -- GCAM v5.1 (DOI: 10.5194/gmd-12-677-2019) | **Rename → `Calvin_2019_GCAM`** |
| `RN6` | Kyle et al. 2023, *Earth's Future* -- Sustainable Agriculture Matrix projection (DOI: 10.1029/2022EF003323) | **Rename → `Kyle_2023`**. Re-evaluate placement: this is an agriculture-projection paper, used in line 62 to support a *water-scarcity drivers* claim -- verify that claim is actually in this source |
| `RN9` | Niazi et al. 2024, *Nat. Sustain.* -- Global peak water limit of future groundwater withdrawals (DOI: 10.1038/s41893-024-01306-w) | **Rename → `Niazi_2024_peakwater`**. Strong fit for line 62. |
| `RN12` | Awais et al. 2024, *preprint* -- Global Water Basins under Combined Climate Mitigation, Adaptation, and SDGs (DOI: 10.21203/rs.3.rs-4149842/v1) | **Rename → `Awais_2024_preprint`**. **Caution: still a preprint** -- check current publication status before submission and use the published version if available |
| `RN13` | Zhao et al. 2024, *Geosci. Model Dev.* -- GCAM-GLORY v1.0 reservoir water storage (DOI: 10.5194/gmd-17-5587-2024) | **Rename → `Zhao_2024_glory`** (avoids collision with existing `Zhao2024`) |
| `RN15` | Niazi et al. 2025, *Geosci. Model Dev.* -- Superwell v1.1 hydro-economic groundwater (DOI: 10.5194/gmd-18-1737-2025) | **Rename → `Niazi_2025_superwell`** |
| `Roy_2005` | Roy et al. 2005 | OK |
| `skinnerWaterWithdrawalConsumption2025` | Skinner et al. 2025 | Rename to `Skinner_2025` (length) |
| `TODO-TGW-WRF` | **MISSING** -- placeholder | **Add real entry**: Jones et al. 2023 *Scientific Data* "Im3/IM3 TGW" or Burleyson et al. 2024 |
| `van_Vliet_2021` | van Vliet et al. 2021 | OK |
| `Vernon-2018` | Vernon et al. 2018 (Demeter) | OK |
| `Vernon2021` | Vernon et al. 2021 (CERF) | OK |
| `Wada_2017` | Wada et al. 2017 | OK |
| `Wada2011` | Wada et al. 2011 | OK |
| `WWDR2019` | UN World Water Development Report 2019 | OK |
| `Zhao_gcamusa_water` | Zhao et al. (GCAM-USA water) | Rename to `Zhao_<year>` (consistency) |
| `Zhao2024` | Zhao et al. 2024 | OK |

**Notable observations from the audit:**

- **All `RN*` keys are real papers and resolve cleanly.** Five of six are tightly relevant to the manuscript's claims (Calvin 2019 for GCAM v5.1, Niazi 2024 for groundwater limits, Zhao 2024 GLORY for reservoir representation, Niazi 2025 Superwell for hydro-economic groundwater). One (`RN6` Kyle 2023) is an agriculture-projection paper currently cited on line 62 as evidence for water-scarcity demand-side drivers -- a weaker fit; consider replacing with a more directly water-focused citation.
- **`RN12` (Awais et al. 2024) is still listed as a preprint** in the bib. Verify whether it has been published; if still a preprint, this is a load-bearing citation (line 62) that should be flagged or replaced.
- **`Zhao_gcamusa_water` is "in-review 2026"** with no DOI. As a load-bearing methods reference (cited at line 106 introducing GCAM-USA), this is risky -- secure a preprint DOI or supplement with the 2024 paper before submission.
- **TGW-WRF placeholder (`TODO-TGW-WRF`)** must be resolved. Likely target: Jones et al. 2023 *Scientific Data* "An open-source thermodynamic global warming dataset for impact-relevant climate change research at high resolution" or the Burleyson et al. CONUS-WRF release. Will be staged in `new-entries.bib`.

---

## Suggested Additional Citations (reviewer-led, to be filled)

This section will be populated by the next phase using `research-lookup` to find recent (2023–2026) literature relevant to the issues raised above. Specifically:

| Review issue | Lit-search query | Why |
|---|---|---|
| M2 (validation metrics) | "spatial autocorrelation in water-use validation HUC bootstrap" | Anchor block-bootstrap recommendation in published precedent |
| M2 (KGE/NSE) | "KGE NSE water demand validation gridded" | Justify metric choice |
| M3 (mass-balance under clip) | "USGS-anchored downscaling mass balance" | Comparable methodology in recent water-resources work |
| M5 (Domestic R coefficient) | "domestic water demand temperature anomaly post-2015 USGS" | Determine whether updated R values exist |
| M7 (Background datasets) | "CONUS gridded water demand 2024 2025 dataset" | Find newer comparison datasets to refresh Table 1 |
| M1 / M2 (UQ in projected demand) | "ensemble water demand projection uncertainty quantification 2024" | Frame Fig. 8 envelope recommendation |
| Background freshness | "monthly sectoral water use CONUS 2024 2025" | Recent methodological advances since draft |
| TGW-WRF primary ref | "TGW-WRF thermodynamic global warming meteorological dataset" | Resolve `TODO-TGW-WRF` placeholder |
| GODEEEP-hydro ref | "Bracken GODEEEP hydropower 2025" | Resolve header TODO |

These queries will be executed in the next phase and concrete BibTeX entries staged in `new-entries.bib`.

---

## Summary of Required Revisions

The two highest-priority items are:

1. **Reframe abstract and validation summary (M1)** to lead with sector-level findings and explicitly note that aggregate agreement reflects partial cancellation of opposing biases. This is the single most consequential edit and is a few sentences.
2. **Add a complete validation metrics table with uncertainty (M2)**, including bootstrap CIs that respect spatial autocorrelation, sample sizes, NSE/KGE, MBE, NRMSE, Spearman ρ, and a phase metric for seasonal cycles.

Items M3–M5 (Eq. 8 clip characterization, Eq. 5 threshold sensitivity, Domestic bias diagnosis) are short text additions plus one figure each. M6 is a figure update. M7–M8 are editorial. Minor and editorial issues are largely sentence-level.

None of the findings call into question the value of the dataset, the soundness of the GCAM-USA → Tethys → mosartwmpy chain, or the appropriateness of *Scientific Data* as a venue. A revised manuscript that addresses M1–M3 and M5 should be ready for acceptance.

---

## Comparison with prior review (`TETHYS_data_paper_v3-review.md`)

*(Added after independent draft was complete.)*

The prior review and this one converge on the most important issues -- sector-level bias in the abstract framing (issue 1 there ↔ M1 here), thin validation metrics (issue 2 ↔ M2), uncertainty quantification (issue 3 ↔ M2/M6), Domestic bias diagnosis (issue 4 ↔ M5), and the Eq. 8 clip behavior (issue 5 ↔ M3). The two reviews recommend the same overall posture (revision, minor-to-major).

This independent review goes further on three points: (a) M4 (Eq. 5 HDD/CDD threshold sensitivity) was not raised in the prior review; (b) M8 (`RN*` opaque cite keys as a maintainability issue) was not flagged previously; (c) the editorial pass identifies several specific source-level issues (line 14 ASCII corruption, line 199 case-3 sanity check, line 415 16x/4x phrasing, line 417 truncated sentence) that complement rather than duplicate the prior review.

The prior review goes further on visual scrutiny of Fig. 6 (anchored-by-large-basins concern) and on issue 22 (in-review reference handling). Both should be retained as part of the merged revision plan.
