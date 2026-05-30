# Style notes — target voice and structure for main_v2.tex

Distilled from three *Scientific Data* descriptors Cameron (co-)authored:

- **Bracken, Son, Broman, Voisin (2025).** "GODEEEP-hydro: Historical and projected power system ready hydropower data for the United States" — 6 pages. Bracken first author. Most direct precedent.
- **Son, Bracken, Broman, Voisin (2025).** "Monthly hydropower generation data for Western Canada to support Western-US interconnect power system studies" — 8 pages. Same team, sister paper.
- **Campbell, Bracken, Underwood, Voisin (2024).** "A Multi-Decadal Hourly Coincident Wind and Solar Power Production Dataset for the Contiguous United States" — 8 pages. Campbell first author; similar structure.

All three follow the *Scientific Data* house template rigorously. They are compact, equation-forward, and validation-heavy. The Tethys v2 paper should inherit this shape.

## Quick-reference card

1. **Total length:** aim for **7–9 pages** typeset (the current draft will probably compile to ~6 when the commented-out sections fill in). *Scientific Data* descriptors are concise; do not inflate.
2. **Voice:** first-person plural ("we present", "we use", "we validate") for choices; passive for procedures. Active wherever results are stated. No "In this paper we…" openers; start each section with a claim or a fact.
3. **Equations:** numbered (1), (2), … and referenced by number as "Eq. (2)" or "Equation (2)". Every symbol defined immediately after the equation in the same paragraph.
4. **Figure captions:** one factual sentence. Occasionally a second short sentence clarifying what the reader should notice. **Not** interpretive; the Technical Validation prose does the interpreting.
5. **Citations:** superscript numeric (Nature style). Inline software/data URLs as parenthetical links, not as footnote-cites.

## Section-by-section, with concrete patterns

### Title
- Descriptive, information-dense, no fluff. Son 2025 is 86 characters; GODEEEP-hydro 87; Campbell 106. The current Tethys draft title (86 characters) is already in the pocket.

### Abstract
- **Single paragraph, 9–12 sentences, ~170–200 words.**
- First sentence: the *thing* (what resource or system).
- Middle: *problem* (what's missing in available data) → *solution* (what this paper presents) → *scope* (years, scenarios, spatial coverage, sectors).
- Last 1–2 sentences: *what's validated* and *who this is for*.
- GODEEEP-hydro abstract example: "Hydropower is a critical electricity resource … Despite its value … there are very few comprehensive datasets … In this paper, we present a hydropower generation dataset … The dataset contains monthly and weekly hydropower generation estimates … which includes 4 future climate scenarios."

Current Tethys abstract has the right shape but needs tightening and more numbers up front.

### Background & Summary
- **2–3 paragraphs typically, rarely 4.** Not a comprehensive lit review — just enough to motivate the dataset's existence.
- **Paragraph 1:** why the resource matters, how much of it there is ("hydropower accounts for 6.63% of annual utility-scale generation from 2013 to 2023"). Concrete numbers.
- **Paragraph 2:** prior work and what gap this fills. Cite 3–6 prior studies, not 20. Son et al. and Campbell et al. both use this paragraph to set up their Table 1 comparison of prior datasets — see **Emulate This**, below.
- **Paragraph 3:** this paper's contribution. What we present (scope), what's new, and what it enables.
- **Emulate this pattern** for Tethys v2: open with USGS total US water use and the multi-sector split, spend one paragraph on the demand-side-drivers literature + Khan 2023 gap, spend one paragraph on this dataset's scope and the six improvements (with a forward reference to the "Improvements over previous version" section).

### Comparison table of prior datasets (Son 2025, Table 1)
**Emulate this.** Son's Table 1 columns: *Dataset name · Type · Spatial representation · Temporal representation · Runoff model · Streamflow/reservoir ops · Hydropower model*. It lets the reader see the new paper's contribution at a glance. For Tethys v2, analogous columns could be: *Dataset · Spatial resolution · Temporal resolution · Scenarios · Sectors · Validation approach*. Rows: Khan 2023 (prior Tethys), Huang 2018, van Vliet 2021, Jones 2024, this paper. This single table does half the work of the "Improvements over previous version" section.

### Methods
- **Subsection per model component**, each 1–2 paragraphs. GODEEEP-hydro has Meteorology / Hydrology Model / Routing and Water Management / Hydropower Model. Campbell has Power Plant Specifications / Wind / Solar / Wind and Solar generation model. Son has Overview / Hydroelectric power plants / Runoff generation / Streamflow routing with reservoir operations / Monthly hydropower generation scaling.
- **Tethys v2 target subsections** (rename from current draft):
  - GCAM-USA (input scenarios) — 1 short paragraph; no equations; cite Zhao et al.
  - **Preprocessing of climate forcing** (NEW — for Eldardiry's gsi_nersc pipeline): 1 paragraph, reference the new Fig 1 flow diagram.
  - Spatial Downscaling (Eq. 1 + per-sector proxies): 1 paragraph intro + 1 short paragraph per sector (Irrigation / Electricity / Municipal / Livestock / Others).
  - Temporal Downscaling (the big one): 1 intro paragraph + 1 subsection per sector with their equations.
  - Gridded runoff shares (needs the new USGS-anchored ratio equation from `EQUATIONS_AUDIT.md`).
  - Future Projection Methods ("frankenstein" caveat): 2–3 paragraphs listing the version choices and their consistency arguments.
- **Every equation** that affects the published data must appear. Symbols defined immediately.
- **Decision rules** (like Campbell's "For any plant with a positive 'Azimuth Angle' …") formatted as labeled lists. Used for rules that don't simplify to a formula. Good pattern for Tethys's HDD/CDD reallocation rules if we don't fold them into the cases-block equation.

### Figure 1 — the schematic flow diagram
- All three papers have a schematic on page 1 or 2.
- **Son 2025 Fig 1** is best for Tethys to emulate: four horizontal rows — *Process* (text labels), *Model* (colored boxes with software names), *Input* (cylindrical data stores with URLs where public). Left-to-right pipeline.
- **GODEEEP-hydro Fig 1** is simpler — just four boxes left-to-right.
- Tethys v2 Fig 1 should show: *Process* = {GCAM input → Spatial downscaling → Temporal downscaling → Runoff-share adjustment → Published dataset}; *Model* = {GCAM-USA, Tethys core with Demeter+CERF+Population proxies, TGW-WRF preprocessing producing GSI/HDD/CDD, adjust_runoff_shares}; *Input* = {GCAM database, Demeter LULC, CERF siting, Jones SSP population, TGW-WRF forcing, USGS baseline}. Check whether `flow-chart2.pdf` already does this.

### Data Records
- **Compact and factual.** Not a story.
- Opens with the repository URL.
- One paragraph per file type, followed by a definition list of columns / variables.
- Bold-italic for variable names: *eia_id* An integer value…
- Sample CDL listing for netCDFs (the current draft already does this well for the Livestock monthly netCDF).

### Technical Validation — *the heart of the paper*
- **Subsections by validation approach, not by sector.**
  - GODEEEP-hydro: Hydrology model validation / Hydropower model validation / Validation against 9505 data.
  - Campbell: Meteorology / Power (split into plant-level, BA-level, NERC-level).
  - Son: Runoff and streamflow / Hydropower generation.
- Each subsection: a **standard metric** (KGE for hydrology; bias % for power). Explain the metric in one sentence on first use.
- **Compare at multiple scales** — the paper shows its comparison at plant/cell scale *and* at aggregated scale. That answers different questions (local accuracy vs. system-level bias).
- **Compare to multiple reference datasets** if possible. Son compares to Statistics Canada, WECC ADS 2032, PLEXOS-World 2015, WRI Global DB in Table 1 and discusses each. For Tethys that's USGS 2015 water-use, USGS 2010, Khan 2023 output.
- **Spatial plots + distribution plots** as complementary figures. GODEEEP-hydro's Fig 3 shows KGE spatially *and* as a histogram side-by-side; that's the template for our HUC6 percent-difference map + boxplot (already in the current draft).
- **Honest about bias.** GODEEEP-hydro: "lower performance in the Midwest region east of the Rocky Mountains. The validation period has lower performance than the calibration period, which is to be expected." Campbell: names specific BAs with high bias. Son: lists the 36 excluded facilities and why. **Tethys v2 Limitations subsection must do the same** — concrete named regions and causes, not hand-waving.

### Usage Notes
- **Short.** 1–2 paragraphs.
- Opens with the file format and how to read it. "The data is provided in csv files which should be readable in any modern software package."
- Then how to join / subset / convert. For Tethys: an `xarray.open_mfdataset` snippet, the `km³/yr ↔ MGD` constants, and a pointer to `validation/1-postprocess-tethys.py` for HUC aggregation.

### Code Availability
- Every code dependency cited with URL and version / DOI. GODEEEP-hydro lists GitHub org, package names, and specific repository URLs inline.
- For Tethys v2: `tethys-code` (specific tag), `tethys_integration_metarepo` (post-cleanup tag), `mosartwmpy` (for downstream users), Demeter, CERF, Jones-population, TGW-WRF (MSD-Live URL).

### Acknowledgements, Author Contributions, Competing Interests
- Very short, templated. Cameron's prior papers: one sentence for funding, a 2–4 sentence attribution of specific contributions (CRediT-style), one sentence "The authors declare no competing interests."

## Prose patterns to emulate

### Sentence length and rhythm
- Median sentence length ~20 words. Longest sentences ~35 words, usually when naming a list.
- Alternate short factual claim + longer supporting sentence: "The VIC hydrology model is calibrated at a monthly timestep for the period 1981–2000, and validated for 2001–2019, with the period 1979–1980 used as spin-up. We use the KGE metric to assess model performance on simulating runoff."
- Don't stack too many qualifiers. Cut "relatively", "generally", "typically" when they add nothing.

### Opening sections with claims, not signposts
- **Bad:** "This section describes the validation procedure."
- **Good (GODEEEP-hydro Hydrology):** "The VIC hydrology model is calibrated at a monthly timestep for the period 1981–2000…"
- **Good (Son Overview):** "The monthly estimates of hydroelectric power generation by individual plants in Western Canada are developed using an integrated hydrology-hydropower modeling approach…"

### Explicit numbers over adjectives
- "accounted for 6.63% of annual utility-scale generation" (GODEEEP-hydro)
- "Of the 1492 plants in the HydroWIRES B1 data, 1452 are included" (GODEEEP-hydro)
- "less than 5% average bias" (Campbell)
- **Tethys v2 analog:** "the three modeled sectors — Irrigation, Electricity, and Domestic — account for over 90% of total U.S. water demand" is already in the current draft; keep and cite USGS.

### Honest limitations without apologetic hedging
- State the limitation, state the cause, state the consequence. Don't editorialize.
- "Due to these projections of non-stationarity in weather patterns, there is increased urgency to develop models to accurately predict renewable energy generation from climate models." (Campbell, setting up motivation)
- "Despite some bias when compared to EIA-923 and scada data, the overall trend in infrastructure development is [reproduced]." (Campbell)

## Figure-caption patterns

Bracken and Son both use short captions. Examples:

- "Fig. 2 KGE values for the calibrated VIC model in the calibration period (top) and the validation period (bottom)."
- "Fig. 3 KGE values from the B1hydro model for all modeled hydropower plants for both monthly and weekly data."
- "Fig. 4 Annual verification of B1hydro predictions against generation reported by the Army Corps of Engineers Northwestern Division for Columbia River Basin hydropower plants."

Pattern: `Fig. N <what it shows>, <qualifier: scale, period, or source>.` Period at the end. No "This figure demonstrates that …" sentences.

Campbell's captions sometimes run a bit longer with a second sentence, e.g., Fig. 2: "The annual wind energy delivered by BA shows the annual change in infrastructure. The EIA-923 and GODEEEP datasets are aggregated to the BA according to the EIA-860 operating reports while SCADA come pre-aggregated by the BA. The percent difference with respect to GODEEEP is averaged over the number of years that overlap with the comparison datasets EIA-923 and BA self-reported SCADA." Use this longer form only when the reader needs the methodology to interpret the panel.

**Tethys v2 — captions to rewrite:**
- Current Fig 2 (annual totals): works, but shorten.
- Current Fig 3 (percent diff boxplot): one sentence is enough.
- Current Fig 4 (HUC6 spatial %diff): add scale clarification.
- Current Fig 5 (scatter + correlation): currently says "Enter Caption" — write.
- Current Fig 6 (monthly): currently "Enter Caption" — write.
- New Fig 7 (val6-scenarios-annual-conus-timeseries): "Annual CONUS water withdrawals by sector and scenario. The historical simulation (black, 1975–2015) is shown alongside eight future scenarios (2020–2100) that vary by RCP, climate model sample (cooler/hotter), and SSP. Each panel uses an independent y-axis."

## Equation conventions

- Numbered in parentheses on the right margin: `\tag{(1)}` equivalent (the current draft uses standard LaTeX `\begin{equation}…\end{equation}` which is fine — *Scientific Data* numbers them automatically).
- Referred in prose as "Eq. (2)" or "Equation (2)".
- **Variables in italic math mode**, units in upright text: `$18^\circ\text{C}$`, not `$18^{\circ}C$`.
- Subscripts are descriptive text in math mode: `\text{cell}`, `\text{region}`, `\text{month}`.
- After every equation, a line starting "where …" defining every symbol.
- Cases blocks for piecewise definitions (use `\begin{cases}`). Match `EQUATIONS_AUDIT.md` for the exact rewritten forms.

## What to explicitly *avoid*

- "It is well known that …" — either cite someone or state it as fact.
- "In order to …" — use "To".
- "Utilize" → "use".
- "Approximately" → write the number with a `~` or `\approx` if you have one.
- Self-reference to the paper ("as shown in this paper", "we have demonstrated") — SciData descriptors describe datasets, not claims.
- Bullet lists in Background & Summary or Methods prose. Reserve bullets for Data Records column definitions and similar enumerations.

## Specific moves for Tethys v2

1. **Abstract:** rewrite to match the 9–12-sentence pattern. Open with total US water demand numbers from USGS. End with "This dataset is available on MSD-Live (URL)".
2. **Fig 1 redesign:** adopt Son-style three-row flow diagram. Either repurpose `flow-chart2.pdf` if it already uses this layout, or produce a new one in Mermaid/TikZ/pptx.
3. **New Table 1:** comparison of prior datasets with this one, 5 columns × 5 rows. Replaces much of the "Improvements over previous version" bullet list.
4. **Methods:** add the "Preprocessing of climate forcing" subsection documenting Eldardiry's gsi_nersc pipeline. Cite TGW-WRF primary paper.
5. **Technical Validation:** reorganise by scale (CONUS → HUC6 → HUC12 → monthly cycle) rather than by figure, as in Bracken 2025 and Son 2025. Uncomment the Limitations paragraph and expand per `EQUATIONS_AUDIT.md` secondary findings.
6. **Code Availability:** replace the placeholder prose with specific DOIs/tags.
7. **Captions:** rewrite every caption in one-sentence factual form.
8. **Scenarios timeseries figure:** place in Technical Validation under a new "Inter-scenario consistency" subsection; caption as drafted above.

---

Do NOT copy prose verbatim from the three reference papers. Use them as rhythm, density, and structure exemplars only.
