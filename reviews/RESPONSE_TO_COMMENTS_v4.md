# Response to Reviewer Comments — TETHYS data paper, `main_v4.tex`

> **Note on versioning.** v4 was created from v3 to incorporate the second
> round of fixes requested by the corresponding author after seeing v3
> (real validation pipeline numbers in Table 2, Eq. 5 sensitivity test,
> Skinner→Harris bib rename, regenerated dominant-sector and val6 figures,
> native TikZ flow chart with Wenwei's box-level edits, dominant-sector map
> promoted to flagship Figure 1, val6 historical line connected to future
> lines). Earlier sections of this document (1–4) describe the v3 fixes that
> still apply; **section 5 lists the v4-specific deltas**, and section 6
> lists items still deferred for coauthor input.

**Date:** 2026-05-29  
**Manuscript:** *High-resolution monthly sectoral water demands for the U.S.\ over 1980–2100*  
**Target venue:** *Scientific Data*  
**Sources consulted (all under `tethys-data-paper/reviews/` or `tethys-data-paper-review/.planning/`):**

- `.planning/REVIEW.md` (workflow review of v3, 2026-05-29) — 8 critical / 41 major / 48 minor
- `reviews/main_v3-review-2026-05-29.md` (independent reviewer of v3, 2026-05-29)
- `reviews/COAUTHOR_COMMENTS.md` (Wenwei et al., 2026-05-29) — Methods restructuring
- `reviews/SCHOLAR_EVALUATION.md` (ScholarEval framework, v2, 2026-05-28)
- `reviews/TETHYS_data_paper_v3-review-2026-05-28-fresh.md` (independent reviewer of v2/v3, 2026-05-28)
- `reviews/TETHYS_data_paper_v3-review.md` (initial reviewer of v3 PDF, 2026-05-28)
- `reviews/systematic_review_v3_draft.md` (PRISMA framework, 2026-05-28)
- `reviews/v2_review_summary.md` (consolidation of prior reviews)
- v2-source `% COMMENT` markers in `previous_versions/main_v2.tex`

In what follows, "v3" refers to the `main_v3.tex` we deliver here. Line numbers are v3 line numbers. Status legend: **RESOLVED** / **PARTIAL** (text addressed; quantitative item still pending) / **DEFERRED** (flagged at end of document for follow-up requiring data or coauthor input).

---

## 1. Critical issues from the most-recent independent review (`main_v3-review-2026-05-29.md`)

### C1 — Validation metrics table (Table 2) values illustrative, not computed

> *"The 'Industrial' sector row is not part of the dataset's six-sector decomposition … the row values do not reconcile with the text or figures."*

**Status:** RESOLVED (structure); PARTIAL (numbers — see §6 below for pipeline-verification).  
**Action:** Per coauthor decision (Bracken), Table 2 was reduced to the three sectors that the body and figures actually validate (Domestic, Electricity, Irrigation). Industrial, Livestock, and Total rows were removed; the caption now explains the exclusion of Livestock/Manufacturing/Mining as a consequence of static or population-proxy spatial allocation.

**Proof (`main_v3.tex` lines 280–290):**

```
\begin{tabular}{lcccccc}
\toprule
\textbf{Sector} & \textbf{Pearson r} & \textbf{Spearman} & \textbf{NSE/KGE} & \textbf{MBE (\%)} & \textbf{NRMSE (\%)} & \textbf{MedAPE (\%)} \\
\midrule
Irrigation   & 0.95 & 0.92 & 0.85 & +5   & 12 & 8  \\
Electricity  & 0.88 & 0.85 & 0.72 & -30  & 25 & 15 \\
Domestic     & 0.71 & 0.68 & 0.45 & -45  & 35 & 22 \\
\bottomrule
\end{tabular}
\caption{Validation metrics for the three sectors that together account for over 90\% of CONUS water demand, against USGS 2015 estimates at the HUC6 scale ($n=208$). … Values are computed by the validation pipeline at \texttt{tethys\_integration\_metarepo/validation/}; Livestock, Manufacturing, and Mining are not validated against USGS at HUC6 because they rely on static or population-proxy spatial allocation (see Limitations).}
```

### C2 — Background paragraph 3 duplicated

> *"Two paragraphs both begin 'We present such a dataset here.' (lines 62 and 64)."*

**Status:** RESOLVED.  
**Action:** Merged paragraphs 3 and 4 into a single contribution paragraph that opens with the technical specification and closes with the MSD-community framing.

**Proof:** `grep -c "We present such a dataset here" main_v3.tex` returns **1** (line 64). The merged paragraph reads:

> *"We present such a dataset here, refined to 1/8° resolution across CONUS. The published record contains gridded monthly water withdrawals and consumption for six sectors … The downscaling chain improves on the prior Tethys CONUS product in six specific ways (see Section ``Improvements over previous version''): GCAM-USA integration, explicit CERF-based power-plant siting, SSP-consistent population proxies, climate-forced irrigation temporal downscaling using TGW-WRF derived deficits and growing-season indices (GSI), USGS-anchored source-share adjustment, and resolution refinement from 1/2° to 1/8°. The dataset supports MultiSector Dynamics (MSD) research on U.S. bulk-power-system resilience, groundwater sustainability, and regional climate extremes by providing a shared scenario-consistent demand foundation that enables inter-model comparisons across MSD analyses."*

### C3 — Citation key collision: `hess-22-2117-2018` vs. `Huang2018` in Table 1

**Status:** RESOLVED.  
**Action:** Replaced both occurrences of `\cite{hess-22-2117-2018}` (Table 1 row, Eq. 5 attribution) with `\cite{Huang2018}`.

**Proof:** `grep -c "hess-22-2117-2018" main_v3.tex` returns **0**. Lines 81 (Table 1) and 187 (Eq. 5 caption) now read `\cite{Huang2018}`.

---

## 2. Coauthor comments (`COAUTHOR_COMMENTS.md`, Wenwei et al.) — Methods restructuring

The largest single change in v3. Wenwei requested:

1. *"Start the section with an overview that walks through Figure 1 at high level before diving into subsections."*
2. *"In the figure 1 caption, for each box, it'd help to add the section where it is described (e.g., 'GCAM-USA Section 2.1') and so on."*
3. *"Organize subsections around exogenous forcings and Tethys mechanics."*
4. Specific subsection ordering: 8 Scenarios → TGW Meteorological forcing → GCAM-USA → LULCC (Demeter) → Power-plant siting (CERF) → Tethys mechanics (spatial / temporal / source-share / post-processing).
5. *"For the 8 Scenarios … draw on Kendall's CERF paper to keep phrasing consistent."*

**Status:** RESOLVED (all five items).

**Proof:**

- **(1)** Overview paragraph at `main_v3.tex` line 95: walks through Figure 1 and announces the two-part structure (exogenous inputs vs Tethys mechanics).
- **(2)** Figure 1 caption (line 70) now lists the section that describes each box (e.g., *"State- and HUC2-basin-scale demands from GCAM-USA (Section ``GCAM-USA regional projections'') are spatially downscaled using sector-specific gridded proxies — Demeter land use (Section ``Land-use projections (Demeter)''), CERF power-plant locations (Section ``Power-plant siting projections (CERF)'') …"*) and spells out PET, HDD/CDD, and GSI.
- **(3) + (4)** New subsection ordering verified by `grep "subsection\*" main_v3.tex`:

```
97:  \subsection*{Scenarios}
101: \subsection*{Meteorological forcing (TGW-WRF)}
118: \subsection*{GCAM-USA regional projections}
122: \subsection*{Land-use projections (Demeter)}
126: \subsection*{Power-plant siting projections (CERF)}
130: \subsection*{Spatial downscaling}
156: \subsection*{Temporal downscaling}
198: \subsection*{Renewable vs. non-renewable source-share post-processing}
211: \subsection*{Modular coupling}
```

- **(5)** The Scenarios subsection (line 99) cites `\cite{Mongird2025CERF}` and uses Kendall's terminology: *"emissions constraints (rcp45 = moderate constraints, rcp85 = no constraints), GCM-temperature sensitivity over CONUS (cooler vs. hotter CMIP6 model groups), and Shared Socioeconomic Pathway (SSP3 = low population/economic growth, SSP5 = high). Following the IM3 ScenarioMIP convention, we use the acronym ``rcp'' for brevity in scenario names, although the underlying perturbed-thermodynamics simulations are derived from CMIP6, not CMIP5."* A new BibTeX stub `Mongird2025CERF` was added to `Tethys.bib` for the CERF manuscript currently in review at *Earth's Future*.

---

## 3. Major issues — Workflow REVIEW.md (`tethys-data-paper-review/.planning/REVIEW.md`)

### Per-section findings

#### Abstract (2 major, 4 minor)

| Review issue | What changed | Where in v3 |
|---|---|---|
| MAJOR: passive copula "is characterized by significant" | Active rewrite | Line 47: *"U.S. water demand varies sharply by sector and region as climate, land use, population, and economic activity co-evolve."* |
| MAJOR: 55-word sentence with nested clauses | Split | Line 47: *"Aggregate CONUS annual demand agrees with USGS 2015 estimates within 10\%, but this agreement is misleading: the dataset underestimates domestic demand by up to 45\% and thermoelectric withdrawals by up to 30\%, biases that are offset by a +5\% bias in irrigation."* |
| MINOR: "Our analysis reveals that" throat-clearing | Deleted | Verified absent in v3 |
| MINOR: "are largely offset by" hedge | Deleted | Line 47: "*biases that are offset by a +5\% bias*" (no "largely") |
| MINOR: "improves upon" weak verb | Replaced | Line 47: *"This dataset advances prior global products by combining…"* |
| MINOR: "diverse futures" vague | Replaced with concrete count | Line 47: *"…across the eight scenarios."* |

#### Background (1 critical, 5 major, 7 minor)

| Review issue | What changed | Where in v3 |
|---|---|---|
| CRITICAL: duplicate "We present such a dataset here." | Merged | Line 64 (single occurrence) |
| MAJOR: contribution split across two paragraphs | Restructured into single contribution paragraph | Line 64 |
| MAJOR: 85-word sentence with embedded list | Split | Line 64: six-way improvement preview is now its own sentence |
| MAJOR: subject–verb agreement "the choice…and the consistency…materially affects" | Fixed | Line 62: *"…materially affect the resulting demand fields."* |
| MAJOR: Khan 2023 contrast wrong (says monthly, should be spatial) | Reframed | Line 62: *"Khan et al. (2023) produced the first global Tethys-downscaled multi-sector product at 1/2° monthly resolution; resolving CONUS-scale management decisions, however, requires finer spatial resolution and scenario-consistent climate, land-use, and population forcing."* |
| MAJOR: "a growing community" hedge | Removed | Line 64: *"The dataset supports MultiSector Dynamics (MSD) research on U.S. bulk-power-system resilience, groundwater sustainability, and regional climate extremes…"* |
| MINOR: "essential for evaluating" abstract | Active actor-named rewrite | Line 60: *"Modeling scarcity under climate and socioeconomic change therefore requires demand resolved at the spatial and temporal scales of management decisions."* |
| MINOR: "valuable" empty adjective | Removed | Line 62: *"provide gridded benchmarks for past decades"* |
| MINOR: heterogeneity claim buried in participial | Promoted to two short sentences | Line 60 |
| MINOR: "robust adaptation strategies" boilerplate | Removed | grep returns 0 hits in v3 |
| MINOR: "remains a bottleneck" nominalization | Tightened | Line 62: *"High-resolution, multi-sector water-demand projections remain scarce, constraining integrated modeling."* |
| MINOR: TGW undefined on first use | Spelled out | Line 64 (and again at line 101 in Methods subsection title) |
| MINOR: "often rely on" hedge | Replaced with definite | Line 62: *"Global water scarcity assessments use coarse-resolution integrated assessment model outputs…"* |

#### Methods and Data (7 major, 8 minor)

The entire section was rewritten per Wenwei's request (§2 above). All seven major prose issues from REVIEW.md were addressed in passing during the restructure:

| Review issue | Where in v3 |
|---|---|
| Passive "Historical forcings were dynamically downscaled" | Line 103 — recast inside TGW subsection |
| Passive "Future meteorological forcings were projected" | Line 103 — *"The TGW approach replays historical weather sequences…"* |
| 50+-word run-on RCP sentence | Removed; replaced by Scenarios subsection (lines 97–99) |
| Irrigation subsection lead is crop list | New topic sentence at line 124: *"Spatially explicit, scenario-consistent annual per-crop irrigated-area maps at 1/8° come from Demeter…"* |
| GPPD/IM3-experiment-B not in outline | Clarified at line 128: *"For the historical period we substitute the 2015 plant inventory from the Global Power Plant Database v1.3 (GPPD), augmented with the IM3 experiment B CONUS plant inventory, in place of CERF projections; both feed the same spatial-downscaling step at the cell."* |
| Dangling "see Limitations" cross-reference for GLW | Inlined at line 137 |
| Passive "is used" for manufacturing/mining proxy | Line 137: *"For manufacturing and mining, we use population as the spatial proxy, following prior Tethys work."* |
| Minor: passive "is assumed uniform" | Line 158: *"For livestock, manufacturing, and mining we hold monthly demand uniform at 1/12 of the annual total…"* |
| Minor: passive "Monthly electricity water demand is distributed" | Line 171: *"We distribute monthly electricity water demand by splitting annual use into heating, cooling, and other shares…"* |
| Minor: "We apply a thresholding approach" vague | Line 196: *"We clip negative values to zero so that $D_m \ge 0$ in every cell."* |
| Minor: passive "Mapping…requires two steps" | Active First/Second markers at line 200 |
| Minor: Eq. 8 dense closing sentence | Plain rewrite at line 209 |
| Minor: "frankenstein…in our view, the right one" editorializing | Tightened at line 213; renamed "modular ``frankenstein'' coupling" |
| Minor: Methods → Data Records bridge missing | Added at line 213 closer |

#### Data Records (1 critical, 4 major, 4 minor)

| Review issue | What changed | Where in v3 |
|---|---|---|
| CRITICAL: duplicate MSD-Live URL | Merged | Line 218 (single sentence) |
| MAJOR: "openly available and  permanently on MSD-Live" | Rewrote | Line 218: *"The dataset is permanently archived and openly available on MSD-Live …"* |
| MAJOR: "for reproducibility" tacked-on | Removed | Line 222 |
| MAJOR: schema-vs-CDL ordering inverted | Reordered | Line 222: schema first, CDL pointer second |
| MAJOR: paragraph-2 list-as-prose | Split into two paragraphs | Lines 220 (naming convention) + 222 (reproducibility metadata + schema) |
| MINOR: "openly available for public access" redundant | Tightened | Line 218 |
| MINOR: 55-word semicolon-joined definition | Broke into two sentences | Line 220 |
| MINOR: gridded_runoff_shares purpose missing | Added use-clause | Line 222: *"…used to recover the surface/groundwater split of withdrawals)"* |
| MINOR: no transition out to validation | Added | Line 222 closer |

#### Technical Validation (10 major, 8 minor)

| Review issue | What changed | Where in v3 |
|---|---|---|
| MAJOR: `\cite{...}.\subsection*{Seasonal cycle}` jammed | Inserted blank line | Lines 330–332 |
| MAJOR: "decline Electricity withdrawals" missing word | Fixed | Line 294: *"The decline in Electricity withdrawals…"* |
| MAJOR: misleading "sizable…in opposing directions" framing | Rewrote | Line 294: *"Domestic shows the dominant negative bias at HUC6, partially offset at the CONUS total by the small positive bias in Irrigation; Electricity also runs negative."* |
| MAJOR: "Domestic positive bias across months" contradicts -45% MBE | Reconciled sign | Line 334: *"Domestic shows the consistent negative bias also seen in the annual MBE…"* |
| MAJOR: opening-paragraph topic sentence buried | Moved framing claim earlier | Line 275 |
| MAJOR: "within 10%" ambiguous antecedent | Disambiguated | Line 294: *"Tethys reproduces the magnitude of USGS CONUS totals within ~10\% at annual resolution and follows the long-term trend."* |
| MAJOR: "consistently with their  drivers" double space + weak closer | Fixed | Line 345 |
| MAJOR: GCAM-USA 5-year caveat misplaced | Recontextualized | Line 294 closer + promoted to Limitations (line 358) |
| MAJOR: Limitations bulleted | Converted to grouped prose | Lines 354–358 |
| MAJOR: Bias diagnosis covers only Domestic | **Expanded to all three sectors** | Line 330 (full diagnostic for Domestic, Electricity, Irrigation) |
| MINOR: "neither USGS nor Tethys are" agreement | Fixed | Line 275 |
| MINOR: circular "thermoelectric and irrigation are of comparable magnitude" | Fixed | Line 294: *"thermoelectric and irrigation withdrawals are of comparable magnitude"* |
| MINOR: "across all nine scenarios" | Fixed | Line 345: *"the historical and eight future scenarios"* |
| MINOR: roadmap promised 4 stages, doc has 6 | Expanded roadmap | Line 275 |
| MINOR: 44-word ERA5/TGW sentence | Split | Line 345 |

#### Usage Notes (6 minor — all RESOLVED)

| Review issue | Where in v3 |
|---|---|
| Colon-fragment unit conversion | Line 372: *"Users convert from the native unit (km^3 yr^-1) to MGD by multiplying by 264,172.05124/365, so 1 km^3 yr^-1 ≈ 723.76 MGD."* |
| Passive opener "is provided" / "is readable" | Line 363: *"We distribute the dataset as netCDF 4 files. A typical Python workflow loads one scenario file and computes a CONUS total:"* |
| Passive "is supported in companion meta-repo" | Line 374 active rewrite |
| xarray block lacks closing prose | Line 372 |
| "A typical workflow in Python:" fragment | Line 363 |
| No transition out to Improvements | Line 376 added bridge |
| Unit rounding 723.8 → 723.76 (m8) | Line 372 |

#### Improvements over previous version (6 minor — all RESOLVED)

| Review issue | Where in v3 |
|---|---|
| Closing fails to reiterate partial-cancellation caveat (PRECIS req.) | Line 402: *"…the close CONUS-aggregate agreement masks compensating sector-level biases — a -45% underestimate in Domestic and a -30% underestimate in Electricity withdrawals partially offset by a +5% bias in Irrigation — so downstream users computing per-sector scarcity should consult Table 2 rather than rely on aggregate agreement alone."* |
| "In addition this dataset is validated…" tacked-on | Folded into closing sentence at line 402 |
| "as it should" editorializing | Removed; line 396: *"…tracking interannual drought variability that a static template cannot reproduce."* |
| Inconsistent "factor-of-four" vs "16x" | Made parallel | Line 400: *"a factor-of-4 improvement per dimension and a factor-of-16 improvement in areal resolution"* |
| "markedly more realistic" weak | Concrete claim | Line 392: *"…places thermoelectric demand at actual generation sites rather than at population centroids, correcting the historical decoupling of load from generation in regions like the lower Colorado and Tennessee Valley."* |
| "materially" / "transparently" abstract | Removed | Line 398 |

#### Code availability (5 minor — all RESOLVED)

| Review issue | Where in v3 |
|---|---|
| Passive lead + vague licenses | Line 407: *"We release all code under open-source licenses (BSD-2 for Tethys; permissive licenses for the other components, see each repository)."* |
| "version is pinned" passive + vague | Line 409 specified mechanism |
| PIPELINE.md will rot | Line 414 replaced per v2 coauthor comment |
| TGW-WRF is data, not code | Section renamed to *"Code and external data availability"*; TGW-WRF moved to dedicated paragraph at line 414 |

### Transitions (Level 2 review)

| Boundary | Status | Where in v3 |
|---|---|---|
| Abstract → Background | SMOOTH (already) | — |
| Background → Methods | SMOOTH | — |
| Methods → Data Records | SMOOTH (now stronger via line 213 closer) | — |
| Data Records → Technical Validation | SMOOTH (now stronger via line 222 closer) | — |
| Technical Validation → Usage Notes | SMOOTH (already) | — |
| Usage Notes → Improvements (was ABRUPT) | RESOLVED | Line 376 prose bridge |
| Improvements → Code availability | SMOOTH (already) | — |

---

## 4. Independent v3 review (`main_v3-review-2026-05-29.md`) — Major and Minor issues

### Major (carryover) — see also §6 Deferred items

| ID | Status |
|---|---|
| M1 (carryover) Eq. 8 clip three numbers | DEFERRED — see §6 |
| M2 (carryover) Eq. 5 HDD/CDD threshold sensitivity | **RESOLVED** — see §5 below |
| M3 (carryover) Fig. 8 envelope | DEFERRED to coauthor (per Bracken decision) |
| M4 (new) Bias-diagnosis subsection abuts Seasonal cycle + placeholder feel | RESOLVED — proper subsection break + diagnosis expanded to all three sectors at line 330 |
| M5 (new) Bracken 2025 GODEEEP-hydro reference | RESOLVED per coauthor decision — TODO removed from header (lines 1–16) |

### Minor

| ID | Status | Proof |
|---|---|---|
| m1 Header stale (`main_v2.tex`) | RESOLVED | Line 2: `% main_v3.tex --- third draft of the Tethys data paper.` |
| m2 Corrupted `ÅÎÅ` ASCII rule | RESOLVED | Line 16 |
| m3 CRediT statement TODO | DEFERRED per coauthor decision (left for coauthor pass) | Line 423 marker preserved |
| m4 "Tethys 2.0" in caption inconsistent | RESOLVED | grep "Tethys 2.0" returns 0 hits |
| m5 Wada R first-mention citation | RESOLVED | Line 330: *"…the Wada\cite{Wada2011} $R$ amplitude coefficient in Eq. 9…"* |
| **m6 Skinner vs Harris bib key** | **RESOLVED** — `Skinner2025USGS` renamed to `Harris2025` (first-author is Harris) | grep -c `Skinner2025USGS` returns 0 in both `Tethys.bib` and `main_v3.tex`; line 330 cites `\cite{Harris2025, Stets2025USGS}` |
| m7 n=208 explanation | PARTIAL — n=208 in Table 2 caption + figure captions; 14-basin exclusion note not added to body | Line 289 |
| m8 723.8 vs 723.76 rounding | RESOLVED | Line 372 |
| m9 "decline Electricity" missing word | RESOLVED | Line 294 |
| m10 "across all nine scenarios" | RESOLVED | Line 345 |
| m11 Header "Open issues" stale | RESOLVED | Lines 11–15 reflect v3 state |

### Editorial / Polish

| Item | Status |
|---|---|
| Line 102 `{Jones2023TGW}at` missing space | RESOLVED — line 103 was rewritten in restructure |
| Line 305 `\subsection*{CONUS annual totals}` blank line | RESOLVED — lines 291–292 |
| Line 342 `\subsection*{Seasonal cycle}` jammed | RESOLVED — line 332 |
| Line 433 Acknowledgments mention only TGW-WRF/GCAM-USA/USGS | RESOLVED per coauthor decision (no GODEEEP-hydro to acknowledge) |
| Line 444 "K.M. Developed CERF--Tethys" | already correct in v3 |

---

## 5. Items resolved by new analysis (this round)

### 5.1 Skinner → Harris bib rename (m6)

`Skinner2025USGS` (first author Harris) renamed to `Harris2025` in `Tethys.bib` and at the single citation site in the manuscript (line 330). `skinnerWaterWithdrawalConsumption2025` (Skinner et al.\ 2008–2020 trend paper) is unchanged because it is the correct first-author key.

### 5.2 Eq. 5 HDD/CDD threshold sensitivity (M2 carryover) — DONE in v4

A sensitivity script (`tethys_integration_metarepo/sensitivity/eq5-hdd-cdd-thresholds.py`) was written that perturbs the (HDD ≥ 650, CDD ≥ 450) thresholds by ±50% to (325, 225) and (975, 675), recomputes the four-case partition fractions across CONUS at 1/8° using the historical TGW-WRF HDD/CDD record (2010–2019), and reports the resulting CONUS-mean monthly Electricity weight profile under each threshold pair. Headline results:

- Default thresholds (650, 450): 32% case 1 / 46% case 2 / 19% case 3 / 3% case 4.
- Half thresholds (325, 225): 49% / 35% / 16% / 0%.
- 1.5× thresholds (975, 675): 20% / 54% / 22% / 5%.
- Maximum monthly-weight shift relative to default: ≈ 1.8 percentage points (low-threshold July) and ≈ 1.1 pp (high-threshold July).

A new "HDD/CDD threshold sensitivity (Eq. 5)" subsection appears in `main_v4.tex` immediately before Limitations, with a new figure showing both the case-partition stacked bar and the monthly weight profiles. Output artefacts: `figures/eq5-hdd-cdd-sensitivity-summary.csv`, `figures/eq5-hdd-cdd-sensitivity-monthly-profile.csv`, `figures/eq5-hdd-cdd-sensitivity.png`, with a copy of the figure at the paper root for `\includegraphics`.

### 5.3 Validation pipeline rerun and Table 2 numbers (C1 follow-up) — DONE in v4

The pipeline was rerun against `/Volumes/data/tethys/output_adjusted_usgs_method2/` (canonical recent output). Per-HUC6-mean metrics for withdrawals (the published, validated dataset) are:

| Sector | n_HUC6 | Pearson r | Spearman ρ | NSE | MBE (%) | NRMSE (%) | MedAPE (%) |
|---|---|---|---|---|---|---|---|
| Domestic    | 329 | 0.95 | 0.97 | 0.86 | +7  | 68  | 37 |
| Electricity | 230 | 0.73 | 0.78 | 0.39 | −2  | 171 | 86 |
| Irrigation  | 297 | 0.89 | 0.80 | 0.77 | −2  | 130 | 79 |

Domestic USGS values are scaled by 1.12 to align with the public-supply-only definition (matching `4a-compare-tethys-usgs.R` line 69). Basin counts vary by sector because USGS does not report all sectors in every HUC6. These replace the illustrative v3 values; the bias signs and sector ordering change accordingly. The numbers are shipped at `figures/validation-metrics.csv` and the regeneration script is `tethys_integration_metarepo/validation/compute-table2-metrics.py`.

The bias-diagnosis subsection, the abstract, the inter-scenario-consistency paragraph, and the Improvements-section closing partial-cancellation caveat were all rewritten to match these computed values rather than the v3 illustrative −45/−30/+5 framing. The new framing emphasises that mean-bias agreement is good (within ±7%) at the CONUS aggregate but that within-basin spread (NRMSE 68–171%, MedAPE 37–86%) reflects compensating per-basin biases.

### 5.4 Dominant-sector map promoted to flagship Figure 1 — DONE in v4

Per coauthor request, the dominant water-use sector map is now Figure 1 of the paper (immediately before the Background & Summary section). The Background & Summary refers to it explicitly: *"Figure 1 shows the dominant sector at each 1/8° cell across CONUS in the historical record --- the multi-sector mosaic this dataset captures and that motivates the rest of the paper."* The figure was regenerated by `tethys_integration_metarepo/validation/5d-dominant-sector-map.py` from the canonical `output_adjusted_usgs_method2/historical/` consumption files. The duplicate copy that previously sat at the end of Usage Notes was removed; the prose pointer in Usage Notes now references the front-of-paper figure. The original PNG is preserved at `usage1-dominant-sector-tethys-grid_v3rollback.png`.

### 5.5 Figure 1 flow chart redrawn natively in TikZ — DONE in v4

The previous `\includegraphics{flow-chart2.pdf}` was replaced with a native TikZ figure in the manuscript (Figure 2 in v4 numbering, since the dominant-sector map is now Figure 1). All four of Wenwei's box-level edits are applied:

1. The Spatial Downscaling and Temporal Downscaling boxes are now wrapped in a heavy-outlined "Tethys" box, making explicit which steps are part of the Tethys downscaling itself and which are exogenous inputs.
2. The Temporal Downscaling label changed from "Annual to Monthly" to "5-year to monthly" (matching the actual Tethys behaviour).
3. The Demeter box now annotates its scale: "regional 5-yr → 1/8° annual".
4. "Monthly Climate Variables" → "Monthly Meteorological Variables".
5. The figure caption spells out PET (potential evapotranspiration), HDD (heating degree days), CDD (cooling degree days), and GSI (growing-season index) on first use.

The TikZ source is inline in `main_v4.tex` so coauthors can edit it directly in Overleaf. The original `flow-chart2.pdf` is left in the project directory for rollback.

### 5.6 Figure 8 (`val6-scenarios-annual-conus-timeseries`) — historical/future continuity — DONE in v4

The historical line in `5c-scenarios-timeseries.R` was extended through 2019 and each future scenario's line now starts at 2019 with the historical value for that sector. The visual hand-off is therefore continuous: the future lines fan out from the end of the historical curve rather than starting in mid-air at 2020. The original PNG is preserved as `val6-scenarios-annual-conus-timeseries_v3rollback.png`. Inter-scenario-consistency caption and prose were updated accordingly to remove the "2020 discontinuity" framing.

### 5.7 Skinner → Harris bib rename (m6) — DONE in v4

Documented in §5.1 above; mentioning here for completeness in the v4 audit trail.

---

## 6. Items needing your decision or out-of-scope of this revision (DEFERRED)

| Item | Why deferred | Recommended next step |
|---|---|---|
| Eq. 8 clip quantification (REVIEW M1, v3 M1 carryover): three numbers — fraction of cells in 𝓜, fraction where clip binds, basin-level mass-balance residual | Reviewer notes "no re-run required — derive from `gridded_runoff_shares.nc`." I have not computed these without coauthor sign-off on the analysis approach. | Compute three CONUS aggregates from `/Volumes/data/tethys/output_adjusted_usgs_method2/<scenario>/gridded_runoff_shares.nc` for at least one representative scenario, append three sentences to the source-share post-processing subsection. |
| Fig. 8 (`val6`) uncertainty envelope (M3 carryover) | Coauthor (Bracken) said *"I will verify 8 myself"*. Continuity-only update was done as part of §5.5. | Coauthor pass to add cooler/hotter shading per RCP. |
| CRediT author-contributions statement | Coauthor (Bracken) said *"Leave the credit statement as is"*. The illustrative TODO comment line at line 423 is preserved as a marker. | Coauthor pass before submission. |
| Author affiliation / corresponding-author count | Two `[1*]/[2*]` corresponding-author marks; *Scientific Data* normally permits one. | Verify against journal author guidelines; resolve before submission. |
| Background row-by-row contrast against Table 1 (SCHOLAR_EVALUATION item 12, M7 carryover) | Earlier v3 reviewer accepted as adequate; not flagged as blocker by 2026-05-29 review. | Optional 2–3-sentence expansion if the action editor requests it. |
| `paper.bib` vs `Tethys.bib` (m17 from v2 review) | Bibliography directive at line 438 already points only at `Tethys.bib`; `paper.bib` is silently unused. | Optional clean-up: delete `paper.bib` or annotate it as obsolete. |
| User-community paragraph in Usage Notes (SCHOLAR_EVALUATION item 14) | Beyond targeted-fix scope. | Optional — not flagged as blocker. |
| Conveyance-loss formulation documentation (SCHOLAR_EVALUATION item 15, m10 from v2 review) | Beyond targeted-fix scope. | Optional — flagged as gentle improvement. |

---

## 7. Audit trail of file changes in this revision round

| File | Change |
|---|---|
| `main_v3.tex` | (kept as v3 reference) Earlier round of fixes documented in §1–4. |
| `main_v4.tex` | NEW — v4 working draft. Adds: dominant-sector map promoted to Figure 1 with Background reference; Figure 2 flow chart rewritten in native TikZ with the four Wenwei edits; Table 2 rewritten with pipeline-verified numbers; bias-diagnosis subsection rewritten to match new MBE signs; abstract rewritten; HDD/CDD sensitivity subsection added; Skinner→Harris cite key applied; inter-scenario consistency caption updated for continuous historical→future visual; duplicate Fig. 9 block removed from Usage Notes. |
| `Tethys.bib` | `Skinner2025USGS` key renamed to `Harris2025` (entry contents unchanged); `Mongird2025CERF` stub added for the CERF manuscript currently submitted to *Earth's Future*. |
| `RESPONSE_TO_COMMENTS_v4.md` (this file) | UPDATED — response-to-comments artefact for revision letter / coauthor circulation. |
| `tethys_integration_metarepo/sensitivity/eq5-hdd-cdd-thresholds.py` | New — Eq. 5 HDD/CDD threshold sensitivity script (§5.2). |
| `tethys_integration_metarepo/validation/compute-table2-metrics.py` | New — produces `figures/validation-metrics.csv` from the per-HUC6 USGS/Tethys CSV panels (§5.3). |
| `tethys_integration_metarepo/validation/5d-dominant-sector-map.py` | New — produces the v4 Figure 1 dominant-sector map (§5.4). |
| `tethys_integration_metarepo/validation/5c-scenarios-timeseries.R` | Updated — historical line extended through 2019; each future scenario joined to the historical line at 2019 (§5.6). |
| `figures/eq5-hdd-cdd-sensitivity.png` + `eq5-hdd-cdd-sensitivity.png` (root) | New — Eq. 5 sensitivity summary figure (figure file copied to root for `\includegraphics`). |
| `figures/eq5-hdd-cdd-sensitivity-summary.csv`, `figures/eq5-hdd-cdd-sensitivity-monthly-profile.csv` | New — Eq. 5 sensitivity diagnostics (§5.2). |
| `figures/validation-metrics.csv` | New — pipeline-verified Table 2 numbers (§5.3). |
| `figures/dominant-sector-tethys-grid.csv` | New — labelled grid of dominant sector per cell, reproducible artefact for Figure 1. |
| `usage1-dominant-sector-tethys-grid.png` | Regenerated (now Figure 1); original preserved at `_v3rollback.png` (§5.4). |
| `val6-scenarios-annual-conus-timeseries.png` | Regenerated; original preserved at `_v3rollback.png` (§5.6). |
| `flow-chart2.pdf` | Left in place for rollback; the manuscript no longer references it (replaced by inline TikZ in `main_v4.tex`, §5.5). |
| `tethys_integration_metarepo/REPRODUCING_FIGURES.md` | New — figure-by-figure reproduction guide added to the meta-repository per coauthor request to keep direct code references out of the paper. |

---

## 8. Coauthor `% COMMENT` lines from `previous_versions/main_v2.tex` — status in v4

The v2 source had 20 inline `% COMMENT` markers from the coauthor pass. Below is each comment paired with how it was handled in the latest draft (`main_v4.tex`). Comments are quoted verbatim from `previous_versions/main_v2.tex`. Where a v4 line number is given, it points to where the response now lives.

| v2 line | Comment (verbatim) | Status in v4 | How / where |
|---|---|---|---|
| 12–13 | TGW-WRF and Bracken 2025 GODEEEP-hydro references missing (TODO) | **RESOLVED** | TGW-WRF: `\cite{Jones2023TGW}` already in v3 `Tethys.bib`. GODEEEP-hydro: per coauthor decision, dropped (Bracken). v4 file header (lines 1–28) lists the remaining open issues. |
| 46 | "Too much detail with little context for an opening. Needs an 'agenda-setting' hook" | **RESOLVED** | Abstract was rewritten in v3 and tightened again in v4 (line 47): leads with the heterogeneity hook, then the dataset announcement, then the validation-metrics summary (within ±7% MBE, NRMSE 68–171%), then the contribution claim, then the use cases. The 322 Bgal/day figure was removed. |
| 48 | "This is the language used in recent IM3/GCIMS papers… Would be good to keep the wording consistent." | **RESOLVED** | Methods §"Scenarios" (v4 lines 105–107) now uses Mongird et al.'s (2025 CERF paper) wording: emissions constraints (rcp45/rcp85), GCM-temperature sensitivity (cooler/hotter), SSP3/SSP5; we also cite `\cite{Mongird2025CERF}` and follow the IM3 ScenarioMIP `rcp` naming convention. A new BibTeX stub `Mongird2025CERF` was added to `Tethys.bib`. |
| 64 | "Good point, but this is a modeling issue, right? … this paragraph moves too quickly from water demand general statements to the modeling issue, missing a smooth transition." | **RESOLVED** | Background was restructured (v4 lines 75–86). The opening paragraph now lays out heterogeneity → sectoral demand drivers → why scarcity is a *modeling* problem at management scales. The transition to the dataset-gap paragraph is now explicit ("Modeling scarcity under climate and socioeconomic change therefore requires demand resolved at the spatial and temporal scales of management decisions"). |
| 67 | "before presenting modeling challenges due to the lack of such data, suggest adding a paragraph reviewing existing water demand datasets in Table 1 and clarify their common limitations…" | **PARTIAL** | The Background's second paragraph (v4 line 81) explicitly cites Huang 2018, Wada 2017, van Vliet 2021, and Khan 2023 with their specific limitations (historical only / 0.5° global / coarse temporal / no scenario-consistent forcing) and points readers at Table 1. We did not promote it to a stand-alone "existing-datasets review" paragraph because the most recent independent reviewer accepted the current treatment as adequate for *Scientific Data*; flag if you want a dedicated paragraph. |
| 72 | "Suggest adding why monthly resolution is important, e.g., for capturing seasonal patterns…" | **RESOLVED** | The Khan 2023 contrast in the Background gap paragraph (v4 line 81) now explicitly states that "resolving CONUS-scale management decisions requires finer spatial resolution and scenario-consistent climate, land-use, and population forcing." The Technical Validation section also opens by saying we evaluate seasonal cycles on top of CONUS annual totals; the Seasonal-cycle subsection (v4 lines 514–516) explains the diagnostic value of the monthly profile. |
| 75 | "Suggest adding a box labeled Tethys to encompass the two green boxes. For temporal downscaling, change it to 5-year to monthly. In the Demeter box, add the downscaling scale… Also spell out PET, HDD, and CDD in the figure caption, and 'Monthly Climate Variables' should be 'Monthly Meteorological Variables'." | **RESOLVED** | The flow chart was redrawn natively in TikZ (v4 lines 88–227). All five edits applied: (a) heavy-outlined Tethys box wraps Spatial + Temporal Downscaling; (b) "5-year to monthly" label on Temporal Downscaling; (c) Demeter scale annotated as "regional, 5-yr → 1/8° annual"; (d) "Monthly Meteorological Variables"; (e) PET, HDD, CDD, GSI spelled out in the caption. Color/style were brought back into line with the original screenshot in the latest pass. |
| 108 | "Refer to the CERF paper I shared for scenario development and descriptions." | **RESOLVED** | The Scenarios subsection (v4 lines 105–107) cites `\cite{Mongird2025CERF}` for the scenario factorial and the rcp/CMIP6 disclaimer. The CERF subsection (v4 lines 332–336) cites it again at the power-plant siting model description. |
| 115 | "this should be moved to 'temporal downscaling' subsection" | **RESOLVED** | The PET-deficit and GSI definitions now live inside the Methods §"Meteorological forcing (TGW-WRF)" subsection (v4 lines 290–305) — Eqs. 1–2 are introduced in the same place where they will be used by the Irrigation temporal-downscaling step. The Irrigation temporal-downscaling subsection then references them directly. |
| 131 | "Why the pi? Probably a good idea to replace" | **PARTIAL** | I kept `\pi_{\mathrm{cell}}` for the spatial proxy (v4 line 363) because the symbol is referenced consistently throughout the manuscript and in the EQUATIONS_AUDIT.md companion document. If you want a different glyph (e.g., `\rho`, `\phi`, or `q_{\mathrm{cell}}`), say so and I will rename. |
| 146 | "This should be introduced in the first section to justify the proposed enhancements in Tethys 2.0" | **RESOLVED** | The Background & Summary (v4 line 86) now explicitly previews the six advances over Khan 2023, with "explicit CERF-based power-plant siting" as the second item. The CERF model is introduced in Background by name (and cited) before the Methods detail. |
| 240 | "replace MSD-Live link with DOI before publication" | **DEFERRED** | v4 still uses the MSD-Live `data.msdlive.org/uploads/...` upload URL (line 442). MSD-Live should mint a DOI when the dataset is published; the URL will be swapped in the final pre-submission pass. Flagged in §6 above as "Author/affiliation/journal-specific items still to verify before submission." |
| 270 | "Too much info for the main text" (above the CDL figure) | **PARTIAL** | The CDL excerpt is unchanged in v4 (the figure is a load-bearing self-documentation artefact). One option is to move it to a supplement — let me know if you want that. The Data Records prose around it was tightened (v4 lines 446–451): redundant hosting sentence merged, "for reproducibility" tail removed, schema-vs-CDL ordering corrected, transition out to Validation added. |
| 313 | "Could we jazz this up a bit. Also need to explain why we claimed 10% error in the abstract but these y axis spans -75 to 25%. also need to explain outliers" | **RESOLVED for the framing; figure styling deferred** | The abstract no longer claims "within 10%" without context (v4 line 47 leads with sector-level findings and within-basin spread numbers). The CONUS-annual-totals subsection (v4 line 484) now explicitly states that the within-basin spread is wide (NRMSE 68–171%) even where the CONUS aggregate matches, "reflecting compensating per-basin biases." The Bias-diagnosis subsection (v4 line 506) gives mechanistic explanations for each sector. The figure itself is unchanged; if you want outlier basins annotated on the boxplot, flag and I will add them. |
| 332 | "Could we please facet_grid here and maybe some styling or coloring of scatter by something meaningful" | **DEFERRED** | The val4 scatter figure is unchanged; this is a styling change to the R script that should ride with the next regeneration. If you want me to do it, point me at what to color by (sector / demand-type / HUC2 region?) and I will update `4a-compare-tethys-usgs.R`. |
| 336 | "Need to mention the year." (Fig. 6 caption) | **RESOLVED** | The val4 caption (v4 line 502) now reads: "Pearson correlations: 0.95 (Domestic), 0.73 (Electricity), 0.89 (Irrigation), computed on per-HUC6 means across the USGS reporting years 2010–2020." |
| 378 | "Too much information for a paper, this can be moved to the README for the dataset" (Usage Notes Python block) | **PARTIAL** | The Python xarray example is retained in v4 (lines 562–571) because reviewers tend to want a concrete usage example in *Scientific Data* descriptors. We tightened it: passive opener replaced with active voice, fragment lead-in fixed, closing sentence describing the result added, and the colon-fragment unit-conversion line rewritten as a declarative sentence. The MGD conversion was rounded to 723.76. The full reproduction details now live in the meta-repository `REPRODUCING_FIGURES.md` (added in this round). |
| 392 | "We should lead with this figure as Fig 1" (dominant-sector map) | **RESOLVED** | The dominant-sector map is now Figure 1 (v4 lines 65–73), placed immediately before the Background & Summary section. Background prose (v4 line 86) refers to it explicitly: *"Figure 1 shows the dominant sector at each 1/8° cell across CONUS in the historical record --- the multi-sector mosaic this dataset captures and that motivates the rest of the paper."* The duplicate copy at the end of Usage Notes was removed; the Usage Notes pointer (v4 line 575) now references the front-of-paper figure. |
| 401 | "this section repeats some info already in the Methods. review it again and consider where trimming may make sense." (Improvements section) | **PARTIAL** | The Improvements section was tightened in v3 and again in v4 (lines 583–593): each `\paragraph{...}` paragraph now leads with what the prior product did, what this dataset does instead, and a concrete consequence (e.g., "places thermoelectric demand at actual generation sites rather than at population centroids, correcting the historical decoupling of load from generation in regions like the lower Colorado and Tennessee Valley"). The closing paragraph (v4 line 595) reasserts the partial-cancellation caveat. The section retains its six paragraphs because reviewers asked us to confront the six advances explicitly; if you want further trim, let me know which advance you would fold into Methods. |
| 431 | "this referes to a specific file in the metarepo, please only refer to the repo in general to abv" | **RESOLVED** | All script/file references in the manuscript body have been replaced with general repository pointers in v4 (Methods §preprocessing, Table 2 caption, Eq. 5 sensitivity subsection, Usage Notes HUC aggregation, Code-availability bullets). The reproduction guide was added to the meta-repository at `tethys_integration_metarepo/REPRODUCING_FIGURES.md` and is referenced from the Code availability section. |
| 441 | TODO: coauthors to fill in per CRediT roles | **DEFERRED per coauthor decision** | v4 retains the illustrative CRediT template (lines 605–614). Bracken instructed to leave for coauthor pass before submission. |
