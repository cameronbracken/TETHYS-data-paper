# Equations audit — `main.tex` v1 vs. canonical code

Generated 2026-05-01 as Stage 2 of the Tethys data paper v2 work. For each
equation and semi-quantitative prose claim in the current v1 draft
(`tethys-data-paper/main.tex`, line numbers below), this document traces
to the exact code that implements it and flags mismatches that must be
resolved before the v2 draft can be written.

**Policy:** where paper and code disagree, the *code* is the source of
truth for what the published dataset actually contains. The paper text
is updated to match the code. Separately, if the code itself deviates
from its cited reference (Huang 2018, Moore 2015, Wada 2011), that's
flagged as a secondary concern for follow-up — but it doesn't change
what we write in the paper.

Code paths below reflect the post-cleanup layout (branch
`metarepo-cleanup` in `tethys_integration_metarepo/`).

## Summary table

| Paper equation / claim | Paper loc. | Code loc. | Status | Action |
|---|---|---|---|---|
| Eq. 1 — spatial downscaling | L75–77 | `tethys-code/tethys/model.py:197` | ✅ MATCH | none |
| Eq. 2 — irrigation monthly weight | L129–134 | `metarepo/scripts/0_preprocessing/compute_monthly_weights.py`; `compute_deficit.py`; `compute_gsi.py`; plus `gsi_nersc/` for upstream | ❌ **WRONG FORMULA** | rewrite Eq. 2 to match code (GSI × deficit, not 1/(P−PET)) |
| Eqs. 3–6 — electricity HDD/CDD thresholds and reallocation | L157–179 | `tethys-code/tethys/tdmethods/electricity.py:29–34` | ⚠️ **THRESHOLDS SWAPPED** | swap 450/650 in paper text; flag Huang 2018 cross-check |
| Eq. 7 — domestic (Wada 2011) | L187–189 | `tethys-code/tethys/tdmethods/domestic.py:11–14` | ✅ MATCH structurally | minor — clarify `R_cell` ≡ `amplitude` variable name |
| Runoff-share adjustment | L196–199 (prose only, no eq.) | `metarepo/scripts/2_postprocess/adjust_runoff_shares/adjust_runoff_shares_method2_kazi.py:92–102` | ❌ **MISSING EQUATION** | add explicit equation for the USGS-anchored ratio adjustment |

## Detailed findings

### Eq. 1 — spatial downscaling ✅

**Paper (L75–77)**

$$\text{demand}_\text{cell} = \text{demand}_\text{region} \times \frac{\text{proxy}_\text{cell}}{\text{proxy}_\text{region}}.$$

**Code** — `tethys-code/tethys/model.py:179–197`:

```python
def downscale(self, distribution, inputs, region_masks):
    ...
    # demand_cell = demand_region * (proxy_cell / proxy_region)
    out = xr.dot(out, inputs / sums, dims='region')
```

The inline comment literally quotes the paper equation. No action.

---

### Eq. 2 — Irrigation monthly weight ❌ WRONG

**Paper (L129–134)** currently reads:

$$\text{weight}_\text{month} =
\begin{cases}
\left|\dfrac{1}{P_\text{month} - \text{PET}_\text{month}}\right| & P_\text{month} > \text{PET}_\text{month}\\[4pt]
\left|P_\text{month} - \text{PET}_\text{month}\right| & P_\text{month} \le \text{PET}_\text{month}
\end{cases}$$

with the text after stating these are "multiplied by the growing season indicator" (and the sentence is incomplete — ends on ellipsis).

**Problems:**
1. The reciprocal branch (`|1/(P−PET)|` when P > PET) is not what the code computes, and it is mathematically pathological: as P approaches PET from above, the weight diverges to infinity. That's the opposite of the desired behaviour (in a wet month, irrigation demand should be small, not infinite).
2. The code does not use P − PET (wet) vs |P − PET| (dry). It uses a single `deficit = PET − P` and lets it go negative in wet months, which is then zeroed out via the normalisation.
3. The equation never actually shows the GSI multiplication or the normalisation to sum = 1.

**Code** — authoritative pipeline (paths post-cleanup):

**Step A** — `scripts/0_preprocessing/compute_deficit.py:21`:
```python
ds['deficit'] = ds.PET - ds.precip
```
Note: `deficit = PET − P`, **monthly**, computed from daily TGW-WRF outputs resampled to monthly sums.

**Step B** — `scripts/0_preprocessing/compute_gsi.py:40–41`:
```python
ds = (ds.clip(-2, 5) + 2) / 7      # f(Tmin):  Tmin=-2°C → 0, Tmin=+5°C → 1
ds *= daylengths(ds.lat, ...).clip(10, 11) - 10
                                    # g(daylength): ≤10 h → 0, ≥11 h → 1
```
So GSI = f(Tmin) × g(daylength) ∈ [0, 1], computed daily, then resampled to monthly mean.
**Note:** this is a simplified GSI vs. Jolly et al. 2005 — it drops the VPD (vapour-pressure-deficit) indicator.

**Step C** — `scripts/0_preprocessing/compute_monthly_weights.py:17–19`:
```python
ds = deficit * gsi
ds /= days_in_month     # lambda x,y: monthrange(x,y)[1]
ds /= ds.sum(dim='month').where(lambda x: x != 0, 1)   # normalise to sum=1 across 12 months
```

**Step D** — the per-cell, per-year normalised monthly weights are written to `irrigation_weight_{scenario}.nc` and consumed in `tethys-code/tethys/tdmethods/weights.py` as the `pirrww` variable (the prenormalised flag is set to True in `test_config.yml`, so `weights.py` does not re-normalise).

**Correct equation** (what to put in the paper):

Let $D_m = \max(\text{PET}_m - P_m, 0)$ (positive monthly water deficit in mm), $G_m$ be the monthly-mean growing-season index of Jolly et al. (2005, simplified to Tmin and daylength indicators only), and $N_m$ be the number of days in month $m$. For each cell,

$$
\tilde{w}_m = \dfrac{D_m \, G_m}{N_m}, \qquad w_m = \dfrac{\tilde{w}_m}{\sum_{k=1}^{12} \tilde{w}_k}
$$

so that $\sum_m w_m = 1$ per cell per year. The monthly irrigation demand is then $\text{demand}_m = w_m \times \text{demand}_{\text{year}}$.

(The `max(·, 0)` is the cleanest paper-facing statement; the actual code keeps the sign on `deficit` and relies on the sum-normalisation to handle net-wet years — but for paper prose, clipping at 0 is equivalent under the normalisation.)

**GSI expression for the paper:**

$$
G_m = \big\langle f(T_{\min,d}) \cdot g(L_d) \big\rangle_{d \in m}
$$

with daily components

$$
f(T_{\min}) = \min\left(\max\left(\dfrac{T_{\min}+2}{7}, 0\right), 1\right), \qquad
g(L) = \min\left(\max\left(L - 10, 0\right), 1\right)
$$

where $T_{\min}$ is daily-minimum air temperature in °C (from TGW-WRF) and $L$ is daylength in hours. The angle-brackets denote the monthly mean over days $d$.

**Paper should also note:** the simplification drops the VPD term from the original Jolly et al. (2005) GSI. Cite this as a deliberate choice and reference Moore et al. (2015) for precedent in an irrigation context.

---

### Eqs. 3–6 — Electricity monthly weights (HDD/CDD) ⚠️ THRESHOLDS SWAPPED

**Paper (L157–179)** text around Eq. 2 says:

> "For grid cells where annual HDD > 450 and CDD > 650, [Eq. 3]. … When HDD > 450 but CDD < 650, [Eq. 4]. Similarly, when CDD > 650 but HDD < 450, [Eq. 5]. When both HDD < 450 and CDD < 650, all sources of monthly variation vanish, leaving demand_month = demand_year × 1/12."

That is: HDD threshold = 450, CDD threshold = 650.

**Code** — `tethys-code/tethys/tdmethods/electricity.py:29–34`:

```python
# when hdd under threshold but cdd above threshold, cooling percent is added to heating signal
hdd = xr.where((hdd_sums < 650) & (cdd_sums >= 450), cdd, hdd)
# when cdd under threshold but hdd above threshold, heating percent is added to cooling signal
cdd = xr.where((cdd_sums < 450) & (hdd_sums >= 650), hdd, cdd)
# when neither are above threshold, both are reallocated to other category
hdd = xr.where((hdd_sums < 650) & (cdd_sums < 450), 1 / 12, hdd)
cdd = xr.where((hdd_sums < 650) & (cdd_sums < 450), 1 / 12, cdd)
```

i.e., HDD threshold = **650**, CDD threshold = **450**. Exactly swapped.

**Three possible explanations:**
1. The paper text is a transcription error — code is right. Most likely.
2. The code has a bug — paper is right, code needs fixing. Would mean the published dataset has bad monthly electricity weights in border climates. Worth checking.
3. Both paper and code diverge from Huang et al. 2018 — cross-checking the original paper settles the question.

**Action for paper v2:** write the prose with the *code* values (HDD > 650 ⇒ region has meaningful heating season; CDD > 450 ⇒ region has meaningful cooling season). Keep the Huang et al. 2018 citation but make sure the numerical thresholds are consistent with what the code actually runs.

**Follow-up (outside paper scope):** read Huang et al. 2018 §3 to confirm the canonical thresholds. If Huang says (450, 650), the code has a bug and the dataset should be regenerated — but that's a much bigger problem than a paper edit, so handle separately.

**Paper equation reformulated to match code (one option, using code-consistent thresholds):**

Let $\text{HDD}_m$, $\text{CDD}_m$ be monthly heating/cooling degree days at base 18 °C, and let $H_y = \sum_m \text{HDD}_m$, $C_y = \sum_m \text{CDD}_m$ be annual sums. Let $p_\text{heat}$, $p_\text{cool}$, $p_\text{other}$ be region-level shares of annual electricity use (from GCAM-USA). For each cell, define monthly distributions $\hat{h}_m$, $\hat{c}_m$, $\hat{o}_m$ with

$$
(\hat{h}_m, \hat{c}_m) =
\begin{cases}
(\text{HDD}_m / H_y,\; \text{CDD}_m / C_y) & H_y \ge 650 \text{ and } C_y \ge 450 \quad \text{(both seasons)}\\[3pt]
(\text{HDD}_m / H_y,\; \text{HDD}_m / H_y) & H_y \ge 650 \text{ and } C_y < 450 \quad \text{(heating only)}\\[3pt]
(\text{CDD}_m / C_y,\; \text{CDD}_m / C_y) & H_y < 650 \text{ and } C_y \ge 450 \quad \text{(cooling only)}\\[3pt]
(1/12,\; 1/12) & H_y < 650 \text{ and } C_y < 450 \quad \text{(neither)}
\end{cases}
$$

with $\hat{o}_m = 1/12$ always. Then

$$
\text{demand}_m = \text{demand}_\text{year} \times \big(p_\text{heat}\,\hat{h}_m + p_\text{cool}\,\hat{c}_m + p_\text{other}\,\hat{o}_m\big).
$$

This compresses Eqs. 3–6 into a single cases-block equation that mirrors the code exactly. The v2 draft should use this form (or the four-equation form with corrected thresholds) — author's choice, just be consistent.

---

### Eq. 7 — Domestic monthly (Wada 2011) ✅ MATCH

**Paper (L187–189)**

$$
\text{demand}_m = \dfrac{\text{demand}_\text{year}}{12} \times \left(\dfrac{T_m - \bar{T}}{T_\text{max} - T_\text{min}} \cdot R_\text{cell} + 1 \right)
$$

where $\bar{T}$ is the annual mean temperature, $T_\text{max}$, $T_\text{min}$ are annual extremes, and $R_\text{cell}$ is a region-level amplitude coefficient.

**Code** — `tethys-code/tethys/tdmethods/domestic.py:11–14`:

```python
ranges = tas.max(dim='month') - tas.min(dim='month')
ranges = xr.where(ranges != 0, ranges, 1)  # avoid 0/0
distribution = (((tas - tas.mean(dim='month')) / ranges) * amplitude + 1) / 12
```

Which expands, after multiplying by `demand_year`, to

$$
\text{demand}_m = \text{demand}_\text{year} \times \dfrac{1}{12} \times \left(\dfrac{T_m - \bar{T}}{T_\text{max} - T_\text{min}} \cdot \text{amplitude} + 1 \right).
$$

**Match.** Only quibble: the paper's symbol $R_\text{cell}$ and the code's `amplitude` variable refer to the same quantity. The `amplitude` loaded from `DomesticR.nc` is per-region (not per-cell) as far as I can tell from the proxy setup; the paper's subscript $_\text{cell}$ is a mild misnomer. Suggest renaming to $R$ or $A_\text{region}$ in paper v2 for accuracy.

---

### Runoff-share adjustment ❌ MISSING EQUATION

**Paper (L196–199)** describes the adjustment in prose:

> "GCAM determines total water demands in a basin by aggregating individual demands … These demands are met by renewable and non-renewable water sources based on cost and supply competition between these sources … Following this adjustment, basin-level supply-source shares are recomputed to ensure internal consistency between thermoelectric prioritization of surface water and the overall renewable versus non-renewable extraction profile used in the downscaling framework."

There is **no equation**, and the prose glosses over the key step: the output dataset uses the **USGS-anchored method-2 adjustment**, not the raw GCAM basin shares.

**Code** — `scripts/2_postprocess/adjust_runoff_shares/adjust_runoff_shares_method2_kazi.py:92–102`:

```python
for i, yr in enumerate(years):
    gy = gcam.sel(year=yr).values.astype(np.float32)
    out[i] = gy  # preserve original everywhere
    ratio = np.ones_like(gy, dtype=np.float32)
    ratio[denom_mask] = gy[denom_mask] / denom[denom_mask]
    adj = usgs_base * ratio
    out[i][denom_mask] = np.clip(adj[denom_mask], 0.0, 1.0)
```

Where `denom` is the GCAM-derived historical 2015 baseline (per-cell), `usgs_base` is the static USGS-derived per-cell share, and `denom_mask` is the set of cells with both a valid USGS baseline and a non-zero GCAM 2015 denominator.

**Correct equation for the paper.**

Let $s^{\text{GCAM}}_{c,y}$ denote the GCAM-derived renewable-water share at cell $c$ in year $y$, and $s^{\text{USGS}}_c$ the static USGS-derived share at cell $c$. Define the subset of cells $\mathcal{M}$ for which both $s^{\text{GCAM}}_{c,2015}>0$ and $s^{\text{USGS}}_c$ is available. The adjusted per-cell share is

$$
s^{\text{adj}}_{c,y} =
\begin{cases}
\min\!\left(1,\; s^{\text{USGS}}_c \times \dfrac{s^{\text{GCAM}}_{c,y}}{s^{\text{GCAM}}_{c,2015}}\right) & c \in \mathcal{M}\\[6pt]
s^{\text{GCAM}}_{c,y} & c \notin \mathcal{M}
\end{cases}
$$

In plain words: within the USGS-observable region, the 2015 USGS pattern is anchored in place and the GCAM scenario trajectory enters only as a per-cell temporal ratio. Outside that region, the raw GCAM share is used. The $\min(1, \cdot)$ clip prevents the ratio amplification from pushing shares above unity at cells where the GCAM 2015 baseline is small.

**Separately,** the paper should also note that the electricity sector is exempted from the shared-basin renewable/non-renewable split and is assigned surface-water only. This is currently in the paper prose but belongs next to the equation so readers see the two rules together.

---

## Secondary findings (not equations, but prose issues)

1. **L89** — inline TODO question from a coauthor about CERF → state → grid weighting remains unresolved in the text. The answer is in `scripts/0_preprocessing/cerf_to_tethys/cerf_to_tethys.py` plus the notes in the prior Tethys paper (Khan 2023). Resolve in v2.
2. **L139–152** — commented-out conveyance-losses discussion block. These notes point at a real issue (GCAM state sums differ from GCAM USA totals by a factor of ~0.83 due to conveyance losses not being modelled in the US). The v2 paper needs an explicit paragraph here — either documenting the conveyance-loss correction applied in Tethys, or flagging it as a known limitation.
3. **L181** — stray single-line note "Energy sector fix - CERF holds plants to site later - normalized aggregate - nuke plants are to dispersed". Looks like an author comment. Either expand into prose or delete.
4. **L202–206** — "Future Projection Methods" is a stub with an empty bullet list. Needs full treatment in v2.
5. **L383–384** — bullet 8 ("supply source attribution") refers to the method we now audit as "WRONG" above. The v2 draft needs the corrected eq. + caption for this claim.

## Authoritative file paths (post-cleanup)

Use these citations in the v2 Methods section and in the Code Availability block:

| Concept | Path |
|---|---|
| Spatial downscaling (Eq. 1) | `tethys-code/tethys/model.py::Tethys.downscale` |
| Irrigation deficit | `tethys_integration_metarepo/scripts/0_preprocessing/compute_deficit.py` |
| Irrigation GSI | `tethys_integration_metarepo/scripts/0_preprocessing/compute_gsi.py` |
| Irrigation monthly weight | `tethys_integration_metarepo/scripts/0_preprocessing/compute_monthly_weights.py` |
| Preceding TGW-WRF preprocessing | `tethys_integration_metarepo/scripts/0_preprocessing/gsi_nersc/` |
| Electricity HDD/CDD (Eqs. 3–6) | `tethys-code/tethys/tdmethods/electricity.py::temporal_distribution` |
| Domestic temporal (Eq. 7) | `tethys-code/tethys/tdmethods/domestic.py::temporal_distribution` |
| Runoff-share adjustment | `tethys_integration_metarepo/scripts/2_postprocess/adjust_runoff_shares/adjust_runoff_shares_method2_kazi.py` |

## Action list for v2 draft

- [ ] **Rewrite Eq. 2** to the GSI × deficit / days-in-month / normalized form above.
- [ ] **Add equations for GSI and its components** (the Tmin and daylength ramps).
- [ ] **Note the VPD omission vs. Jolly 2005** as a deliberate simplification.
- [ ] **Swap 450/650** in the electricity HDD/CDD prose to match code, or rewrite as the cases-block equation above.
- [ ] **Verify Huang 2018 thresholds** separately; note any residual discrepancy in Limitations.
- [ ] **Add runoff-share adjustment equation** (USGS-anchored ratio form).
- [ ] **Clarify electricity surface-water-only rule** next to the runoff-share equation.
- [ ] **Minor: rename paper's $R_\text{cell}$ → $R$ or $A_\text{region}$** to match the per-region truth of the amplitude coefficient.
- [ ] **Resolve inline TODOs at L89, L139–152, L181, L202–206, L383–384** per the notes above.
