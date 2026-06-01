# Section: Code availability

> Source: `tethys-data-paper/main_v3.tex` lines 419–429. The block below is the
> verbatim LaTeX content; reviewers should cite line numbers from main_v3.tex.

```
419 \section*{Code availability}
420
421 All code used to generate and validate the dataset is publicly available under permissive open-source licenses.
422 \begin{itemize}
423     \item \textbf{Tethys downscaling package}: \url{https://github.com/JGCRI/tethys} (\texttt{pip install tethys-downscale}). The specific version used for the published dataset is pinned in the scenario YAML config files included with each scenario directory.
424     \item \textbf{Integration meta-repository}: \url{https://github.com/IMMM-SFA/tethys_integration_metarepo}. Contains the per-scenario run drivers (\texttt{scripts/1\_runs/im3\_tethys\_runs/}), climate-forcing preprocessing (\texttt{scripts/0\_preprocessing/gsi\_nersc/} and \texttt{scripts/0\_preprocessing/compute\_\{gsi,deficit,monthly\_weights\}.py}), runoff-share adjustment (\texttt{scripts/2\_postprocess/adjust\_runoff\_shares/}), and the numbered validation pipeline (\texttt{validation/}).
424     \item \textbf{Demeter} (land-use downscaling, used to produce per-crop irrigated-area proxies): \url{https://github.com/IMMM-SFA/demeter}\cite{Vernon-2018}.
425     \item \textbf{CERF} (power-plant siting): \url{https://github.com/IMMM-SFA/cerf}\cite{Vernon2021}.
426     \item \textbf{TGW-WRF climate forcing}\cite{Jones2023TGW}: \url{https://tgw-data.msdlive.org/}.
427 \end{itemize}
428 To reproduce the published record for one scenario, follow the \texttt{PIPELINE.md} in the integration meta-repository, which documents required inputs, expected outputs, and the command sequence for each stage.
```
