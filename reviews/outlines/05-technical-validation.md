# Outline: Technical Validation

- **Goal**: Quantify agreement with USGS at HUC6 across the three dominant sectors and characterize biases.
- **Implements**: CLAIM-04.
- **Subsections**:
  - Setup: USGS Jan-2025 refresh; HUC12 for irrigation/PS, per-plant for thermoelectric; coarse-to-fine, total-to-seasonal frame.
  - Validation metrics table (Table~\ref{tab:validation-metrics}) covering Pearson, Spearman, NSE/KGE, MBE, NRMSE, MedAPE.
  - CONUS annual totals (Fig.~\ref{fig:annual-total-timeseries}, Fig.~\ref{fig:annual-total-boxplot}).
  - HUC6 spatial agreement (Fig.~\ref{fig:map-pbias}, Fig.~\ref{fig:huc-correlation}).
  - Bias diagnosis and uncertainty.
  - Seasonal cycle (Fig.~\ref{fig:monthly}).
  - Inter-scenario consistency (Fig.~\ref{fig:scenarios}).
  - Limitations (six bullets).
- **Transition out**: usage notes show how to consume the validated record.
