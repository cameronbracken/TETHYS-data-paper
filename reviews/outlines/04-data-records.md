# Outline: Data Records

- **Goal**: Describe the published artifact (where it lives, what files, what schema).
- **Implements**: CLAIM-03.
- **Key points**:
  - Hosting: MSD-Live URL; Tethys GitHub URL.
  - File-naming convention: `<Sector>_<demand_type>[_monthly].nc`; `_with_losses` variant for irrigation.
  - Per-scenario YAML configs (`config_withdrawals.yaml`, `config_consumption.yaml`).
  - `gridded_runoff_shares.nc` (per-cell, per-year renewable share).
  - Schema: `(year, lat, lon[, month])` with sector-specific sub-variables; CDL example.
  - Scenario directory table (Table~\ref{tab:scenarios}).
- **Transition out**: validation tests the published record.
