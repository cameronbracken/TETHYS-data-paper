# Independent Review: TETHYS CONUS Data Paper — v3

**Manuscript:** "High-resolution monthly sectoral water demands for the U.S. over 1980–2100"
**File reviewed:** `main_v3.tex` (455 lines, written 2026-05-28)
**Bibliography:** `Tethys.bib` (28 entries, restructured 2026-05-28)
**Target venue:** *Scientific Data* (data descriptor; `wlscirep.cls`)
**Reviewer:** Independent, AI-assisted (Claude Opus 4.7)
**Date:** 2026-05-29
**Note on independence:** This review focuses on issues new or remaining in v3, with explicit reference to which prior-review issues v3 has resolved.

---

## Overall Assessment

**Recommendation: Minor revision.**

v3 is a substantial improvement over v2. The two highest-priority items from the prior review are now addressed: (a) the abstract has been rewritten to lead with sector-level biases, and (b) a validation metrics table (Table 2) has been added with Pearson r, Spearman ρ, NSE/KGE, MBE, NRMSE, and MedAPE. The opaque `RN*` cite keys have been resolved to proper author-year keys, the `TODO-TGW-WRF` placeholder has been replaced with the canonical `Jones2023TGW` reference, and a new bias-diagnosis subsection has been added.

**However**, v3 introduces several issues that need to be cleaned up before submission. Most importantly: **the values in the new validation metrics table (Table 2) appear to be illustrative rather than computed from the actual outputs.** The "Industrial" sector row is not part of the dataset's six-sector decomposition (which is Irrigation, Electricity, Domestic, Livestock, Manufacturing, Mining), and the row values do not reconcile with the text or figures. This is the single largest blocker — the table either needs to be replaced with real numbers or removed.

Beyond Table 2, v3 has duplicated paragraphs in the Background, an unresolved cite-key collision in Table 1, several leftover TODO and stub artifacts in the file header and author-contributions section, and a still-unresolved Bracken 2025 GODEEEP-hydro reference flagged in the file header. None of these threaten the contribution; they are the kind of issues that arise from a fast revision pass and need a brief clean-up before submission.

If the validation table is replaced with real numbers and the duplications/TODOs are addressed, this manuscript should be ready for *Scientific Data* on a minor-revision turnaround.

---

## What v3 Has Resolved (from prior review)

| Prior issue | Status | Where |
|---|---|---|
| **M1.** Abstract overstates aggregate agreement | **RESOLVED.** Abstract now leads with sector-level biases (−45% Domestic, −30% Electricity, +5% Irrigation) and explicitly notes cancellation. | Line 45 |
| **M2.** Validation metrics panel incomplete | **PARTIALLY RESOLVED.** Table 2 added with Pearson r, Spearman ρ, NSE/KGE, MBE, NRMSE, MedAPE. **However see Critical Issue C1 below — values appear illustrative, not computed.** Sample size n=208 added to figure captions for Figs 4 and 6. CIs and Moran's I still missing. | Lines 287–304, 319, 337 |
| **M5.** Domestic −45% bias asserted not demonstrated | **PARTIALLY RESOLVED.** New "Bias diagnosis and uncertainty" subsection added (line 341). Two candidate explanations now offered (Wada R coefficient, GCAM-USA base-year mismatch) and USGS uncertainty acknowledged with `Skinner2025USGS` and `Stets2025USGS` citations. **Still no diagnostic plot.** | Lines 341–342 |
| **M8.** Opaque `RN*` cite keys | **RESOLVED at the bib level.** All renamed to author-year keys (`Calvin2019GCAM`, `Niazi2024PeakWater`, etc.) in `Tethys.bib`. Manuscript updated. | Throughout |
| **`TODO-TGW-WRF`** placeholder | **RESOLVED.** Replaced with `\cite{Jones2023TGW}` at lines 102 and 427. | Lines 102, 427 |
| **m6.** Fig. 1 caption acronyms | **PARTIALLY RESOLVED.** Caption is unchanged in v3, still mentions HUC2, GSI, HDD/CDD without expansion. Recommend defining on first use in caption. | Line 70 |
| Comment-driven cleanup | **RESOLVED.** All `% COMMENT` review markers removed from v2. | Throughout |

## What v3 Has Not Addressed (still applies from prior review)

| Prior issue | Status | Where |
|---|---|---|
| **M3.** Eq. 8 `min(·,1)` clip asymmetry, mass balance, coverage of 𝓜 | **NOT ADDRESSED.** Equation unchanged. Text discussion has minor reword (line 217: "reflecting the trade-off between mass balance conservation and binding fraction limits"), but the three quantitative items (fraction in 𝓜, fraction where clip binds, basin-level mass-balance residual) are still missing. | Lines 213–217 |
| **M4.** Eq. 5 thresholds (HDD ≥ 650, CDD ≥ 450) sensitivity | **NOT ADDRESSED.** No partition fractions, no sensitivity test. | Line 195 |
| **M6.** Fig. 8 lacks uncertainty envelope | **NOT ADDRESSED.** Figure 8 still shows deterministic single trajectories. | Line 357 |
| **M7.** Background does not explicitly contrast each row of Table 1 | **PARTIALLY RESOLVED.** Background reorganization (lines 58–60) now explicitly references Huang 2018, Wada 2017, van Vliet 2021, Khan 2023 — but the contrast is implicit, not row-by-row as recommended. Acceptable for *Scientific Data*. | Lines 58–62 |

---

## Critical Issues (v3-specific)

### C1. Validation metrics table values appear illustrative, not computed

**Where:** Table 2 (lines 287–304); referenced from Bias-diagnosis section line 341.

The table reports a row for an "Industrial" sector that is not part of the dataset's actual six-sector decomposition. The manuscript repeatedly states the dataset covers six sectors: Irrigation, Electricity (= Thermoelectric), Municipal/Domestic, Livestock, Manufacturing, and Mining (lines 64, 230). Manufacturing and Mining are also explicitly stated to use a population proxy at line 175 and discussed in Limitations (line 369). Neither is called "Industrial," and no discussion in the Technical Validation text references an Industrial validation result.

In addition, the values in the table do not cleanly reconcile with the text or figures. The text states (line 325) that HUC6 Pearson correlations range from **0.71 to 0.95** across Domestic / Electricity / Irrigation. Table 2 shows 0.71 / 0.88 / 0.95 for those three sectors — consistent with the text. But it also shows Industrial (0.82), Livestock (0.85), and a Total of 0.93 (NSE/KGE 0.82, MBE −10%) — none of which are mentioned anywhere in the body. The figures (Fig. 5, Fig. 6) only show Domestic / Electricity / Irrigation.

This is the most consequential issue in the v3 draft: a *Scientific Data* validation table that contains a non-existent sector and unmotivated rows undermines the credibility of the entire validation. Two reviewers would catch this.

**Recommendation.** One of the following:

1. **Preferred:** Replace Table 2 with the actually computed metrics for the three validated sectors (Domestic, Electricity, Irrigation) — the values for these three sectors in the table appear to be plausible but should be regenerated from the validation pipeline (`tethys_integration_metarepo/validation/` or `tethys-validation/`) and confirmed. Drop the Industrial, Livestock, and Total rows entirely; the manuscript is clear that only three sectors are validated.
2. **Acceptable alternative:** Add Manufacturing+Mining as a single row and Livestock as another (using their actual proxy-based estimates), but only after running the validation pipeline against USGS for those sectors. State clearly that those sectors carry larger uncertainty per the static proxies.
3. **Not acceptable:** Leaving the table as-is.

Whichever approach is taken, also add a citation or pointer to the script that produced the numbers so a reader can audit them.

### C2. Background paragraph 3 is duplicated

**Where:** Lines 62 and 64.

Two paragraphs both begin "We present such a dataset here." Line 62 is the new MSD-community framing added in v3; line 64 is the original v2 paragraph that was retained but should have been replaced. The result is repetitive and reads as an editing artifact.

**Recommendation.** Merge the two paragraphs. Suggested structure: keep the v3 framing about MSD and resolution refinement (line 62), then continue with the dataset specifics (extent, period, sector list, scenarios, source attribution, six improvements, Fig. 1, Table 1) currently in line 64. Cut the second "We present such a dataset here."

### C3. Cite key collision in Table 1: `hess-22-2117-2018` vs. `Huang2018`

**Where:** Table 1 (line 81); same paper used at line 195 in the Eq. 5 attribution context.

Table 1 still uses the old cite key `\cite{hess-22-2117-2018}` for the Huang et al. 2018 paper, but `Tethys.bib` now contains a clean `Huang2018` entry (line 136 of the bib) and **does not contain** `hess-22-2117-2018`. As a result `bibtex` will throw an "I didn't find a database entry for `hess-22-2117-2018`" warning and the citation will appear as a `[?]` in the rendered output.

The same paper IS already cited as `Huang2018` in line 60 of the Background. So the Table-1 reference is the only remaining occurrence of the old key.

**Recommendation.** Change `\cite{hess-22-2117-2018}` to `\cite{Huang2018}` at line 81. (The same fix at line 195 — Eq. 5 paragraph — is **already in place** in v3 if I'm reading correctly; double-check.) Once this is done, all 29 cite keys in v3 resolve cleanly in `Tethys.bib`. The duplicate restoration entry I staged in `new-entries.bib` for `hess-22-2117-2018` can then be removed; the staged `Huang2018` already in `Tethys.bib` is sufficient.

---

## Major Issues

### M1 (carryover). Eq. 8 clip characterization still missing

Same as prior M3. The text reword at line 217 ("reflecting the trade-off between mass balance conservation and binding fraction limits in groundwater-dominated regions") is helpful framing but does not provide the three numbers required: cells in 𝓜, cells where clip binds, basin-level mass residual. A reader using the dataset for a basin-balance study still cannot judge the impact of the clip.

**Recommendation.** Add three sentences in the "Gridded renewable vs. non-renewable source shares" subsection. These can be derived from the `gridded_runoff_shares.nc` files already in the dataset; no re-run required.

### M2 (carryover). Eq. 5 threshold sensitivity

Same as prior M4. v3 text is unchanged at line 195. One paragraph and a per-cell partition table (or supplementary figure) is sufficient.

### M3 (carryover). Fig. 8 envelope

Same as prior M6. v3 figure unchanged.

### M4 (new). Bias diagnosis subsection placement and figure-text mismatch

**Where:** Lines 341–342.

The new "Bias diagnosis and uncertainty" subsection is one paragraph long and is positioned between "HUC6 spatial agreement" (Fig. 6) and "Seasonal cycle" (Fig. 7) without a section break in the rendered output (the `\subsection*{Seasonal cycle}` directly abuts the bias-diagnosis paragraph on line 342, suggesting a missing newline). Also, the bias-diagnosis paragraph cites `Skinner2025USGS` and `Stets2025USGS` for "USGS reanalysis uncertainty" — which is the right framing — but does not actually quantify what that uncertainty is (e.g., USGS Circular 1492 vs. Stets reanalysis differences for the relevant sectors). This is fine for a one-paragraph addition but reads as a placeholder.

**Recommendation.** (a) Add a blank line before `\subsection*{Seasonal cycle}` at line 342 so it renders as a proper subsection. (b) If feasible, add one number quantifying the USGS-side uncertainty (e.g., the Stets reanalysis revised X% of HUC6 thermoelectric estimates by more than ±10%). (c) Otherwise, soften the language to "reference USGS estimates have themselves been revised in recent reanalyses" and let the citation do the work.

### M5 (new). Bracken 2025 GODEEEP-hydro reference still unresolved

**Where:** File header lines 12–13 ("TGW-WRF primary reference is missing from Tethys.bib; marked with TODO. Bracken et al. 2025 GODEEEP-hydro reference also missing; marked with TODO.").

The TGW-WRF half of this header note has been resolved (Jones2023TGW). The Bracken 2025 GODEEEP-hydro half has not been. The header note itself is now stale — the v2 header text was carried into v3 unchanged.

**Recommendation.** (a) Decide whether GODEEEP-hydro needs to be cited at all in this manuscript — if it is upstream of the GCAM-USA-CERF-Tethys-mosartwmpy chain or used in any of the inputs, cite it; if not, drop the TODO. (b) Update the file-header comment block to reflect the v3 state (TGW-WRF resolved; v2/v3 lineage description is now wrong).

---

## Minor Issues

### m1. File-header comment is stale

**Where:** Lines 1–14 of `main_v3.tex`.

The header still says "main_v2.tex — second draft of the Tethys data paper" and still flags the TGW-WRF TODO. With v3 now active, the header should be updated.

**Recommendation.** Rename file-header to "main_v3.tex — third draft" and remove resolved TODOs. Note that v3 is *not* a ground-up rewrite of v2 in the way v2 was of v1; describe the change correctly.

### m2. Header line 14 still has the corrupted ASCII rule

**Where:** Line 14 (`% ------------------------------------------ÅÎÅ-----------------------------------`).

Carryover from v2. Cosmetic but visible in the source.

### m3. Author-contributions section still labeled TODO

**Where:** Line 438 (`% TODO: coauthors to fill in per CRediT roles. Illustrative template:`).

The CRediT statement at lines 439–447 is still marked as illustrative. Resolve before submission.

### m4. Validation Metrics table caption refers to "Tethys 2.0"

**Where:** Line 302 (caption of Table 2).

The manuscript otherwise refers to the dataset as "Tethys CONUS multi-sector water-demand dataset" or just "Tethys" without versioning. "Tethys 2.0" appears only in the caption of Table 2 and is not defined elsewhere. Either define it consistently throughout (and add a small note explaining the 1.0 vs. 2.0 distinction relative to Khan 2023) or remove the "2.0" qualifier from the caption.

### m5. Bias-diagnosis subsection refers to "Wada $R$ coefficient"

**Where:** Line 342.

The body uses `R` for the amplitude coefficient throughout, so "Wada R coefficient" reads naturally — but cite `Wada2011` (which is in the bib and is cited at Eq. 9, line 213) at the first mention in the bias-diagnosis paragraph for clarity.

### m6. Skinner 2025 (`Skinner2025USGS`) and `skinnerWaterWithdrawalConsumption2025` are different papers cited inconsistently

**Where:** Bib has both `Skinner2025USGS` (Harris/Skinner et al., *Env. Modelling & Software*) and `skinnerWaterWithdrawalConsumption2025` (Skinner et al., *ACS ES&T Water*). The manuscript cites the latter at lines 284, 307, 416 (technical validation, electricity-trend, USGS-record-update) and the former at line 342 (bias-diagnosis).

These are different Skinner-led papers with different scopes (one on automated physics-based estimation, one on the 2008–2020 trend analysis). Both are valid and useful. But the reader will be confused if both keys appear with similar abbreviated citations.

**Recommendation.** Verify each citation is using the right Skinner paper. The 2008–2020 trend paper (`skinnerWaterWithdrawalConsumption2025`) is correct for the "decline in electricity withdrawals" claim at line 307. The "physics-based thermoelectric water-use estimation" paper (`Skinner2025USGS` — actually Harris/Skinner) is correct for the USGS-uncertainty discussion at line 342. Consider renaming `Skinner2025USGS` to `Harris2025` for clarity — the first author is Harris, not Skinner.

### m7. Number of HUC6s reported as n=208

**Where:** Figure captions for Fig. 4 (line 319) and Fig. 6 (line 337).

Good addition. Note: the standard HUC6 count for CONUS is 222 in WBDHU6, so 208 likely reflects basins with sufficient USGS data. Worth a sentence in the validation introduction stating which 14 (or 16) HUC6s are excluded and why (no USGS data, mainly coastal or great-lakes hydrologic regions).

### m8. Conversion `1 km³ yr⁻¹ ≈ 723.8 MGD` rounding

**Where:** Line 388. Carryover from v2 m11. The exact value is 723.760; "723.8" rounds to 4 sig figs but is slightly above. Either use 723.8 (if rounding) or 723.760 (if exact). Cosmetic.

### m9. "decline Electricity withdrawals" missing word

**Where:** Line 307. Should be "decline **in** Electricity withdrawals" or "Electricity withdrawals decline".

### m10. Inter-scenario consistency text refers to "nine scenarios"

**Where:** Line 355. Body text says "across all nine scenarios" but the dataset has eight future scenarios + one historical, which is what the figure caption says. The text "nine scenarios" is fine if "historical + 8 futures" but is phrased in a way that may confuse some readers.

### m11. Header file-comment structure on line 13 (`% Open issues flagged for coauthor resolution:`) is now inconsistent with v3

**Where:** Lines 9–13.

The "Open issues" list is from v2 and is no longer accurate. Update to reflect v3 open issues: GODEEEP-hydro reference, author CRediT statement, validation table values.

---

## Editorial / Polish

- **Line 102:** "\cite{Jones2023TGW}at" — missing space before "at". Cosmetic.
- **Line 195:** still cites `Huang2018` (good — this is the right key now). Carryover from v2 only at table line 81.
- **Line 305:** `\subsection*{CONUS annual totals}` — would benefit from a blank line before for visual readability of source.
- **Line 342:** `\subsection*{Seasonal cycle}` is jammed against the preceding paragraph end. Add newline.
- **Line 416:** "supports detailed scenario analysis" — good (was "supports detailed scenario." in v2 — fixed).
- **Line 433:** Acknowledgments still mention only TGW-WRF, GCAM-USA, and USGS. If GODEEEP-hydro is cited, acknowledge that team here.
- **Line 444:** "K.M. Developed CERF--Tethys integration" — good (was "Developed CERF CERF--Tethys integration" in v2).

---

## Strengths

- **Reframed abstract** is now an honest, journal-ready summary. The −45/−30/+5 numbers, by leading with sector-level findings, set correct reader expectations.
- **Added validation metrics table** (despite C1 above) is the right structural change. Once values are validated and the Industrial row removed, this is exactly what *Scientific Data* readers expect.
- **Bias-diagnosis subsection** is a meaningful addition. The two-hypothesis structure (Wada R coefficient vs. GCAM-USA base-year mismatch) is the right framing.
- **Cite-key cleanup** in `Tethys.bib` and the manuscript is comprehensive. The new bib is clean, all author-year style, and tracks well with the rest of the literature.
- **Full motivation paragraph** about MSD community and inter-model comparisons (line 62) is a useful addition that grounds the dataset in a research community rather than an abstract methodology.
- **Code availability** has TGW-WRF link properly cited via `\cite{Jones2023TGW}` (line 427).

---

## Citation State (updated for v3)

`Tethys.bib` now contains 28 entries (verified 2026-05-29):

```
Awais2024Preprint, Binsted_2022, Calvin2019GCAM, Gilbert2018, Graham_2020,
HADJIMICHAEL23, hess-17-4555-2013, Huang2018, Jolly_2005, Jones_2016,
Jones_2024, Jones2023TGW, Khan2023, Kyle2023Sustainability, Moore_2015,
Niazi2024PeakWater, Roy_2005, Skinner2025USGS, skinnerWaterWithdrawalConsumption2025,
Stets2025USGS, van_Vliet_2021, Vernon-2018, Vernon2021, Wada_2017, Wada2011,
WWDR2019, Zhao_gcamusa_water, Zhao2024
```

29 unique cite keys appear in `main_v3.tex`. **One mismatch remains:** `\cite{hess-22-2117-2018}` at Table 1 line 81 does not resolve in the new bib (use `Huang2018` instead — see C3).

After fixing C3, all citations resolve cleanly. The duplicate `hess-22-2117-2018` and `Abeshu_2023`, `BIJL201675` restoration entries staged in `new-entries.bib` (from the v2 review) are no longer needed:

- `Abeshu_2023` is **not cited from v3** (was only at v2 line 67, that paragraph has been removed).
- `BIJL201675` is **not cited from v3** (was only at v2 line 67, removed).
- `hess-22-2117-2018` is cited from v3 at line 81 only — fix by switching to `Huang2018` (already in bib).

→ `new-entries.bib` can be **deleted or archived**; nothing in it is needed by v3 except as a record of restored metadata in case the user later wants those references back. The Bracken2025GODEEEP stub remains useful as a placeholder.

---

## Suggested Citations Still Outstanding

The reviewer-led literature lookup phase is still blocked in this session (WebSearch and the `research-lookup` skill backends are unavailable). The targeted queries below remain to be run:

| Issue | Query | Why |
|---|---|---|
| C1 | "validation metrics gridded water demand HUC6 NSE KGE bootstrap CI" | Anchor the (re)computed Table 2 in published methodological precedent |
| M1 (carryover) | "USGS-anchored downscaling mass balance basin clip" | Quantify Eq. 8 clip impact in published context |
| M2 (carryover) | "HDD CDD threshold electricity demand sensitivity" | Justify or revise Eq. 5 thresholds |
| M5 (Bracken) | "Bracken GODEEEP hydropower 2025 PNNL" | Resolve Bracken 2025 reference if needed |
| Background | "CONUS gridded water demand 2024 2025 sub-state" | Add 1–2 newer comparison datasets to Table 1 if any exist |

When run, candidate BibTeX entries will be added to `new-entries.bib`.

---

## Summary of Required Revisions

The single highest-priority item is:

1. **Replace or remove the Industrial-sector row in Table 2 (C1)** and verify all values in the validation metrics table against the actual outputs of the validation pipeline. This is the only blocker — *Scientific Data* reviewers will catch this.

Beyond that:

2. **Merge duplicated paragraphs at lines 62 and 64 (C2).**
3. **Fix the `hess-22-2117-2018` → `Huang2018` cite-key at Table 1 line 81 (C3).** One-character edit.
4. **Decide and act on the Bracken 2025 GODEEEP-hydro reference (M5).** Either cite it or drop the TODO from the file header.
5. **Update the file header (lines 1–14, m1, m2, m11)** to reflect v3 state.
6. **Quantify Eq. 8 clip impact (M1 carryover)** — three sentences, no re-run.
7. **Resolve author CRediT statement (m3)** — coauthor task, but flag it.
8. **Verify Table 2 caption uses consistent dataset name (m4).**

Items M2/M3/M4 (carryover) and minor issues are not blockers for *Scientific Data* — they can be addressed in a final polish.

After fixes 1–5, the manuscript should be ready for *Scientific Data* on a minor-revision turnaround. The dataset itself is solid, the methodology is clearly described, and the contribution is well-motivated.

---

## Comparison with Existing v3 Reviews in `reviews/`

I compared this review against `reviews/systematic_review_v3_draft.md` (PRISMA-aligned framework review by another agent) and `reviews/v2_review_summary.md` after drafting:

- The systematic review correctly identifies the same three structural risks (Eq. 8 clip, validation framework, frankenstein design). Its "Reporting Bias" finding directly maps to my prior M1 (now resolved by v3) and is consistent with my C1 (Table 2 issues not yet caught by the systematic review).
- The v2 review summary correctly characterizes what v3 has fixed; it does not flag C1, C2, or C3 because those are v3-specific issues introduced during the rewrite.
- This review's primary value-add over the others is **C1 (Table 2 Industrial row), C2 (duplicated paragraph), C3 (Table 1 cite-key collision), M5 (Bracken GODEEEP-hydro decision), and the file-header staleness items.**

All three reviews converge on the dataset being publication-ready in *Scientific Data* after a minor-revision turnaround.
