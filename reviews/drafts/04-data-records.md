# Section: Data Records

> Source: `tethys-data-paper/main_v3.tex` lines 224–279. The block below is the
> verbatim LaTeX content; reviewers should cite line numbers from main_v3.tex.

```
224 \section*{Data Records}
225
226 The dataset is openly available for public access at MSD-Live (\url{https://data.msdlive.org/uploads/p4xce-e8822}) and the Tethys model is available at: \href{https://github.com/JGCRI/tethys}{github.com/JGCRI/tethys}.
227
228 The dataset is openly available and  permanently on MSD-Live (\url{https://data.msdlive.org/uploads/p4xce-e8822}). Scenario directories (Table~\ref{tab:scenarios}) each contain per-sector netCDF~4 files following the naming convention
229 \texttt{<Sector>\_<demand\_type>[\_monthly].nc}, where \texttt{<Sector>} is one of \texttt{Domestic}, \texttt{Electricity}, \texttt{Irrigation}, \texttt{Livestock}, \texttt{Manufacturing}, \texttt{Mining}; \texttt{<demand\_type>} is \texttt{withdrawals} or \texttt{consumption}; and the \texttt{\_monthly} suffix distinguishes monthly files from their annual counterparts. For irrigation, an additional \texttt{\_with\_losses} suffix marks files that include conveyance losses.
230
231 Each scenario directory also contains \texttt{gridded\_runoff\_shares.nc} (per-year, per-cell renewable share $s^{\mathrm{adj}}_{c,y}$ from Eq.~\ref{eq:source-shares}) and two YAML configuration files (\texttt{config\_withdrawals.yaml}, \texttt{config\_consumption.yaml}) that record the exact Tethys run configuration used to produce the files, for reproducibility. Figure~\ref{fig:data-listing} shows an example CDL listing. All sector files share the same \texttt{(year, lat, lon)} or \texttt{(year, lat, lon, month)} schema with sector-specific sub-variables.
232
233 [scenarios table at lines 234–253; CDL listing figure at lines 255–279]
```
