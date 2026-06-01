# Writing Review -- TETHYS data paper, main_v3.tex

**Source**: `tethys-data-paper/main_v3.tex` (455 lines)  
**Workflow**: `workflows:writing-review` v5.20.0 (patched to use main-loop model)  
**Date**: 2026-05-29  
**Verdict**: **ISSUES FOUND**  

## Summary counts

- Critical: 8
- Major: 41
- Minor: 48
- Total: 97
- Blocking (critical + major): 49
- Advisory (minor): 48

## ⚠ Unreliable sections

All sections are flagged unreliable because the prose-quality and source-fidelity reviewers (custom subagent types `workflows:writing-prose-reviewer` / `workflows:writing-source-fidelity-reviewer`) failed with `subagent completed without calling StructuredOutput` -- likely because the harness's custom-agent system prompts in this PNNL gateway environment did not surface the StructuredOutput tool. Only the **structure reviewers, transition analyzer, and document-level reviewer ran successfully**. The findings below are real but the prose-style and citation-fidelity legs are missing -- treat the count as a lower bound.

## Document-level findings

### Concept introduction order

- Background & Summary forward-references the 'frankenstein' coupling concept (line 64 mentions scenario-consistent inputs across GCAM-USA/CERF/SSP-pop/TGW) without naming or characterizing the multi-team coupling caveat, then Methods (line 221) introduces 'frankenstein' as if new. A one-clause forward-reference would strengthen the link.
- GSI is invoked in the Improvements section ('GSI-based irrigation timing', line 410) and in Background's six-way list (line 64) before being defined. It is formally defined in Methods (Eq. eq:gsi-components, line 104). For readers who skim Background → Improvements → Methods, GSI appears as a named acronym before its formal introduction. Acceptable for forward reference, but a parenthetical gloss in Background (e.g., 'growing-season index, GSI') would help.
- USGS 2015 reference data is cited in Abstract and Background as a validation anchor before the methods section explains the source-share anchoring (Eq. eq:source-shares, line 208). The reader sees USGS used both for source-share anchoring (Methods) and for validation (Technical Validation) without an early clarification that both roles draw on the same record.
- Eq. eq:source-shares is invoked in Data Records (line 231) for the gridded_runoff_shares.nc field before the reader has reached Methods, which defines it. This is a standard forward-reference and is signposted via \ref, so non-blocking, but worth noting.

### Repetition

- **[REDUNDANT]** "We present such a dataset here."
    - drafts/02-background-and-summary.md line 62 (main_v3.tex line 62)
    - drafts/02-background-and-summary.md line 64 (main_v3.tex line 64)
- **[REDUNDANT]** "The dataset is openly available ... at MSD-Live (https://data.msdlive.org/uploads/p4xce-e8822)"
    - drafts/04-data-records.md line 226 (main_v3.tex line 226)
    - drafts/04-data-records.md line 228 (main_v3.tex line 228)
- **[INTENTIONAL_CALLBACK]** "partial cancellation of significant sectoral biases: a -45% underestimate in domestic demand and a -30% underestimate in thermoelectric withdrawals are largely offset by a +5% bias in irrigation"
    - drafts/01-abstract.md (main_v3.tex line 45)
    - drafts/05-technical-validation.md (main_v3.tex line 307, paraphrased)
    - PRECIS Hook
- **[INTENTIONAL_CALLBACK]** "annual correlations of 0.71 (Domestic) to 0.95 (Irrigation) at HUC6"
    - drafts/05-technical-validation.md (main_v3.tex line 325)
    - drafts/07-improvements-over-previous-version.md (main_v3.tex line 416)
- **[INTENTIONAL_CALLBACK]** "six specific ways / six specific advances / six-step downscaling chain"
    - drafts/02-background-and-summary.md (main_v3.tex line 64)
    - drafts/07-improvements-over-previous-version.md (main_v3.tex line 402)
    - PRECIS CLAIM-02 and CLAIM-05
- **[INTENTIONAL_CALLBACK]** "scenario-consistent (climate / population / energy-water-land inputs)"
    - drafts/01-abstract.md (line 45)
    - drafts/02-background-and-summary.md (lines 60, 62, 64)
    - drafts/07-improvements-over-previous-version.md (line 408)

### Thesis threading

- Counterargument #2 ('validation is statistically thin for Scientific Data') is only partially addressed. PRECIS commits to reporting Pearson r WITH n and confidence intervals, residual spatial autocorrelation, and an explicit count of how often the source-share clip binds. Table tab:validation-metrics (line 287–304) reports point estimates of Pearson, Spearman, NSE/KGE, MBE, NRMSE, MedAPE but no n, no CIs, no significance testing, and no statement about residual spatial autocorrelation. This weakens the response to a key reviewer counterargument and leaves the thesis 'characterized honestly enough that downstream users can decide where to trust it' under-supported.
- Counterargument #4 ('Eq. source-shares clip is asymmetric and not mass-conserving') is acknowledged in Methods (line 217: 'reflecting the trade-off between mass balance conservation and binding fraction limits') but PRECIS commits to QUANTIFYING how often the clip binds and the magnitude of basin-level mass-balance violation. The current text states the trade-off qualitatively only. The thesis's reproducibility-and-honesty framing is weakened by leaving this unquantified.
- Counterargument #5 ('HDD/CDD thresholds (650/450) are not sensitivity-tested') is implicitly addressed by citing Huang 2018 precedent (line 195) but PRECIS commits to either adding a sensitivity table or justifying why thresholds were not perturbed. The current 'threshold convention follows Huang' is precedent-citation, not justification of insensitivity. Thesis-relevant because the bias diagnosis on Electricity (-30%) does not consider whether the threshold choice contributes.
- The Bias diagnosis subsection (line 341–342) does the work for the -45% Domestic bias (Wada R coefficient + GCAM-USA base-year mismatch + USGS uncertainty) but does NOT diagnose the -30% Electricity bias, which is equally central to the Hook. PRECIS Hook ('-30% thermoelectric underestimate') is left as a number without mechanism. The CERF-siting/eastern-overestimate paragraph (line 325) discusses spatial pattern, not the aggregate bias direction. Thesis-relevant: the dataset's value depends on biases being explained, not just reported.
- Limitations (line 364–374) lists six itemized limitations but PRECIS CLAIM-06 lists exactly six: livestock stationarity, manuf./mining proxy, thermoelectric source-share carve-out, riparian vs. reservoir, simplified GSI, conveyance losses. The drafts deliver these. CLAIM-06 is fully addressed.
- The Background's MSD-community paragraph (line 62 'This product serves a growing community...') is a duplicate-style restart of the contribution sentence at line 64. The thesis's emphasis on reproducibility and downstream use would be served better by a single cohesive contribution paragraph rather than two near-parallel openings.

### Completeness

- **Claims addressed**: All six PRECIS claims (CLAIM-01 through CLAIM-06) are addressed in the appropriate sections: CLAIM-01 in Background & Summary (Huang 2018, Khan 2023, Wada 2017, van Vliet 2021 cited; Table tab:prior-datasets compares scope), CLAIM-02 in Methods and Data (six-step chain explicit through GCAM-USA → Demeter/CERF/SSP-pop/GLW-3 → TGW-WRF temporal proxies → USGS-anchored source-share clip; eight scenarios named), CLAIM-03 in Data Records + Code availability (MSD-Live URL, netCDF schema, YAML config files, Tethys version pinning), CLAIM-04 in Technical Validation (Pearson r 0.71–0.95 at HUC6 in Table tab:validation-metrics; sector-level biases -45%/-30%/+5% explicit), CLAIM-05 in Improvements over previous version (six paragraphs, one per advance), CLAIM-06 in Technical Validation Limitations subsection (all six itemized).
- **Counterarguments confronted**: Of the five counterarguments PRECIS commits to confronting: (1) aggregate-vs-sector cancellation -- fully confronted in Abstract and Validation; (2) statistical thinness -- PARTIALLY confronted (panel of metrics present, but no n, no CIs, no significance, no residual spatial autocorrelation as PRECIS commits); (3) frankenstein coupling -- fully confronted in Methods Future projection methods subsection (line 219–221) with Khan 2023 precedent and explicit framing as scenario-plausible for sensitivity studies; (4) source-share clip mass conservation -- PARTIALLY confronted (trade-off acknowledged qualitatively at line 217 but not quantified as PRECIS commits); (5) HDD/CDD threshold sensitivity -- INSUFFICIENTLY confronted (Huang precedent cited but no sensitivity table and no explicit justification for why thresholds were not perturbed). Three of five fully addressed, two partially.
- **Scope honored**: True
- **Hook delivered**: True
- **Conclusion follows**: True

**Completeness issues:**

- Counterargument #2 (statistical thinness) under-delivered: validation table lacks n, CIs, significance tests, and residual spatial autocorrelation that PRECIS commits to.
- Counterargument #4 (source-share clip) under-delivered: quantification of how often the clip binds and basin-level mass-balance impact is committed in PRECIS but not delivered.
- Counterargument #5 (HDD/CDD threshold sensitivity) under-delivered: Huang precedent is cited but neither a sensitivity table nor an explicit non-perturbation justification is given.
- Bias diagnosis subsection diagnoses Domestic -45% but is silent on the -30% Electricity bias mechanism, which is equally central to the Hook.
- Background paragraph 'We present such a dataset here.' (line 62) and the next paragraph 'We present such a dataset here.' (line 64) are duplicate sentence-starts that should be consolidated.
- Data Records paragraphs at lines 226 and 228 both state 'openly available ... at MSD-Live (https://data.msdlive.org/uploads/p4xce-e8822)' verbatim -- clear redundancy, should be merged.


## Transitions (Level 2)

### Abstract → Background and Summary -- **SMOOTH**

- *Closes*: > By capturing the fine-scale spatiotemporal patterns of demand across diverse futures, this dataset supports integrated energy-water-land modeling and local-to-regional water scarcity assessments.
- *Opens*: > Humans depend on water for irrigation, thermoelectric cooling, public supply, industry, and livestock, with the relative importance of these sectors varying sharply across regions and over time.

### Background and Summary → Methods and Data -- **SMOOTH**

- *Closes*: > Table~\ref{tab:prior-datasets} compares this dataset with closely related published records.
- *Opens*: > Region-scale water-demand inputs come from the Global Change Analysis Model (GCAM-USA version).
- *Optional*: Optionally add a one-sentence Methods preamble naming the six chain stages (GCAM-USA inputs -> meteorological forcing -> spatial proxies -> temporal weights -> source-share clip -> frankenstein coupling) so the reader sees the structure before diving into stage 1. Not required for correctness.

### Methods and Data → Data Records -- **SMOOTH**

- *Closes*: > This ``frankenstein'' design is an established compromise in multi-sector dynamics modeling and is, in our view, the right one for a dataset intended to support sensitivity and adaptation studies rather than causal attribution.
- *Opens*: > The dataset is openly available for public access at MSD-Live (\url{https://data.msdlive.org/uploads/p4xce-e8822}) and the Tethys model is available at: \href{https://github.com/JGCRI/tethys}{github.com/JGCRI/tethys}.

### Data Records → Technical Validation -- **SMOOTH**

- *Closes*: > All sector files share the same \texttt{(year, lat, lon)} or \texttt{(year, lat, lon, month)} schema with sector-specific sub-variables.
- *Opens*: > We validate the downscaled dataset at the three sectors that together account for over 90\% of CONUS water demand: irrigation, thermoelectric, and domestic (public supply)\cite{skinnerWaterWithdrawalConsumption2025}.

### Technical Validation → Usage Notes -- **SMOOTH**

- *Closes*: > Users coupling the dataset to hydrologic routing should select the appropriate variant for their application.
- *Opens*: > The dataset is provided in netCDF~4 and is readable in any standard scientific-computing environment.

### Usage Notes → Improvements over previous version -- **ABRUPT**

- *Closes*: > \caption{Dominant water-use sector at each 1/8$^{\circ}$ cell, by annual-average consumption.}
- *Opens*: > Compared with the prior Tethys global product, the dataset presented here advances the representation of demand in six specific ways.
- **Problem**: The boundary as captured ends on a figure caption ('Dominant water-use sector at each 1/8 deg cell, by annual-average consumption.') rather than on a closing prose sentence -- the boundary metadata explicitly notes 'transition is implicit (the figure float ends the section without a prose bridge).' The next section then jumps to a comparison with the prior Tethys global product. Both halves are fine on their own (the dominant-sector map is a good closing artifact, and the six-improvements lede is a strong opener for a comparison section), but there is no prose connector. The reader moves from a caption about per-cell sector dominance to a section comparing this dataset against Khan 2023 with no bridging sentence. The OUTLINE expected Usage Notes to close in a way that invites the improvements comparison; instead it closes on an orientation figure, leaving the link to be inferred. No conceptual contradiction, but the rhetorical seam is visible.
- **Suggestion**: Add a one-sentence closing paragraph to Usage Notes after the dominant-sector figure, e.g., 'These usage patterns -- multi-sector at 1/8 deg, with explicit groundwater/surface-water shares -- reflect the specific advances this dataset makes over the prior Tethys global product, which we itemize next.' This restores the planned hand-off and explicitly bridges the dominant-sector map to the six-way comparison.

### Improvements over previous version → Code availability -- **SMOOTH**

- *Closes*: > In addition this dataset is validated against the refreshed January 2025 USGS water-use record, which includes updated thermoelectric cooling-water estimates.
- *Opens*: > All code used to generate and validate the dataset is publicly available under permissive open-source licenses.

## Per-section findings (Level 1 structure reviewer)

### Abstract

*PRECIS claim*: Summarizes the dataset, scope, and sector-first validation framing -- implements CLAIM-01, CLAIM-02, CLAIM-04, CLAIM-05; foregrounds the partial-cancellation caveat (Hook).

_Counts_: 0 critical, 2 major, 4 minor

- **[MAJOR/structure]** `drafts/01-abstract.md:8 (main_v3.tex:45, sentence 1)`
  - Quote: > Water demand in the United States is characterized by significant sectoral and regional heterogeneity, driven by the coupled evolution of climate, land use, population, and economic activity.
  - Issue: Opens with the weak passive-style copula 'is characterized by' and uses the filler intensifier 'significant', which the project CLAUDE.md flags alongside 'key/super/best' as overemphasis to avoid. Strunk & White's 'omit needless words' and the writing-general red-flag table both treat such qualifiers as deletable. The hook also buries the actor.
  - Fix: Rewrite in active voice with a concrete verb, e.g. 'U.S. water demand varies sharply by sector and region as climate, land use, population, and economic activity co-evolve.'

- **[MAJOR/structure]** `drafts/01-abstract.md:8 (main_v3.tex:45, sentence 3)`
  - Quote: > Our analysis reveals that while aggregate CONUS-scale annual demand aligns within 10\% of USGS 2015 estimates, this close agreement reflects the partial cancellation of significant sectoral biases: a -45\% underestimate in domestic demand and a -30\% underestimate in thermoelectric withdrawals are largely offset by a +5\% bias in irrigation.
  - Issue: Roughly 55 words with nested clauses -- exceeds the writing-general 40-word red flag for breaking into 2-3 sentences. Also stacks weak openers ('Our analysis reveals that') and hedges ('largely offset') and reuses the filler 'significant' a second time in the same paragraph. The sector-first framing is the abstract's load-bearing claim and should land in punchier sentences.
  - Fix: Split into two sentences, lead with the punchline: 'Aggregate CONUS demand matches USGS 2015 within 10%, but this agreement is misleading: a -45% bias in Domestic and a -30% bias in Electricity withdrawals cancel against a +5% bias in Irrigation.' Then a short follow-up framing the implication for sector-first validation.

- **[MINOR/structure]** `drafts/01-abstract.md:8 (main_v3.tex:45, sentence 3)`
  - Quote: > Our analysis reveals that
  - Issue: Soft AI-style opener ('reveals that') functions as throat-clearing. Strunk & White: lead with the point, not with a meta-claim about the analysis.
  - Fix: Delete the opener and lead with the finding itself.

- **[MINOR/structure]** `drafts/01-abstract.md:8 (main_v3.tex:45, sentence 3)`
  - Quote: > are largely offset by
  - Issue: 'Largely' is a hedge qualifier in a sentence whose whole purpose is to assert that the cancellation is real and quantitatively misleading. Hedging here weakens the partial-cancellation caveat that the outline marks as the sector-first hook.
  - Fix: Delete 'largely' and let the numbers speak ('cancel against a +5% bias in Irrigation').

- **[MINOR/structure]** `drafts/01-abstract.md:8 (main_v3.tex:45, sentence 4)`
  - Quote: > This dataset improves upon previous global products by incorporating state-resolved sectoral demands from the Global Change Analysis Model (GCAM-USA), explicit future power plant siting via the CERF model, and scenario-consistent high-resolution climate and population forcing.
  - Issue: Long enumerative sentence (~40 words) using the bland verb 'improves upon'. Acceptable but borderline -- a stronger verb (e.g. 'advances', 'replaces aggregated forcings with') would carry the contribution claim more concretely.
  - Fix: Tighten the verb: 'This dataset advances prior global products by combining GCAM-USA state-resolved sectoral demands, CERF-based future power-plant siting, and scenario-consistent high-resolution climate and population forcing.'

- **[MINOR/structure]** `drafts/01-abstract.md:8 (main_v3.tex:45, sentence 5)`
  - Quote: > By capturing the fine-scale spatiotemporal patterns of demand across diverse futures, this dataset supports integrated energy-water-land modeling and local-to-regional water scarcity assessments.
  - Issue: 'Diverse futures' is vague where the abstract has just stated the scenario count concretely (eight scenarios). Closing should reuse the concrete scope rather than retreat to abstraction.
  - Fix: Replace 'diverse futures' with 'the eight scenarios' or 'historical and future scenarios' to keep the closing sentence concrete.

**Boundary summary:**

- *First sentence*: > Water demand in the United States is characterized by significant sectoral and regional heterogeneity, driven by the coupled evolution of climate, land use, population, and economic activity.
- *Last sentence*: > By capturing the fine-scale spatiotemporal patterns of demand across diverse futures, this dataset supports integrated energy-water-land modeling and local-to-regional water scarcity assessments.
- *Assumes from prev*: None -- this is the opening section. Assumes only that the reader knows what water demand and CONUS are at a general level.
- *Hands off to next*: Hands off to the Introduction the heterogeneity hook, the partial-cancellation caveat (sector-first framing), and the headline claim that this dataset advances prior global products via GCAM-USA + CERF + scenario-consistent forcing -- all of which the Introduction must motivate at length.

### Background and Summary

*PRECIS claim*: Establishes the gap that motivates the contribution -- implements CLAIM-01 (existing high-resolution multi-sector demand records lack future projections or coarser global resolution) and forward-references CLAIM-02 and CLAIM-05.

_Counts_: 1 critical, 5 major, 7 minor

- **[CRITICAL/structure]** `drafts/02-background-and-summary.md:13-15 (main_v3.tex lines 62 and 64)`
  - Quote: > We present such a dataset here, refined to 1/8$^{\circ}$ resolution across CONUS. ... We present such a dataset here.
  - Issue: The phrase 'We present such a dataset here.' appears twice -- once opening paragraph 3 (line 62) and again opening paragraph 4 (line 64). This is a duplicated topic sentence, almost certainly a copy/paste leftover. Paragraph 4 then re-announces what paragraph 3 already announced, creating redundancy and a broken topic-sentence inventory.
  - Fix: Delete the duplicate 'We present such a dataset here.' opening of paragraph 4 (line 64). Replace with a topic sentence that pivots to the concrete contents of the published record, e.g., 'The published record contains gridded monthly water withdrawals and consumption for six sectors...' Alternatively, merge paragraphs 3 and 4: keep the MSD-community framing as a tail of paragraph 3 and start paragraph 4 with 'The published record contains...'.

- **[MAJOR/structure]** `drafts/02-background-and-summary.md:13 (main_v3.tex line 62) and :15 (line 64)`
  - Quote: > We present such a dataset here, refined to 1/8$^{\circ}$ resolution across CONUS. This product serves a growing community of researchers in MultiSector Dynamics (MSD)...
  - Issue: Paragraph 3 (community framing) and paragraph 4 (technical contents) both function as the contribution paragraph but split the contribution across two non-parallel topic sentences. The community/MSD framing currently sits between the gap statement (para 2) and the concrete technical description (para 4), interrupting the gap->contribution logical flow. The outline lists 'This dataset: refined to 1/8 degree, CONUS, 8 futures, six sectors + GW/SW split' as a single key point, which the draft fragments.
  - Fix: Restructure into one contribution paragraph that opens with the technical specification (extent, resolution, sectors, scenarios, GW/SW split, six-way improvement preview, figure/table forward-references) and closes with the MSD-community/inter-model-comparison framing as the consequence/why-it-matters tail. This preserves gap -> contribution -> impact ordering and removes the duplicated topic sentence.

- **[MAJOR/structure]** `drafts/02-background-and-summary.md:15 (main_v3.tex line 64)`
  - Quote: > The downscaling chain improves on the prior Tethys CONUS product in six specific ways (Section~``Improvements over previous version''): GCAM-USA integration, explicit CERF-based\cite{Vernon2021} power-plant siting, SSP-aware population proxies, climate-forced irrigation temporal downscaling using TGW-WRF derived deficits and growing-season indices, USGS-anchored source-share adjustment, and resolu...
  - Issue: This is a comma-delimited inline list of six items embedded inside an already long sentence (~85 words) that also defines the dataset extent, sectors, scenarios, source-share content, AND forward-references the figure and table. The sentence violates the writing-general 40-word/nested-clause heuristic and the outline's 'Six-way improvement preview' key point would read more clearly as its own short sentence (or as the topic sentence of a dedicated improvement-preview paragraph).
  - Fix: Split the sentence. Keep the dataset specification (extent, resolution, sectors, scenarios, source shares) in one sentence. Put the six-way improvement preview in a separate sentence: 'The downscaling chain improves on the prior Tethys CONUS product in six specific ways: ... (Section ...).' Then end the paragraph with the figure and table forward-references. This matches outline key points 3-5 as parallel sentences.

- **[MAJOR/structure]** `drafts/02-background-and-summary.md:11 (main_v3.tex line 60)`
  - Quote: > Bridging these scales requires spatial and temporal downscaling\cite{hess-17-4555-2013, van_Vliet_2021, Jones_2024}, but the choice of gridded proxy variables and the consistency of driving scenarios materially affects the resulting demand fields.
  - Issue: Two issues. (1) Subject-verb agreement: 'the choice ... and the consistency ...' is a compound subject and takes 'affect', not 'affects'. (2) The clause introduces 'choice of gridded proxy variables and the consistency of driving scenarios' as a new concept that is not picked up in the rest of the section -- the next sentence pivots to Khan 2023 and seasonal/scenario-consistent forcing without explicitly tying back to 'gridded proxy variables'. Concept introduced but not used downstream.
  - Fix: Fix agreement: '... materially affect the resulting demand fields.' Then either drop the 'gridded proxy variables' phrase or thread it forward into the contribution paragraph (e.g., 'sector-specific gridded proxies -- Demeter land use, CERF power-plant locations, SSP population, fixed livestock distributions -- drive the spatial step') so the concept is reused, not orphaned.

- **[MAJOR/structure]** `drafts/02-background-and-summary.md:11 (main_v3.tex line 60)`
  - Quote: > Khan et al. (2023)\cite{Khan2023} produced the first global Tethys-downscaled multi-sector product at 1/2$^{\circ}$ resolution; however, resolving seasonal patterns---which differ sharply across sectors and regions---requires monthly resolution and scenario-consistent climate and population forcing.
  - Issue: The 'however' clause asserts a requirement (monthly + scenario-consistent forcing) without explicitly saying Khan 2023 fails to meet it. As written, Khan 2023 is at monthly resolution (per the prior-datasets table on line 82), so the contrast is not 'monthly' but 'CONUS-scale spatial detail and scenario-consistent forcing aligned to higher resolution'. The contrast is therefore misleading and the gap relative to Khan 2023 is not crisply stated.
  - Fix: Tighten the contrast to the actual gap: spatial resolution (1/2 degree global vs. management-scale 1/8 degree CONUS) and the use of scenario-consistent population/land-use/climate forcing rather than static or globally-uniform baselines. E.g., 'Khan et al. (2023) produced the first global Tethys-downscaled multi-sector product at 1/2 degree monthly resolution; resolving CONUS-scale management decisions, however, requires finer spatial resolution and scenario-consistent climate, land-use, and population forcing.'

- **[MAJOR/structure]** `drafts/02-background-and-summary.md:13 (main_v3.tex line 62)`
  - Quote: > This product serves a growing community of researchers in MultiSector Dynamics (MSD) who require consistent energy-water-land inputs to study the resilience of the U.S. bulk power system, the sustainability of groundwater resources, and the impacts of regional climate extremes.
  - Issue: The phrase 'a growing community' is a hedge/weasel construction (writing-general: 'Use definite language; avoid hedging, qualifiers, and weasel words'). 'Growing' is unsupported and adds nothing concrete. The sentence also leans on the abstract noun 'community' rather than naming the use cases directly.
  - Fix: Drop 'growing'. Consider tightening to: 'The dataset supports MultiSector Dynamics (MSD) research on U.S. bulk-power-system resilience, groundwater sustainability, and regional climate extremes by providing scenario-consistent energy-water-land inputs.' This is active, definite, and removes the hedge.

- **[MINOR/structure]** `drafts/02-background-and-summary.md:9 (main_v3.tex line 58)`
  - Quote: > Resolving water demand at the spatial and temporal scales of management decisions is therefore essential for evaluating scarcity under climate and socioeconomic change.
  - Issue: 'Essential' is a softening abstract adjective doing the work of a precise claim. Strunk & White: prefer concrete, definite assertions. The sentence also uses 'is ... essential for evaluating' rather than naming the actor (modelers, water managers, MSD researchers) who require it.
  - Fix: Replace with an active, actor-named formulation, e.g., 'Modeling scarcity under climate and socioeconomic change therefore requires demand resolved at the spatial and temporal scales of management decisions.' This also tightens the topic sentence's role as the bridge into paragraph 2.

- **[MINOR/structure]** `drafts/02-background-and-summary.md:11 (main_v3.tex line 60)`
  - Quote: > have provided valuable gridded benchmarks for past decades but do not extend to future scenarios.
  - Issue: 'Valuable' is a vague positive adjective with no informational content (writing-general red flag: 'overemphasis dilutes meaning'). The sentence works without it.
  - Fix: Drop 'valuable': 'have provided gridded benchmarks for past decades but do not extend to future scenarios.'

- **[MINOR/structure]** `drafts/02-background-and-summary.md:9 (main_v3.tex line 58)`
  - Quote: > with the relative importance of these sectors varying sharply across regions and over time.
  - Issue: Trailing participial clause buries the topic-sentence point inside a subordinate construction. The paragraph's argumentative move ('demand-side drivers dominate; demand must be resolved at management scales') would be served by a sharper opening assertion that names heterogeneity directly.
  - Fix: Consider promoting the heterogeneity claim to a finite clause: 'Humans depend on water for irrigation, thermoelectric cooling, public supply, industry, and livestock. The relative importance of these sectors varies sharply across regions and over time.' Two short sentences read more directly.

- **[MINOR/structure]** `drafts/02-background-and-summary.md:13 (main_v3.tex line 62)`
  - Quote: > By providing a common, scenario-consistent demand foundation, this dataset enables inter-model comparisons and supports the development of robust adaptation strategies.
  - Issue: 'Robust' is a stock adjective frequently flagged as AI-anti-pattern boilerplate; 'supports the development of robust adaptation strategies' is a vague impact claim that does not advance CLAIM-01/02/05. Also nominalization ('the development of') where a verb suffices.
  - Fix: Either delete this sentence (the inter-model-comparison point can fold into the prior sentence) or replace with a concrete impact, e.g., 'The shared demand foundation enables inter-model comparisons across MSD analyses.' Drop 'robust' and the nominalization.

- **[MINOR/structure]** `drafts/02-background-and-summary.md:11 (main_v3.tex line 60)`
  - Quote: > The availability of high-resolution, multi-sectoral water demand projections remains a bottleneck for integrated modeling.
  - Issue: Topic sentence uses the abstract nominalization 'The availability of ... remains a bottleneck'. Stronger alternative names the constraint directly.
  - Fix: Tighten to: 'High-resolution, multi-sector water-demand projections remain scarce, constraining integrated modeling.' Active and concrete.

- **[MINOR/structure]** `drafts/02-background-and-summary.md:15 (main_v3.tex line 64)`
  - Quote: > for one historical period (1980--2019) and eight future scenarios (2020--2100) that vary by RCP, TGW climate sample, and SSP.
  - Issue: The scenario count and dimensions are introduced here but the eight-scenario matrix is later named in the paper as 'rcp{45,85}{cooler,hotter}_ssp{3,5}'. The Background section silently introduces 'TGW climate sample' as a third dimension without defining TGW (Thermodynamic Global Warming) on first use. Concept introduced but undefined.
  - Fix: On first use, expand: 'TGW (Thermodynamic Global Warming) climate sample'. Optionally state the 2x2x2 structure explicitly so readers can map RCP x climate-sample x SSP to eight scenarios without forward-referencing a later section.

- **[MINOR/structure]** `drafts/02-background-and-summary.md:11 (main_v3.tex line 60)`
  - Quote: > Conversely, global water scarcity assessments often rely on coarse-resolution integrated assessment model outputs that lack the spatial detail required for river routing or local management modeling
  - Issue: 'Often rely on' is a hedge. The cited references support a definite claim: these assessments use coarse IAM outputs. The hedge weakens the gap statement, which is the load-bearing move of the section.
  - Fix: Replace 'often rely on' with 'rely on' or 'use'. Definite language matches the writing-general guidance and sharpens the gap.

**Boundary summary:**

- *First sentence*: > Humans depend on water for irrigation, thermoelectric cooling, public supply, industry, and livestock, with the relative importance of these sectors varying sharply across regions and over time.
- *Last sentence*: > Table~\ref{tab:prior-datasets} compares this dataset with closely related published records.
- *Assumes from prev*: Reader has seen the abstract's high-level claim that a high-resolution multi-sector CONUS water demand dataset is being introduced; no specific technical content is assumed.
- *Hands off to next*: Hands off to the Methods chain that produces the dataset (downscaling pipeline: GCAM-USA -> Tethys spatial/temporal downscaling -> USGS-anchored source-share adjustment) and to the 'Improvements over previous version' section that itemizes the six-way improvement preview.

### Methods and Data

*PRECIS claim*: Specifies the six-step downscaling chain (GCAM-USA → Demeter/CERF/SSP-pop/GLW-3 spatial proxies → TGW-WRF temporal proxies → USGS-anchored source-share clip) producing 1/8° monthly demand under one historical and eight future scenarios -- implements CLAIM-02.

_Counts_: 0 critical, 7 major, 8 minor

- **[MAJOR/structure]** `drafts/03-methods-and-data.md:16`
  - Quote: > Historical forcings were dynamically downscaled from ~30-km ERA5 reanalysis (1980-2019) using WRF.
  - Issue: Passive voice hides the actor (the TGW team). Strunk & White flags passive constructions; the section uses passive form repeatedly without naming who did the work.
  - Fix: Rewrite as active: 'The TGW team dynamically downscaled ~30-km ERA5 reanalysis (1980–2019) using WRF.' Or restructure to attribute to the cited Jones2023TGW study.

- **[MAJOR/structure]** `drafts/03-methods-and-data.md:16`
  - Quote: > Future meteorological forcings were projected through the TGW approach, which replays historical weather sequences with added thermodynamic signals derived from CMIP6 Earth System Models.
  - Issue: Passive voice ('were projected'). The actor is the TGW method itself; the construction obscures agency and inflates the sentence.
  - Fix: Rewrite: 'The TGW approach projects future forcings by replaying historical weather sequences with added thermodynamic signals from CMIP6 Earth System Models.'

- **[MAJOR/structure]** `drafts/03-methods-and-data.md:16`
  - Quote: > Four scenarios combine diverging emission pathways and structural uncertainties in CMIP6 models, including moderate emissions constraints (rcp45), leading to a moderately hotter and drier future on average across CONUS, and no emissions constraints (rcp85), leading to a substantially hotter and drier future.
  - Issue: Run-on sentence (>50 words) with multiple nested clauses; violates the 'sentence > 40 words with nested clauses → break into 2–3 sentences' rule. Also conflicts with the 8-scenario count established in subsection 1 ('eight GCAM-USA runs') by referring here to 'four scenarios' without clarifying these are the four climate combinations (2 RCP × 2 climate) before the SSP cross.
  - Fix: Split into 2–3 sentences and clarify scenario accounting: e.g., 'TGW provides four climate combinations: two RCPs (4.5, 8.5) crossed with two CMIP model groups (cooler, hotter). RCP4.5 yields a moderately hotter and drier CONUS on average; RCP8.5 yields a substantially hotter and drier CONUS. These four climate samples are crossed with two SSPs (3, 5) to give the eight GCAM-USA runs of subsection 1.'

- **[MAJOR/structure]** `drafts/03-methods-and-data.md:42`
  - Quote: > Per-crop irrigated-area fields then serve as the proxy $\pi_{\mathrm{cell}}$ for each crop's irrigation demand via Eq.~(\ref{eq:spatial}).
  - Issue: Topic-sentence inventory: the Irrigation subsection's first sentence is a list of 13 crop classes ('GCAM-USA reports water demand for 13 crop classes: Corn, Wheat, Rice, …'). The lead does not state the subsection's claim (the proxy choice for irrigation). Strunk & White: lead with the point.
  - Fix: Promote a topic sentence such as: 'For irrigation, scenario-consistent annual per-crop irrigated-area maps from Demeter serve as the spatial proxy.' Then list crops as supporting detail.

- **[MAJOR/structure]** `drafts/03-methods-and-data.md:47`
  - Quote: > For the historical period we use the 2015 plant inventory from the Global Power Plant Database v1.3 (GPPD) augmented with the IM3 experiment B CONUS plant inventory, merged onto the same 1/8$^{\circ}$ grid.
  - Issue: GPPD/IM3-experiment-B is a named historical proxy not listed in the outline's 'Demeter, CERF, SSP-pop, GLW-3, population' enumeration. Outline-compliance: either the outline should mention GPPD or the draft should clarify GPPD as the historical specialization of the CERF proxy. As written, a reader cannot reconcile the proxy list against the outline.
  - Fix: Either expand the outline to list GPPD, or in the draft add a clause: 'For the historical period we substitute the GPPD v1.3 / IM3-experiment-B observed plant inventory in place of CERF projections; both feed the same Eq. (spatial) at the cell.'

- **[MAJOR/structure]** `drafts/03-methods-and-data.md:55`
  - Quote: > GLW is published at 1/12$^{\circ}$ resolution for reference year 2010; we re-grid to 1/8$^{\circ}$ by allocating source-cell counts to target cells in proportion to fractional overlap, and hold the 2010 distribution fixed across all years and scenarios.
  - Issue: Forward reference to 'Limitations' is made but no Limitations subsection appears within Methods and Data; the cross-reference is to a section outside this draft. The reader has no anchor in this section. Either inline the limitation language briefly or remove the dangling reference.
  - Fix: Either drop the 'see Limitations' aside, or add a brief inline acknowledgment so the section is self-contained: 'so the assumption's effect on aggregate totals is small (∼2% of CONUS demand).'

- **[MAJOR/structure]** `drafts/03-methods-and-data.md:60`
  - Quote: > For manufacturing and mining, population is used as the spatial proxy, matching the approach of prior Tethys work\cite{Khan2023}.
  - Issue: Passive voice hiding the actor ('is used'). Also 'See "Limitations"' (line 60) -- second forward reference to a section not present in this draft.
  - Fix: Active rewrite: 'We use population as the spatial proxy for manufacturing and mining, following Khan et al. (2023).' Drop or inline the Limitations cross-reference.

- **[MINOR/structure]** `drafts/03-methods-and-data.md:64`
  - Quote: > Livestock, manufacturing, and mining monthly demand is assumed uniform at 1/12 of the annual value; irrigation, electricity, and domestic follow climate-driven formulations described below.
  - Issue: Passive 'is assumed' hides agent. Strong verb available: 'we set' or 'we hold'.
  - Fix: Rewrite: 'For livestock, manufacturing, and mining we hold monthly demand uniform at 1/12 of the annual total; irrigation, electricity, and domestic follow the climate-driven formulations below.'

- **[MINOR/structure]** `drafts/03-methods-and-data.md:75`
  - Quote: > Monthly electricity water demand is distributed according to the share of annual electricity use that services heating, cooling, and all other uses, each modulated by a temperature-dependent distribution.
  - Issue: Passive lead-in ('is distributed'); also a weak verb chain ('services… each modulated'). Topic sentence does not state the formula's purpose crisply.
  - Fix: Rewrite: 'We distribute monthly electricity water demand by splitting annual use into heating, cooling, and other shares, each weighted by an HDD/CDD-driven monthly profile.'

- **[MINOR/structure]** `drafts/03-methods-and-data.md:102`
  - Quote: > We apply a thresholding approach to ensure $D_m \ge 0$ in all cells.
  - Issue: Vague hedging ('a thresholding approach'). Concrete language preferred per Strunk & White; specify the threshold (e.g., clip to zero) so the reader can reproduce.
  - Fix: Rewrite: 'We clip negative values to zero so that D_m ≥ 0 in every cell.'

- **[MINOR/structure]** `drafts/03-methods-and-data.md:106`
  - Quote: > GCAM-USA solves for the share of each basin's withdrawals met from renewable (surface) versus non-renewable (groundwater) supply by cost-based allocation.
  - Issue: Topic sentence is fine but the next sentence 'Mapping that basin-scale split onto the 1/8$^{\circ}$ grid requires two steps' is followed by a long paragraph describing those steps in passive constructions ('is applied uniformly', 'are renormalized', 'we anchor'). Mixed voice within a single paragraph; the two steps are not visually flagged so the reader must reconstruct them from prose.
  - Fix: Either add 'First, … Second, …' explicit markers (already partially present), or rewrite all step verbs in active voice with consistent subjects: 'We apply the basin share uniformly… we renormalize… we anchor…'

- **[MINOR/structure]** `drafts/03-methods-and-data.md:115`
  - Quote: > The $\min(\cdot,1)$ clip bounds ratio amplifications where the GCAM 2015 baseline is small, reflecting the trade-off between mass balance conservation and binding fraction limits in groundwater-dominated regions.
  - Issue: Sentence is dense with abstractions ('reflecting the trade-off between mass balance conservation and binding fraction limits') -- Strunk & White flags abstract nouns. Also slightly self-aggrandizing in framing ('reflecting the trade-off').
  - Fix: Rewrite plainly: 'The min(·,1) clip prevents amplifications when the 2015 GCAM baseline is small. In groundwater-dominated regions the clip can mask trajectory increases, but it preserves the physical bound that a share cannot exceed one.'

- **[MINOR/structure]** `drafts/03-methods-and-data.md:119`
  - Quote: > This ``frankenstein'' design is an established compromise in multi-sector dynamics modeling\cite{Khan2023} and is, in our view, the right one for a dataset intended to support sensitivity and adaptation studies rather than causal attribution.
  - Issue: Closing sentence editorializes ('in our view, the right one') -- Strunk & White prefers definite assertions but warns against overstatement. Also long compound clause structure (>40 words) with parenthetical hedge.
  - Fix: Tighten: 'This frankenstein design is an established compromise in multi-sector dynamics modeling and is appropriate for a dataset intended to support sensitivity and adaptation studies, not causal attribution.'

- **[MINOR/structure]** `drafts/03-methods-and-data.md:11`
  - Quote: > GCAM is a market-equilibrium integrated assessment model that allocates supply and demand across coupled energy, water, land, and economic sectors given scenario-specific assumptions on population, productivity, technology, and policy.
  - Issue: Long single sentence (37 words) packed with abstractions. Acceptable but borders on the 40-word soft limit. Consider splitting for readability.
  - Fix: Optional split: 'GCAM is a market-equilibrium integrated assessment model. It allocates supply and demand across coupled energy, water, land, and economic sectors under scenario-specific assumptions on population, productivity, technology, and policy.'

- **[MINOR/structure]** `drafts/03-methods-and-data.md (overall)`
  - Quote: > \subsection*{Future projection methods}
  - Issue: Subsection-boundary check: outline lists 'Future projection methods: frankenstein-coupling rationale' as a Methods subsection, but conceptually the frankenstein discussion is more a design-justification/limitation than a method specification. Placement within Methods is defensible but the subsection makes no forward hand-off to Data Records (the next section), undermining the outline's stated 'Transition out: methods produce the published record (Data Records).'
  - Fix: Add a one-sentence bridge at the end: 'The combined chain -- GCAM-USA → Demeter/CERF/SSP-pop/GLW-3 spatial proxies → TGW-driven temporal weights → USGS-anchored source-share clip -- produces the 1/8° monthly gridded record described next.'

**Boundary summary:**

- *First sentence*: > Region-scale water-demand inputs come from the Global Change Analysis Model (GCAM-USA version).
- *Last sentence*: > This ``frankenstein'' design is an established compromise in multi-sector dynamics modeling and is, in our view, the right one for a dataset intended to support sensitivity and adaptation studies rather than causal attribution.
- *Assumes from prev*: Reader knows the dataset's purpose (CLAIM-01: 1/8° monthly CONUS gridded water-demand record under historical and future scenarios) and that a six-step downscaling chain will be specified.
- *Hands off to next*: The fully-specified methods produce the published 1/8° monthly gridded record, whose contents and access (Data Records) are described next.

### Data Records

*PRECIS claim*: Documents the MSD-Live publication, netCDF schema, and per-scenario YAML configurations sufficient to identify the exact Tethys run that produced each scenario -- implements CLAIM-03.

_Counts_: 1 critical, 4 major, 4 minor

- **[CRITICAL/structure]** `drafts/04-data-records.md:11 (main_v3.tex line 226)`
  - Quote: > The dataset is openly available for public access at MSD-Live (\url{https://data.msdlive.org/uploads/p4xce-e8822}) and the Tethys model is available at: \href{https://github.com/JGCRI/tethys}{github.com/JGCRI/tethys}.
  - Issue: Paragraph 1 (line 226) and paragraph 2 (line 228) both open with 'The dataset is openly available ... at MSD-Live (\url{https://data.msdlive.org/uploads/p4xce-e8822})' -- the hosting statement and the URL are repeated verbatim. The duplication is not stylistic; it is two near-identical sentences in adjacent paragraphs.
  - Fix: Merge the two openings into a single sentence that names MSD-Live and the Tethys GitHub repo once, then proceed directly to scenario directory contents. E.g., 'The dataset is permanently archived at MSD-Live (\url{...}); the Tethys model source is at \href{...}{github.com/JGCRI/tethys}. Each scenario directory (Table~\ref{tab:scenarios}) contains ...'.

- **[MAJOR/structure]** `drafts/04-data-records.md:13 (main_v3.tex line 228)`
  - Quote: > The dataset is openly available and  permanently on MSD-Live
  - Issue: Two-space gap between 'and' and 'permanently', and the phrasing is ungrammatical -- 'openly available and permanently on MSD-Live' lacks a verb/adjective parallel ('available ... and [is] permanently [archived] on MSD-Live'). Reads as an unfinished edit.
  - Fix: Rewrite as 'The dataset is permanently archived and openly available on MSD-Live' (single space, parallel adjectives) -- and fold into the merged opening sentence per the previous issue.

- **[MAJOR/structure]** `drafts/04-data-records.md:14 (main_v3.tex line 231)`
  - Quote: > two YAML configuration files (\texttt{config\_withdrawals.yaml}, \texttt{config\_consumption.yaml}) that record the exact Tethys run configuration used to produce the files, for reproducibility
  - Issue: 'for reproducibility' is a tacked-on justification that adds no information -- recording the exact run configuration IS reproducibility. Strunk & White: omit needless words; don't tell the reader the obvious purpose of a fact you just stated.
  - Fix: Drop ', for reproducibility'. The clause 'that record the exact Tethys run configuration used to produce the files' already conveys the point.

- **[MAJOR/structure]** `drafts/04-data-records.md:14 (main_v3.tex line 231)`
  - Quote: > Figure~\ref{fig:data-listing} shows an example CDL listing. All sector files share the same \texttt{(year, lat, lon)} or \texttt{(year, lat, lon, month)} schema with sector-specific sub-variables.
  - Issue: Topic-sentence ordering inverted: the schema statement is the actual claim of the paragraph's second half; the CDL figure is its evidence. As written, the paragraph ends on the schema sentence with no transition out, and the CDL pointer interrupts the YAML→schema flow. The outline lists schema BEFORE the CDL example.
  - Fix: Reorder: '... All sector files share the same \texttt{(year, lat, lon)} or \texttt{(year, lat, lon, month)} schema with sector-specific sub-variables; Figure~\ref{fig:data-listing} shows an example CDL listing.'

- **[MAJOR/structure]** `drafts/04-data-records.md:7-17 (entire section)`
  - Quote: > [scenarios table at lines 234–253; CDL listing figure at lines 255–279]
  - Issue: Section is only two body paragraphs (plus the table/figure stubs). The outline calls for distinct points (hosting, naming convention, YAML configs, gridded_runoff_shares, schema, scenario table) -- paragraph 2 jams the convention, the YAML configs, the runoff-shares file, the CDL pointer, AND the schema into one paragraph. No topic sentence governs it; it reads as a list rendered as prose.
  - Fix: Split paragraph 2 into two: (a) one paragraph on the per-scenario file inventory and naming convention (sector files + irrigation _with_losses + monthly suffix), and (b) one paragraph on the per-scenario reproducibility metadata (gridded_runoff_shares.nc, two YAML configs) and the shared schema with the CDL pointer. Each paragraph then has one main idea, matching the outline.

- **[MINOR/structure]** `drafts/04-data-records.md:11 (main_v3.tex line 226)`
  - Quote: > The dataset is openly available for public access at MSD-Live
  - Issue: 'openly available for public access' is redundant -- 'openly available' already means publicly accessible. Strunk & White 'omit needless words'.
  - Fix: 'The dataset is openly available at MSD-Live ...' or, after the merge, 'permanently archived and openly available on MSD-Live'.

- **[MINOR/structure]** `drafts/04-data-records.md:12 (main_v3.tex line 229)`
  - Quote: > where \texttt{<Sector>} is one of \texttt{Domestic}, \texttt{Electricity}, \texttt{Irrigation}, \texttt{Livestock}, \texttt{Manufacturing}, \texttt{Mining}; \texttt{<demand\_type>} is \texttt{withdrawals} or \texttt{consumption}; and the \texttt{\_monthly} suffix distinguishes monthly files from their annual counterparts.
  - Issue: Single sentence carries three separate semicolon-joined definitions plus a fourth clause ('For irrigation, an additional ...') in the next sentence. At ~55 words it is on the edge of the 40-word red flag and trades clarity for compactness -- readers must parse three placeholder definitions in series.
  - Fix: Break into a short definition list rendered as two sentences, e.g., '\texttt{<Sector>} is one of {Domestic, Electricity, Irrigation, Livestock, Manufacturing, Mining}, and \texttt{<demand\_type>} is \texttt{withdrawals} or \texttt{consumption}. The \texttt{\_monthly} suffix marks monthly files; for irrigation, \texttt{\_with\_losses} marks files that include conveyance losses.'

- **[MINOR/structure]** `drafts/04-data-records.md:14 (main_v3.tex line 231)`
  - Quote: > Each scenario directory also contains \texttt{gridded\_runoff\_shares.nc} (per-year, per-cell renewable share $s^{\mathrm{adj}}_{c,y}$ from Eq.~\ref{eq:source-shares})
  - Issue: The parenthetical defines the variable but does not say why this file is shipped alongside the sector files (i.e., it is the diagnostic that recovers the surface/groundwater split applied to withdrawals). Without one phrase tying it to use, the file appears as a loose addendum.
  - Fix: Append a brief use-clause: '... renewable share $s^{\mathrm{adj}}_{c,y}$ from Eq.~\ref{eq:source-shares}, used to recover the surface/groundwater split of withdrawals)'.

- **[MINOR/structure]** `drafts/04-data-records.md:16 (main_v3.tex line 233)`
  - Quote: > [scenarios table at lines 234–253; CDL listing figure at lines 255–279]
  - Issue: Outline lists the scenario directory table as a key point and the section references Table~\ref{tab:scenarios} in paragraph 2, but no transition-out sentence introduces or summarizes either the table or the CDL figure. The section ends abruptly on the schema sentence with no handoff to Technical Validation, contrary to the outline's 'Transition out: validation tests the published record.'
  - Fix: Add a one-sentence transition after the schema/CDL sentence, e.g., 'Table~\ref{tab:scenarios} enumerates the eight scenarios and Figure~\ref{fig:data-listing} an example CDL listing; the next section validates this published record against USGS observations.'

**Boundary summary:**

- *First sentence*: > The dataset is openly available for public access at MSD-Live (\url{https://data.msdlive.org/uploads/p4xce-e8822}) and the Tethys model is available at: \href{https://github.com/JGCRI/tethys}{github.com/JGCRI/tethys}.
- *Last sentence*: > All sector files share the same \texttt{(year, lat, lon)} or \texttt{(year, lat, lon, month)} schema with sector-specific sub-variables.
- *Assumes from prev*: Assumes the reader knows what Tethys produces (six sector demand fields, withdrawals/consumption, monthly disaggregation, irrigation conveyance losses, and the source-share equation \ref{eq:source-shares}) from the Methods section.
- *Hands off to next*: Hands off a fully described, citable artifact to the Technical Validation section, which can now test 'the published record' as a fixed object.

### Technical Validation

*PRECIS claim*: At HUC6 the dataset reproduces the spatial pattern of USGS demand with Pearson r between 0.71 (Domestic) and 0.95 (Irrigation), with sector-level biases of -45% (Domestic) to +5% (Irrigation) that partially cancel at CONUS aggregate -- implements CLAIM-04 and addresses counterargument #2 (statistical thinness).

_Counts_: 0 critical, 10 major, 8 minor

- **[MAJOR/structure]** `drafts/05-technical-validation.md:41`
  - Quote: > as documented in recent reanalyses \cite{Skinner2025USGS, Stets2025USGS}.\subsection*{Seasonal cycle}
  - Issue: The 'Bias diagnosis and uncertainty' subsection runs directly into '\subsection*{Seasonal cycle}' on the same line with no paragraph break. This is a LaTeX formatting bug that will produce a malformed subsection heading and breaks the outline's intended subsection boundary between 'Bias diagnosis' and 'Seasonal cycle'.
  - Fix: Insert a newline (or blank line) between the closing citation '...\cite{Skinner2025USGS, Stets2025USGS}.' and '\subsection*{Seasonal cycle}' so the heading starts on its own line.

- **[MAJOR/structure]** `drafts/05-technical-validation.md:32`
  - Quote: > The decline Electricity withdrawals reflects a known trend due in large part to the switch from coal-fired plants to other technologies
  - Issue: Ungrammatical: missing 'in' (or 'of'). Should read 'The decline in Electricity withdrawals' or 'The decline of Electricity withdrawals'. Sentence-level error in a paragraph that carries a load-bearing claim about the long-term trend.
  - Fix: Change to 'The decline in Electricity withdrawals reflects a known trend driven largely by the switch from coal-fired plants to other technologies.'

- **[MAJOR/structure]** `drafts/05-technical-validation.md:32`
  - Quote: > Domestic and Irrigation show sizable sector-level biases in opposing directions at the HUC6 scale, which partially cancel at the CONUS total.
  - Issue: Inconsistent with Table 1 (line 18-20 of draft): Irrigation MBE is +5% and Domestic is -45%. The +5% irrigation bias is not 'sizable' relative to the -45% domestic bias. Calling them both 'sizable' overstates the irrigation bias and obscures the asymmetry that actually drives the partial cancellation. The claim of 'opposing directions' is also weak -- Electricity (-30%), Domestic (-45%), and Industrial (-10%) all share the same sign; only Irrigation (+5%) opposes them.
  - Fix: Rephrase to identify Domestic (-45%) as the dominant negative bias and Irrigation (+5%) as the small opposing bias; note that magnitude differences (irrigation being the largest sector by volume) are what produce the partial cancellation at CONUS aggregate.

- **[MAJOR/structure]** `drafts/05-technical-validation.md:43`
  - Quote: > Domestic shows a broadly consistent positive bias across months; this reflects the $R$ amplitude coefficient used in Eq.~(\ref{eq:dom-monthly}), which was calibrated to aggregate USGS demand rather than to the post-2015 public-supply subset.
  - Issue: Direct contradiction with Table 1 and with the 'Bias diagnosis' subsection (line 41), both of which report Domestic MBE = -45% (negative bias). Saying the seasonal cycle shows a 'positive bias' for Domestic is inconsistent with the rest of the section. This is a factual/internal-consistency error, not just a wording issue.
  - Fix: Reconcile the sign: either (a) state Domestic shows a broadly consistent NEGATIVE bias across months consistent with the -45% MBE, or (b) clarify that the seasonal-cycle figure shows a different signal (e.g., shape bias vs. amplitude bias) and explain why amplitude in monthly cycle differs from annual MBE.

- **[MAJOR/structure]** `drafts/05-technical-validation.md:9`
  - Quote: > The goal is not to declare a ``true'' dataset, since neither USGS nor Tethys are direct observations at 1/8$^{\circ}$ resolution, but to establish that the downscaled record reproduces the dominant features of observed spatial and temporal demand patterns, with quantified bias where it departs.
  - Issue: Topic sentence of the introductory paragraph buries the lead. The paragraph's main point -- that we proceed coarse-to-fine, total-to-seasonal, comparing against USGS -- is in the prior sentence; the closing sentence then introduces a hedge ('not to declare a true dataset'). Per the writing-general 'lead with the point' principle, the framing claim (what the section establishes) should appear earlier.
  - Fix: Move the framing sentence ('The goal is...to establish that the downscaled record reproduces the dominant features of observed spatial and temporal demand patterns, with quantified bias where it departs') to the start of the paragraph, then describe the coarse-to-fine approach as the method for establishing it.

- **[MAJOR/structure]** `drafts/05-technical-validation.md:32`
  - Quote: > Tethys reproduces both the magnitude and long-term trend of USGS totals, within 10\% at annual resolution.
  - Issue: Ambiguous antecedent: 'within 10%' could refer to magnitude only, trend only, or both. Given Table 1 shows Total MBE of -10%, this is plausibly the magnitude bound only -- the trend match has a different metric. A reader trying to verify the precis claim cannot tell which quantity is being constrained.
  - Fix: Specify: e.g., 'Tethys reproduces the magnitude of USGS CONUS totals within ~10% (Table~\ref{tab:validation-metrics}) and follows the long-term trend.'

- **[MAJOR/structure]** `drafts/05-technical-validation.md:48`
  - Quote: > within the future period the scenarios evolve smoothly and consistently with their  drivers.
  - Issue: Double space before 'drivers' (typo) and weak/vague closer to a load-bearing inter-scenario-consistency paragraph. 'Consistently with their drivers' restates rather than concludes -- the paragraph already enumerated the SSP/RCP signatures, so the closer should cement what the inter-scenario comparison establishes (e.g., that the dataset's scenario differentiation is interpretable and free of artefacts beyond the documented 2020 discontinuity).
  - Fix: Remove the double space; rewrite the clause to make a stronger closing claim, e.g., '...within the future period the scenarios evolve smoothly, with no artefacts beyond the documented 2020 reanalysis-to-TGW discontinuity, supporting use of the inter-scenario contrasts.'

- **[MAJOR/structure]** `drafts/05-technical-validation.md:32`
  - Quote: > The GCAM-USA 5-year time step manifests in the Tethys annual irrigation demands as reduced interannual variability relative to USGS.
  - Issue: Sentence sits in the middle of the 'CONUS annual totals' paragraph but is not connected to the surrounding magnitude/trend discussion. Reads as an interjected limitation rather than part of the argument; would fit better either earlier (as a caveat on the trend) or moved to Limitations. Disrupts paragraph unity.
  - Fix: Either move this caveat to immediately follow the magnitude/trend claim (so trend caveat sits next to trend) or relocate to the Limitations subsection where temporal-resolution mismatches with USGS belong.

- **[MAJOR/structure]** `drafts/05-technical-validation.md:53-61`
  - Quote: > Several known limitations should inform reuse of the dataset: 367 \begin{itemize} 368     \item \textbf{Livestock spatial stationarity.} ...
  - Issue: The Limitations subsection is delivered as a six-item bulleted list. The writing-general style guide explicitly directs 'Write in prose | Avoid bullet points and lists unless explicitly requested' (and lists this as a Red Flag: 'Bullet points are lazy → Write in prose paragraphs'). For a Scientific Data manuscript, prose limitations paragraphs are conventional and stronger.
  - Fix: Convert the six-bullet list to one or two prose paragraphs that group related limitations (e.g., spatial-stationarity caveats: livestock, manufacturing/mining proxy; methodological caveats: source-share carve-out, GSI simplification, riparian vs. reservoir allocation, conveyance-loss variants).

- **[MAJOR/structure]** `drafts/05-technical-validation.md:41`
  - Quote: > The -45\% bias observed in domestic demand (Table \ref{tab:validation-metrics}) is likely attributable to the calibration of the Wada $R$ coefficient, which may not fully capture the U.S. public-supply sensitivity, or a mismatch in the GCAM-USA base-year socioeconomic data compared to USGS 2015 reporting.
  - Issue: 'Bias diagnosis and uncertainty' subsection is a single short paragraph that diagnoses ONLY the Domestic bias. The outline's parent claim and the section abstract reference biases ranging from -45% to +5%, plus Electricity (-30%) which the spatial-agreement subsection flagged as an over-prediction in the eastern/southeastern U.S. The diagnosis subsection should at minimum touch the Electricity over-prediction (CERF siting vs. USGS aggregation) and the Irrigation under-prediction (GSI weighting in western basins) the section already raised -- otherwise the subsection name 'Bias diagnosis' is broader than its content.
  - Fix: Expand the subsection to a paragraph (or two) that diagnoses Domestic, Electricity, and Irrigation biases in turn, drawing on the spatial-agreement findings already presented; or rename the subsection to 'Domestic bias diagnosis' to match its scope.

- **[MINOR/structure]** `drafts/05-technical-validation.md:9`
  - Quote: > since neither USGS nor Tethys are direct observations at 1/8$^{\circ}$ resolution
  - Issue: Subject-verb agreement: 'neither...nor' with two singular subjects takes a singular verb in formal usage ('neither USGS nor Tethys is...'). Minor but noticeable in a technical section.
  - Fix: Change 'are' to 'is': 'since neither USGS nor Tethys is a direct observation at 1/8$^{\circ}$ resolution'.

- **[MINOR/structure]** `drafts/05-technical-validation.md:32`
  - Quote: > Magnitudes differ sharply across sectors, as expected: irrigation dominates consumptive use, while thermoelectric and irrigation are of comparable magnitude in withdrawals.
  - Issue: Repeats 'irrigation' as both sides of a comparison ('thermoelectric and irrigation are of comparable magnitude'); should compare thermoelectric to irrigation explicitly. As written it reads circularly.
  - Fix: Rephrase: 'irrigation dominates consumptive use, while thermoelectric withdrawals are comparable in magnitude to irrigation withdrawals.'

- **[MINOR/structure]** `drafts/05-technical-validation.md:37`
  - Quote: > where the GSI-weighted monthly distribution underweights months that USGS records as heavy irrigation under observed 2015 conditions
  - Issue: Long nested clause; 'months that USGS records as heavy irrigation under observed 2015 conditions' is hard to parse. Strunk & White: break sentences > 40 words with nested clauses.
  - Fix: Split: 'where the GSI-weighted monthly distribution underweights peak irrigation months. USGS records these months as heavy-use under observed 2015 conditions.'

- **[MINOR/structure]** `drafts/05-technical-validation.md:43`
  - Quote: > Electricity consumption shows a consistent offset in non-summer months, likely from the GCAM-USA representation of non-cooling electricity water use.
  - Issue: 'Offset' is undirectional -- does electricity consumption read high or low in non-summer months relative to USGS? Without a sign the reader cannot use this for diagnosis.
  - Fix: State the sign of the offset (positive or negative) and the approximate magnitude if available.

- **[MINOR/structure]** `drafts/05-technical-validation.md:39`
  - Quote: > annual-average agreement at HUC6 ranges from 0.71 (Domestic) to 0.95 (Irrigation), which we take as evidence that the spatial pattern of use is well captured even where the magnitude is biased.
  - Issue: 'We take as evidence' is a softer construction than the section's typical declarative tone. Per writing-general, 'Use definite language; avoid hedging.' Reads stronger as a direct claim.
  - Fix: Rewrite: '...annual-average agreement at HUC6 ranges from 0.71 (Domestic) to 0.95 (Irrigation), demonstrating that the spatial pattern of use is captured even where magnitude is biased.'

- **[MINOR/structure]** `drafts/05-technical-validation.md:9`
  - Quote: > We proceed from coarse to fine and from total to seasonal: first comparing CONUS annual totals, then moving to HUC6 spatial agreement, then to the HUC6 annual scatter and correlation, and finally the CONUS monthly cycle.
  - Issue: Roadmap promises four stages (CONUS annual totals → HUC6 spatial agreement → HUC6 annual scatter/correlation → CONUS monthly cycle), but the actual subsection list is: CONUS annual totals → HUC6 spatial agreement (which itself contains the HUC6 correlation discussion) → Bias diagnosis → Seasonal cycle → Inter-scenario consistency → Limitations. The intro roadmap omits 'Bias diagnosis', 'Inter-scenario consistency', and 'Limitations' -- three of the six subsections. Reader is set up to expect a 4-step structure and gets a 6-step one.
  - Fix: Either expand the roadmap to enumerate all six subsections, or simplify to '...we proceed coarse-to-fine and total-to-seasonal' and drop the explicit list.

- **[MINOR/structure]** `drafts/05-technical-validation.md:48`
  - Quote: > The discontinuity at 2020 between the historical and future lines reflects the switch from the ERA5‑based reanalysis historical run to the TGW-driven future simulations that restart the historical weather sequence with added thermodynamic warming;
  - Issue: 44-word clause with three nested participial phrases ('reflects the switch...', 'TGW-driven future simulations that restart...', 'with added thermodynamic warming'). Parsing is hard at first read.
  - Fix: Split: 'The 2020 discontinuity between historical and future lines reflects the switch from the ERA5-based reanalysis run to the TGW-driven future simulations. TGW restarts the historical weather sequence with added thermodynamic warming.'

- **[MINOR/structure]** `drafts/05-technical-validation.md:32`
  - Quote: > Domestic and Irrigation show sizable sector-level biases in opposing directions at the HUC6 scale, which partially cancel at the CONUS total.
  - Issue: Capitalisation inconsistency: 'Domestic' and 'Irrigation' are capitalised here (and elsewhere as proper categories), but 'irrigation' is lower-case in the same paragraph ('irrigation dominates consumptive use'). Pick one convention and apply throughout the section.
  - Fix: Decide on capitalisation convention (likely lower-case unless used as a Table 1 row label) and apply consistently across the section.

**Boundary summary:**

- *First sentence*: > We validate the downscaled dataset at the three sectors that together account for over 90\% of CONUS water demand: irrigation, thermoelectric, and domestic (public supply)\cite{skinnerWaterWithdrawalConsumption2025}.
- *Last sentence*: > Users coupling the dataset to hydrologic routing should select the appropriate variant for their application.
- *Assumes from prev*: The Methods section has defined the downscaling algorithms (GCAM-USA inputs, Wada R coefficient, GSI temporal disaggregation, source-share carve-outs, conveyance-loss variants) and the scenario matrix; the reader knows what is being validated and how it was produced.
- *Hands off to next*: The validated record (with documented HUC6 biases and limitations) is now characterized; the next section (Usage Notes) can describe how to consume this validated dataset.

### Usage Notes

*PRECIS claim*: Demonstrates xarray loading, unit conversions, and HUC aggregation so users can reproduce sectoral aggregates -- supports the reusability dimension of CLAIM-03.

_1 quote(s) dropped by mechanical Verify (did not resolve to draft)._  
_Counts_: 0 critical, 0 major, 6 minor

- **[MINOR/structure]** `drafts/06-usage-notes.md:18 (main_v3.tex:388)`
  - Quote: > Conversion between the native unit (km$^3$~yr$^{-1}$) and the USGS unit (million gallons per day, MGD): $1\text{ km}^3\text{ yr}^{-1} \approx 723.8\text{ MGD}$ (using $\text{km}^3$\,yr$^{-1}\rightarrow\text{MGD}$ $= 264\,172.05124/365$).
  - Issue: Sentence is a colon-fronted fragment without a finite verb anchoring the subject. The construction 'Conversion between X and Y: $1...\approx...$' uses the colon as a copula and reads as a note rather than prose. The outline lists this as a 'Native unit km^3/yr <-> MGD conversion' point and a prose topic sentence would handle it more cleanly (e.g., 'The native unit km^3 yr^-1 converts to MGD by multiplying by 264172.05124/365 (1 km^3 yr^-1 = 723.8 MGD).').
  - Fix: Rewrite as a complete declarative sentence with a finite verb: 'Users convert from the native unit (km^3 yr^-1) to MGD by multiplying by 264172.05124/365, so 1 km^3 yr^-1 = 723.8 MGD.'

- **[MINOR/structure]** `drafts/06-usage-notes.md:9 (main_v3.tex:379)`
  - Quote: > The dataset is provided in netCDF~4 and is readable in any standard scientific-computing environment.
  - Issue: Opening sentence uses passive voice ('is provided', 'is readable') and hides the actor. Strunk & White rule (active voice) flagged in writing-general SKILL.md. Also 'standard scientific-computing environment' is vague filler relative to the concrete xarray example that follows.
  - Fix: Lead with the actor and the action: 'We distribute the dataset as netCDF-4 files. Users can load any scenario in Python with xarray:'

- **[MINOR/structure]** `drafts/06-usage-notes.md:20 (main_v3.tex:390)`
  - Quote: > HUC-level aggregation is supported in the companion integration meta-repository under \texttt{validation/1-postprocess-tethys.py}, which uses the \texttt{xagg} library to compute overlap-weighted aggregates from the 1/8$^{\circ}$ grid to HUC2, HUC4, HUC6, HUC8, or HUC12 polygons.
  - Issue: Passive 'is supported' hides the actor and weakens the topic sentence of the HUC-aggregation paragraph. The outline names this as a key point so the lead should be active and specific.
  - Fix: Use active voice: 'The companion integration meta-repository provides HUC-level aggregation in validation/1-postprocess-tethys.py, which uses xagg to compute overlap-weighted aggregates from the 1/8 deg grid to HUC2, HUC4, HUC6, HUC8, or HUC12 polygons.'

- **[MINOR/structure]** `drafts/06-usage-notes.md:10-17 (main_v3.tex:380-387)`
  - Quote: > \begin{verbatim} import xarray as xr ds = xr.open_dataset(     "rcp45cooler_ssp3/Domestic_withdrawals_monthly.nc" ) # CONUS total by year and month: total = ds["Domestic"].sum(dim=("lat", "lon")) \end{verbatim}
  - Issue: The xarray block sits inside a single sentence that ends 'A typical workflow in Python:' followed by code, with no closing prose tying the example to the user's takeaway. Outline calls for an 'xarray loading example' but the section never names what the example demonstrates (loading + spatial reduction). A one-line wrap-up sentence after the verbatim block would close the paragraph.
  - Fix: After the verbatim block, add a closing sentence such as: 'The result is a (year, month) DataArray of CONUS-total withdrawals in km^3 yr^-1.'

- **[MINOR/structure]** `drafts/06-usage-notes.md:9 (main_v3.tex:379)`
  - Quote: > A typical workflow in Python:
  - Issue: Sentence fragment used as a code-block lead-in. The outline frames Usage Notes as prose; a fragment + colon + verbatim is a list-style construction the writing-general SKILL flags as 'lazy.' A finite-verb topic sentence would do the work.
  - Fix: Replace with a full sentence: 'A typical Python workflow loads one scenario file and computes a CONUS total:'

- **[MINOR/structure]** `drafts/06-usage-notes.md (transition out)`
  - Quote: > (no closing sentence in section)
  - Issue: Outline specifies 'Transition out: improvements summarize the dataset's advances,' but the section ends on a figure float with no transition sentence handing off to the next section. The handoff to a closing/improvements section is left implicit.
  - Fix: Add a brief closing sentence before the figure or after the HUC paragraph that signals the next section, e.g., 'These workflows make the dataset immediately usable; the remaining advances over prior versions are summarized below.'

**Boundary summary:**

- *First sentence*: > The dataset is provided in netCDF~4 and is readable in any standard scientific-computing environment.
- *Last sentence*: > \caption{Dominant water-use sector at each 1/8$^{\circ}$ cell, by annual-average consumption.}
- *Assumes from prev*: Reader knows the dataset structure (per-scenario folders, monthly netCDF files per sector and water-use type, native units of km^3/yr) and the basic scenario naming (e.g., rcp45cooler_ssp3) established in the Data Records section.
- *Hands off to next*: Hands off to a closing/improvements section that summarizes the dataset's advances; transition is implicit (the figure float ends the section without a prose bridge).

### Improvements over previous version

*PRECIS claim*: Itemizes the six advances over Khan 2023 (state-resolved GCAM-USA, CERF siting, SSP-population, GSI-based irrigation timing, USGS-anchored source shares, 1/2°→1/8° refinement) -- implements CLAIM-05; closing paragraph re-states the partial-cancellation caveat.

_Counts_: 0 critical, 0 major, 6 minor

- **[MINOR/structure]** `drafts/07-improvements-over-previous-version.md:23 (main_v3.tex:416)`
  - Quote: > Together, these six advances produce a dataset that validates well against USGS at HUC6 (annual correlations of 0.71--0.95) and that supports detailed scenario analysis.
  - Issue: The closing paragraph fails to reiterate the 'sector-bias caveat' / partial-cancellation caveat that the outline requires for honesty. The PRECIS explicitly says the closing paragraph should re-state the partial-cancellation caveat, but the draft instead emphasizes that the dataset 'validates well' without acknowledging the well-documented sector-level over/under-estimation that partially cancels at aggregate.
  - Fix: Add a sentence noting that aggregate HUC6 agreement masks compensating sector-level biases (e.g., irrigation overestimate offset by thermoelectric/public-supply underestimate), per CLAIM-05 honesty requirement.

- **[MINOR/structure]** `drafts/07-improvements-over-previous-version.md:23 (main_v3.tex:416)`
  - Quote: > In addition this dataset is validated against the refreshed January 2025 USGS water-use record, which includes updated thermoelectric cooling-water estimates
  - Issue: Phrase 'In addition' is a weak transitional opener after a topic sentence; awkward as the final sentence of the section. The point about the refreshed 2025 USGS record is content-bearing but its placement at the very end (after the validation summary) reads like an addendum rather than an integrated improvement. Consider listing it as a seventh advance or folding it into the USGS-anchored source-share paragraph.
  - Fix: Either promote to a labeled improvement or integrate into the USGS-anchored paragraph; replace 'In addition' with a definite construction.

- **[MINOR/structure]** `drafts/07-improvements-over-previous-version.md:17 (main_v3.tex:410)`
  - Quote: > In consequence, the monthly irrigation distribution varies from year to year and across scenarios, as it should.
  - Issue: 'as it should' is editorializing/hedging filler that adds nothing factual. Strunk & White: omit needless words; use definite language without rhetorical flourish.
  - Fix: Delete 'as it should' or replace with a concrete consequence (e.g., 'tracking interannual drought variability that a static template cannot reproduce').

- **[MINOR/structure]** `drafts/07-improvements-over-previous-version.md:21 (main_v3.tex:414)`
  - Quote: > a factor-of-four improvement in each dimension and 16x improvement in areal resolution
  - Issue: Inconsistent notation: 'factor-of-four' written out but '16x' uses 'x' shorthand. Should be parallel ('factor of 16' or '4x...16x'). Minor but noticeable in publication-grade prose.
  - Fix: Use 'factor-of-16 areal' or '4x linear and 16x areal' for parallel form.

- **[MINOR/structure]** `drafts/07-improvements-over-previous-version.md:13 (main_v3.tex:406)`
  - Quote: > The result is a markedly more realistic spatial distribution of thermoelectric demand
  - Issue: 'markedly' is an adverb that the strong verb does not need; 'more realistic' is comparative without specifying magnitude. Style guide flags weak verb + adverb construction and vague qualifiers.
  - Fix: Replace with concrete claim, e.g., 'The result places thermoelectric demand at actual generation sites rather than at population centroids, correcting decoupling in regions like the lower Colorado and Tennessee Valley.'

- **[MINOR/structure]** `drafts/07-improvements-over-previous-version.md:19 (main_v3.tex:412)`
  - Quote: > In regions with observable baseline data this reduces bias materially; outside those regions, the GCAM share is preserved transparently.
  - Issue: 'materially' and 'transparently' are abstract qualifiers without numbers. The earlier sections in the paper presumably quantify the bias reduction; this paragraph should cite or reference that magnitude rather than asserting it qualitatively.
  - Fix: Replace 'materially' with a number or cross-reference to the validation section; 'transparently' is filler -- delete.

**Boundary summary:**

- *First sentence*: > Compared with the prior Tethys global product, the dataset presented here advances the representation of demand in six specific ways.
- *Last sentence*: > In addition this dataset is validated against the refreshed January 2025 USGS water-use record, which includes updated thermoelectric cooling-water estimates.
- *Assumes from prev*: Reader knows the dataset structure (sectors, scenarios, 1/8 degree CONUS grid), the validation results at HUC6 (correlations 0.71-0.95), the equations for irrigation weights (Eq. irr-weights) and source-share attribution (Eq. source-shares), and the existence of the prior Khan 2023 Tethys global product as the baseline of comparison.
- *Hands off to next*: Sets up that every advance is reproducible from the released code/data, motivating a Code & Data Availability section. Also leaves open that the validation has known sector-level caveats that downstream users should track.

### Code availability

*PRECIS claim*: Provides pointers to every code artifact required to reproduce the dataset (Tethys, integration meta-repository, Demeter, CERF, TGW-WRF) -- supports the reproducibility dimension of CLAIM-03 and CLAIM-05.

_1 quote(s) dropped by mechanical Verify (did not resolve to draft)._  
_Counts_: 0 critical, 0 major, 5 minor

- **[MINOR/structure]** `drafts/08-code-availability.md:9`
  - Quote: > All code used to generate and validate the dataset is publicly available under permissive open-source licenses.
  - Issue: Lead sentence uses passive voice ('is publicly available') and a generic claim ('permissive open-source licenses') without naming the licenses. The Strunk & White rule prefers active voice and concrete details; here the lead would be stronger as 'We release all code...' and could specify the licenses (MIT, BSD, etc.) since this is a Code availability statement where license specificity is load-bearing.
  - Fix: Rewrite in active voice and name the licenses, e.g., 'We release all code under MIT/BSD licenses across the following repositories.' Or, if licenses vary, state that variation explicitly.

- **[MINOR/structure]** `drafts/08-code-availability.md:10-16`
  - Quote: > \begin{itemize}     \item \textbf{Tethys downscaling package}...
  - Issue: The section is entirely a bulleted list with two short framing sentences. While bulleted enumeration is conventional and acceptable for Code/Data availability statements (where reviewers scan for URLs and install commands), the writing-general SKILL flags 'Avoid bullet points and lists unless explicitly requested.' For this section type the bullets are justified, but flag for awareness -- no other prose carries the section's argument.
  - Fix: Acceptable as-is for a Code availability statement. No change required, but if the journal style permits, the framing sentence and trailing PIPELINE.md sentence could be expanded into one short prose paragraph that names each artifact, with URLs in footnotes -- only worth doing if the target journal disfavors bullet lists in availability statements.

- **[MINOR/structure]** `drafts/08-code-availability.md:17`
  - Quote: > To reproduce the published record for one scenario, follow the \texttt{PIPELINE.md} in the integration meta-repository, which documents required inputs, expected outputs, and the command sequence for each stage.
  - Issue: The closing sentence points to PIPELINE.md but does not state whether PIPELINE.md exists in the repository at submission time. The outline lists PIPELINE.md as a key point, but the draft offers no commit hash, tag, or DOI/Zenodo archive for the meta-repository. For a published data paper, the version of code used to generate the archived dataset should be pinned to a release tag or Zenodo DOI, not just 'the integration meta-repository.'
  - Fix: Add a sentence pinning the meta-repository to a specific commit/tag (e.g., 'Release v1.0 archived at Zenodo DOI: ...') so future readers can reproduce the published version even if main branch evolves.

- **[MINOR/structure]** `drafts/08-code-availability.md:11`
  - Quote: > The specific version used for the published dataset is pinned in the scenario YAML config files included with each scenario directory.
  - Issue: Passive voice ('is pinned') hides the actor and the mechanism. Reader needs to know how the version is pinned (a tethys version string in YAML? a git SHA? a pip version?). Without that, 'pinned in the scenario YAML' is vague.
  - Fix: Rewrite as 'Each scenario YAML config records the exact tethys-downscale version (e.g., tethys-downscale==X.Y.Z) used to produce that scenario's outputs.'

- **[MINOR/structure]** `drafts/08-code-availability.md:15`
  - Quote: > \item \textbf{TGW-WRF climate forcing}\cite{Jones2023TGW}: \url{https://tgw-data.msdlive.org/}.
  - Issue: TGW-WRF is climate-forcing data, not code. Listing it under 'Code availability' is a category error; it belongs in Data availability. The outline does include TGW-WRF here, so this issue traces to the outline as well.
  - Fix: Move TGW-WRF to the Data availability section, or rename this section's lead to 'Code and external data sources' if the authors want to keep it consolidated.

**Boundary summary:**

- *First sentence*: > All code used to generate and validate the dataset is publicly available under permissive open-source licenses.
- *Last sentence*: > To reproduce the published record for one scenario, follow the PIPELINE.md in the integration meta-repository, which documents required inputs, expected outputs, and the command sequence for each stage.
- *Assumes from prev*: Reader has just finished the Data availability / Usage notes sections and now expects pointers to the software needed to regenerate or extend the archived dataset; assumes familiarity with Tethys, Demeter, CERF, and TGW-WRF as named in earlier sections (Methods, Forcing inputs).
- *Hands off to next*: Hands off to the References / Acknowledgments / end-matter; closes the reproducibility chain by pointing readers at PIPELINE.md as the entry point for end-to-end execution. No further argumentative section should follow.
