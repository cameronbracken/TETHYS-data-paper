# Section: Improvements over previous version

> Source: `tethys-data-paper/main_v3.tex` lines 400–416. The block below is the
> verbatim LaTeX content; reviewers should cite line numbers from main_v3.tex.

```
400 \section*{Improvements over previous version}
401
402 Compared with the prior Tethys global product\cite{Khan2023}, the dataset presented here advances the representation of demand in six specific ways.
403
404 \paragraph{GCAM-USA integration.} The prior record used the global GCAM configuration, which disaggregated U.S.~demand from a single national total. This dataset uses GCAM-USA, which resolves U.S.~electricity generation, manufacturing, and municipal demand at the state level and crop irrigation demand at state$\,\times\,$basin intersections. State-level inputs eliminate the artifact of national-average demand being pushed uniformly into states with very different sectoral mixes, and they allow the subsequent spatial downscaling to respect state-level regulatory and policy boundaries.
405
406 \paragraph{CERF-based power-plant siting.} Prior gridded electricity demand used population as the spatial proxy, which approximates the location of load rather than the location of cooling demand. This dataset uses explicit power-plant siting from the CERF model\cite{Vernon2021}, which places thermoelectric plants at $\approx$1-km resolution based on siting feasibility (exclusion layers, transmission proximity, cooling-water access) and then aggregates installed capacity to the 1/8$^{\circ}$ grid as the proxy. The result is a markedly more realistic spatial distribution of thermoelectric demand, particularly in regions where load centers and generation sites are geographically decoupled.
407
408 \paragraph{SSP-consistent population.} Prior work used a static base-year population map to distribute municipal, manufacturing, and mining demand across all years, including future projections. This dataset uses SSP3 and SSP5 gridded population projections from Jones and O'Neill\cite{Jones_2016}, linearly interpolated from their decadal native resolution to annual values. Scenario-consistent population is essential for the SSP-differentiated futures: SSP3 and SSP5 diverge markedly in U.S.~population growth, and that divergence propagates into the public-supply demand field in a way that a static map cannot represent.
409
410 \paragraph{GSI-based irrigation temporal downscaling.} Prior irrigation monthly weights used a simpler temperature-driven scheme. This dataset computes per-cell monthly weights (Eq.~\ref{eq:irr-weights}) from the TGW-WRF monthly deficit and growing-season index, ensuring that the monthly distribution of irrigation demand responds to climate-consistent drought and growing-condition signals rather than to a static seasonal template. In consequence, the monthly irrigation distribution varies from year to year and across scenarios, as it should.
411
412 \paragraph{USGS-anchored source-share attribution.} Prior work applied GCAM's basin-level renewable vs.\ non-renewable split uniformly across cells within each basin. This dataset uses Eq.~(\ref{eq:source-shares}) to anchor the historical 2015 spatial pattern to USGS observations while preserving the temporal evolution from GCAM. In regions with observable baseline data this reduces bias materially; outside those regions, the GCAM share is preserved transparently.
413
414 \paragraph{Resolution refinement.} Spatial resolution is refined from 1/2$^{\circ}$ to 1/8$^{\circ}$, a factor-of-four improvement in each dimension and 16x improvement in areal resolution. Combined with the finer proxy data (CERF plants at \textasciitilde1~km, Demeter LULC at 1/8$^{\circ}$, Jones population at 1/8$^{\circ}$), the 1/8$^{\circ}$ grid allows the resulting demand field to represent sub-state variation relevant to river routing, reservoir management, and local planning applications.
415
416 Together, these six advances produce a dataset that validates well against USGS at HUC6 (annual correlations of 0.71--0.95) and that supports detailed scenario analysis. In addition this dataset is validated against the refreshed January 2025 USGS water-use record, which includes updated thermoelectric cooling-water estimates\cite{skinnerWaterWithdrawalConsumption2025}.
```
