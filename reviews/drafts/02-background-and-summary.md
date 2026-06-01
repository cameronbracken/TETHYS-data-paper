# Section: Background & Summary

> Source: `tethys-data-paper/main_v3.tex` lines 56–90. The block below is the
> verbatim LaTeX content; reviewers should cite line numbers from main_v3.tex.

```
56 \section*{Background \& Summary}
57
58 Humans depend on water for irrigation, thermoelectric cooling, public supply, industry, and livestock, with the relative importance of these sectors varying sharply across regions and over time. Global water demand has continued to rise through the 21st century under combined socioeconomic and climatic pressures\cite{WWDR2019, Niazi2024PeakWater, Awais2024Preprint}, and demand-side drivers, not supply-side limits, dominate most projected shifts in water scarcity\cite{Graham_2020, Awais2024Preprint, Kyle2023Sustainability}. Even where regional supply appears ample, scarcity can manifest locally when demand and availability are mismatched in space or time\cite{HADJIMICHAEL23}. Resolving water demand at the spatial and temporal scales of management decisions is therefore essential for evaluating scarcity under climate and socioeconomic change.
59
60 The availability of high-resolution, multi-sectoral water demand projections remains a bottleneck for integrated modeling. Reconstructed historical datasets, such as Huang et al. (2018)\cite{Huang2018}, have provided valuable gridded benchmarks for past decades but do not extend to future scenarios. Conversely, global water scarcity assessments often rely on coarse-resolution integrated assessment model outputs that lack the spatial detail required for river routing or local management modeling\cite{Wada_2017, van_Vliet_2021}. Bridging these scales requires spatial and temporal downscaling\cite{hess-17-4555-2013, van_Vliet_2021, Jones_2024}, but the choice of gridded proxy variables and the consistency of driving scenarios materially affects the resulting demand fields. Khan et al. (2023)\cite{Khan2023} produced the first global Tethys-downscaled multi-sector product at 1/2$^{\circ}$ resolution; however, resolving seasonal patterns---which differ sharply across sectors and regions---requires monthly resolution and scenario-consistent climate and population forcing.
61
62 We present such a dataset here, refined to 1/8$^{\circ}$ resolution across CONUS. This product serves a growing community of researchers in MultiSector Dynamics (MSD) who require consistent energy-water-land inputs to study the resilience of the U.S. bulk power system, the sustainability of groundwater resources, and the impacts of regional climate extremes. By providing a common, scenario-consistent demand foundation, this dataset enables inter-model comparisons and supports the development of robust adaptation strategies.
63
64 We present such a dataset here. The published record contains gridded monthly water withdrawals and consumption for six sectors --- irrigation, thermoelectric, municipal (public-supply and domestic), livestock, manufacturing, and mining --- at 1/8$^{\circ}$ spatial resolution, on the CONUS extent $[25.0625^{\circ}\text{N},\,52.9375^{\circ}\text{N}] \times [-124.9375^{\circ}\text{W},\,-67.0625^{\circ}\text{W}]$, for one historical period (1980--2019) and eight future scenarios (2020--2100) that vary by RCP, TGW climate sample, and SSP. For each scenario the dataset also provides per-cell renewable vs. non-renewable source shares. The downscaling chain improves on the prior Tethys CONUS product in six specific ways (Section~``Improvements over previous version''): GCAM-USA integration, explicit CERF-based\cite{Vernon2021} power-plant siting, SSP-aware population proxies, climate-forced irrigation temporal downscaling using TGW-WRF derived deficits and growing-season indices, USGS-anchored source-share adjustment, and resolution refinement from 1/2$^{\circ}$ to 1/8$^{\circ}$. Figure~\ref{fig:schematic} shows the overall workflow. Table~\ref{tab:prior-datasets} compares this dataset with closely related published records.
65
66 \begin{figure}[ht]
67 \centering
68 % \includegraphics[width=0.85\linewidth]{flow-chart}
69 \includegraphics[width=0.85\linewidth]{flow-chart2.pdf}
70 \caption{Workflow for producing the Tethys CONUS multi-sector water-demand dataset. HUC2 Basin-scale demands from GCAM-USA are spatially downscaled using sector-specific gridded proxies (Demeter land use, CERF power-plant locations, SSP population, and fixed livestock distributions), temporally downscaled using monthly meteorological indicators derived from the TGW meteorological dataset, and post-processed with USGS-anchored adjustment of per-cell renewable vs. non-renewable source shares.}
71 \label{fig:schematic}
72 \end{figure}
73
74 \begin{table}[ht]
75 \centering
76 \small
77 \begin{tabular}{lllll}
78 \toprule
79 \textbf{Dataset} & \textbf{Spatial res.} & \textbf{Temporal res.} & \textbf{Scenarios} & \textbf{Sectors} \\
80 \midrule
81 Huang et al.\cite{hess-22-2117-2018}           & 0.5$^{\circ}$ global & monthly & historical (1971--2010) & 6 sectors \\
82 Khan et al.\cite{Khan2023} (prior Tethys)      & 0.5$^{\circ}$ global & monthly & historical + SSP/RCP futures & 6 sectors \\
83 van Vliet et al.\cite{van_Vliet_2021}          & country/basin & annual & historical + SSP & 6 sectors \\
84 Wada et al.\cite{Wada_2017}                    & 0.5$^{\circ}$ global & monthly & historical + projections & 4 sectors \\
85 \textbf{This work}                             & \textbf{0.125$^{\circ}$ CONUS} & \textbf{monthly} & \textbf{hist.\ + 8 RCP/climate/SSP} & \textbf{6 sectors + GW/SW split} \\
86 \bottomrule
87 \end{tabular}
88 \caption{Gridded multi-sector water-demand datasets that overlap in scope with the product presented here. The current dataset increases spatial resolution fourfold over its immediate Tethys predecessor\cite{Khan2023}, adds per-cell groundwater/surface-water attribution, and uses scenario-consistent population, land-use, and climate forcing rather than static baselines.}
89 \label{tab:prior-datasets}
90 \end{table}
```
