# Precis: High-resolution monthly sectoral water demands for the U.S. over 1980–2100

## Thesis
A scenario-consistent, gridded (1/8°), monthly, six-sector water-demand record for CONUS spanning 1980–2100 — produced by coupling GCAM-USA, Demeter, CERF, SSP-aware population, TGW-WRF climate forcing, and USGS-anchored source-share adjustment in the Tethys downscaling framework — improves on the prior 1/2° global Tethys product and supports integrated energy-water-land modeling and local-to-regional scarcity assessment, while exhibiting compensating sector-level biases (notably -45% Domestic, -30% Electricity, +5% Irrigation) that the descriptor characterizes transparently.

## Audience
*Scientific Data* readers: integrated assessment modelers, hydrologists, water-resources engineers, MultiSector Dynamics (MSD) researchers, regional planners, and developers of routing/water-management models (e.g., mosartwmpy) who need scenario-consistent demand inputs at sub-state resolution. They expect: complete metric panels (Pearson + Spearman, KGE/NSE, MBE, RMSE), statistical uncertainty (n, CIs, significance), explicit characterization of methodological choices, and reusable provenance.

## Purpose
Convince the reader that (a) this dataset is the highest-resolution scenario-consistent multi-sector water-demand record for CONUS, (b) the authors have characterized its biases honestly enough that downstream users can decide where to trust it, and (c) the data, code, and configuration are reproducible. The reader should be able to download a scenario directory, read the YAML config, run a sector aggregation, and know exactly what each sector represents.

## Hook
Aggregate CONUS-scale agreement with USGS within 10% — but that 10% is the partial cancellation of a -45% domestic underestimate, a -30% thermoelectric underestimate, and a +5% irrigation overestimate. The dataset is useful precisely because its biases are sector-resolved and reported, not because it is uniformly accurate.

## Key Claims
- **CLAIM-01**: Existing high-resolution multi-sector demand records for CONUS either lack future projections (Huang 2018) or run at coarser global resolution (Khan 2023, Wada 2017, van Vliet 2021). → motivates the contribution and framing in Background & Summary.
- **CLAIM-02**: A six-step downscaling chain (GCAM-USA → Demeter/CERF/SSP-pop/GLW-3 spatial proxies → TGW-WRF temporal proxies → USGS-anchored source-share clip) produces gridded demand at 1/8° monthly resolution under one historical and eight future RCP×TGW×SSP scenarios. → implemented in Methods and Data.
- **CLAIM-03**: The dataset is published at MSD-Live with a documented netCDF schema and YAML configurations sufficient to identify the exact Tethys run that produced each scenario. → Data Records.
- **CLAIM-04**: At HUC6 the dataset reproduces the spatial pattern of USGS demand with Pearson r between 0.71 (Domestic) and 0.95 (Irrigation), with sector-level biases of -45% (Domestic) to +5% (Irrigation) that partially cancel at CONUS aggregate. → Technical Validation.
- **CLAIM-05**: The dataset advances the prior Tethys global product in six specific ways (state-resolved GCAM-USA, CERF siting, SSP-population, GSI-based irrigation timing, USGS-anchored source shares, 1/2°→1/8° refinement). → Improvements over previous version.
- **CLAIM-06**: Known limitations (livestock stationarity, manuf./mining proxy, thermoelectric source-share carve-out, riparian vs. reservoir allocation, simplified GSI, conveyance losses) bound the appropriate use of the record. → Limitations.

## Counterarguments to Address
1. **"Aggregate agreement within 10% is misleading because it cancels sector biases."**
   - Response: Acknowledge explicitly in abstract and closing summary; lead with sector-resolved metrics in the validation section; report Table~\ref{tab:validation-metrics} with full panel.
   - Section: Abstract, Technical Validation, Improvements over previous version (closing).
2. **"The validation is statistically thin for *Scientific Data*."**
   - Response: Add Pearson r with n and CIs; report Spearman, KGE/NSE, MBE, NRMSE, MedAPE per sector at HUC6; note residual spatial autocorrelation; bound how often the Eq.~\ref{eq:source-shares} clip binds and basin-level mass-balance impact.
   - Section: Technical Validation, especially the bias-diagnosis subsection.
3. **"The frankenstein coupling is not a single self-consistent Earth-system simulation."**
   - Response: Address head-on in Future projection methods; cite Khan 2023 precedent; mark the dataset as scenario-plausible for sensitivity/adaptation studies, not causal attribution.
   - Section: Future projection methods.
4. **"The Eq.~\ref{eq:source-shares} clip is asymmetric and not mass-conserving."**
   - Response: Quantify how often the clip binds, the magnitude of basin-level mass-balance violation, and the rationale (preserving observable spatial pattern at the cost of strict conservation).
   - Section: Gridded renewable vs. non-renewable source shares (or Bias diagnosis subsection).
5. **"The Eq.~\ref{eq:elec-cases} HDD/CDD thresholds are not sensitivity-tested."**
   - Response: Reference Huang 2018 precedent and either add a sensitivity table or justify why thresholds were not perturbed.
   - Section: Electricity (temporal downscaling).

## Scope
### In
- Methods description for the full Tethys-USA pipeline used to produce the published record.
- Validation against USGS 2015 (refreshed Jan 2025) at HUC6 for the three sectors covering >90% of demand (Irrigation, Electricity, Domestic).
- Inter-scenario consistency check across the 8 future scenarios.
- Six-point comparison vs the prior global Tethys product.
- Six explicit limitations and the resulting caveats for downstream use.

### Out
- New science about water scarcity itself (this is a data descriptor, not a scarcity-assessment paper).
- Per-plant validation of CERF siting (cited from Vernon 2021).
- Independent re-derivation of TGW-WRF (cited from Jones 2023).
- Routing/management of demand through the river network (deferred to mosartwmpy).
- Direct uncertainty quantification of GCAM-USA scenarios.

## Domain
general — physical-science data descriptor; *Scientific Data* style; not legal or pure economics. Use `writing-general` style rules (clean, declarative, evidence-anchored prose, no hedging, no AI smell).
