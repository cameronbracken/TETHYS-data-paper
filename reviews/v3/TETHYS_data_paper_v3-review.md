# Review: TETHYS Data Paper v3

**Manuscript:** "High-resolution monthly sectoral water demands for the U.S. over 1980–2100"
**File:** `TETHYS_data_paper_v3.pdf` (14 pages)
**Venue:** Scientific Data (data descriptor)
**Date:** 2026-05-28

---

## Overall Assessment

**Recommendation: Minor revision.**

This is a well-scoped data descriptor presenting a genuinely useful CONUS-resolution multi-sector water-demand dataset that materially advances on its predecessors (Khan et al. 2023, Huang et al. 2018, Wada et al., van Vliet et al.). Table 1 establishes the contribution clearly: 4× spatial resolution refinement, GW/SW split, scenario-consistent inputs, and 8-scenario ensemble together justify a separate descriptor. Methodology is sound, the workflow well-documented, and FAIR compliance is strong (MSD-Live archive, scenario YAMLs included, GitHub repos linked).

The main weaknesses are (a) the technical validation is statistically thin for a Scientific Data descriptor — Pearson correlations and a single CONUS-scale percent agreement number are not enough — and (b) the abstract framing oversells aggregate agreement that is partly an artifact of compensating sector-level biases. Both are addressable with the existing outputs.

The honest treatment of method limitations (the "frankenstein-design" caveat, the explicit min(·,1) clip in Eq. 8, the conveyance-loss variant) is exemplary for the genre.

---

## Ranked Issues

### MAJOR

#### 1. Sector-level bias framing in abstract and validation summary
**Where:** Abstract (lines 9–10); "Improvements" summary (line 268–269); contradicts Fig. 4 and line 179–180.

The abstract states the dataset "validates well against USGS at HUC6 (annual correlations of 0.71–0.95)" and is "within 10% at CONUS scale." Figure 4 shows Domestic withdrawals biased ~−45% and Electricity withdrawals ~−30% at HUC6, with sign-opposing biases that partially cancel at the CONUS total. The CONUS-scale agreement is therefore partly an artifact of compensating errors. Line 179–180 acknowledges this; the abstract does not. A naive reader will infer 10% accuracy applies at the sector level — it does not.

**Recommendation:** Revise the abstract to lead with sector-level findings, e.g.: "annual CONUS totals agree within 10%; sector-level HUC6 biases range from approximately −45% (Domestic) to +5% (Irrigation withdrawals), with HUC6 spatial-pattern correlations of 0.71–0.95." Add a sentence to the validation summary explicitly noting that aggregate agreement reflects partial cancellation of opposing sector biases. **This is the single most important framing change.**

#### 2. Validation relies on a narrow and incomplete metric set
**Where:** Lines 168–169 (abstract claim); Fig. 6; Technical Validation throughout.

Validation rests on (a) "within 10% at annual resolution" for CONUS totals and (b) Pearson r 0.71–0.95 at HUC6. These are insufficient: Pearson r is dominated by a few large basins (visible in Fig. 6, where one or two points anchor each regression), invariant to multiplicative bias, and conflates spatial pattern with magnitude. The "within 10%" claim is a single number with no uncertainty and no per-sector decomposition stated quantitatively. No RMSE, NRMSE, MAE, MBE, NSE/KGE, Spearman rank, or concordance correlation is reported. No bias decomposition (mean / variance / phase) is provided for the seasonal cycle in Fig. 7 despite visible phase/amplitude differences in Electricity and Domestic.

**Recommendation:** Add a validation table reporting, for each sector × demand-type at HUC6: n, Pearson r, Spearman ρ, NSE or KGE (with α/β/r decomposition), MBE, NRMSE, and median absolute percent error with IQR. For seasonal cycles (Fig. 7) report monthly RMSE and a phase metric (e.g., circular correlation or month-of-peak agreement).

#### 3. No uncertainty quantification on validation statistics or scenario outputs
**Where:** Fig. 6 (correlations); Fig. 8 (scenario trajectories); Technical Validation.

Pearson r values in Fig. 6 are reported to three significant figures with no confidence intervals, no n stated, no significance test. With ~200 HUC6s nationally, CIs on r=0.71 vs r=0.95 differ materially. Fig. 5 shows clear regional clustering (eastern Electricity overestimates, western Irrigation underestimates), implying spatial autocorrelation that inflates effective n for r. Fig. 8 inter-scenario trajectories are deterministic lines with no envelope despite the dataset being explicitly "scenario-plausible" (line 149).

**Recommendation:** (i) Block-bootstrap (by HUC2 to respect spatial dependence) 95% CIs on all reported correlations and biases. (ii) Test residual spatial autocorrelation (Moran's I) and report effective n. (iii) For Fig. 8, add at minimum the spread across the climate sample (cooler/hotter) as a shaded band, or state explicitly that the 8-member ensemble is too small for meaningful UQ.

#### 4. Domestic −45% bias is large and under-explained
**Where:** Fig. 4; lines 192–194.

The Domestic consumption bias of ~−45% is striking and is attributed only briefly to the Wada et al. R amplitude coefficient. The magnitude warrants a clearer diagnosis: is this a units issue (consumption vs. withdrawal accounting), a GCAM-USA municipal demand magnitude issue, or a downscaling artifact? Users planning Domestic-sector scarcity analysis need to know whether the bias is a known offset (correctable) or a structural limitation. The line 192–194 attribution is asserted, not demonstrated — no diagnostic plot or fit statistic supports it.

**Recommendation:** Add 2–3 sentences in Technical Validation or Limitations diagnosing the source. If GCAM-USA municipal totals are the source, say so. If a consumption-fraction assumption, document it. Consider providing a per-HUC6 bias-correction factor as an ancillary file, or guide users on how to apply USGS-anchored scaling for domestic scarcity. Either show a diagnostic (e.g., scatter of monthly Tethys/USGS ratio vs R) or soften the language to "consistent with."

#### 5. Eq. 8 min(·,1) clip is asymmetric and its effect is unquantified
**Where:** Eq. 8 (line 138–140).

Eq. 8 clips the adjusted renewable share at 1 only for cells in 𝓜 (where both s^GCAM_2015 > 0 and s^USGS exists) and leaves cells outside 𝓜 untouched. Three problems:
- **Mass not conserved:** when min(·,1) binds, the implicit non-renewable share at that cell is set to 0, but the basin total is not re-normalized — basin renewable/non-renewable totals can drift from GCAM.
- **One-sided clip:** ratios that *shrink* the renewable share (s^GCAM_y/s^GCAM_2015 < 1) apply without floor; ratios that *grow* it are capped. This systematically biases historical-anchored cells toward lower renewable shares relative to un-anchored cells.
- The fraction of cells in 𝓜, the fraction where the clip binds, and basin-level mass-balance error are never reported.

**Recommendation:** Report (a) the share of CONUS cells and CONUS demand volume in 𝓜; (b) the fraction of cell-years where min(·,1) is active, in 2015 and at end-of-century for each scenario; (c) basin-level mass-balance residuals (GCAM basin renewable total vs sum of s^adj × demand). Justify why a symmetric correction (logistic transform, or basin-renormalized rescaling) was rejected. If the clip-binding fraction is non-trivial (>5%), consider a renormalization step.

#### 6. Eq. 5 thresholds (HDD ≥ 650, CDD ≥ 450) lack sensitivity analysis
**Where:** Eq. 5 (line ~119); line 124.

The piecewise definition introduces hard discontinuities at H_y = 650 and C_y = 450. Cells near either threshold can flip between case 1 (climate-weighted) and case 4 (uniform 1/12) from year to year as climate evolves over 2020–2100, producing artificial step changes unrelated to physical demand. The threshold convention is attributed to Huang et al. but no sensitivity test is shown, and the spatial extent of cells near the threshold is not mapped. Under warming, many historically case-1 cells will cross into case-3 (CDD only) — this transition is uncharacterized.

**Recommendation:** (i) Map the fraction of CONUS cells within ±20% of either threshold under historical baseline and rcp85hotter 2100. (ii) Run a sensitivity test perturbing thresholds to (550, 350) and (750, 550); report resulting CONUS monthly Electricity demand spread. (iii) Consider replacing the hard switch with a smooth blend (e.g., logistic weighting of the four cases).

#### 7. Box-plot statistics underspecified (Figs 4, 7)
**Where:** Fig. 4, Fig. 7 captions.

Central evidence figures with missing statistical anatomy: (a) n underlying each box (HUC6 count for CONUS, presumably ~200, never stated; Fig. 7 monthly box presumably across years 2000–2020, n=21, never stated); (b) whisker definition (Tukey 1.5×IQR? min/max?); (c) outlier-inclusion rule; (d) the exact denominator for "percent difference (USGS−Tethys)" — (USGS−Tethys)/USGS, /Tethys, or /mean? With small n, percent-difference distributions are highly skewed; median ± IQR can mislead. Fig. 4 Domestic shows visible outliers near −75% — not discussed.

**Recommendation:** State n, whisker rule, and percent-difference formula in each caption. Where percent differences are skewed, also report the symmetric percent difference 2(A−B)/(A+B) or use log-ratios. Discuss the outlier basins explicitly.

#### 8. Historical-to-future discontinuity at 2020 deserves more than one sentence
**Where:** Lines 199–202; Fig. 8.

Lines 199–202 acknowledge a visible discontinuity in Fig. 8 between the historical (ERA5-driven) record and the future (TGW-driven) runs at 2020. Consequential for users computing trends or anomalies that span 2015–2025. Treatment is one sentence in "Inter-scenario consistency."

**Recommendation:** Promote to Limitations as a distinct bullet. State the magnitude of the offset (quantify for at least Total). Recommend a concrete approach: use historical only through 2019 and futures from 2020 forward as separate baselines, or document a bias-adjustment recipe.

#### 9. GCAM-USA 5-year linear interpolation artifact not addressed as a Limitation
**Where:** Lines 105, 252; line 175 acknowledges reduced interannual variability for irrigation.

Linear interpolation between 5-year GCAM steps suppresses interannual variability and creates artificial smoothness in trend metrics. The trend lines in Fig. 3 are visibly straighter than USGS — a likely consequence. This is a structural feature downstream users (especially scarcity-event statistics) need to understand explicitly.

**Recommendation:** Add a Limitations bullet "Interannual smoothing from 5-year GCAM steps." Quantify (e.g., ratio of Tethys to USGS interannual standard deviation at HUC6 for at least Irrigation withdrawals). Explicitly state that this dataset is appropriate for scenario-level and climatological-mean analyses but not for replicating observed year-to-year demand variability.

#### 10. Uncertainty propagation is not quantified anywhere
**Where:** Lines 141–150 (frankenstein caveat); Technical Validation; Usage Notes.

The "frankenstein" caveat is honest but does not translate into a usable uncertainty estimate. Users get no guidance on relative magnitudes from GCAM-USA scenario assumptions vs. proxy choice vs. climate sample vs. source-share adjustment. For a dataset intended to "support sensitivity and adaptation studies" (line 150), structured uncertainty discussion is essential.

**Recommendation:** Add a short "Uncertainty considerations" subsection (within Technical Validation or Usage Notes) that ranks the dominant uncertainty sources qualitatively, ideally with reference to the inter-scenario spread visible in Fig. 8 as a lower bound on combined uncertainty. Even semi-quantitative ranking would strengthen the paper considerably.

---

### MINOR

#### 11. Livestock static-2010 distribution bias not quantified
Lines 97–99, 205–207. The ~2% aggregate share is offered as mitigation but localized basin-level error in rapidly shifting states (CA→ID dairy, DE/MD poultry) is plausibly material. State-level USDA NASS inventories could bound it. **Recommendation:** Compare GLW3-2010 to USDA NASS 1980/2000/2020 for 2–3 shifting states; report % drift in livestock demand at HUC6.

#### 12. Fig. 8 has no significance/separability test for scenario divergence
Lines 196–202. SSP3 vs SSP5 distinguishability given climate-sample spread is not tested. Independent y-axes (caption) can visually exaggerate small differences. **Recommendation:** Add a fixed-axis version in supplementary; report end-of-century (2090–2099) ensemble means ± range by SSP and RCP in a small table.

#### 13. Fig. 3 trend lines lack slope/CI annotation
Slopes, p-values, and trend-distinguishability are not given. Electricity withdrawal decline is attributed to coal switch but rate not compared. **Recommendation:** Annotate slopes (km³/yr per decade) with 95% CIs; report whether Tethys and USGS slopes overlap.

#### 14. USGS HUC6 reference data uncertainty treated as zero
Validation implicitly attributes all disagreement to Tethys. USGS 5-year compilations have documented reporting/estimation uncertainty (especially Domestic post-2015 with public-supply-only redefinition). **Recommendation:** Add one paragraph acknowledging USGS uncertainty (cite Skinner et al. 2025, ref 29); frame metrics as "agreement with USGS" rather than "error."

#### 15. Title slightly oversells temporal reach
Title "1980–2100" masks the 2019/2020 split and discontinuity. **Recommendation:** Acceptable as-is, or "1980–2099 across historical and eight future scenarios."

#### 16. Manufacturing/mining basin-specific failures unflagged
Lines 100–103, 208–210. Specific basins (Permian, Powder River, Marcellus) have industrial water use far above population-weighted estimate. **Recommendation:** Name 2–3 known-failure basins so users can flag them.

#### 17. "Frankenstein" terminology in formal manuscript
Line 148–149. Colloquial; while candor is welcome, reads as informal. **Recommendation:** Replace with "modular" or "component-coupled," or quote once and proceed with the formal label.

#### 18. Audience and use cases not explicitly stated
Implies users (water managers, IAM modelers, mosartwmpy users) but never names them. **Recommendation:** Add 3–4 sentences to Usage Notes naming primary user communities and 2–3 cautionary use cases (e.g., not for plant-specific cooling-water permitting).

#### 19. Reproducibility — version pinning unclear for non-Tethys components
Tethys versions pinned in YAMLs. Demeter, CERF, GCAM-USA (ref 23 has DOI — good), TGW-WRF, Jones-O'Neill, GLW3, GPPD versions/commits not consistently pinned. **Recommendation:** State specific version/commit/DOI for each upstream component.

#### 20. Conveyance-loss variant under-documented
Lines 220–221. The `_with_losses` files exist but loss assumption (rate, source, spatial variation) is not documented. **Recommendation:** 2 sentences specifying formulation, source, spatial variation.

#### 21. Figure 9 (dominant sector map) appears without textual reference
Page 13, no in-text citation. **Recommendation:** Cite in Usage Notes as an example product.

#### 22. Reference 9 (Zhao et al., "In-review 2026") needs preprint DOI or de-emphasis
**Recommendation:** Provide a preprint DOI if available; otherwise ensure the claim does not rely on the in-review reference alone.

#### 23. Abstract claim of novelty should reference Table 1
**Recommendation:** Add a phrase pointing readers to Table 1.

---

## Strengths Worth Noting

- **Table 1** is convincing evidence of contribution beyond a methods footnote.
- The honest treatment of method limitations (Limitations section, frankenstein caveat, explicit clipping rule) is exemplary.
- Validation moves systematically from CONUS annual → HUC6 spatial → seasonal cycle.
- Code/data availability is strong: MSD-Live archive, scenario YAMLs included, GitHub repos linked.
- Temporal-downscaling formulation (GSI-deficit weights for irrigation, HDD/CDD for electricity, Wada anomaly for domestic) is well-grounded and clearly specified.

---

## Summary of Required Revisions

The two highest-priority items are:

1. **Reframe abstract and validation summary** to lead with sector-level results and acknowledge that aggregate agreement reflects partial cancellation of opposing biases (Issue 1).
2. **Add a proper validation metrics table** with bootstrap CIs accounting for spatial autocorrelation, and quantify the Eq. 8 clip behavior and Eq. 5 threshold sensitivity (Issues 2, 3, 5, 6).

Issues 4, 7, 8, 9, 10 should be addressable via additional Limitations bullets and short diagnostic text. The minor issues are largely editorial. None of the findings calls into question the value of the dataset or the soundness of the underlying methodology.
