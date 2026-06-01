# Outline: Methods and Data

- **Goal**: Specify, with equations and named proxies, every step of the downscaling chain.
- **Implements**: CLAIM-02.
- **Subsections**:
  - GCAM-USA: state-level + state×basin crop demands; 5-year intervals; 8 runs (RCP × climate × SSP).
  - Preprocessing of meteorological forcing: TGW-WRF; daily PET, P, T, HDD, CDD, GSI; Eqs. (gsi-components, gsi-monthly).
  - Spatial downscaling: Eq. (spatial); per-sector proxies -- Demeter, CERF, SSP-pop, GLW-3, population.
  - Temporal downscaling: irrigation Eq. (irr-weights); electricity Eqs. (elec-cases, elec-demand) with HDD/CDD thresholds; domestic Eq. (dom-monthly).
  - Source shares: Eq. (source-shares) with min(·,1) clip; thermoelectric carve-out.
  - Future projection methods: frankenstein-coupling rationale.
- **Transition out**: methods produce the published record (Data Records).
