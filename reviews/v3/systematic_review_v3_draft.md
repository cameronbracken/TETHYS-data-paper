### Systematic Review Support: High-resolution monthly sectoral water demands for the U.S. (Tethys 2.0)

**PRISMA Protocol Status**: Quality Appraisal & Synthesis Phase
**Search string**: `("water demand" OR "water withdrawal" OR "water consumption") AND ("gridded" OR "high-resolution" OR "downscaled") AND ("CONUS" OR "United States") AND ("sectoral" OR "multi-sector") AND ("future" OR "projections" OR "scenarios")`

**Review Dashboard**:
- IDENTIFIED: 30 sources (via `main_v3.tex` bibliography and background)
- SCREENED: 12 sources (focusing on gridded demand products)
- ELIGIBLE: 5 sources (Table 1 comparison set: Huang 2018, Khan 2023, van Vliet 2021, Wada 2017, Tethys 2.0)
- INCLUDED: 1 primary dataset (Tethys 2.0) validated against 1 reference (USGS 2015)

**Evidence Synthesis (Methodological Rigor & Risk of Bias)**:

| Component | Quality Rating | Key Outcome | Risk of Bias (RoB) Assessment |
| :--- | :--- | :--- | :--- |
| **Spatial Proxy (Thermoelectric)** | High | CERF-based siting improves on population proxies. | Low - explicit siting reduces decoupling bias between load and generation. |
| **Spatial Proxy (Municipal)** | Medium | SSP-consistent population (Jones & O'Neill). | Low - uses scenario-consistent forcing, reducing inter-scenario misalignment. |
| **Temporal Downscaling (Irrigation)** | High | GSI/Deficit-based (TGW-WRF) climate-forced. | Low - captures interannual/scenario variability better than static templates. |
| **Source Attribution (GW/SW)** | Medium | USGS-anchored adjustment (Eq. 8). | **High (Selection Bias)** - Eq. 8 clip is asymmetric; caps amplification but not attenuation, potentially biasing basin-scale mass balance. |
| **Validation Framework** | Medium | Pearson r (0.71-0.95) at HUC6. | **High (Reporting Bias)** - Aggregate 10% CONUS agreement masks significant opposing sector-level biases (-45% to +5%). |
| **Inter-scenario Consistency** | Medium | "Frankenstein" design using diverse model outputs. | **Moderate (Systematic Bias)** - Input models (GCAM, CERF, Demeter, TGW) are consistent but not self-consistent; potential artifacts at model boundaries. |

**Next PRISMA Steps**:
1. **Bias Characterization**: Quantify the impact of the Eq. 8 asymmetric clip on basin-level renewable/non-renewable mass balance.
2. **Sensitivity Analysis**: Conduct sensitivity tests for the HDD/CDD thresholds (Eq. 5) to evaluate robustness across climate zones.
3. **Reporting Transparency**: Update the Abstract to lead with sector-level biases rather than aggregate agreement to minimize "Optimism Bias" in reader interpretation.
4. **Evidence Strengthening**: Calculate Nash-Sutcliffe Efficiency (NSE) or Kling-Gupta Efficiency (KGE) to complement Pearson correlation, providing a more robust measure of magnitude agreement.

**Critical Findings for Data Descriptor Rigor**:
- The transition from 1/2° to 1/8° resolution is well-supported by finer-scale proxies (CERF, Demeter).
- The "Domestic" sector bias (-45%) is the most significant methodological weakness; the current attribution to the $R$ coefficient is an untested hypothesis that requires empirical validation (e.g., residual analysis vs. $T$).
- The exclusion of Vapour Pressure Deficit (VPD) from the GSI formulation (Simplified GSI) may introduce bias in humid regions; this should be explicitly flagged in the "Limitations" as a source of "Model Specification Bias".

---
*Review conducted according to Systematic Review standards (PRISMA-aligned) for the Tethys v3 Data Paper draft.*
