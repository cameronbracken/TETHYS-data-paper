# Section: Methods and Data

> Source: `tethys-data-paper/main_v3.tex` lines 93–221. The block below is the
> verbatim LaTeX content; reviewers should cite line numbers from main_v3.tex.

```
93 \section*{Methods and Data}
94
95 \subsection*{GCAM-USA}
96
97 Region-scale water-demand inputs come from the Global Change Analysis Model (GCAM-USA version)\cite{Zhao_gcamusa_water,Zhao2024,Calvin2019GCAM,Binsted_2022}. GCAM is a market-equilibrium integrated assessment model that allocates supply and demand across coupled energy, water, land, and economic sectors given scenario-specific assumptions on population, productivity, technology, and policy. GCAM-USA resolves U.S.~electricity generation, manufacturing, and municipal demands at the state level and crop-level irrigation demands at state $\times$ basin intersections, at 5-year intervals.
98 The eight GCAM-USA runs used in this study combine two RCPs (4.5, 8.5), two climate samples (cooler, hotter) drawn from the TGW perturbed-thermodynamics ensemble, and two SSPs (3, 5).
99
100 \subsection*{Preprocessing of meteorological forcing}
101
102 Irrigation and electricity temporal downscaling both require monthly meteorological variables consistent with each scenario. We derive these from the Thermodynamic Global Warming (TGW) meteorological forcing \cite{Jones2023TGW}at 1/8$^{\circ}$ covering the CONUS for the historical period and four future scenarios. Historical forcings were dynamically downscaled from ~30-km ERA5 reanalysis (1980-2019) using WRF. Future meteorological forcings were projected through the TGW approach, which replays historical weather sequences with added thermodynamic signals derived from CMIP6 Earth System Models. The TGW method simulates how historical weather events may shift under warming conditions while retaining the physical realism and synoptic structure of observed weather. Four scenarios combine diverging emission pathways and structural uncertainties in CMIP6 models, including moderate emissions constraints (rcp45), leading to a moderately hotter and drier future on average across CONUS, and no emissions constraints (rcp85), leading to a substantially hotter and drier future. These pathways are further combined with two CMIP model groups: one relatively cooler and one relatively hotter, based on their temperature sensitivity over CONUS. For each TGW scenario we compute daily potential evapotranspiration (PET), precipitation (P), mean temperature, heating degree days (HDD), cooling degree days (CDD), and a growing-season index (GSI). These daily fields are aggregated to monthly totals or means as appropriate and reprojected from the native TGW WRF grid to the Tethys 1/8$^{\circ}$ CONUS grid.
103
104 The monthly water deficit used in irrigation temporal downscaling is defined as $\Delta_m = \max\!\big(\text{PET}_m - P_m,\, 0\big)$. The monthly GSI is derived from a simplified version of Jolly et al.\cite{Jolly_2005}, retaining the daily minimum-temperature and daylength indicators but omitting the vapour-pressure-deficit term. Specifically, for each day $d$,
105 \begin{equation}
106 f(T_{\min,d}) = \min\!\left(\max\!\left(\frac{T_{\min,d}+2}{7},\,0\right),\,1\right), \qquad
107 g(L_d) = \min\!\left(\max\!\left(L_d - 10,\,0\right),\,1\right),
108 \label{eq:gsi-components}
109 \end{equation}
110 where $T_{\min,d}$ is the daily minimum air temperature (\textdegree C) and $L_d$ is the daylength (hours). Monthly GSI is the daily-mean product over month $m$,
111 \begin{equation}
112 G_m = \big\langle f(T_{\min,d}) \cdot g(L_d) \big\rangle_{d \in m}.
113 \label{eq:gsi-monthly}
114 \end{equation}
115 Preprocessing code is archived under \texttt{scripts/0\_preprocessing/gsi\_nersc/} in the integration meta-repository (see ``Code availability'').
116
117 \subsection*{Spatial downscaling}
118
119 The location of demand within a region is assumed to follow that of a gridded proxy appropriate to the sector. For any sector with total demand $D_{\mathrm{region}}$ and proxy field $\pi_{\mathrm{cell}}$,
120 \begin{equation}
121 D_{\mathrm{cell}} = D_{\mathrm{region}} \times \frac{\pi_{\mathrm{cell}}}{\sum_{c \in \mathrm{region}} \pi_{c}}.
122 \label{eq:spatial}
123 \end{equation}
124 The following subsections specify the proxy used for each sector.
125
126 \subsubsection*{Irrigation}
127
128 GCAM-USA reports water demand for 13 crop classes: Corn, Wheat, Rice, RootTuber, OilCrop, SugarCrop, OtherGrain, FiberCrop, FodderGrass, FodderHerb, biomass, MiscCrop, and PalmFruit. We use Demeter\cite{Vernon-2018}, a land-use spatial disaggregation model, to produce scenario-consistent annual per-crop irrigated-area maps at 1/8$^{\circ}$. Demeter applies transition-priority rules that distinguish intensification (increase of a land type within a cell) from extensification (spread from an adjacent cell) to reconcile baseline high-resolution land use with GCAM-USA boundary conditions. Per-crop irrigated-area fields then serve as the proxy $\pi_{\mathrm{cell}}$ for each crop's irrigation demand via Eq.~(\ref{eq:spatial}).
129
130 \subsubsection*{Electricity}
131
132 Electricity-sector demand in this dataset represents cooling water consumed by thermoelectric generation (coal, natural gas, oil, nuclear, biomass, geothermal, concentrated solar thermal), excluding hydropower. Previous gridded products often used population as a proxy, on the reasoning that thermoelectric plants are sited near load centers.
133 This assumption breaks down at 1/8$^{\circ}$: plants are sparser than people and are sited by a combination of cooling-water access, fuel logistics, transmission proximity, and siting constraints, not by local population. We therefore use the Capacity Expansion Regional Feasibility (CERF)\cite{Vernon2021} model to site projected power plants at $\approx$1-km resolution and 5-year increments, consistent with the installed-capacity trajectories output by GCAM-USA at state level. For each technology class, CERF-sited plants are aggregated to 1/8$^{\circ}$ grid cells and the cell-level installed capacity (MW) is used as the proxy $\pi_{\mathrm{cell}}$. State-level thermoelectric demand from GCAM-USA is then allocated proportionally to installed capacity within the state. For the historical period we use the 2015 plant inventory from the Global Power Plant Database v1.3 (GPPD) augmented with the IM3 experiment B CONUS plant inventory, merged onto the same 1/8$^{\circ}$ grid.
134
135 \subsubsection*{Municipal (public supply and domestic)}
136
137 SSP-consistent gridded population maps from Jones and O'Neill\cite{Jones_2016} are available at 10-year intervals between 2010 and 2100. For years in which population is required but unavailable, we linearly interpolate between the two bracketing decadal maps. Within each state, municipal demand from GCAM-USA is distributed to cells proportionally to projected population via Eq.~(\ref{eq:spatial}).
138
139 \subsubsection*{Livestock}
140
141 GCAM represents five livestock-product sectors (Beef, Dairy, Pork, Poultry, SheepGoat). Gridded livestock head-count maps from the GLW~3 dataset\cite{Gilbert2018} provide the spatial proxy. Mapping of GCAM sectors to GLW animals follows Table~\ref{tab:livestock}. GLW is published at 1/12$^{\circ}$ resolution for reference year 2010; we re-grid to 1/8$^{\circ}$ by allocating source-cell counts to target cells in proportion to fractional overlap, and hold the 2010 distribution fixed across all years and scenarios. The overall water-demand contribution from livestock is small (\textasciitilde2\% of CONUS total) so the impact of this static-distribution assumption on the aggregate record is limited; see ``Limitations''.
142
143 [livestock mapping table at lines 143–158]
160 \subsubsection*{Manufacturing and mining}
161
162 For manufacturing and mining, population is used as the spatial proxy, matching the approach of prior Tethys work\cite{Khan2023}. Total U.S.~demand for these two sectors is small compared to irrigation or thermoelectric, which limits the effect of this less-refined proxy on the aggregate record. See ``Limitations'' for localized implications.
163
164 \subsection*{Temporal downscaling}
165
166 GCAM-USA operates at 5-year steps. Spatially downscaled outputs are linearly interpolated in time to annual resolution before monthly downscaling. Sector-specific formulas then distribute the annual demand at each cell into 12 monthly values. Livestock, manufacturing, and mining monthly demand is assumed uniform at 1/12 of the annual value; irrigation, electricity, and domestic follow climate-driven formulations described below.
167
168 \subsubsection*{Irrigation}
169
170 For each cell and year, we compute a monthly weight field from the growing-season index $G_m$ (Eq.~\ref{eq:gsi-monthly}), the monthly deficit $\Delta_m$, and month length $N_m$:
171 \begin{equation}
172 \tilde{w}_m = \frac{\Delta_m \, G_m}{N_m}\quad, \qquad w_m = \frac{\tilde{w}_m}{\sum_{k=1}^{12}\tilde{w}_k}
173 \label{eq:irr-weights}
174 \end{equation}
175 so that $\sum_m w_m = 1$. Monthly irrigation demand is then $D_m = w_m \, D_{\mathrm{year}}$. Equation~(\ref{eq:irr-weights}) operationalizes the combined deficit-and-growing-season approach of Moore et al.\cite{Moore_2015} and Roy et al.\cite{Roy_2005}: water demand is concentrated in months that are simultaneously water-limited ($\Delta_m > 0$) and vegetatively active ($G_m > 0$). The weights are per-cell and differ across cells and years.
176
177 \subsubsection*{Electricity}
178
179 Monthly electricity water demand is distributed according to the share of annual electricity use that services heating, cooling, and all other uses, each modulated by a temperature-dependent distribution. Region-level shares of annual electricity consumption for heating $p_{\mathrm{heat}}$, cooling $p_{\mathrm{cool}}$, and other $p_{\mathrm{other}}$ come from GCAM-USA. At each cell, define annual sums $H_y = \sum_m \text{HDD}_m$ and $C_y = \sum_m \text{CDD}_m$ and monthly distribution fields $\hat{h}_m$ and $\hat{c}_m$ with
180 \begin{equation}
181 (\hat{h}_m,\,\hat{c}_m) =
182 \begin{cases}
183 \big(\text{HDD}_m / H_y,\ \text{CDD}_m / C_y\big)      & H_y \ge 650 \text{ and } C_y \ge 450 \\[2pt]
184 \big(\text{HDD}_m / H_y,\ \text{HDD}_m / H_y\big)      & H_y \ge 650 \text{ and } C_y < 450 \\[2pt]
185 \big(\text{CDD}_m / C_y,\ \text{CDD}_m / C_y\big)      & H_y < 650 \text{ and } C_y \ge 450 \\[2pt]
186 (1/12,\ 1/12)                                          & H_y < 650 \text{ and } C_y < 450
187 \end{cases}
188 \label{eq:elec-cases}
189 \end{equation}
190 with $\hat{o}_m = 1/12$ always. Monthly demand is
191 \begin{equation}
192 D_m = D_{\mathrm{year}} \times \big(p_{\mathrm{heat}}\,\hat{h}_m + p_{\mathrm{cool}}\,\hat{c}_m + p_{\mathrm{other}}\,\hat{o}_m\big).
193 \label{eq:elec-demand}
194 \end{equation}
195 The first case in Eq.~(\ref{eq:elec-cases}) applies to cells with both a meaningful heating season (annual HDD $\ge 650$) and a meaningful cooling season (annual CDD $\ge 450$). The second and third cases collapse onto whichever signal is non-trivial, which prevents division by near-zero annual sums in climates dominated by one extreme. The fourth case reverts to a uniform distribution where neither threshold is exceeded. The threshold convention follows Huang et al.\cite{hess-22-2117-2018}.
196
197 \subsubsection*{Domestic}
198
199 For the domestic (residential public-supply) sector we use the temperature-anomaly formula of Wada et al.\cite{Wada2011}:
200 \begin{equation}
201 D_m = \frac{D_{\mathrm{year}}}{12} \times \left(\frac{T_m - \bar{T}}{T_{\max} - T_{\min}}\,R + 1\right),
202 \label{eq:dom-monthly}
203 \end{equation}
204 where $T_m$ is the monthly mean temperature at the cell, $\bar{T}$ is the annual mean temperature, $T_{\max}$ and $T_{\min}$ are the annual extremes, and $R$ is a region-scale amplitude coefficient. The amplitude $R$ is taken from a static regional map and reflects the sensitivity of observed domestic use to seasonal temperature swings; higher $R$ implies stronger seasonal amplification. We apply a thresholding approach to ensure $D_m \ge 0$ in all cells.
205
206 \subsection*{Gridded renewable vs.\ non-renewable source shares}
207
208 GCAM-USA solves for the share of each basin's withdrawals met from renewable (surface) versus non-renewable (groundwater) supply by cost-based allocation. Mapping that basin-scale split onto the 1/8$^{\circ}$ grid requires two steps. First, the basin-level share is applied uniformly to all end-use sectors in the basin, except that thermoelectric demand is assumed to use surface water only and the remaining sectoral shares are renormalized accordingly. Second, we anchor the historical spatial pattern of renewable/non-renewable mix to observed USGS data by rescaling each cell's GCAM share against its historical-2015 value while preserving the USGS baseline spatial pattern. Specifically, let $s^{\mathrm{GCAM}}_{c,y}$ denote the GCAM-derived renewable share at cell $c$ in year $y$, and $s^{\mathrm{USGS}}_c$ the static 2015 USGS-derived share at cell $c$. For the subset of cells $\mathcal{M}$ for which both $s^{\mathrm{GCAM}}_{c,\,2015}>0$ and $s^{\mathrm{USGS}}_c$ is available, the adjusted share is
209 \begin{equation}
210 s^{\mathrm{adj}}_{c,y} =
211 \begin{cases}
212 \displaystyle \min\!\left(1,\; s^{\mathrm{USGS}}_c \times \frac{s^{\mathrm{GCAM}}_{c,y}}{s^{\mathrm{GCAM}}_{c,\,2015}}\right) & c \in \mathcal{M} \\[10pt]
213 s^{\mathrm{GCAM}}_{c,y}                                                                                        & c \notin \mathcal{M}
214 \end{cases}
215 \label{eq:source-shares}
216 \end{equation}
217 The $\min(\cdot,1)$ clip bounds ratio amplifications where the GCAM 2015 baseline is small, reflecting the trade-off between mass balance conservation and binding fraction limits in groundwater-dominated regions. The USGS spatial pattern is thus anchored in place where observable, and the GCAM scenario trajectory enters only as a per-cell temporal ratio.
218
219 \subsection*{Future projection methods}
220
221 The dataset combines simulation outputs that were produced, in some cases, by independent teams using scenario assumptions that are consistent but not strictly identical. In particular: the GCAM-USA run uses its own scenario configuration for each SSP$\times$RCP combination; Demeter is run with the corresponding GCAM scenario to produce per-crop irrigated-area maps; CERF sites power plants using GCAM-USA state-level capacity trajectories; the Jones and O'Neill SSP3/SSP5 population maps are used as-is; and the TGW-WRF climate sample is drawn from a fixed ensemble conditioned on the RCP. We do not attempt to perfectly co-calibrate these inputs, which would be prohibitively expensive; instead, we document the specific versions used (see ``Code availability'') and treat the resulting record as scenario-plausible but not a single self-consistent Earth-system simulation. This ``frankenstein'' design is an established compromise in multi-sector dynamics modeling\cite{Khan2023} and is, in our view, the right one for a dataset intended to support sensitivity and adaptation studies rather than causal attribution.
```
