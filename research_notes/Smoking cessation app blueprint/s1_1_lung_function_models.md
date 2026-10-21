# Section 1.1 — Spirometric Lung-Age and FEV1 Decline Models for a Spirometer-less Smoking-Cessation App

Verification legend (read first). Tool conditions this session: WebFetch failed DNS for every host (PubMed, PMC, Europe PMC, doi.org, nature.com, BMJ), direct HTTPS to PubMed/CRAN was refused by the egress proxy, and the shared WebSearch budget was exhausted after one query. GitHub was reachable, so the reference-equation coefficients were taken from machine-readable files in the open-source `rspiro` R package (commit 8d22e84, 2026-04-11). That package redistributes the GLI lookup tables and the published NHANES III/JRS coefficients. Every item carries one of these tags:
- **[V-DATA]**: transcribed this session from machine-readable coefficient files or code. Safe to implement, but still unit-test against the official GLI calculator.
- **[D]**: computed this session from [V-DATA] coefficients (the scripts were run locally).
- **[V-SEARCH]**: confirmed by the one web-search result set retrieved this session (snippet-level only).
- **[R]**: recalled from training knowledge. The citation is believed correct but the paper was NOT re-opened this session. **The report writer must label these numbers "to be verified" or have a human check them against the DOI before they go into product.**

## Q1. Lung-age equations: Morris & Temple 1985, Morris 1971, and later equations and critiques

### Takeaway
Morris & Temple (1985) is a closed-form algebraic inversion of the Morris 1971 linear FEV1 reference equations (height in inches, FEV1 in litres). It is easy to implement, but modern studies show it is systematically biased toward younger lung ages. A defensible 2026 implementation should define lung age as the age at which the race-neutral GLI Global predicted median FEV1 equals the user's (estimated) FEV1, solved numerically. Morris & Temple can be kept only as a legacy cross-check, because it is the equation family used in the Step2quit trial lineage.

### Cited Findings
- **Definition**: "lung age" is the age at which a person's measured FEV1 would equal the predicted (median) value for a healthy non-smoker of the same sex, height (and in older equations, ethnicity). — [V-SEARCH] [AlQerem et al., Curr Respir Med Rev 2018 (PDF)](https://sure.sunderland.ac.uk/id/eprint/10470/1/AlQerem%20et%20al%20CRMR%202018.pdf)
- **Morris JF, Temple W. "Spirometric 'lung age' estimation for motivating smoking cessation." Prev Med 1985;14(5):655–662. DOI 10.1016/0091-7435(85)90085-4.** These were the first published FEV1-based lung-age equations. — [V-SEARCH] for the existence and priority of the paper ([Newbury et al. 2010, PCRJ](https://www.nature.com/articles/pcrj201029)); [R] for the DOI and pages ([doi](https://doi.org/10.1016/0091-7435(85)90085-4))
- **Morris & Temple equations (imperial units; FEV1 in L, height H in inches)** — [R] ([doi](https://doi.org/10.1016/0091-7435(85)90085-4)):
  - Men: `LungAge = 2.87·H_in − 31.25·FEV1 − 39.375`
  - Women: `LungAge = 3.56·H_in − 40.0·FEV1 − 77.28`
  - Metric conversion (H_in = H_cm / 2.54) [D]: Men `LungAge = 1.1299·H_cm − 31.25·FEV1 − 39.375`; Women `LungAge = 1.4016·H_cm − 40.0·FEV1 − 77.28`. These are derived here, not quoted from a source.
- **Morris 1971 parent equations**: Morris JF, Koski A, Johnson LC. "Spirometric standards for healthy nonsmoking adults." Am Rev Respir Dis 1971;103(1):57–67. DOI 10.1164/arrd.1971.103.1.57. — [R] ([doi](https://doi.org/10.1164/arrd.1971.103.1.57))
  - Men: `FEV1(L) = 0.092·H_in − 0.032·Age − 1.260`
  - Women: `FEV1(L) = 0.089·H_in − 0.025·Age − 1.932`
  - **Internal-consistency check [D]**: solving each equation for Age gives exactly the Morris–Temple constants. Men: 0.092/0.032 = 2.875 (published rounded to 2.87), 1/0.032 = 31.25, 1.260/0.032 = 39.375. Women: 0.089/0.025 = 3.56, 1/0.025 = 40, 1.932/0.025 = 77.28. The two independently recalled coefficient sets reproduce each other exactly, which strongly supports both. Primary-text verification is still pending.
- **Bias of Morris 1971 relative to modern references [D]**: predicted FEV1 for a 50-year-old, 175 cm man is 3.479 L (Morris 1971), 3.795 L (GLI-2012 Caucasian), 3.574 L (GLI Global) and 3.790 L (NHANES III Caucasian). For a 50-year-old, 162 cm woman the values are 2.494 / 2.746 / 2.612 / 2.785 L. Morris predicts about 0.1–0.3 L lower, so any measured FEV1 maps to a **younger** lung age. Example: a 175 cm man with FEV1 3.5 L has a Morris lung age of 49.0 y versus 52.5 y by GLI Global inversion. With FEV1 2.5 L the figures are 80.2 y versus 88.3 y. — computed from [V-DATA] GLI/NHANES coefficients ([rspiro data-raw](https://github.com/thlytras/rspiro/tree/8d22e84cc5e67b5377443563d3cad314746e8cbe/data-raw)) plus the [R] Morris coefficients
- **Newbury W, Newbury J, Briggs N, Crockett A. "Exploring the need to update lung age equations." Prim Care Respir J 2010;19(3):242–247 (DOI 10.4104/pcrj.2010.00029 [R])**: in an Australian sample, Morris-based lung ages were younger than chronological age in both never-smokers and current smokers. The authors concluded the equations need review or updating. — [V-SEARCH] [Nature/PCRJ](https://www.nature.com/articles/pcrj201029); [Flinders record](https://researchnow.flinders.edu.au/en/publications/exploring-the-need-to-update-lung-age-equations/)
- An ERS Congress abstract (Mediterranean population) reported that the Morris & Temple FEV1 model underestimated lung age by roughly 12 years on average. — [V-SEARCH] [ERJ 2013;42(Suppl 57):P3942](https://publications.ersnet.org/content/erj/42/suppl57/p3942) (the search summary called it a "2014" study, but the URL is the 2013 congress supplement)
- A Jordanian study (AlQerem et al. 2018) concluded that existing lung-age equations are unreliable for that population. — [V-SEARCH] [AlQerem et al. 2018 PDF](https://sure.sunderland.ac.uk/id/eprint/10470/1/AlQerem%20et%20al%20CRMR%202018.pdf)
- **2022 spline-based lung age**: "Estimation of lung age via a spline method and its application in chronic respiratory diseases" (npj Prim Care Respir Med, Sep 2022). It builds lung-age equations from FEV1, FEF50%, FEF75% and height. — [V-SEARCH] [PMC9522795](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC9522795/); [DOAJ](https://doaj.org/article/1cfbf3b83f6845d08d40f96bfe0a140b)
- **Japanese Respiratory Society (JRS) lung age** (2001 JRS reference-based; used widely in Japanese health checks): Men `LungAge = (0.036·H_cm − 1.178 − FEV1)/0.028`; Women `LungAge = (0.022·H_cm − 0.005 − FEV1)/0.022`. — [R], LOW confidence on the women's constant and its sign. No retrievable URL this session; see Gaps.
- **Modern Japanese reference (for a numerically inverted JRS lung age)**: JRS-2014 LMS equations, Kubota M et al. Respir Investig 2014;52(4):242–250, DOI 10.1016/j.resinv.2014.03.003, valid for ages 17–95. Coefficients are in Q4. — [V-DATA] [rspiro DESCRIPTION](https://github.com/thlytras/rspiro/blob/8d22e84cc5e67b5377443563d3cad314746e8cbe/DESCRIPTION); [getLMS_JRS.R](https://github.com/thlytras/rspiro/blob/8d22e84cc5e67b5377443563d3cad314746e8cbe/R/getLMS_JRS.R)

### Inferences
- The Morris & Temple formula is simply `Age = (a·H + c − FEV1)/b`, i.e. the inverse of a linear reference equation. Any modern reference can be inverted the same way. For LMS/spline equations (GLI) the inversion must be numerical (bisection over age) because there is no closed form. This is trivial on-device: about 300 evaluations at 0.25-year resolution.
- Because Morris 1971 predicts lower FEV1 than GLI-2012/GLI Global, switching from Morris to GLI Global will make displayed lung ages older for the same FEV1. In the 175 cm male example the difference is about 3.5 years at FEV1 3.5 L and about 8 years at 2.5 L. The product should pick one reference and keep it, so that users who re-take the onboarding do not see unexplained jumps.
- GLI predicted FEV1 peaks at about 22.0 y in men and about 20.75 y in women (computed for 175 cm men and 162 cm women [D]). The inverse function is therefore two-valued below that age. Clamp lung age at the peak age (display "≤ 25" or similar).

### Gaps
- The Morris & Temple 1985 and Morris 1971 coefficients could not be checked against the primary PDFs this session (no access). Their exact algebraic consistency is strong but indirect evidence. **Verify before shipping.** It is also unverified whether Morris & Temple published an additional FEF25–75-based lung-age equation.
- "Hansen et al. 2010 ATS lung age from NHANES III": I could not locate or verify any such publication. Do not cite it until someone confirms it exists.
- JRS lung-age formula: the women's intercept (−0.005 vs +0.005) and the original JRS document citation are unverified.
- PCRJ 2010 article "pcrj201058" also appeared in the search results. Its content (possibly a related lung-age commentary or critique) could not be read.
- No paper validating a GLI-based lung-age definition was retrieved. I believe the definition used here (age at which GLI median equals FEV1) is the natural extension, but it is not a published standard.

## Q2. Natural history of FEV1 decline, effects of quitting, dose-response, and sex differences

### Takeaway
The Fletcher–Peto figure is a schematic, not a fitted model. Usable numeric parameters come from the Lung Health Study (LHS) and population cohorts:
- Sustained quitters gain about +47 mL in year 1 and then decline about 30 mL/yr (men) or about 22 mL/yr (women).
- Continuing smokers with mild COPD decline about 62–66 mL/yr (men) or about 54 mL/yr (women).
- The population-average cross-sectional dose-response is about 7.4 mL FEV1 per pack-year in men and 4.4 in women.
- Healthy (GLI Global) median decline is about 23–33 mL/yr in men and about 13–25 mL/yr in women [D]. This agrees closely with the LHS quitter slopes, which is good news for a "quit → return to never-smoker slope" model.
All LHS, cohort and dose-response numbers below are [R]; only the GLI-derived slopes are [D].

### Cited Findings
- **Fletcher C, Peto R. "The natural history of chronic airflow obstruction." BMJ 1977;1(6077):1645–1648. DOI 10.1136/bmj.1.6077.1645.** Based on about 792 working men in West London followed for about 8 years. Main conclusions:
  - (a) Smoking-attributable FEV1 loss is largely irreversible, but stopping smoking returns the subsequent rate of decline toward the non-smoker rate.
  - (b) Only a susceptible minority of smokers lose FEV1 fast enough to become disabled.
  - (c) The iconic figure plots FEV1 as a % of the value at age 25 against age 25–75. It marks "disability" and "death" thresholds and is explicitly illustrative of "a man who is liable to its effects", not a set of fitted parameters.
  - (d) In their data, mucus hypersecretion did not predict FEV1 decline.
  — [R] [doi](https://doi.org/10.1136/bmj.1.6077.1645)
- **LHS-1: Anthonisen NR, Connett JE, Kiley JP, et al. JAMA 1994;272(19):1497–1505. DOI 10.1001/jama.1994.03520190043033.** 5,887 smokers aged 35–60 with mild airflow obstruction, randomised to special intervention (SI) + ipratropium, SI + placebo, or usual care, followed 5 years. SI participants had a smaller FEV1 decline. Sustained quitters had an FEV1 improvement in year 1 and then declined at roughly half the rate of continuing smokers. Ipratropium had no effect on the long-term decline. — [R] [doi](https://doi.org/10.1001/jama.1994.03520190043033)
- **Scanlon PD, Connett JE, Waller LA, et al. "Smoking cessation and lung function in mild-to-moderate COPD: the Lung Health Study." AJRCCM 2000;161(2 Pt 1):381–390. DOI 10.1164/ajrccm.161.2.9901044.** Sustained quitters' FEV1 improved by about **47 mL (≈2% of predicted)** in the first year after quitting. Their subsequent decline was about **31 mL/yr**, half that of continuing smokers at about **62 mL/yr**. Intermittent quitters were intermediate. The post-quit improvement was reported to be larger in women and in heavier smokers (direction recalled; exact values not). — [R] [doi](https://doi.org/10.1164/ajrccm.161.2.9901044)
- **Anthonisen NR, Connett JE, Murray RP. "Smoking and lung function of Lung Health Study participants after 11 years." AJRCCM 2002;166(5):675–679. DOI 10.1164/rccm.2112096.**
  - FEV1 decline: sustained quitters **30.2 mL/yr (men), 21.5 mL/yr (women)**; continuing smokers **66.1 mL/yr (men), 54.2 mL/yr (women)**.
  - At 11 years, about **38% of continuing smokers vs about 10% of sustained quitters** had FEV1 < 60% predicted.
  — [R] [doi](https://doi.org/10.1164/rccm.2112096)
- **Sex difference in LHS: Connett JE, Murray RP, Buist AS, et al. "Changes in smoking status affect women more than men: results of the Lung Health Study." Am J Epidemiol 2003;157(11):973–979. DOI 10.1093/aje/kwg083.** Women who quit had a larger first-year FEV1 gain (in % predicted) than men, and women who kept smoking lost more % predicted per cigarette. Exact magnitudes are unverified. — [R] [doi](https://doi.org/10.1093/aje/kwg083)
- **Kohansal R, Martinez-Camblor P, Agustí A, Buist AS, Mannino DM, Soriano JB. "The natural history of chronic airflow obstruction revisited: an analysis of the Framingham Offspring Cohort." AJRCCM 2009;180(1):3–10. DOI 10.1164/rccm.200901-0047OC.** Using about 4,391 participants with repeated spirometry, they re-plotted Fletcher–Peto-type curves. Findings:
  - Smoking accelerated FEV1 decline in a dose-dependent way.
  - Quitting (especially earlier in life, around ≤40 y) brought decline back toward the never-smoker rate.
  - Women and people with asthma showed different susceptibility.
  - Smoking in adolescence impaired maximal attained lung function.
  — [R] (qualitative only; numeric slopes not recalled reliably) [doi](https://doi.org/10.1164/rccm.200901-0047OC)
- **Lange P, Celli B, Agustí A, et al. "Lung-function trajectories leading to chronic obstructive pulmonary disease." NEJM 2015;373(2):111–122. DOI 10.1056/NEJMoa1411532.** Data came from the Framingham Offspring, Copenhagen City Heart and Lovelace cohorts. Among people who had COPD at the end of follow-up:
  - About half started with a normal FEV1 before age 40 and declined rapidly (**53 ± 21 mL/yr**).
  - The other half started with a low FEV1 (< 80% predicted) and declined at a near-normal rate (**27 ± 18 mL/yr**).
  - Of those with low FEV1 in early adulthood, about **26%** developed COPD, versus about **7%** of those with normal early FEV1.
  — [R] [doi](https://doi.org/10.1056/NEJMoa1411532)
- **Dose-response per pack-year: Dockery DW, Speizer FE, Ferris BG Jr, Ware JH, Louis TA, Spiro A 3rd. "Cumulative and reversible effects of lifetime smoking on simple tests of lung function in adults." Am Rev Respir Dis 1988;137(2):286–292. DOI 10.1164/ajrccm/137.2.286.** Harvard Six Cities, cross-sectional. Average FEV1 deficit: **≈7.4 mL per pack-year in men and ≈4.4 mL per pack-year in women**, with very wide inter-individual variation in response. Quitting was associated with a partial recovery. — [R] [doi](https://doi.org/10.1164/ajrccm/137.2.286)
- **Symptoms as markers of accelerated decline: Vestbo J, Prescott E, Lange P. "Association of chronic mucus hypersecretion with FEV1 decline and COPD morbidity." AJRCCM 1996;153(5):1530–1535. DOI 10.1164/ajrccm.153.5.8630597.** In the Copenhagen City Heart Study, chronic mucus hypersecretion was associated with an **excess FEV1 decline of ≈22.8 mL/yr in men and ≈12.6 mL/yr in women**. This partly contradicts Fletcher–Peto finding (d). — [R] [doi](https://doi.org/10.1164/ajrccm.153.5.8630597)
- **Susceptibility fraction:**
  - Løkke A, Lange P, Scharling H, Fabricius P, Vestbo J. "Developing COPD: a 25 year follow up study of the general population." Thorax 2006;61(11):935–939. DOI 10.1136/thx.2006.062802. In this 25-year follow-up of people with normal baseline lung function, the absolute risk of developing clinically significant COPD among continuous smokers was **at least about 25%**, and about 92% of never-smokers kept normal lung function. — [R] [doi](https://doi.org/10.1136/thx.2006.062802)
  - Rennard SI, Vestbo J. "COPD: the dangerous underestimate of 15%." Lancet 2006;367(9518):1216–1219. DOI 10.1016/S0140-6736(06)68516-4. Argues that the oft-quoted "only 15–20% of smokers get COPD" understates risk, and that a much larger proportion develop measurable impairment with long enough exposure. — [R] [doi](https://doi.org/10.1016/S0140-6736(06)68516-4)
- **Sex differences, meta-analytic:** Gan WQ, Man SFP, Postma DS, Camp P, Sin DD. "Female smokers beyond the perimenopausal period are at increased risk of chronic obstructive pulmonary disease: a systematic review and meta-analysis." Respir Res 2006;7:52. DOI 10.1186/1465-9921-7-52. Female smokers aged over about 45 had a faster annual FEV1 decline than male smokers. — [R] (qualitative; magnitude unverified) [doi](https://doi.org/10.1186/1465-9921-7-52)
- **Healthy (never-smoker) reference decline from GLI Global [D]** (slope of the predicted median; central difference):
  - Men, 175 cm: −24.3 mL/yr at age 30, −23.1 at 40, −29.7 at 50, −32.5 at 60, −28.9 at 70.
  - Women, 162 cm: −13.3, −19.7, −24.8, −24.7 and −21.7 mL/yr at the same ages.
  - GLI-2012 Caucasian slopes are similar or slightly steeper (men 25.6–36.0; women 14.6–28.9 mL/yr).
  — computed from [V-DATA] [getLMS_GLIgl.R](https://github.com/thlytras/rspiro/blob/8d22e84cc5e67b5377443563d3cad314746e8cbe/R/getLMS_GLIgl.R), [GLI Global lookup xlsx](https://github.com/thlytras/rspiro/blob/8d22e84cc5e67b5377443563d3cad314746e8cbe/data-raw/gli_global_lookuptables_dec6.xlsx), [RLookupTable.csv](https://github.com/thlytras/rspiro/blob/8d22e84cc5e67b5377443563d3cad314746e8cbe/data-raw/RLookupTable.csv)

### Inferences
- **Consistency check (useful for the "quit" curve):** LHS sustained quitters' long-term slopes (≈30 mL/yr men, ≈22 mL/yr women, [R]) are within the range of the GLI Global healthy median slopes (≈23–33 men, ≈13–25 women, [D]). So "after quitting, FEV1 follows the GLI never-smoker slope from the new (lower) level" is numerically compatible with LHS data, and the app can derive the quit slope from the reference equation instead of hard-coding it.
- **Excess decline in continuing susceptible smokers:** LHS continuing minus sustained quitters ≈ 66.1 − 30.2 ≈ 36 mL/yr (men) and 54.2 − 21.5 ≈ 33 mL/yr (women) [derived from R values]. This is an upper-range (susceptible, already-obstructed) excess. The LHS population was selected for airflow obstruction, so this should NOT be applied to all smokers.
- **Reconciling LHS with Dockery (mixture-model sanity check):** a 1-pack/day smoker accrues 1 pack-year per year. Dockery's average of 7.4 mL/PY means about 7.4 mL/yr of average excess loss for men. If about 25% of smokers are susceptible (Løkke [R]) and non-susceptible smokers have roughly zero excess, susceptible smokers' excess would be about 7.4/0.25 ≈ 30 mL/yr. That is close to the LHS-derived excess of about 31–36 mL/yr. The two literatures are therefore mutually consistent under a simple two-class (Fletcher–Peto) mixture. This is an inference, not a published parameter.
- **First-year quit bonus (+47 mL)** comes from a mildly obstructed population. Apply it fully only to users with a high probability of obstruction (symptomatic or heavy exposure). For others, use a scaled or smaller bonus or show none. No published value was found for non-obstructed quitters.
- For a 50-year-old 175 cm man, 47 mL corresponds to about 1.6 years of lung age (slope ≈ 29.7 mL/yr [D]). A modest but honest "your lungs got ~1–2 years younger in year one" message is supportable for symptomatic heavy smokers. Larger rejuvenation claims are not.

### Gaps
- All LHS, Kohansal, Lange, Dockery, Vestbo, Løkke and Gan numbers are [R]: I could not open the papers this session. Verify every number against the abstracts before it appears in product copy.
- The exact women's first-year post-quit gain in mL (LHS / Connett 2003) was not recovered. Use "larger in women than men" qualitatively until verified.
- Kohansal 2009 numeric decline rates by smoking status, sex and age at quitting were not recovered.
- No verified FEV1-decline coefficients exist here for e-cigarette, heated-tobacco, oral-tobacco or dual use. Do not convert these into pack-years.
- I found no published estimate of a "first-year bonus" for quitters without airflow obstruction.

## Q3. Evidence that telling smokers their lung age helps them quit: Step2quit and later reviews

### Takeaway
Step2quit (Parkes et al., BMJ 2008) is the key RCT. Telling smokers their spirometric lung age, with a graph, roughly doubled biochemically verified 12-month quit rates (13.6% vs 6.4%; NNT ≈ 14), and the effect did not depend on the result being abnormal. Systematic reviews (Cochrane, Clair 2019) still rate biomedical risk feedback as low-certainty evidence. "Lung age" can be used as a motivational framing, but no large replication supports a strong efficacy claim. Step2quit also used measured spirometry, not an estimate.

### Cited Findings
- **Parkes G, Greenhalgh T, Griffin M, Dent R. "Effect on smoking quit rate of telling patients their lung age: the Step2quit randomised controlled trial." BMJ 2008;336(7644):598–600. DOI 10.1136/bmj.39503.582396.25.** — [R] for every detail below ([doi](https://doi.org/10.1136/bmj.39503.582396.25)):
  - **Design**: RCT in about 5 general practices in Hertfordshire, England. 561 current smokers aged over 35 had spirometry.
  - **Intervention**: results were given as "lung age", with a graphic based on the Fletcher–Peto curve showing the participant's lung age.
  - **Control**: the FEV1 result was given as a raw number, without the lung-age explanation.
  - Both arms were strongly encouraged to quit and offered referral to local NHS stop-smoking services.
  - **Outcome**: independently verified cessation at 12 months, confirmed by salivary cotinine. About 89% retention.
  - **Result**: 13.6% vs 6.4% quit; difference 7.2% (95% CI 2.2% to 12.1%; P = 0.005); NNT ≈ 14.
  - Quit rates in the intervention arm were reportedly similar whether lung age was normal or abnormal.
  - The lung-age equation used is believed to be Morris & Temple (unverified).
- **Clair C, Mueller Y, Livingstone-Banks J, et al. "Biomedical risk assessment as an aid for smoking cessation." Cochrane Database Syst Rev 2019;3:CD004705. DOI 10.1002/14651858.CD004705.pub5.** The review covers feedback of spirometry/lung age, CO, genetic susceptibility, imaging and similar. It concluded that the evidence is mostly low or very-low certainty and insufficient to show that biomedical risk feedback increases quitting. Spirometry/lung-age feedback is a small subgroup in which Step2quit is the most positive trial. — [R] [doi](https://doi.org/10.1002/14651858.CD004705.pub5)
- **Kotz D, Wesseling G, Huibers MJH, van Schayck OCP. "Efficacy of confronting smokers with airflow limitation for smoking cessation." Eur Respir J 2009;33(4):754–762. DOI 10.1183/09031936.00116308.** In smokers with newly detected airflow limitation, confrontation with spirometry results added no significant benefit over counselling. — [R] [doi](https://doi.org/10.1183/09031936.00116308)

### Inferences
- The Step2quit effect came from measured spirometry plus a GP letter and a graph. An app that estimates lung age from questionnaire data lacks personal "objective evidence", which may be the active ingredient. Treat any efficacy carry-over as a hypothesis and A/B-test it.
- The finding that quit rates did not differ between normal and abnormal results supports showing lung age to everyone, not only high-risk users. Copy should avoid implying "your lungs are fine, so smoking is OK" when the estimated lung age is near chronological age (a known "false reassurance" risk).
- Design cues to replicate: a single clear number (lung age vs real age), a Fletcher–Peto-style curve with the user's position marked, an immediate referral or offer of a cessation service, and a quit date.

### Gaps
- I could not verify Step2quit's exact wording, the graph design, the lung-age equation used, the cotinine cut-off, or the normal-vs-abnormal subgroup numbers. The trial's figure or supplement should be checked.
- Clair 2019: the pooled RR and trial count for the spirometry subgroup were not recovered.
- Any replications or meta-analyses from 2020–2026 (including app-based or estimated lung age) were not searched. The web-search budget was exhausted.

## Q4. Reference equations: GLI-2012 LMS, GLI Global 2022, ATS/ERS guidance, NHANES III, JRS-2014, ethnicity/region, and licensing

### Takeaway
GLI-2012 and GLI Global both use the LMS form `M = exp(a0 + a1·ln(Ht_cm) + a2·ln(Age) [+ ethnic terms] + Mspline(Age))`, with S and L analogues and z = ((x/M)^L − 1)/(L·S). Exact coefficients for adults are below [V-DATA]. GLI Global (Bowerman 2023) is race-neutral and has been recommended by the ATS (2023), so it is the right default for a global app. Region-specific options are JRS-2014 for Japanese users and, if needed, the GLI-2012 ethnic coefficients. NHANES III (Hankinson 1999) is a simple polynomial alternative for US populations; its exact coefficients are below [V-DATA].

### Cited Findings
- **Citations** — DOIs [V-DATA] via the [rspiro DESCRIPTION](https://github.com/thlytras/rspiro/blob/8d22e84cc5e67b5377443563d3cad314746e8cbe/DESCRIPTION); full bibliographic details [R]:
  - GLI-2012: Quanjer PH, Stanojevic S, Cole TJ, et al. "Multi-ethnic reference values for spirometry for the 3–95-yr age range: the global lung function 2012 equations." Eur Respir J 2012;40(6):1324–1343. DOI 10.1183/09031936.00080312. Built from about 74,000 healthy never-smokers from about 33 countries ([R] for the counts).
  - GLI Global: Bowerman C, Bhakta NR, Brazzale D, et al. "A race-neutral approach to the interpretation of lung function measurements." AJRCCM 2023;207(6):768–774. DOI 10.1164/rccm.202205-0963OC.
  - NHANES III: Hankinson JL, Odencrantz JR, Fedan KB. "Spirometric reference values from a sample of the general U.S. population." AJRCCM 1999;159(1):179–187. DOI 10.1164/ajrccm.159.1.9712108.
  - JRS-2014: Kubota M, Kobayashi H, Quanjer PH, et al. Respir Investig 2014;52(4):242–250. DOI 10.1016/j.resinv.2014.03.003.
- **GLI-2012 LMS structure (exact code)** — [V-DATA] [getLMS.R](https://github.com/thlytras/rspiro/blob/8d22e84cc5e67b5377443563d3cad314746e8cbe/R/getLMS.R):
  - `L = q0 + q1·ln(Age) + Lspline`
  - `M = exp(a0 + a1·ln(Ht_cm) + a2·ln(Age) + a3·AfrAm + a4·NEAsia + a5·SEAsia + a6·Other + Mspline)`
  - `S = exp(p0 + p1·ln(Age) + p2·AfrAm + p3·NEAsia + p4·SEAsia + p5·Other + Sspline)`
  - The spline values come from a lookup table at 0.25-year steps (ages 3–95), linearly interpolated: `spline = v0 + (v1 − v0)·(Age − agebound)/0.25`, where agebound = floor(4·Age)/4.
  - The ethnic indicators are 0/1. Caucasian is the reference (all zero).
- **z-score and LLN** — [V-DATA] [zscores_GLI.R](https://github.com/thlytras/rspiro/blob/8d22e84cc5e67b5377443563d3cad314746e8cbe/R/zscores_GLI.R), [LLN_GLI.R](https://github.com/thlytras/rspiro/blob/8d22e84cc5e67b5377443563d3cad314746e8cbe/R/LLN_GLI.R):
  - `z = ((x/M)^L − 1)/(L·S)`
  - `LLN (5th centile) = exp(ln(M) + ln(1 − 1.645·L·S)/L)`
  - Inverse, for a target z: `x = M·(1 + L·S·z)^(1/L)` [D, algebraic].
- **GLI-2012 FEV1 coefficients (adults; Ht in cm, Age in years)** — [V-DATA] [RLookupTable.csv](https://github.com/thlytras/rspiro/blob/8d22e84cc5e67b5377443563d3cad314746e8cbe/data-raw/RLookupTable.csv):

  | Sex | a0 | a1 (lnHt) | a2 (lnAge) | a3 AfrAm | a4 NE Asian | a5 SE Asian | a6 Other | p0 | p1 (lnAge) | p2 AfrAm | p3 NEA | p4 SEA | p5 Other | q0 | q1 (lnAge) |
  |---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
  | Male FEV1 | −10.3420 | 2.2196 | 0.0574 | −0.1589 | −0.0351 | −0.0881 | −0.0708 | −2.3268 | 0.0798 | 0.1096 | −0.3973 | 0.0327 | 0.0114 | 0.8866 | 0.0850 |
  | Female FEV1 | −9.6987 | 2.1211 | −0.0270 | −0.1484 | −0.0149 | −0.1208 | −0.0708 | −2.3765 | 0.0972 | 0.1016 | −0.0109 | 0.0733 | 0.0114 | 1.1540 | 0 |
  | Male FVC | −11.2281 | 2.4135 | 0.0865 | −0.1684 | −0.0405 | −0.1177 | −0.0825 | −2.2963 | 0.0718 | 0.0794 | −0.4600 | 0.0325 | −0.0503 | 0.9481 | 0 |
  | Female FVC | −10.4030 | 2.2633 | 0.0234 | −0.1555 | −0.0262 | −0.1516 | −0.0833 | −2.3549 | 0.1017 | 0.0810 | −0.1809 | 0.0459 | −0.0503 | 0.8236 | 0 |

  FEV1 Lspline = 0 at all adult ages in the table. FEV1 Mspline / Sspline at selected agebounds (m0 / s0):
  - Male: 20: 0.2081 / −0.0901; 25: 0.1899 / −0.0844; 30: 0.1495 / −0.0625; 40: 0.0721 / −0.0596; 50: −0.0125 / −0.0240; 60: −0.1143 / 0.0671; 70: −0.2328 / 0.1698; 80: −0.3512 / 0.2538; 90: −0.4586 / 0.3260.
  - Female: 20: 0.1839 / −0.0627; 25: 0.1753 / −0.0780; 30: 0.1590 / −0.0909; 40: 0.1040 / −0.0892; 50: 0.0232 / −0.0345; 60: −0.0741 / 0.0492; 70: −0.1926 / 0.1389; 80: −0.3226 / 0.2231; 90: −0.4446 / 0.2985.
  - The full table has 369 rows per sex per parameter, ages 3–95.
- **Ethnic multipliers implied by GLI-2012 FEV1 [D]** (exp(coefficient), relative to Caucasian):
  - Male: AfrAm 0.853, NE Asian 0.966, SE Asian 0.916, Other/mixed 0.932.
  - Female: AfrAm 0.862, NE Asian 0.985, SE Asian 0.886, Other/mixed 0.932.
- **GLI-2012 group definitions** [R]: "North East Asian" covers Korea and China north of the Huaihe River–Qinling Mountains line. "South East Asian" covers Thailand, Taiwan and China south of that line (including Hong Kong). "Other/mixed" is used for groups not represented, including South Asians/Indians and mixed ancestry. — [R] [doi](https://doi.org/10.1183/09031936.00080312)
- **GLI Global (race-neutral) FEV1 and FVC equations (exact code)** — [V-DATA] [getLMS_GLIgl.R](https://github.com/thlytras/rspiro/blob/8d22e84cc5e67b5377443563d3cad314746e8cbe/R/getLMS_GLIgl.R):
  - Male FEV1: `M = exp(−11.399108 + 2.462664·ln(Ht_cm) − 0.011394·ln(Age) + Mspline)`; `S = exp(−2.256278 + 0.080729·ln(Age) + Sspline)`; `L = 1.22703`
  - Female FEV1: `M = exp(−10.901689 + 2.385928·ln(Ht_cm) − 0.076386·ln(Age) + Mspline)`; `S = exp(−2.364047 + 0.129402·ln(Age) + Sspline)`; `L = 1.21388`
  - Male FVC: `M = exp(−12.629131 + 2.727421·ln(Ht) + 0.009174·ln(Age) + Mspline)`; `S = exp(−2.195595 + 0.068466·ln(Age) + Sspline)`; `L = 0.9346`
  - Female FVC: `M = exp(−12.055901 + 2.621579·ln(Ht) − 0.035975·ln(Age) + Mspline)`; `S = exp(−2.310148 + 0.120428·ln(Age) + Sspline)`; `L = 0.899`
  - FEV1/FVC: male `M = exp(1.022608 − 0.218592·ln(Ht) − 0.027586·ln(Age) + Mspline)`, `S = exp(−2.882025 + 0.068889·ln(Age) + Sspline)`, `L = 3.8243 − 0.3328·ln(Age)`; female `M = exp(0.9189568 − 0.1840671·ln(Ht) − 0.0461306·ln(Age) + Mspline)`, `S = exp(−3.171582 + 0.144358·ln(Age) + Sspline)`, `L = 6.6490 − 0.9920·ln(Age)`
- **GLI Global FEV1 spline values (Mspline / Sspline; Lspline = 0)** — [V-DATA] [gli_global_lookuptables_dec6.xlsx](https://github.com/thlytras/rspiro/blob/8d22e84cc5e67b5377443563d3cad314746e8cbe/data-raw/gli_global_lookuptables_dec6.xlsx). The workbook has six sheets (Male/Female × FEV1/FVC/FEV1FVC), one row per 0.25 year, ages 3–95.
  - Male: 20: 0.146601 / −0.050874; 25: 0.147244 / −0.052816; 30: 0.121250 / −0.046372; 40: 0.066296 / −0.021369; 50: −0.001884 / 0.009634; 60: −0.092396 / 0.040633; 70: −0.190811 / 0.069004; 80: −0.283142 / 0.094172; 90: −0.366044 / 0.116495.
  - Female: 20: 0.118399 / −0.038399; 25: 0.127551 / −0.054393; 30: 0.121830 / −0.063902; 40: 0.087996 / −0.052727; 50: 0.021965 / −0.012312; 60: −0.065223 / 0.037213; 70: −0.157595 / 0.084868; 80: −0.245459 / 0.127729; 90: −0.325115 / 0.165883.
- **QA test vectors [D]** (computed this session from the coefficients above; check against the official GLI calculator before release):

  | Case | GLI Global M / LLN (L) | GLI-2012 Caucasian M / LLN (L) | NHANES III Caucasian pred (L) |
  |---|---|---|---|
  | Male 175 cm, 25 y | 4.181 / 3.271 | 4.466 / 3.599 | 4.438 |
  | Male 175 cm, 50 y | 3.574 / 2.695 (S = 0.1450) | 3.795 / 2.961 | 3.790 |
  | Male 175 cm, 70 y | 2.947 / 2.154 | 3.104 / 2.243 | 3.116 |
  | Female 162 cm, 25 y | 3.061 / 2.362 | 3.258 / 2.618 | 3.239 |
  | Female 162 cm, 50 y | 2.612 / 1.929 (S = 0.1541) | 2.746 / 2.142 | 2.785 |
  | Female 162 cm, 70 y | 2.127 / 1.484 | 2.193 / 1.598 | 2.247 |

  GLI-2012 at 50 y, by group (male 175 cm / female 162 cm): NE Asian 3.665 / 2.705; SE Asian 3.475 / 2.434; Other 3.536 / 2.558; AfrAm 3.238 / 2.367.
- **NHANES III (Hankinson 1999) FEV1 polynomial** — [V-DATA] [NHtb45.csv](https://github.com/thlytras/rspiro/blob/8d22e84cc5e67b5377443563d3cad314746e8cbe/data-raw/NHtb45.csv), [pred_NHANES3.R](https://github.com/thlytras/rspiro/blob/8d22e84cc5e67b5377443563d3cad314746e8cbe/R/pred_NHANES3.R):
  - `FEV1_pred(L) = b0 + b1·Age + b2·Age² + b3·Ht_cm²`
  - `LLN = same b0, b1, b2, + b3_LLN·Ht_cm²`

  | Group (adult) | b0 | b1 (Age) | b2 (Age²) | b3 pred (Ht²) | b3 LLN (Ht²) | R² |
  |---|---|---|---|---|---|---|
  | Caucasian male | 0.5536 | −0.01303 | −0.000172 | 0.00014098 | 0.00011607 | 0.851 |
  | Caucasian female | 0.4333 | −0.00361 | −0.000194 | 0.00011496 | 0.00009283 | 0.749 |
  | African-American male | 0.3411 | −0.02309 | 0 | 0.00013194 | 0.00010561 | 0.808 |
  | African-American female | 0.3433 | −0.01283 | −0.000097 | 0.00010846 | 0.00008546 | 0.669 |
  | Mexican-American male | 0.6306 | −0.02928 | 0 | 0.00015104 | 0.00012670 | 0.854 |
  | Mexican-American female | 0.4529 | −0.01178 | −0.000113 | 0.00012154 | 0.00009890 | 0.727 |

  - The paediatric rows exist in the same file, e.g. Caucasian male <20 y: −0.7453, −0.04106, 0.004477, 0.00014098.
  - NHANES III FEV1/FVC (%): Caucasian male `88.066 − 0.2066·Age` (LLN `78.388 − 0.2066·Age`); Caucasian female `90.809 − 0.2125·Age` (LLN `81.015 − 0.2125·Age`). — [V-DATA] [NHtb6.csv](https://github.com/thlytras/rspiro/blob/8d22e84cc5e67b5377443563d3cad314746e8cbe/data-raw/NHtb6.csv)
  - **Caveat**: rspiro switches to the adult rows at age ≥20 for both sexes. In the paper, females switch at 18 ([R]).
- **JRS-2014 FEV1 (Japanese adults, 17–95 y)** — [V-DATA] [getLMS_JRS.R](https://github.com/thlytras/rspiro/blob/8d22e84cc5e67b5377443563d3cad314746e8cbe/R/getLMS_JRS.R); splines in the Respir Investig supplement (rspiro data-raw `1-s2.0-S2212534514000288-mmc1.xlsx`):
  - Male: `M = exp(−7.5722 + 1.9393·ln(Ht_cm) − 0.3068·ln(Age) + Mspline)`; `S = exp(−3.0440 + 0.2325·ln(Age) + Sspline)`; `L = 1`
  - Female: `M = exp(−6.9428 + 1.8053·ln(Ht_cm) − 0.3401·ln(Age) + Mspline)`; `S = exp(−3.1024 + 0.2537·ln(Age) + Sspline)`; `L = 0.7783`
  - Note: rspiro looks up JRS splines at integer-year age bounds.
- **Where the official tables live**: the GLI initiative publishes lookup tables for IT engineers and manufacturers on the ERS education site. — [V-DATA] [rspiro README acknowledgement](https://github.com/thlytras/rspiro/blob/8d22e84cc5e67b5377443563d3cad314746e8cbe/README.md) → [GLI IT-engineers page](https://www.ers-education.org/guidelines/global-lung-function-initiative/spirometry-tools/it-engineers-and-manufacturers/)
- **Licensing**:
  - The `rspiro` code is **GPL (≥2)**. Copying its code into a closed-source app would trigger GPL obligations. — [V-DATA] [DESCRIPTION](https://github.com/thlytras/rspiro/blob/8d22e84cc5e67b5377443563d3cad314746e8cbe/DESCRIPTION)
  - GLI coefficient and lookup tables are published as journal supplements and as free downloads for manufacturers. My understanding is that GLI permits free implementation and asks implementers to validate against GLI test data. — [R]; terms not verified this session
- **ATS 2023 statement**: Bhakta NR, Bime C, Kaminsky DA, et al. "Race and ethnicity in pulmonary function test interpretation: an official American Thoracic Society statement." AJRCCM 2023;207(8):978–995. DOI 10.1164/rccm.202302-0310ST. It recommends replacing race- or ethnicity-specific reference equations with race-neutral average equations (GLI Global) for PFT interpretation. — [R] [doi](https://doi.org/10.1164/rccm.202302-0310ST)
- **ERS/ATS 2022 interpretive standard**: Stanojevic S, Kaminsky DA, Miller MR, et al. "ERS/ATS technical standard on interpretive strategies for routine lung function tests." Eur Respir J 2022;60(1):2101499. DOI 10.1183/13993003.01499-2021. It recommends GLI equations, interpretation by z-score with LLN = z −1.645, and severity grading by z-score: mild −1.65 to −2.5, moderate −2.5 to −4, severe < −4. It recommends against % predicted and fixed cut-offs. — [R] [doi](https://doi.org/10.1183/13993003.01499-2021)

### Inferences
- **Default for a global app: GLI Global.** It needs only age, sex and height, so the app does not have to ask ethnicity for the lung model (a UX and fairness win). It matches the 2023 ATS direction and is valid for ages 3–95. Region-specific options:
  - Japan: JRS-2014 is national and validated.
  - Optional research setting: GLI-2012 with ethnic coefficients, used only if a regional advisor requires it.
  - South Asia/India: no GLI-2012 group fits. Use GLI Global, with a note that local studies suggest population-specific differences.
- GLI Global gives predictions about 5–6% below GLI-2012 Caucasian [D: 3.574/3.795 = 0.942 men and 2.612/2.746 = 0.951 women, at age 50]. Users of European ancestry will therefore get slightly younger lung ages with GLI Global than with GLI-2012.
- Implementation tip: ship the GLI Global FEV1 lookup (370 rows × 2 sexes × 3 values ≈ 2–3 kB) as a bundled JSON. Unit-test the six QA vectors above against the official GLI calculator, and also check them against a fresh build of a validated library.

### Gaps
- The text of the GLI licence and terms of use was not read this session. Legal review should confirm commercial-use terms on the GLI/ERS site.
- Adoption of GLI Global in 2024–2026 (ERS position, NHS/ARTP, Canadian Thoracic Society, Asian societies, lab vendors) could not be searched.
- No South Asian/Indian-specific equation was verified. Candidate: Chhabra SK et al., Indian J Chest Dis Allied Sci 2014 (north Indian adults) [R, unverified]. It is also unverified whether GLI Global under- or over-predicts for Indian adults.
- The Bowerman 2023 derivation details (how the ethnic groups were weighted) are [R], not verified.

## Q5. Estimating FEV1 without a spirometer: smoking-attributable deficit, susceptibility, and symptom screeners

### Takeaway
No validated published model predicts an individual's FEV1 from questionnaire data alone with useful precision. Healthy between-person variation is large: SD ≈ M·S ≈ 0.52 L for a 50-year-old 175 cm man, which is about 17 years of lung age [D]. It dwarfs the average smoking-attributable deficit (≈7.4 mL/PY in men [R], so 30 PY ≈ 0.22 L ≈ 7.5 lung-age years). The defensible approach is therefore a population-expected deficit: `expected FEV1 = GLI Global median − E[deficit | pack-years, sex, symptoms]`. Symptoms raise the probability that the user belongs to the "susceptible" class, using published screeners (COPD-PS, LFQ, CDQ, CAPTURE) as the structural template.

### Cited Findings
- **Population-average dose-response** — [R] [Dockery 1988](https://doi.org/10.1164/ajrccm/137.2.286): ≈7.4 mL/PY (men) and ≈4.4 mL/PY (women).
- **Excess decline in susceptible continuing smokers** — [R] [Anthonisen 2002](https://doi.org/10.1164/rccm.2112096) and [Scanlon 2000](https://doi.org/10.1164/ajrccm.161.2.9901044): ≈31–36 mL/yr above quitters in a mildly obstructed population.
- **Susceptibility prior** — [R] [Løkke 2006](https://doi.org/10.1136/thx.2006.062802): ≥25% of continuous smokers develop clinically significant COPD over 25 years. [Rennard & Vestbo 2006](https://doi.org/10.1016/S0140-6736(06)68516-4) argues 15% is an underestimate.
- **Chronic mucus hypersecretion (morning cough/phlegm)** — [R] [Vestbo 1996](https://doi.org/10.1164/ajrccm.153.5.8630597): excess decline ≈22.8 mL/yr (men) and ≈12.6 mL/yr (women).
- **COPD Population Screener (COPD-PS)**: Martinez FJ, Raczek AE, Seifer FD, et al. COPD 2008;5(2):85–95. DOI 10.1080/15412550801940721. Five self-scored items (dyspnoea frequency, productive cough, activity limitation from breathing, ≥100 lifetime cigarettes, age band), scored 0–10, with ≥5 suggesting airflow obstruction. — [R] [doi](https://doi.org/10.1080/15412550801940721)
- **Lung Function Questionnaire (LFQ)**: Yawn BP, Mapel DW, Mannino DM, et al. Int J Chron Obstruct Pulmon Dis 2010;5:1–10. DOI 10.2147/COPD.S7683. Five items (age, smoking pack-years, mucus, wheeze, dyspnoea); a score of ≤18 suggests risk of airflow obstruction. — [R] [doi](https://doi.org/10.2147/COPD.S7683)
- **COPD Diagnostic Questionnaire (CDQ / IPAG)**: Price DB, Tinkelman DG, Halbert RJ, et al. Respiration 2006;73(3):285–295. DOI 10.1159/000090142. Eight items including age, pack-years, BMI, weather-related cough, phlegm, morning phlegm, wheeze and allergy history, with score bands for COPD likelihood. — [R] [doi](https://doi.org/10.1159/000090142)
- **CAPTURE**: Martinez FJ, Mannino D, Leidy NK, et al. "A new approach for identifying patients with undiagnosed chronic obstructive pulmonary disease." AJRCCM 2017;195(6):748–756. DOI 10.1164/rccm.201603-0622OC. A five-item questionnaire plus peak expiratory flow, designed to find clinically significant COPD. A 2023 JAMA validation reported modest sensitivity and high specificity (exact values unverified). — [R] [doi](https://doi.org/10.1164/rccm.201603-0622OC)
- **Healthy variability [D]** (from verified GLI Global S):
  - Man, 175 cm, 50 y: S = 0.1450, so the approximate SD at the median is M·S = 3.574 × 0.145 ≈ 0.52 L ≈ 17.5 lung-age years at a 29.7 mL/yr slope.
  - Woman, 162 cm, 50 y: S = 0.1541, giving SD ≈ 0.40 L ≈ 16 years.
  - A 0.3 L deficit corresponds to z ≈ −0.57 (man, 50 y) or z ≈ −0.74 (woman, 50 y). A 0.6 L deficit gives z ≈ −1.13 / −1.45. None of these is below the LLN (z −1.645).
- **Lung-age sensitivity [D]** (GLI Global years per 100 mL deficit):
  - Men, 175 cm: 4.1 years at 30 y, 4.3 at 40, 3.4 at 50, 3.1 at 60, 3.5 at 70.
  - Women, 162 cm: 7.5, 5.1, 4.0, 4.0 and 4.6 years at the same ages.
  - Worked example, man 175 cm aged 50: deficits of 0 / 0.2 / 0.4 / 0.6 L give lung ages of 50.0 / 56.5 / 62.5 / 69.0 y (z 0 / −0.38 / −0.76 / −1.13).

### Inferences
- **Recommended deficit model (two-class Fletcher–Peto mixture). The structure is evidence-based; the calibration constants are DESIGN PARAMETERS, not published values.**
  - `PY = (CPD/20) × (Age − AgeStarted)`. Subtract quit-years if collected.
  - `p_sus = logistic(β0 + β1·[chronic morning cough/phlegm] + β2·[dyspnoea grade] + β3·log(PY) + β4·[age ≥ 50])`.
    - Prior for heavy long-term smokers: ≈0.25 ([R] Løkke).
    - Calibrate β1–β4 against COPD-PS/LFQ-style item weights, or better, against an external dataset with spirometry (e.g. NHANES 2007–2012 or UK Biobank). Do not hard-code made-up odds ratios.
  - `E[deficit] = p_sus × D_sus + (1 − p_sus) × D_nonsus`.
    - Anchor: the population mean must reproduce ≈7.4 mL/PY in men and ≈4.4 mL/PY in women (Dockery [R]).
    - With D_nonsus ≈ 0, this implies D_sus ≈ 7.4/p_prior ≈ 30 mL/PY for men (≈18 for women). That is consistent with the LHS excess-decline magnitude.
  - Cap the deficit so that the estimated FEV1 does not go below about z −2.5 (moderate) without measured spirometry. A questionnaire cannot justify a "severe" estimate.
- **Symptoms**:
  - Chronic morning cough/phlegm can add a Vestbo-style excess (≈22.8 mL/yr in men, ≈12.6 in women, [R]) multiplied by the symptomatic years, or simply shift p_sus. Pick one so the effect is not double-counted.
  - Dyspnoea should raise p_sus, and should also trigger a "see a clinician / get spirometry" prompt. A screener such as COPD-PS ≥5 (or equivalent) should route the user to real testing.
- **Inputs that should not enter the FEV1 model**:
  - Time to first cigarette is a nicotine-dependence measure. Use it for cessation support intensity, not for lung function.
  - Vaping and oral tobacco have no validated FEV1 coefficient. Do not add them to pack-years. Show neutral, evidence-limited messaging.
- Because individual uncertainty (±17 years at 1 SD) is larger than the signal (≈5–10 years for typical heavy smokers), the most honest primary metric is the **"smoking-attributable lung-age gap"**: E[deficit] ÷ local reference slope = expected extra years. An "absolute lung age" can be shown as `chronological age + gap`, with a visible uncertainty band.

### Gaps
- No published, validated questionnaire → FEV1 (continuous) regression was found or verified. The screeners above predict a binary airflow-obstruction label, not FEV1 in litres.
- Screener item weights, cut-offs and accuracy (sensitivity/specificity) are [R] and must be verified before calibration.
- Per-pack-year deficits from modern cohorts (e.g. UK Biobank, CanCOLD, PLCO), and the shape of the dose-response (linear vs non-linear at >40 PY), were not retrieved.
- Effects of passive smoking, occupational exposure, biomass, prior TB and asthma (all relevant for a global audience) are not modelled here.

## Q6. Recommended formula pipeline, trajectory projection, and uncertainty/claims framing

### Takeaway
Pipeline:
1. Predicted FEV1 from GLI Global (verified coefficients).
2. Expected current FEV1 = predicted − mixture-model smoking deficit.
3. Lung age by numerical inversion of the GLI Global median, clamped to the peak age and to 95.
4. Two projected trajectories: continue smoking (reference slope + susceptible excess, weighted by p_sus) versus quit now (one-time first-year gain, scaled by p_sus, then reference slope).
Every output must be labelled an educational estimate, with a band and a prompt to get real spirometry.

### Cited Findings
- **Step 1, predicted FEV1**: GLI Global male and female FEV1 equations and splines (Q4). — [V-DATA] [getLMS_GLIgl.R](https://github.com/thlytras/rspiro/blob/8d22e84cc5e67b5377443563d3cad314746e8cbe/R/getLMS_GLIgl.R)
- **Step 3, inversion target and helper formulas** (z-score, LLN, inverse z): — [V-DATA] [zscores_GLI.R](https://github.com/thlytras/rspiro/blob/8d22e84cc5e67b5377443563d3cad314746e8cbe/R/zscores_GLI.R)
- **Step 4 slopes**:
  - Never-smoker / quitter decline: the GLI Global median slope [D]. This matches the LHS quitter slopes of about 30.2 (men) and 21.5 (women) mL/yr. — [R] [Anthonisen 2002](https://doi.org/10.1164/rccm.2112096)
  - Susceptible continuing-smoker decline: about 62–66 (men) and 54 (women) mL/yr in LHS ([R] [Scanlon 2000](https://doi.org/10.1164/ajrccm.161.2.9901044), [Anthonisen 2002](https://doi.org/10.1164/rccm.2112096)) and 53 ± 21 mL/yr in the Lange rapid-decline trajectory ([R] [Lange 2015](https://doi.org/10.1056/NEJMoa1411532)).
  - First-year quit gain: +47 mL ([R] Scanlon 2000).
- **Clinical interpretation framework** (z-score bands, LLN): [R] [Stanojevic 2022](https://doi.org/10.1183/13993003.01499-2021)
- **Motivational framing precedent** (Fletcher–Peto-style graph with lung age): [R] [Parkes 2008](https://doi.org/10.1136/bmj.39503.582396.25), [Fletcher & Peto 1977](https://doi.org/10.1136/bmj.1.6077.1645)

### Inferences
**Engineer-ready pseudocode.** Coefficients are from Q4. Items marked `DESIGN` are tunable parameters, not literature values.

```
inputs: age (y), sex, height_cm, cpd, age_started, chronic_cough (bool), dyspnea_grade (0–4), region
PY        = (cpd/20) * max(0, age - age_started)

# 1. Reference (GLI Global; JRS-2014 if region == Japan)
L, M, S   = gli_global_LMS(age, height_cm, sex)            # [V-DATA]
# slope_ref(age) = (M(age+0.5) - M(age-0.5)), from the same equation  [D]

# 2. Expected smoking deficit (two-class mixture)
p_sus     = calibrated_logistic(PY, chronic_cough, dyspnea_grade, age)   # DESIGN; prior ~0.25 [R Lokke]
beta_pop  = 7.4 mL/PY (male) | 4.4 mL/PY (female)                        # [R Dockery 1988]
D_sus     = beta_pop / p_prior                                           # DESIGN (mixture identity)
deficit   = p_sus * D_sus * PY                                           # litres after /1000
deficit   = min(deficit, M - M*(1 + L*S*(-2.5))**(1/L))                  # cap at z = -2.5 (DESIGN)
FEV1_est  = M - deficit

# 3. Lung age (numerical inverse of the GLI Global median)
lung_age  = bisect(a in [peak_age(sex,height) ~ 21-22, 95]: M(a, height_cm, sex) == FEV1_est)
            # clamp: FEV1_est >= M(peak) -> show "<= 25"; FEV1_est < M(95) -> show "95+"
gap_years = lung_age - age          # primary display metric
band      = lung_age at FEV1_est ± 0.674*M*S   # 50% band (DESIGN) — shows real uncertainty

# 4. Trajectories, t = years from now
continue: FEV1(t) = FEV1_est + Σ slope_ref(age+k) - p_sus * excess * t
          excess  = ~0.031–0.036 L/yr (men), ~0.033 L/yr (women)   # [R LHS derived]
quit:     FEV1(t) = FEV1_est + p_sus * 0.047 [year 1 only] + Σ slope_ref(age+k)   # [R Scanlon]
# Plot both on a Fletcher–Peto-style axis (% of FEV1 at age 25) with an LLN line (z = -1.645) and a z = -2.5 line.
```

- **Validation of the pipeline**: before launch, run it on a dataset that has both questionnaire and spirometry (e.g. NHANES 2007–2012 public-use files) to calibrate p_sus and measure the error of FEV1_est and lung age. Report the mean absolute error in years in the app's "how we calculate this" page.
- **Claims framing**:
  - Present the output as "estimated lung age based on people like you", never as "your lung age". Avoid "diagnosis", "COPD" or "normal/abnormal" labels without measured spirometry.
  - Show the uncertainty band. Without measured spirometry, the 50% band alone is about ±12 years for a 50-year-old man (0.674 × 17.5 [D]).
  - Pair every result with an "ask for spirometry" call-to-action. This also preserves the Step2quit mechanism (real measurement).
- **Regulatory**: an estimate that drives no clinical decision and is labelled educational is more likely to stay outside medical-device rules than one that claims to detect disease. This is an inference only; I did not research regulatory guidance (FDA SaMD, EU MDR) in this task.
- **Optional legacy mode**: show the Morris & Temple lung age only if the team wants to mirror the Step2quit trial. Document that it runs younger than the GLI-based lung age.

### Gaps
- The calibration coefficients for p_sus (β0–β4) are not available from the literature in the form needed. They must be fitted on external data with spirometry.
- How a +47 mL first-year gain should scale for non-obstructed smokers is unknown, as is the time course of any further gains after year 1.
- I found no published validation of any questionnaire-only "lung age" estimator. The pipeline above is a reasoned design, not a validated instrument.
- Uncertainty propagation (combining the healthy SD, the deficit-model error and p_sus uncertainty) should be done by Monte Carlo once the calibration data exist. Only the reference-SD component is quantified here.
