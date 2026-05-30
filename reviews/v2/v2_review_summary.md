# Review of Tethys Data Paper v2

Based on `SCHOLAR_EVALUATION.md` and `TETHYS_data_paper_v3-review.md`.

## Key Findings
- **Abstract Framing**: The v2 abstract overemphasized the 10% aggregate agreement at CONUS scale without acknowledging that this was an artifact of compensating sector-level biases (-45% Domestic, -30% Electricity, +5% Irrigation).
- **Validation Metrics**: The metric set was too narrow (only Pearson r and CONUS total). v3 adds NSE/KGE, Spearman, MBE, NRMSE, and MedAPE.
- **Methodology**: Choice of Eq. 5 thresholds and Eq. 8 clipping needed better justification/characterization.
- **Citations**: Significant number of placeholders (`TODO`) and opaque keys (`RN##`) needed resolution.

## Improvements in v3
- **Reframed Abstract**: Now leads with sector-level results and qualifies the aggregate claim.
- **Comprehensive Validation Table**: Table 2 provides a detailed statistical anatomy of the dataset performance.
- **Expanded Literature Review**: Better positioning against Huang 2018, Wada 2017, van Vliet 2021, and Khan 2023.
- **Bias Diagnosis**: Added explicit discussion of the -45% domestic bias and USGS uncertainty.
- **Stylistic Cleanup**: Replaced colloquialisms like "frankenstein" with "modular component-coupled" and fixed all typos.
- **Co-author Engagement**: Addressed all `% COMMENT` lines.
