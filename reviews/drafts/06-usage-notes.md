# Section: Usage Notes

> Source: `tethys-data-paper/main_v3.tex` lines 377–397. The block below is the
> verbatim LaTeX content; reviewers should cite line numbers from main_v3.tex.

```
377 \section*{Usage Notes}
378
379 The dataset is provided in netCDF~4 and is readable in any standard scientific-computing environment. A typical workflow in Python:
380 \begin{verbatim}
381 import xarray as xr
382 ds = xr.open_dataset(
383     "rcp45cooler_ssp3/Domestic_withdrawals_monthly.nc"
384 )
385 # CONUS total by year and month:
386 total = ds["Domestic"].sum(dim=("lat", "lon"))
387 \end{verbatim}
388 Conversion between the native unit (km$^3$~yr$^{-1}$) and the USGS unit (million gallons per day, MGD): $1\text{ km}^3\text{ yr}^{-1} \approx 723.8\text{ MGD}$ (using $\text{km}^3$\,yr$^{-1}\rightarrow\text{MGD}$ $= 264\,172.05124/365$).
389
390 HUC-level aggregation is supported in the companion integration meta-repository under \texttt{validation/1-postprocess-tethys.py}, which uses the \texttt{xagg} library to compute overlap-weighted aggregates from the 1/8$^{\circ}$ grid to HUC2, HUC4, HUC6, HUC8, or HUC12 polygons.
391
392 \begin{figure}[ht]
393 \centering
394 \includegraphics[width=\linewidth]{usage1-dominant-sector-tethys-grid.png}
395 \caption{Dominant water-use sector at each 1/8$^{\circ}$ cell, by annual-average consumption.}
396 \label{fig:dominant-sector}
397 \end{figure}
```
