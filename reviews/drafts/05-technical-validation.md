# Section: Technical Validation

> Source: `tethys-data-paper/main_v3.tex` lines 282–374. The block below is the
> verbatim LaTeX content; reviewers should cite line numbers from main_v3.tex.

```
282 \section*{Technical Validation}
283
284 We validate the downscaled dataset at the three sectors that together account for over 90\% of CONUS water demand: irrigation, thermoelectric, and domestic (public supply)\cite{skinnerWaterWithdrawalConsumption2025}. Reference data are the USGS five-year water-use records, refreshed in January~2025, at the HUC12 scale for public supply and irrigation and per-plant for thermoelectric. We proceed from coarse to fine and from total to seasonal: first comparing CONUS annual totals, then moving to HUC6 spatial agreement, then to the HUC6 annual scatter and correlation, and finally the CONUS monthly cycle. The goal is not to declare a ``true'' dataset, since neither USGS nor Tethys are direct observations at 1/8$^{\circ}$ resolution, but to establish that the downscaled record reproduces the dominant features of observed spatial and temporal demand patterns, with quantified bias where it departs.
285
286
287 \begin{table}[ht]
288 \centering
289 \begin{tabular}{lcccccc}
290 \toprule
291 \textbf{Sector} & \textbf{Pearson r} & \textbf{Spearman} & \textbf{NSE/KGE} & \textbf{MBE (\%)} & \textbf{NRMSE (\%)} & \textbf{MedAPE (\%)} \\
292 \midrule
293 Irrigation   & 0.95 & 0.92 & 0.85 & +5   & 12 & 8  \\
294 Electricity  & 0.88 & 0.85 & 0.72 & -30  & 25 & 15 \\
295 Domestic     & 0.71 & 0.68 & 0.45 & -45  & 35 & 22 \\
296 Industrial   & 0.82 & 0.79 & 0.65 & -10  & 18 & 12 \\
297 Livestock    & 0.85 & 0.82 & 0.70 & -5   & 15 & 10 \\
298 \midrule
299 \textbf{Total} & \textbf{0.93} & \textbf{0.90} & \textbf{0.82} & \textbf{-10} & \textbf{14} & \textbf{9} \\
300 \bottomrule
301 \end{tabular}
302 \caption{Validation metrics for Tethys 2.0 water demand estimates against USGS 2015 baseline at the HUC6 scale. Metrics include Pearson and Spearman correlations, Nash-Sutcliffe Efficiency (NSE) or Kling-Gupta Efficiency (KGE), Mean Bias Error (MBE), Normalized Root Mean Square Error (NRMSE), and Median Absolute Percent Error (MedAPE).}
303 \label{tab:validation-metrics}
304 \end{table}
305 \subsection*{CONUS annual totals}
306
307 Figure~\ref{fig:annual-total-timeseries} compares CONUS-aggregated annual demand for each of the three sectors and their sum. Tethys reproduces both the magnitude and long-term trend of USGS totals, within 10\% at annual resolution. The GCAM-USA 5-year time step manifests in the Tethys annual irrigation demands as reduced interannual variability relative to USGS. Magnitudes differ sharply across sectors, as expected: irrigation dominates consumptive use, while thermoelectric and irrigation are of comparable magnitude in withdrawals. The decline Electricity withdrawals reflects a known trend due in large part to the switch from coal-fired plants to other technologies \cite{skinnerWaterWithdrawalConsumption2025}. Figure~\ref{fig:annual-total-boxplot} shows the distribution of percent difference between the two records across the HUC6 regions. Domestic and Irrigation show sizable sector-level biases in opposing directions at the HUC6 scale, which partially cancel at the CONUS total.
308
309 [figures 309–321]
323 \subsection*{HUC6 spatial agreement}
324
325 Figure~\ref{fig:map-pbias} maps the percent difference in annual average use at HUC6 scale. Tethys tends to exceed USGS in the Electricity sector, especially in the eastern and southeastern U.S.~where CERF-sited plants concentrate cooling demand in basins where USGS reports lower per-HUC totals. Tethys falls below USGS in Irrigation in several western basins --- notably the lower Colorado and parts of the Central Valley --- where the GSI-weighted monthly distribution underweights months that USGS records as heavy irrigation under observed 2015 conditions. At basin-wise correlation (Figure~\ref{fig:huc-correlation}), annual-average agreement at HUC6 ranges from 0.71 (Domestic) to 0.95 (Irrigation), which we take as evidence that the spatial pattern of use is well captured even where the magnitude is biased.
326
327 [figures 327–339]
341 \subsection*{Bias diagnosis and uncertainty}
342 The -45\% bias observed in domestic demand (Table \ref{tab:validation-metrics}) is likely attributable to the calibration of the Wada $R$ coefficient, which may not fully capture the U.S. public-supply sensitivity, or a mismatch in the GCAM-USA base-year socioeconomic data compared to USGS 2015 reporting. Furthermore, reference USGS estimates themselves carry inherent uncertainties, particularly in the thermoelectric and irrigation sectors, as documented in recent reanalyses \cite{Skinner2025USGS, Stets2025USGS}.\subsection*{Seasonal cycle}
343
344 Figure~\ref{fig:monthly} compares the mean monthly cycle at CONUS scale. Irrigation and Electricity withdrawals reproduce the seasonal shape observed by USGS closely. Electricity consumption shows a consistent offset in non-summer months, likely from the GCAM-USA representation of non-cooling electricity water use. Domestic shows a broadly consistent positive bias across months; this reflects the $R$ amplitude coefficient used in Eq.~(\ref{eq:dom-monthly}), which was calibrated to aggregate USGS demand rather than to the post-2015 public-supply subset.
345
346 [figure 346–351]
353 \subsection*{Inter-scenario consistency}
354
355 Figure~\ref{fig:scenarios} shows CONUS annual demand across all nine scenarios for the three largest sectors and their sum. The scenario spread exhibits the expected signature of each input: strong SSP-driven divergence in Domestic (SSP5 rising with population, SSP3 declining), large inter-scenario variability in Irrigation driven by RCP, and a monotone decline in Electricity across all futures that reflects the GCAM-USA projection of declining thermoelectric water use under continued fleet turnover. The discontinuity at 2020 between the historical and future lines reflects the switch from the ERA5‑based reanalysis historical run to the TGW-driven future simulations that restart the historical weather sequence with added thermodynamic warming; within the future period the scenarios evolve smoothly and consistently with their  drivers.
356
357 [figure 357–362]
364 \subsection*{Limitations}
365
366 Several known limitations should inform reuse of the dataset:
367 \begin{itemize}
368     \item \textbf{Livestock spatial stationarity.} The GLW~3 livestock distribution is held fixed at 2010 across all years and scenarios. Livestock is \textasciitilde2\% of CONUS demand, but within individual basins --- particularly in states with rapidly shifting livestock composition --- this may introduce local bias.
369     \item \textbf{Manufacturing and mining proxy.} Using population as the proxy for these two sectors captures average patterns of labor-associated demand but misses site-specific industrial or mining facilities whose water withdrawals can dominate local basin totals.
370     \item \textbf{Electricity source-share carve-out.} Eq.~(\ref{eq:source-shares}) assigns thermoelectric demand to surface water only and re-normalizes remaining-sector shares. Where a thermoelectric plant is served from a local groundwater source (rare but documented), this assumption places the withdrawal on surface water and slightly overstates surface demand elsewhere.
371     \item \textbf{Riparian vs.\ reservoir allocation.} The dataset represents demand at the cell where use occurs, which is not necessarily the cell from which water is withdrawn in reservoir-fed or interbasin-transfer systems. Downstream routing and water-management models (e.g., mosartwmpy) handle the supply-side re-allocation.
372     \item \textbf{Simplified GSI.} The growing-season index used for irrigation temporal downscaling (Eqs.~\ref{eq:gsi-components}--\ref{eq:gsi-monthly}) drops the vapour-pressure-deficit (VPD) component of the original Jolly et al.\cite{Jolly_2005} formulation. This simplification is consistent with Moore et al.\cite{Moore_2015} but may underweight drought months in humid climates where VPD is the binding constraint.
373     \item \textbf{Conveyance losses.} Irrigation files exist with and without conveyance losses applied (\texttt{\_with\_losses} suffix). Users coupling the dataset to hydrologic routing should select the appropriate variant for their application.
374 \end{itemize}
```
