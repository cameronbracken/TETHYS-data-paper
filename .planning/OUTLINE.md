# Outline: High-resolution monthly sectoral water demands for the U.S. over 1980–2100

## Structure

### I. Abstract
- **Goal**: Summarize the dataset, its scope, the validation result framed honestly, and the contribution.
- **Implements**: CLAIM-01, CLAIM-02, CLAIM-04, CLAIM-05.
- **Key points**:
  - One-line motivation: sectoral and regional heterogeneity in U.S. water demand.
  - Scope: gridded 1/8° monthly six-sector demand for CONUS, 1980–2100, eight scenarios.
  - Validation framed sector-first, not aggregate-first.
  - Headline contribution vs prior products: GCAM-USA, CERF, SSP-pop, climate forcing, USGS anchoring, 1/8°.
- **Transition to next**: lead the body with the same sectoral framing the abstract opens.

### II. Background & Summary
- **Goal**: Establish the scientific need and the gap, then state what the dataset delivers.
- **Implements**: CLAIM-01, CLAIM-02, CLAIM-05.
- **Key points**:
  - Scarcity is demand-driven and locally heterogeneous (Huang 2018, Wada 2017, van Vliet 2021, Hadjimichael 2023).
  - Reconstructed historical and global SSP/RCP gridded products exist but lack CONUS resolution / scenario consistency.
  - Khan 2023 Tethys global product is the immediate predecessor; this work refines it for CONUS.
  - Six-way improvement enumerated as a forward reference to "Improvements over previous version".
  - Workflow figure and prior-datasets table.
- **Transition to next**: methods deliver the chain that produces the dataset.

### III. Methods and Data
- **Goal**: Specify, with equations and proxies, every step of the downscaling chain.
- **Implements**: CLAIM-02.
- **Subsections** (each is a draft file):
  - `methods-gcam-usa.md` — GCAM-USA inputs.
  - `methods-meteorological-forcing.md` — TGW-WRF preprocessing, monthly deficit, GSI (Eqs.~\ref{eq:gsi-components}–\ref{eq:gsi-monthly}).
  - `methods-spatial-downscaling.md` — Eq.~\ref{eq:spatial} and per-sector proxies (Irrigation/Demeter, Electricity/CERF, Municipal/SSP-pop, Livestock/GLW-3, Manufacturing & Mining/population).
  - `methods-temporal-downscaling.md` — Irrigation Eq.~\ref{eq:irr-weights}, Electricity Eqs.~\ref{eq:elec-cases}–\ref{eq:elec-demand}, Domestic Eq.~\ref{eq:dom-monthly}.
  - `methods-source-shares.md` — Eq.~\ref{eq:source-shares} renewable vs non-renewable.
  - `methods-future-projection.md` — frankenstein coupling rationale.
- **Transition to next**: methods produce the published record described in Data Records.

### IV. Data Records
- **Goal**: Document where the data lives and how it is structured.
- **Implements**: CLAIM-03.
- **Key points**:
  - MSD-Live URL and Tethys GitHub URL.
  - File-naming convention; netCDF schema; CDL example listing.
  - Scenario directory table.
  - Per-scenario YAML configs for reproducibility.
- **Transition to next**: validation tests whether the published record matches USGS where USGS data exist.

### V. Technical Validation
- **Goal**: Quantify agreement with USGS at HUC6 for the three dominant sectors and characterize biases.
- **Implements**: CLAIM-04.
- **Subsections** (each is a draft file):
  - `validation-overview.md` — coarse-to-fine, total-to-seasonal validation frame; Table~\ref{tab:validation-metrics}.
  - `validation-conus-annual.md` — Figs.~\ref{fig:annual-total-timeseries}–\ref{fig:annual-total-boxplot}.
  - `validation-huc6-spatial.md` — Figs.~\ref{fig:map-pbias}–\ref{fig:huc-correlation}.
  - `validation-bias-diagnosis.md` — explanation for sector biases; uncertainty in USGS reference.
  - `validation-seasonal.md` — Fig.~\ref{fig:monthly}.
  - `validation-inter-scenario.md` — Fig.~\ref{fig:scenarios}.
  - `validation-limitations.md` — 6 named limitations.
- **Transition to next**: usage notes describe how the validated record is meant to be consumed.

### VI. Usage Notes
- **Goal**: Show how to load and aggregate the dataset.
- **Implements**: CLAIM-03 (reusability dimension).
- **Key points**:
  - xarray loading example.
  - km³/yr ↔ MGD conversion.
  - HUC aggregation pointer to `validation/1-postprocess-tethys.py` and `xagg`.
  - Dominant-sector map (Fig.~\ref{fig:dominant-sector}).
- **Transition to next**: improvements section closes by mapping the dataset's advances to the prior Tethys global product.

### VII. Improvements over previous version
- **Goal**: Itemize the six advances vs Khan 2023.
- **Implements**: CLAIM-05.
- **Key points**:
  - GCAM-USA integration; CERF-based siting; SSP-consistent population; GSI-based irrigation timing; USGS-anchored source-share attribution; 1/2°→1/8° refinement.
  - Closing paragraph: re-state the partial-cancellation caveat for honesty.
- **Transition to next**: code availability supports reproducibility of every advance just claimed.

### VIII. Code availability
- **Goal**: Provide pointers to every code artifact required to reproduce the dataset.
- **Key points**: Tethys, integration meta-repository, Demeter, CERF, TGW-WRF.

### IX. Acknowledgments / Author contributions / Competing interests
- **Goal**: Required journal sections.

## Key Sources
- Huang 2018 (`hess-22-2117-2018`) — historical gridded benchmark.
- Khan 2023 — immediate predecessor.
- Wada 2017 — global gridded.
- van Vliet 2021 — country/basin SSP.
- Vernon 2021 — CERF.
- Vernon 2018 — Demeter.
- Jones 2016 — SSP gridded population.
- Jones 2023 — TGW-WRF.
- Jolly 2005 — GSI formulation.
- Moore 2015 — irrigation deficit-and-growing-season approach.
- Roy 2005 — irrigation timing.
- Wada 2011 — domestic temperature-anomaly formula.
- Calvin 2019, Binsted 2022, Zhao (×2) — GCAM-USA.
- Gilbert 2018 — GLW-3.
- Skinner 2025, Stets 2025 — refreshed USGS uncertainty.
- WWDR 2019, Niazi 2024, Awais 2024, Graham 2020, Kyle 2023, Hadjimichael 2023 — scarcity context.

## Open Questions
- How often does the Eq.~\ref{eq:source-shares} clip bind, and what is the basin-level mass-balance violation?
- Are HDD≥650 / CDD≥450 thresholds robust to perturbation?
- What is the conveyance-loss formulation in `_with_losses` files?
- How are CIs computed for HUC6 Pearson r given clear spatial autocorrelation?
