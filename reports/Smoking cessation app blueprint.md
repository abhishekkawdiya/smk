# Build the Quit-Smoking App the Evidence Supports

*Master clinical, mathematical, behavioral and technical blueprint for a global iOS and Android smoking-cessation and lung-health visualization app. Research date: 21 October 2026.*

**The app can be built today from verified parts, but its most marketable features are its least proven ones, so the build order must follow evidence gates rather than the feature list.** The parts with strong support are ACT-style acceptance of bodily urges (iCanQuit beat a guideline app, 28.2% vs 21.1% at 12 months, OR 1.49), a transparent six-item rules score that triggers tailored messages (Smart-T beat QuitGuide on verified 26-week abstinence, 16.4% vs 10.0%), label-quoted NRT reminders that never calculate a dose, and slip handling that never erases cumulative progress. The hero features are weaker. No trial has tested a questionnaire-estimated lung age, a 3D lung avatar or a reversible-toxicity dashboard. Machine-learning craving prediction reaches a median AUC of only about 0.64–0.75 for new users. The largest Approach Bias Modification trial was null. Microphone exhale detection in noise has no benchmark. Under the Fischbach & Walsh framework the project therefore scores **red as scoped and yellow-to-green** once it fixes one parameter (adult daily smokers ready to quit; CO-verifiable abstinence) and runs five cheap gates in months 0–6 (two gate-zero checks and three go/no-go experiments). The engineering artifacts below are ready to build: race-neutral GLI Global lung-age equations with verified coefficients and test vectors; a two-number Recovery Index (formerly Bio-Toxicity) in which only four parameters reach grade A; three-tier exposure weights for vapes, heated tobacco, bidis, hookah and smokeless products; an original 12-tap onboarding rubric; a Rive Data Binding state machine with color and haptic specifications; an encrypted SQLite schema; an on-device JITAI ladder; and a sub-100 ms breath-detection DSP pipeline. On regulation, FDA's 6 January 2026 General Wellness revision makes room for wellness trends from wearables. Lung Age remains the riskiest claim under EU MDR's "prediction, prognosis" wording, so every output must be presented as an estimate with a range and never with normal/abnormal bands. Plan for a pragmatic relative risk of 1.2–1.5, not the "nearly 3×" headline. A credible pivotal RCT needs about 2,000–7,000 participants and 18–30 months.

### How to read evidence status in this report

The research team could not open full texts. PubMed, PMC, doi.org, Cochrane, FDA and EU hosts were unreachable, and web-search budgets ran out. Every number therefore carries a provenance tag. **Do not present a [PK] number as confirmed.**

| Tag | Meaning | Engineering use |
|---|---|---|
| **[V]** | Confirmed this session from search-result text of the source, abstracts, registries, or primary pages fetched directly (Apple and Android developer docs, Rive docs source, package registries). "[V, snippet]" marks secondary summaries such as law-firm alerts | Citable. Re-check exact figures against the full text before publication |
| **[V-DATA]** | Transcribed from machine-readable files (the `rspiro` GLI/NHANES/JRS coefficient tables; pub.dev, npm and Maven version metadata) | Implementable. Unit-test against official calculators |
| **[D]** | Derived or computed by the research team from [V]/[V-DATA] inputs | Reproducible. Re-check the arithmetic |
| **[PK]** | Recalled from prior knowledge. The citation is believed correct but the paper was not re-opened (covers the notes' "recalled", "[M]" and "UNVERIFIED" tags) | **Do not ship until verified** (see the checklist at the end) |
| **[M]** | Model or design parameter: a tunable assumption, not a literature value | Expose as configuration and A/B test |
| **[R]** | Research team's recommendation or judgment | Design decision. Revisit at each gate |
| **Grade A–D** | Section 1.2 only. A = primary, adequately powered, population-matched; B = primary but small or indirect; C = secondary or extrapolated; D = unsourced | Show a provenance badge for each grade. Grade D must not ship |

### Where the brief's premises were corrected or unsupported

| Premise in the brief | What the evidence shows | Section |
|---|---|---|
| Quit Genius is "now part of Bicycle" | Not confirmed. It rebranded as Pelago (Series C, March 2024) | 0.1 |
| The January 2026 BMJ EBM meta-analysis supports "apps ~3×" | The review is real (Chu 2026, 31 RCTs). RR 2.85 comes from 4 small studies at low certainty, and the authors call it exploratory. Cochrane 2019 found RR 1.00 | 0.3, 2.0 |
| 2025–2026 meta-analyses show app + NRT/varenicline/cytisine synergy | No such source. The only evidence is Chu 2026's app + medication vs medication comparison (RR 1.77, low certainty, I² 86%) and JMIR 2023 (OR 1.79, 3 trials) | 2.6 |
| Cochrane NMA pharmacotherapy effects are risk ratios | They are **odds ratios with credible intervals** (e-cigarettes 2.37, varenicline 2.33, cytisine 2.21) | 2.6 |
| Cytisine joined the WHO EML around 2023; cytisinicline is US-available | Cytisine was added in the **2025** (24th) list. The **FDA issued a CRL on 22 June 2026**; cytisinicline is not approved | 2.6 |
| Fletcher–Peto gives fitted curve parameters | The figure is a **schematic**. Slopes come from the Lung Health Study, Dockery, Vestbo and Lange (all recalled) and from GLI-derived healthy slopes | 1.1 |
| Ethnicity/region should adjust baseline FEV1 | GLI Global is race-neutral and needs only age, sex and height. Region selects the reference (JRS-2014 in Japan) rather than adding a multiplier | 1.1 |
| "Hansen 2010 ATS NHANES lung age" | Could not be located. Do not cite | 1.1 |
| Weaver 2000 gives the COHb room-air half-life | **74 ± 25 min is on 100% oxygen.** Daytime room-air exhaled-CO half-life is ~4.5 h (Sandberg 2011) | 1.2 |
| Cotinine t½ ≈ 16 h; COHb% ≈ 0.16 × ppm; CFK equation | None verified. CFK not retrieved. The only regression found is from CO-poisoning patients and must not be used | 1.2 |
| FEF25-75 marks small-airway damage; VO2max deficits are quantifiable | FEF25-75 is **normal** in preserved-airflow small-airway dysfunction (AJRCCM 2025). No VO2max number was retrieved | 1.2 |
| Cilia recover in 1–9 months; taste returns in days | The cilia clause is a secondary accretion; WHO's rendering omits it. Nasal clearance normalized by day 15 in one study. Smell improved by 45 days; no taste data | 1.2 |
| Bidis weigh 0.25–0.5 of a cigarette | No source. The only published convention is **1 bidi = 1 cigarette**, and bidi smokers have higher breath CO | 1.3 |
| Primack 2016 hookah meta-analysis is in NTR; Chung 2019 shows PG/VG harm | Primack is in *Public Health Reports*. Chung 2019's main finding is **nicotine via TRPA1** | 1.3 |
| "Cravings pass in 3–5 minutes" | No primary source. Use "urges rise and fall; many ease within minutes" | 2.1 |
| Logging every cigarette disrupts striatal habit circuits | No evidence. Logging is measurement and awareness. McFall 1970 suggests logging cigarettes can even increase smoking | 2.2 |
| ApBM swipe training reduces smoking | **Largely null.** Wittekind 2026 (AJP, n=351): 19.3% vs 17.4% sham vs 16.2% TAU. CBM meta-analysis g = 0.08 | 2.5 |
| A 180-second move bout is evidence-based | The shortest effective doses found were 5 min isometric and 15 min light exercise. 180 s is an entry point only | 2.5 |
| FTND cutoffs/wording are free to reuse | Public-domain status is not confirmed and cutoffs conflict across forms. Use original items with HSI factual bands | 3.1 |
| Quitter's flu peaks in weeks 2–4 | Ussher 2003 found symptom increases at **weeks 1–2**, resolved by about 6 weeks | 4.2 |
| Drive the Rive avatar with state-machine Inputs | **Inputs are deprecated** in favor of Data Binding (View Models) | 4.3 |
| Use `sqlcipher_flutter_libs` for encryption | **End-of-life** (`0.7.0+eol`). Use `sqlite3` 3.x build hooks (`source: sqlcipher` or `sqlite3mc`) | 5.2 |
| Citation details | DOI corrections: Baker 2007 → 10.1080/14622200701673480; Bickel 1999 → 10.1007/PL00005490; Brewer 2011 → 10.1016/j.drugalcdep.2011.05.027 [PK]. Journal corrections: Papathanasiou 2007 → *Eur J Cardiovasc Prev Rehabil*; Machulska 2016 → *J Psychiatr Res*; MTSS → *Drug Alcohol Depend*. Breeze → *IMWUT* 2019, not CHI [PK]. PIV → TOCHI 2020 (PIV++ is CHI 2020). Unconfirmed: Johnson 2010 FMD trial's JACC attribution; Crane 2019 *Addiction* DOI; Bowen & Marlatt DOI | various |

## Section 0. Problem selection: a red-light project until it fixes one parameter and runs five early gates

This section applies the Fischbach & Walsh (Cell 2024) problem-selection framework: risk and assumption analysis, an optimization function, a parameter strategy, go/no-go experiments, and a decision tree with pivots. It comes first because its verdict changes how every later section should be read. **As scoped, with about 12 features fixed together, the project scores RED.** Seven assumptions sit at risk 4 (10–40% likely true), several more sit at 3–4, and the main efficacy readout arrives 18–30 months after first patient in. It becomes YELLOW-to-GREEN if the team fixes the user segment and outcome, lets mechanisms float through a MOST optimization, and runs five cheap gates in months 0–6: a regulatory claims check and a microphone bench test (gate zero), plus three go/no-go experiments on retention, the visualization mechanism and JITAI predictability.

### 0.1 The market has commoditized trackers; only ACT and app-plus-pharmacotherapy have RCT support

Few cessation apps have randomized evidence, and the strongest consumer-app result is iCanQuit. iCanQuit is Fred Hutch's acceptance and commitment therapy (ACT) app, now licensed to 2Morrow Inc. In a trial of **N=2,415 adults from all 50 US states, it beat NCI QuitGuide on self-reported 30-day point-prevalence abstinence (PPA) at 12 months** ([Fred Hutch](https://www.fredhutch.org/en/news/releases/2020/09/fred-hutch-led-clinical-trial-shows-new-smartphone-app-helps-smokers-quit.html); [NAQC](https://www.naquitline.org/news/531843/Efficacy-of-Smartphone-Applications-for-Smoking-Cessation-A-Randomized-Clinical-Trial.-.htm)) [V]. **Abstinence was 28.2% vs 21.1% (OR 1.49, 95% CI 1.22–1.83; NNT 14)** ([Fred Hutch](https://www.fredhutch.org/en/news/releases/2020/09/fred-hutch-led-clinical-trial-shows-new-smartphone-app-helps-smokers-quit.html); [AAFP POEM](https://www.aafp.org/afp/2021/0401/p441)) [V]. Participants opened iCanQuit about 37 times over 12 months versus about 10 for QuitGuide, and logins, minutes and unique days all serially mediated the effect ([Bricker 2021, DOI 10.2196/32847](https://mhealth.jmir.org/2021/11/e32847/PDF)) [V]. The mechanism contrast matters for Section 2: iCanQuit teaches acceptance and urge surfing; QuitGuide teaches avoidance of high-risk situations.

The most-downloaded standalone app shows how hard the problem is. In the Smoke Free pragmatic RCT (N=3,143, self-reported 6-month continuous abstinence at 7 months), **the intention-to-treat result was 6.8% vs 7.0%, RR 0.97 (95% CI 0.75–1.26)**, with effective follow-up of only 41.9% ([Jackson 2024, DOI 10.2196/50963](https://jmir.org/2024/1/e50963); [medRxiv](https://medrxiv.org/content/10.1101/2023.01.12.23284463.full.pdf)) [V]. **Only 25.3% of people offered the app downloaded it.** Among downloaders, abstinence was 12.7% vs 7.0% (RR 1.80), but that comparison selects on uptake and is not randomized [V]. Uptake and engagement, not content, are the binding constraint in self-directed populations.

The larger effects come from apps bundled with humans or medication. Quit Genius (now Pelago) reported **22.6% vs 13.2% self-reported 7-day PPA at 52 weeks (RR 1.71)** against very brief advice, but in a CO-verified subset of 280 the difference was significant at 26 weeks and **not at 52 weeks (p=.16)**; the trial was company-funded ([Webb 2022, DOI 10.1093/ntr/ntac113](https://pmc.ncbi.nlm.nih.gov/articles/PMC9597001)) [V]. Pivot (personal CO sensor, app, text coaching, community, with 12 weeks of free NRT in both arms) reported **biochemically confirmed continuous abstinence of 19% vs 9% at 52 weeks, P=.046** ([Marler 2023](https://mhealth.jmir.org/2023/1/e48157/PDF)) [V]; the lead author is company staff and no analysis isolates the sensor. The brief's premise that Quit Genius is "now part of Bicycle" was not confirmed: sources show a rebrand to Pelago and a $58M Series C in March 2024, not an acquisition ([Dealroom](https://app.dealroom.co/companies/pelago_formerly_quit_genius_); [MobiHealthNews](https://www.mobihealthnews.com/news/digital-addiction-treatment-company-quit-genius-scores-64m)) [V]. No FDA clearance for a smoking-cessation app itself appeared in search results; Pivot's 510(k) covers its CO breath sensor (Section 6.1). The one regulator-approved prescription cessation app known is Japan's CureApp SC (Masaki 2020, npj Digit Med, DOI 10.1038/s41746-020-0243-5), reported at about 63.9% vs 50.5% continuous abstinence at weeks 9–24 when added to clinic varenicline/NRT care [PK, unverified]. Text messaging has the strongest pooled mobile evidence: **Cochrane 2019 RR 1.54 (1.19–2.00), 13 studies, moderate certainty** ([Cochrane CD006611.pub5](https://cochranelibrary.com/cdsr/doi/10.1002/14651858.CD006611.pub5/information)) [V].

The implication is that the "tracker plus milestones" layer (money saved, days smoke-free, recovery timeline) is commoditized and does not move pragmatic ITT outcomes, and a lung avatar alone is not a moat. Treat iCanQuit (about 28% self-reported 30-day PPA at 12 months) and Pivot (about 19% CO-verified continuous at 52 weeks with NRT) as ceiling benchmarks, not floors.

### 0.2 Measured lung age worked once; estimated lung age and reversible-toxicity dashboards are untested

Step2quit (Parkes et al., BMJ 2008;336:598–600, DOI 10.1136/bmj.39503.582396.25) told 561 primary-care smokers aged ≥35 their spirometry-measured lung age and reported **verified 12-month quit of 13.6% vs 6.4%** (NNT about 14) [PK, unverified]. Quit rates were reportedly similar whether lung age was normal or abnormal, which suggests personalized attention rather than threat drove the effect [PK]. Cochrane (Clair 2019, CD004705.pub5) found insufficient evidence that most biomedical-risk feedback increases cessation, with spirometric lung age positive in a single trial [PK]. **No RCT of a questionnaire-estimated lung age, a 3D lung avatar, or a reversible-toxicity dashboard was found.** The blueprint's core motivational hook is untested, its effect is probably smaller than Step2quit's (no measurement, no clinician, already-motivated users), and until data say otherwise the visualization should be justified as an engagement and feedback loop rather than an efficacy mechanism.

### 0.3 Plan for a pragmatic RR of 1.2–1.5, not the 2.85 headline

Pooled app evidence is conflicting and low certainty. **Cochrane 2019 found smartphone apps vs lower-intensity support RR 1.00 (0.66–1.52), 5 studies, very low certainty** ([Cochrane abstract](https://cochranelibrary.com/cdsr/doi/10.1002/14651858.CD006611.pub5/pdf/CDSR/CD006611/CD006611_abstract.pdf)) [V]. A JMIR 2023 meta-analysis of 9 RCTs (N=12,967) found apps vs comparators OR 1.25 (0.99–1.56, not significant) and **app plus pharmacotherapy vs pharmacotherapy alone OR 1.79 (1.38–2.33), 3 trials** ([J Med Internet Res 2023;25:e43242](https://www.jmir.org/2023/1/e43242)) [V]. The January 2026 BMJ Evidence-Based Medicine review (Chu et al., online 13 Jan 2026, DOI 10.1136/bmjebm-2025-113971; 31 RCTs, N=12,802, searched to 15 Aug 2025) reported **RR 2.85 for apps alone vs no/minimal support (4 studies, n=1,402, low certainty) and RR 1.98 as an add-on (4 studies, n=2,163, I²=85.7%, low certainty)**, and the authors call the findings hypothesis-generating ([ebm.bmj.com](https://ebm.bmj.com/content/31/4/242); [BMJ press release](https://bmjgroup.com/phone-apps-nearly-3-times-as-good-as-no-basic-support-for-quitting-smoking-long-term/)) [V]. Do not use "2–3× quit rates" in marketing or planning.

Realistic targets follow. App alone, pragmatic ITT, CO-verified 6-month sustained abstinence: **about 6–10% vs 4–7% in control (absolute gain 1–3 points, RR about 1.2–1.5)**. With NRT bundled: about 12–20%, anchored on Pivot. Self-reported 30-day PPA at 12 months in a motivated trial sample: about 20–28%, anchored on iCanQuit. Unaided long-term success is about 3–5% (Hughes 2004, DOI 10.1111/j.1360-0443.2004.00540.x) [PK].

A credible pivotal RCT needs an active comparator (QuitGuide, the NHS app, or brief advice plus NRT signposting), Russell Standard 6-month sustained abstinence (West 2005, DOI 10.1111/j.1360-0443.2004.00995.x: 2-week grace period, ≤5 cigarettes total, biochemical verification at final follow-up, missing counted as smoking) [PK], remote witnessed CO verification as Pivot did, anabasine or cotinine where NRT or e-cigarettes confound (SRNT 2020, Benowitz et al., DOI 10.1093/ntr/ntz132, which recommends lower CO cut-offs of about 5–6 ppm) [PK], at least 70–80% follow-up, and preregistration. The researcher's sample-size computation (two-arm, two-sided α=0.05, ITT) is below [D].

| Control CO-verified 6-mo sustained abstinence | Target RR | n/arm, 80% power | n/arm, 90% power |
|---|---|---|---|
| 5% | 1.3 | 3,780 | 5,060 |
| 5% | 1.5 | 1,471 | 1,969 |
| 7% | 1.3 | 2,634 | 3,526 |
| 7% | 1.5 | 1,022 | 1,368 |
| 10% | 1.3 | 1,774 | 2,375 |
| 10% | 1.5 | 686 | 918 |
| 10% | 1.8 | 295 | 394 |

That means **about 2,000–3,000 total for RR 1.5 and 5,000–7,000 for RR 1.3, with 18–30 months to readout.** The recommended staged path is MOST (Collins 2018, DOI 10.1007/978-3-319-72206-1) [PK]: preparation in months 0–6, a 2^k factorial screening with micro-randomized trials (Klasnja 2015, DOI 10.1037/hea0000305) in months 6–18, an optional SMART that escalates early lapsers to NRT or coaching, and the pivotal RCT in months 18–36.

### 0.4 Retention, not content, is the dominant practical risk

In real-world panel data on 93 mental-health apps, **median 15-day retention was 3.9% and 30-day retention 3.3%, and breathing-exercise apps had median day-30 retention of 0.0% and 1.6% daily active users** ([Baumel 2019, DOI 10.2196/14567](https://www.jmir.org/2019/9/e14567)) [V]. Peer-support apps kept about 8.9% at day 30, mindfulness 4.7% and trackers 6.1%. That breathing figure directly constrains the 0.1 Hz breathing feature: embed it inside urge-surfing and craving-SOS flows rather than shipping it as a destination. Streak counters that reset on a lapse can trigger the abstinence-violation effect and an uninstall, so lapse handling is a retention feature as much as a clinical one. HeartSteps (Klasnja 2019, DOI 10.1093/abm/kay067) and Bidargaddi 2018 (DOI 10.2196/10123) show notification effects decay [PK], so the combined JITAI plus EMA load needs hard caps, tuned later by MRT: Section 2.2 sets **≤3 proactive risk prompts per day** (the Sense2Stop dose) and a separate EMA budget of ≤4/day during the baseline, 3/day in the first two post-quit weeks and 1–2/day after that. No cessation-specific D7/D30 benchmark and no data on dropout immediately after a logged lapse were found; instrument both from day 1.

### 0.5 Assumption analysis: 25 assumptions, seven at risk 4, one late readout

Risk scale: 1 = >90% likely true; 2 = 70–90%; 3 = 40–70%; 4 = 10–40%; 5 = <10%. "Time" is months until the team can know if a test starts now. Ratings are the researcher's judgment calibrated on the cited evidence [R].

| # | Assumption (Type A: behavioral and biological reality) | Risk | Time (mo) | Calibrating evidence |
|---|---|---|---|---|
| A1 | Reversible acute harm (COHb, HR, endothelium, cilia) motivates young smokers more than Lung Age | **4** (3 for "at all") | 3–4 | No head-to-head; gain frames only slightly better for prevention (Gallagher & Updegraff 2012, r≈0.08) [PK] |
| A2 | Questionnaire-estimated Lung Age reproduces Step2quit | **4** | 3–4 | Step2quit used measured FEV1 plus a clinician [PK] |
| A3 | Displayed recovery timelines are defensible per user | 2 COHb / 3 endothelium / **4** cilia, HR | 1–2 | CO half-life is hours; FMD +1 point at 1 year (Johnson 2010, DOI 10.1016/j.jacc.2010.03.002) [PK] |
| A4 | Logging every cigarette reduces consumption | 3–4 | 2–3 | McFall 1970: logging cigarettes smoked can increase smoking, logging urges resisted decreases it [PK] |
| A5 | ACT urge surfing as implemented improves cessation | **2** | 1–2 proximal; 9–12 distal | iCanQuit OR 1.49 [V] |
| A6 | 0.1 Hz breathing bridges an urge | 3 | 1–2 | McClernon 2004 small acute effects [PK]; breathing apps D30 0.0% [V] |
| A7 | Smartphone ApBM swipe training reduces smoking | **4** | 3–6 | Boffo 2019 IPD meta-analysis: no robust CBM effect on behavior [PK] |
| A8 | BE framing without real money increases abstinence | 3–4 | 3–6 | Real incentives work; deposit contracts about 14% uptake (Halpern 2015, DOI 10.1056/NEJMoa1414293) [PK] |
| A9 | Lapse handling prevents lapse→relapse and lapse→dropout | 3 | 3–6 | Kirchner 2012; Kenford 1994 [PK] |
| A10 | In-app NRT support improves correct use and abstinence | 2–3 | 3–6 | App + pharmacotherapy OR 1.79 [V]; Pivot [V] |
| A11 | Phenotype onboarding beats a common path | 3–4 | 6 | No app-specific evidence |
| A12 | Enough users stay ≥30 days to get an effective dose | **4** | 2–4 | D30 3.3% [V]; Smoke Free uptake 25.3% [V] |
| A13 | Personalized JITAI from 5–7 days of EMA reaches AUC ≥0.75, PPV ≥0.3 | **4** | 4–6 | Perski 2023 group models generalize poorly [PK]; pre/post-quit distribution shift |
| A14 | Users sustain ≥3 EMA/day for ≥4 weeks | 3–4 | 2–3 | Habituation [PK] |
| A15 | ~10 components are additive, not burden-diluting | **4** | 9–12 | No evidence for a 10-component stack |
| A16 | CO-verified 6-month RR ≥1.3 vs active comparator | **4** | **18–30** | Cochrane RR 1.00 [V]; Smoke Free RR 0.97 [V] |

| # | Assumption (Type B: technical capability) | Risk | Time (mo) | Calibrating evidence |
|---|---|---|---|---|
| B1 | Phone mic detects exhalation ≥90% in quiet, ≥80% at 60–70 dBA | 2 quiet / **4** noisy | 1–2 | Nam 2016 respiratory rate from built-in mic, controlled settings [PK] |
| B2 | On-device personalization fits battery and privacy budgets | 2 | 2–3 | Data quantity (A13), not compute, binds |
| B3 | Background passive sensing with acceptable consent | 3 | 1–2 | OS limits (inference) |
| B4 | Wellness positioning survives "Lung Age", "toxicity index", "craving prediction", "NRT support" | 3 US / **4** EU/UK | 1–3 | CureApp regulated as a device; MDR Rule 11 [PK] |
| B5 | 3D lung avatar ≥30 fps on 2–3 GB Android | 2 | 1 | Standard engineering |
| B6 | Toxicity index from self-report has defensible uncertainty bands | 3 | 1–2 | Under-reporting; puff topography varies; show ranges |
| B7 | Remote biochemical verification is feasible in target countries | 2–3 | 3–6 | Pivot remote CO worked [V]; online follow-up 41.9% [V] |
| B8 | Localization covers languages, local products and NRT availability | 3 | 3–6 | >100M vapers; men >80% of users ([WHO 2025](https://www.who.int/news/item/06-10-2025-who-tobacco-trends-report-1-in-5-adults-still-addicted-to-tobacco)) [V] |
| B9 | GDPR special-category compliance through on-device processing | 2 | 1–2 | Inference |

**All five framework red flags are present.** There are multiple miracles (7 assumptions at a clean risk 4: A1, A2, A7, A12, A13, A15, A16). The distal efficacy test is late (A16). There are dependency chains: **A13 (JITAI) ← A14 (EMA compliance) ← A12 (retention) → A16 (efficacy)**, and **B4 (regulatory) → A2 (personal Lung Age allowed at all)**. Ostrich-pattern risk is high, because the most enjoyable and lowest-risk work (the avatar, B5) tempts the team to build first while retention, mechanism and prediction stay untested. And the brief is a "use X to do Y in Z" technique-application statement that fixes system, tool, application and regulatory route at once. The green-light features are that the highest-evidence components (ACT, A5; NRT support, A10) are low risk, several high-risk assumptions can be tested in under 6 months, and ApBM, BE framing and JITAI are droppable without killing the product.

### 0.6 Five gates in months 0–6 decide what gets built

| Gate | Months | Experiment | Go criterion | No-go → pivot |
|---|---|---|---|---|
| **0a Regulatory claims (B4)** | 0–2 | Claims matrix of every on-screen and store string; written opinions for US (FDA wellness), EU (MDR Rule 11, MDCG 2019-11), UK (MHRA); test submissions to both stores | All launch claims classifiable as non-device or wellness | P1: replace personal Lung Age with illustrative education |
| **0b Mic exhalation bench (B1)** | 1–2 | 30 participants × 4 noise conditions (<40, ~50, ~65, ≥70 dBA) × ≥6 phones; reference chest belt or nasal thermistor | ≥90% phase agreement quiet, ≥80% at ~65 dBA, false-exhale <10% | P2: haptic/visual pacer only |
| **#1 Retention and dose (A12, A14)** | 1–4 | Minimal MVP (light logging, ACT urge surfing, SOS with embedded breathing, lapse handling, one visualization) in 2–3 markets, ≥2,000 installs; analyze quit-date setters | D30 ≥15% **and** ≥40% reach minimum effective dose (e.g., ≥3 urge-tool uses + ≥5 active days in 2 weeks post-quit) **and** EMA ≥60% at week 4 | D30 8–15% → P4 (add human/SMS, strip features); D30 <8% → stop/rethink |
| **#2 Visualization mechanism (A1–A3)** | 1–4 | Online 2×2 factorial, n≈1,200 daily smokers (~50% aged 18–29): estimated Lung Age on/off × reversible-toxicity dashboard on/off | A factor raises 4-week quit attempts ≥5 points (RR ≥1.25) with no rise in reactance | P5: visualization becomes engagement layer only |
| **#3 JITAI predictability (A13)** | 2–6 | 8-week EMA + passive-sensing cohort, n≈120, ~6 EMA/day; train per-user on days 1–7, test on post-quit days 8–42 | Median within-person AUC ≥0.75 for craving ≥7/10 or lapse in next 60–120 min; at ≤3 prompts/day PPV ≥0.30 and sensitivity ≥0.50; EMA ≥65% at week 4 | P3: rule-based risk windows + one-tap SOS; JITAI moves to v2 MRT |

The Gate #1 thresholds are researcher heuristics set at about 4–5× the Baumel median because quit-date setters are motivated; no cessation-specific benchmark exists. Detecting a 10%→15% D30 difference between two onboarding variants needs about 690 per arm, and Gate #2's factorial gives about 600 vs 600 per main effect, enough to detect 20%→27.5% quit attempts at 80% power (n=505 per group) [D]. **No 3D-avatar polish should happen until Gate #2 reads out.**

### 0.7 Optimization function: life-years per 1,000 installs, dominated by the engagement multiplier

The framework's invention/application metric is "how much good × for how many people". The proposed custom metric is **incremental CO-verified 6-month quitters per 1,000 installs, cost per incremental quitter, and age-weighted life-years per quitter** [R]. Reach potential is high: WHO counts **1.2 billion tobacco users in 2024 and more than 100 million vapers**, with men more than four in five users ([WHO, 6 Oct 2025](https://www.who.int/news/item/06-10-2025-who-tobacco-trends-report-1-in-5-adults-still-addicted-to-tobacco)) [V]. Realized reach is installs × quit-date setting × D30 engagement, so the default is non-use. Depth per quitter is very high: quitting at 25–34 gains about 10 years and at 35–44 about 9 (Jha 2013, DOI 10.1056/NEJMsa1211128) [PK]. As a worked illustration rather than a forecast, per million users who start a quit attempt, an app adding 1–3 points to a 3–5% unaided baseline yields **about 10,000–30,000 additional long-term quitters, or roughly 60,000–270,000 life-years before relapse discounting** [D]. Doubling the fraction of users who reach the effective dose is worth more than any single content feature. On equity, an English-first, iOS-first launch optimizes the wrong population; low-end Android performance and SMS/WhatsApp fallbacks matter for the "global" claim.

### 0.8 Parameter strategy: fix segment and outcome, float everything else

| Parameter | Current brief | Recommendation |
|---|---|---|
| User segment + outcome | Implicit ("global smokers") | **FIXED**: adults ≥18 who smoke daily and intend to quit within 30 days; outcome = CO-verifiable sustained abstinence; proximal = 4-week abstinence, quit attempts |
| Core mechanisms (avatar, toxicity index, JITAI, ApBM, mic, BE, phenotyping) | Fixed bundle | FLOAT, decided by MOST screening |
| Hero visualization | Both fixed | FLOAT, decided by Gate #2 |
| Prediction engine | On-device JITAI fixed | FLOAT: rule-based first, JITAI after MRT |
| Sensor modality | Mic fixed | FLOAT: mic, haptic-only, or wearable HR |
| Channel | iOS/Android DTC | Semi-fixed; can float to B2B (quitlines, employers, pharmacies, lung-cancer screening) or SMS/WhatsApp |
| Regulatory route | General wellness | Fix for v1 with claims engineered to fit; keep an evidence-ready device/DiGA path |
| Geography | Global | FLOAT: 2–3 launch markets with verification infrastructure, then expand |

Fixing segment-plus-outcome suits a product team whose edge is iteration speed and consumer UX. If the team's real edge is the visualization technology, the alternative is to fix the tool and float the application (lung-cancer screening, primary-care spirometry, adolescent prevention, vaping cessation). These are different projects, and the team should choose explicitly.

### 0.9 Decision tree and pivots

| Trigger | Likelihood / impact | Pivot | Upside |
|---|---|---|---|
| **P1** Lung Age or toxicity claims judged device/diagnostic, or store rejects (Gate 0a) | Medium / High | Illustrative population-level education plus personal *exposure* metrics (pack-years, cigarettes avoided, CO-cleared estimate with ranges); or partner with clinics that measure real spirometry/CO | Removes regulatory and credibility risk; opens B2B |
| **P2** Mic DSP unreliable in noise (Gate 0b) | Medium-High / Low-Medium | Haptic + visual 0.1 Hz pacer; optional wearable HR/HRV | Accessible, no mic permission |
| **P3** JITAI accuracy insufficient (Gate #3) | Medium-High / Medium | User-scheduled and rule-based risk windows + one-tap SOS; publish the dataset; MRT on prompt timing | Less notification fatigue; data asset for v2 |
| **P4** D30 below 8–15% (Gate #1) | High / High | Add human support or move to text messaging (RR 1.54 [V]); strip features | Distribution solves uptake |
| **P5** Neither visualization beats control (Gate #2) | Medium / Medium | Visualization becomes engagement layer; hero = ACT + NRT support | Prevents misleading claims |
| **P6** ApBM or BE framing null in MOST | High (ApBM) / Low | Drop component | Lower burden and cost |
| **P7** Distal RCT null at ITT | Medium / High | Reposition as app + pharmacotherapy adherence (OR 1.79 [V]); partner with NRT distributors | Clearer payer value story |
| **P8** Global launch spreads team too thin | High / Medium | 2–3 markets, then expand | Proper cultural adaptation |

The framework's altitude rhythm applies: a weekly review of gate metrics, a monthly scan for new trials (for example a Cochrane CD006611 update), and a quarterly go/pivot/stop portfolio decision. The rest of this blueprint specifies every component in full so that each can be built when its gate passes, but **the build order should follow the gates, not the section numbers.**

## Section 1. Biomathematical lung models: honest estimates beat precise-looking numbers

### 1.1 Lung age should invert the race-neutral GLI Global median, with Morris & Temple kept only as a legacy cross-check

**Lung age is the age at which a person's FEV1 equals the predicted median for a healthy never-smoker of the same sex and height** ([AlQerem 2018](https://sure.sunderland.ac.uk/id/eprint/10470/1/AlQerem%20et%20al%20CRMR%202018.pdf)) [V]. Morris & Temple (Prev Med 1985;14(5):655–662, DOI [10.1016/0091-7435(85)90085-4](https://doi.org/10.1016/0091-7435(85)90085-4)) published the first FEV1-based lung-age equations, which is confirmed ([Newbury 2010](https://www.nature.com/articles/pcrj201029)) [V]. Their equations are a closed-form algebraic inversion of the Morris 1971 linear reference equations (Am Rev Respir Dis 1971;103(1):57–67, DOI [10.1164/arrd.1971.103.1.57](https://doi.org/10.1164/arrd.1971.103.1.57)). The coefficients below were recalled, not read from the PDFs. **Their exact mutual consistency is strong indirect evidence**: solving each 1971 equation for age reproduces the 1985 constants exactly (0.092/0.032 = 2.875, 1/0.032 = 31.25, 1.260/0.032 = 39.375; 0.089/0.025 = 3.56, 1/0.025 = 40, 1.932/0.025 = 77.28) [D]. Primary-text verification is still required.

| Equation | Men | Women | Status |
|---|---|---|---|
| Morris 1971 FEV1 (L), H in inches | `0.092·H_in − 0.032·Age − 1.260` | `0.089·H_in − 0.025·Age − 1.932` | [PK], self-consistent [D] |
| Morris & Temple 1985 lung age, imperial | `2.87·H_in − 31.25·FEV1 − 39.375` | `3.56·H_in − 40.0·FEV1 − 77.28` | [PK], self-consistent [D] |
| Morris & Temple, metric (H_in = H_cm/2.54) | `1.1299·H_cm − 31.25·FEV1 − 39.375` | `1.4016·H_cm − 40.0·FEV1 − 77.28` | [D] conversion, not quoted |
| JRS (Japan) lung age | `(0.036·H_cm − 1.178 − FEV1)/0.028` | `(0.022·H_cm − 0.005 − FEV1)/0.022` | [PK], LOW confidence on women's intercept sign |

Morris & Temple is biased young. **Morris 1971 predicts 0.1–0.3 L lower FEV1 than modern references, so any FEV1 maps to a younger lung age.** For a 50-year-old 175 cm man, predicted FEV1 is 3.479 L (Morris), 3.795 L (GLI-2012 Caucasian), 3.574 L (GLI Global) and 3.790 L (NHANES III); with FEV1 3.5 L the Morris lung age is 49.0 y versus 52.5 y by GLI Global inversion, and at 2.5 L it is 80.2 y versus 88.3 y [D]. Newbury et al. (2010) found Morris-based lung ages younger than chronological age in both Australian never-smokers and smokers and called for updating the equations ([PCRJ](https://www.nature.com/articles/pcrj201029)) [V]. A Mediterranean ERS abstract reported underestimation by about 12 years ([ERJ 2013;42 Suppl 57:P3942](https://publications.ersnet.org/content/erj/42/suppl57/p3942)) [V], and a Jordanian study judged existing equations unreliable for that population ([AlQerem 2018](https://sure.sunderland.ac.uk/id/eprint/10470/1/AlQerem%20et%20al%20CRMR%202018.pdf)) [V]. A 2022 spline-based lung-age method uses FEV1, FEF50%, FEF75% and height ([npj Prim Care Respir Med 2022, PMC9522795](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC9522795/)) [V]. **A "Hansen et al. 2010 ATS NHANES III lung age" paper could not be located; do not cite it.**

The recommendation is to define lung age as the age at which the **GLI Global** predicted median FEV1 equals the user's estimated FEV1, solved by bisection, because GLI equations are LMS splines with no closed-form inverse. This takes about 300 evaluations at 0.25-year resolution and is trivial on-device. GLI predicted FEV1 peaks at about 22.0 y (men, 175 cm) and 20.75 y (women, 162 cm) [D], so the inverse is two-valued below the peak; clamp and display "≤25". Pick one reference and never switch it, or users who re-take onboarding will see unexplained jumps of 3.5–8 years. Note that GLI Global is not itself a published lung-age standard; it is the natural extension [R].

#### GLI reference equations are verified from machine-readable files and ready to ship

The coefficients below were transcribed from the open-source `rspiro` R package (commit 8d22e84, 2026-04-11), which redistributes the GLI lookup tables and the published NHANES III and JRS coefficients ([rspiro data-raw](https://github.com/thlytras/rspiro/tree/8d22e84cc5e67b5377443563d3cad314746e8cbe/data-raw)) [V-DATA]. **rspiro is GPL (≥2): transcribe the published coefficients, do not copy its code into a closed-source app** ([DESCRIPTION](https://github.com/thlytras/rspiro/blob/8d22e84cc5e67b5377443563d3cad314746e8cbe/DESCRIPTION)) [V-DATA]. The GLI initiative publishes official lookup tables for IT engineers on the ERS site ([GLI IT-engineers page](https://www.ers-education.org/guidelines/global-lung-function-initiative/spirometry-tools/it-engineers-and-manufacturers/)); its commercial-use terms were not read and need legal review.

The shared LMS form, from [getLMS.R](https://github.com/thlytras/rspiro/blob/8d22e84cc5e67b5377443563d3cad314746e8cbe/R/getLMS.R) and [zscores_GLI.R](https://github.com/thlytras/rspiro/blob/8d22e84cc5e67b5377443563d3cad314746e8cbe/R/zscores_GLI.R) [V-DATA], is:

```
L = q0 + q1·ln(Age) + Lspline
M = exp(a0 + a1·ln(Ht_cm) + a2·ln(Age) [+ a3·AfrAm + a4·NEAsia + a5·SEAsia + a6·Other] + Mspline)
S = exp(p0 + p1·ln(Age) [+ p2..p5 ethnic terms] + Sspline)
spline(Age) = v0 + (v1 − v0)·(Age − agebound)/0.25,   agebound = floor(4·Age)/4   (table ages 3–95)
z   = ((x/M)^L − 1)/(L·S)
LLN = exp(ln(M) + ln(1 − 1.645·L·S)/L)          # 5th centile
x(z) = M·(1 + L·S·z)^(1/L)                       # inverse, [D] algebraic
```

**GLI Global (Bowerman 2023, race-neutral; recommended default)** — [getLMS_GLIgl.R](https://github.com/thlytras/rspiro/blob/8d22e84cc5e67b5377443563d3cad314746e8cbe/R/getLMS_GLIgl.R) [V-DATA]:

| Sex / measure | M | S | L |
|---|---|---|---|
| Male FEV1 | `exp(−11.399108 + 2.462664·ln(Ht) − 0.011394·ln(Age) + Mspline)` | `exp(−2.256278 + 0.080729·ln(Age) + Sspline)` | 1.22703 |
| Female FEV1 | `exp(−10.901689 + 2.385928·ln(Ht) − 0.076386·ln(Age) + Mspline)` | `exp(−2.364047 + 0.129402·ln(Age) + Sspline)` | 1.21388 |
| Male FVC | `exp(−12.629131 + 2.727421·ln(Ht) + 0.009174·ln(Age) + Mspline)` | `exp(−2.195595 + 0.068466·ln(Age) + Sspline)` | 0.9346 |
| Female FVC | `exp(−12.055901 + 2.621579·ln(Ht) − 0.035975·ln(Age) + Mspline)` | `exp(−2.310148 + 0.120428·ln(Age) + Sspline)` | 0.899 |
| Male FEV1/FVC | `exp(1.022608 − 0.218592·ln(Ht) − 0.027586·ln(Age) + Mspline)` | `exp(−2.882025 + 0.068889·ln(Age) + Sspline)` | `3.8243 − 0.3328·ln(Age)` |
| Female FEV1/FVC | `exp(0.9189568 − 0.1840671·ln(Ht) − 0.0461306·ln(Age) + Mspline)` | `exp(−3.171582 + 0.144358·ln(Age) + Sspline)` | `6.6490 − 0.9920·ln(Age)` |

GLI Global FEV1 spline anchors, Mspline / Sspline (Lspline = 0), from the [GLI Global lookup workbook](https://github.com/thlytras/rspiro/blob/8d22e84cc5e67b5377443563d3cad314746e8cbe/data-raw/gli_global_lookuptables_dec6.xlsx) [V-DATA]; the full table has one row per 0.25 y from age 3 to 95, about 2–3 kB as bundled JSON:

| Age | Male Mspline | Male Sspline | Female Mspline | Female Sspline |
|---|---|---|---|---|
| 20 | 0.146601 | −0.050874 | 0.118399 | −0.038399 |
| 25 | 0.147244 | −0.052816 | 0.127551 | −0.054393 |
| 30 | 0.121250 | −0.046372 | 0.121830 | −0.063902 |
| 40 | 0.066296 | −0.021369 | 0.087996 | −0.052727 |
| 50 | −0.001884 | 0.009634 | 0.021965 | −0.012312 |
| 60 | −0.092396 | 0.040633 | −0.065223 | 0.037213 |
| 70 | −0.190811 | 0.069004 | −0.157595 | 0.084868 |
| 80 | −0.283142 | 0.094172 | −0.245459 | 0.127729 |
| 90 | −0.366044 | 0.116495 | −0.325115 | 0.165883 |

**GLI-2012 (Quanjer 2012, DOI 10.1183/09031936.00080312; ethnic coefficients; research/regional option only)** — [RLookupTable.csv](https://github.com/thlytras/rspiro/blob/8d22e84cc5e67b5377443563d3cad314746e8cbe/data-raw/RLookupTable.csv) [V-DATA]:

| Sex | a0 | a1 lnHt | a2 lnAge | a3 AfrAm | a4 NEAsia | a5 SEAsia | a6 Other | p0 | p1 lnAge | p2 AfrAm | p3 NEA | p4 SEA | p5 Other | q0 | q1 lnAge |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| M FEV1 | −10.3420 | 2.2196 | 0.0574 | −0.1589 | −0.0351 | −0.0881 | −0.0708 | −2.3268 | 0.0798 | 0.1096 | −0.3973 | 0.0327 | 0.0114 | 0.8866 | 0.0850 |
| F FEV1 | −9.6987 | 2.1211 | −0.0270 | −0.1484 | −0.0149 | −0.1208 | −0.0708 | −2.3765 | 0.0972 | 0.1016 | −0.0109 | 0.0733 | 0.0114 | 1.1540 | 0 |
| M FVC | −11.2281 | 2.4135 | 0.0865 | −0.1684 | −0.0405 | −0.1177 | −0.0825 | −2.2963 | 0.0718 | 0.0794 | −0.4600 | 0.0325 | −0.0503 | 0.9481 | 0 |
| F FVC | −10.4030 | 2.2633 | 0.0234 | −0.1555 | −0.0262 | −0.1516 | −0.0833 | −2.3549 | 0.1017 | 0.0810 | −0.1809 | 0.0459 | −0.0503 | 0.8236 | 0 |

GLI-2012 FEV1 Mspline/Sspline anchors are: male 20: 0.2081/−0.0901; 25: 0.1899/−0.0844; 30: 0.1495/−0.0625; 40: 0.0721/−0.0596; 50: −0.0125/−0.0240; 60: −0.1143/0.0671; 70: −0.2328/0.1698; 80: −0.3512/0.2538; 90: −0.4586/0.3260; female 20: 0.1839/−0.0627; 25: 0.1753/−0.0780; 30: 0.1590/−0.0909; 40: 0.1040/−0.0892; 50: 0.0232/−0.0345; 60: −0.0741/0.0492; 70: −0.1926/0.1389; 80: −0.3226/0.2231; 90: −0.4446/0.2985 [V-DATA]. The implied FEV1 ethnic multipliers relative to Caucasian are male AfrAm 0.853, NE Asian 0.966, SE Asian 0.916, Other 0.932, and female 0.862, 0.985, 0.886, 0.932 [D]. "Other/mixed" covers unrepresented groups including South Asians [PK].

**NHANES III (Hankinson 1999, DOI 10.1164/ajrccm.159.1.9712108)**: `FEV1_pred(L) = b0 + b1·Age + b2·Age² + b3·Ht_cm²`, with LLN using `b3_LLN` — [NHtb45.csv](https://github.com/thlytras/rspiro/blob/8d22e84cc5e67b5377443563d3cad314746e8cbe/data-raw/NHtb45.csv) [V-DATA]:

| Group (adult) | b0 | b1 Age | b2 Age² | b3 pred Ht² | b3 LLN Ht² | R² |
|---|---|---|---|---|---|---|
| Caucasian male | 0.5536 | −0.01303 | −0.000172 | 0.00014098 | 0.00011607 | 0.851 |
| Caucasian female | 0.4333 | −0.00361 | −0.000194 | 0.00011496 | 0.00009283 | 0.749 |
| African-American male | 0.3411 | −0.02309 | 0 | 0.00013194 | 0.00010561 | 0.808 |
| African-American female | 0.3433 | −0.01283 | −0.000097 | 0.00010846 | 0.00008546 | 0.669 |
| Mexican-American male | 0.6306 | −0.02928 | 0 | 0.00015104 | 0.00012670 | 0.854 |
| Mexican-American female | 0.4529 | −0.01178 | −0.000113 | 0.00012154 | 0.00009890 | 0.727 |

NHANES III FEV1/FVC (%) is `88.066 − 0.2066·Age` (LLN `78.388 − 0.2066·Age`) for Caucasian men and `90.809 − 0.2125·Age` (LLN `81.015 − 0.2125·Age`) for Caucasian women ([NHtb6.csv](https://github.com/thlytras/rspiro/blob/8d22e84cc5e67b5377443563d3cad314746e8cbe/data-raw/NHtb6.csv)) [V-DATA]. rspiro switches to adult rows at age ≥20 for both sexes, whereas the paper switches females at 18 [PK].

**JRS-2014 (Kubota 2014, DOI 10.1016/j.resinv.2014.03.003; Japanese adults 17–95)** — [getLMS_JRS.R](https://github.com/thlytras/rspiro/blob/8d22e84cc5e67b5377443563d3cad314746e8cbe/R/getLMS_JRS.R) [V-DATA]: male `M = exp(−7.5722 + 1.9393·ln(Ht) − 0.3068·ln(Age) + Mspline)`, `S = exp(−3.0440 + 0.2325·ln(Age) + Sspline)`, `L = 1`; female `M = exp(−6.9428 + 1.8053·ln(Ht) − 0.3401·ln(Age) + Mspline)`, `S = exp(−3.1024 + 0.2537·ln(Age) + Sspline)`, `L = 0.7783`. Splines are in the Respir Investig supplement, looked up at integer-year bounds.

**QA test vectors** [D], to be checked against the official GLI calculator before release:

| Case | GLI Global M / LLN (L) | GLI-2012 Caucasian M / LLN (L) | NHANES III Caucasian pred (L) |
|---|---|---|---|
| Male 175 cm, 25 y | 4.181 / 3.271 | 4.466 / 3.599 | 4.438 |
| Male 175 cm, 50 y | 3.574 / 2.695 (S = 0.1450) | 3.795 / 2.961 | 3.790 |
| Male 175 cm, 70 y | 2.947 / 2.154 | 3.104 / 2.243 | 3.116 |
| Female 162 cm, 25 y | 3.061 / 2.362 | 3.258 / 2.618 | 3.239 |
| Female 162 cm, 50 y | 2.612 / 1.929 (S = 0.1541) | 2.746 / 2.142 | 2.785 |
| Female 162 cm, 70 y | 2.127 / 1.484 | 2.193 / 1.598 | 2.247 |

GLI-2012 at 50 y by group (male 175 / female 162 cm) gives NE Asian 3.665/2.705, SE Asian 3.475/2.434, Other 3.536/2.558 and AfrAm 3.238/2.367 L [D]. **GLI Global runs about 5–6% below GLI-2012 Caucasian** (0.942 men, 0.951 women at 50 y) [D].

**Why GLI Global is the default.** It needs only age, sex and height, so the app never has to ask ethnicity for the lung model, which is a UX and fairness win. The ATS 2023 statement (Bhakta et al., AJRCCM 2023;207(8):978–995, DOI 10.1164/rccm.202302-0310ST) recommends race-neutral average equations [PK]. The ERS/ATS 2022 interpretive standard (Stanojevic et al., DOI 10.1183/13993003.01499-2021) recommends interpretation by z-score with LLN at z = −1.645 and severity grading mild −1.65 to −2.5, moderate −2.5 to −4, severe below −4, and advises against % predicted [PK]. Use JRS-2014 for Japan. No GLI-2012 group fits South Asia, so use GLI Global there; a candidate Indian equation (Chhabra 2014) is unverified. The user's premise that ethnicity or region should feed the baseline FEV1 is therefore **corrected**: region selects the reference equation (GLI Global everywhere except JRS-2014 in Japan), not an ethnic multiplier.

#### Fletcher–Peto is a schematic; usable slopes come from the Lung Health Study and cohorts

**The Fletcher–Peto figure (BMJ 1977;1(6077):1645–1648, DOI [10.1136/bmj.1.6077.1645](https://doi.org/10.1136/bmj.1.6077.1645)) is illustrative, not a fitted model** [PK]. It came from about 792 West London working men followed about 8 years and plots FEV1 as % of the value at age 25 with "disability" and "death" thresholds. Its conclusions were that smoking-attributable loss is largely irreversible, that quitting returns the subsequent decline toward the non-smoker rate, and that only a susceptible minority decline fast enough to become disabled. **The brief's request for "Fletcher–Peto curve parameters" is therefore corrected:** the numeric parameters below come from other studies, and all are recalled and unverified except the GLI-derived slopes.

| Parameter | Value | Source | Status |
|---|---|---|---|
| Never-smoker median decline, men 175 cm | −24.3 (30 y), −23.1 (40), −29.7 (50), −32.5 (60), −28.9 (70) mL/yr | GLI Global slope, central difference | [D] from [V-DATA] |
| Never-smoker median decline, women 162 cm | −13.3, −19.7, −24.8, −24.7, −21.7 mL/yr | GLI Global | [D] |
| GLI-2012 Caucasian slopes | men 25.6–36.0; women 14.6–28.9 mL/yr | GLI-2012 | [D] |
| Sustained quitters, first-year gain | **+47 mL (≈2% predicted)** in mildly obstructed smokers | Scanlon 2000, DOI [10.1164/ajrccm.161.2.9901044](https://doi.org/10.1164/ajrccm.161.2.9901044) | [PK] |
| Sustained quitters, long-term decline | **30.2 mL/yr men, 21.5 women** | Anthonisen 2002 (LHS 11-yr), DOI [10.1164/rccm.2112096](https://doi.org/10.1164/rccm.2112096) | [PK] |
| Continuing smokers (mild COPD) | **66.1 mL/yr men, 54.2 women** (Scanlon: ~62) | Anthonisen 2002; Scanlon 2000 | [PK] |
| FEV1 <60% predicted at 11 y | ~38% continuing vs ~10% quitters | Anthonisen 2002 | [PK] |
| Rapid-decline COPD trajectory | 53 ± 21 mL/yr (normal start) vs 27 ± 18 (low start) | Lange 2015, DOI [10.1056/NEJMoa1411532](https://doi.org/10.1056/NEJMoa1411532) | [PK] |
| Cross-sectional dose-response | **7.4 mL/pack-year men, 4.4 women** | Dockery 1988, DOI [10.1164/ajrccm/137.2.286](https://doi.org/10.1164/ajrccm/137.2.286) | [PK] |
| Chronic mucus hypersecretion excess | 22.8 mL/yr men, 12.6 women | Vestbo 1996, DOI [10.1164/ajrccm.153.5.8630597](https://doi.org/10.1164/ajrccm.153.5.8630597) | [PK] |
| Susceptible fraction | ≥~25% of continuous smokers develop significant COPD over 25 y | Løkke 2006, DOI [10.1136/thx.2006.062802](https://doi.org/10.1136/thx.2006.062802) | [PK] |
| Women | larger first-year gain and faster decline per cigarette (magnitudes unknown) | Connett 2003, DOI 10.1093/aje/kwg083; Gan 2006, DOI 10.1186/1465-9921-7-52 | [PK], qualitative only |

Three consistency checks make these parameters usable. First, **LHS quitter slopes (about 30 men / 22 women) fall inside the GLI Global healthy slopes (about 23–33 / 13–25)**, so the app can model "after quitting, FEV1 follows the never-smoker slope from the new, lower level" by differentiating the reference equation rather than hard-coding a slope [D]. Second, the LHS excess in continuing smokers (66.1 − 30.2 ≈ 36 mL/yr men; 54.2 − 21.5 ≈ 33 women) applies to a population selected for airflow obstruction and **must not be applied to all smokers** [D]. Third, a two-class mixture reconciles LHS with Dockery: if about 25% of smokers are susceptible and the rest have near-zero excess, a 1-pack/day man's average 7.4 mL/yr implies about 30 mL/yr in the susceptible class, close to the LHS excess [D, inference]. The +47 mL first-year bonus comes from obstructed smokers and has no published value for non-obstructed quitters; for a 50-year-old 175 cm man it equals about 1.6 lung-age years, so **"your lungs got ~1–2 years younger in year one" is supportable only for symptomatic heavy smokers** [D].

#### Step2quit's mechanism was measurement plus attention; copy its design cues, not its effect size

Step2quit (Parkes, Greenhalgh, Griffin, Dent; BMJ 2008;336(7644):598–600, DOI [10.1136/bmj.39503.582396.25](https://doi.org/10.1136/bmj.39503.582396.25)) [PK, all details unverified] ran in about 5 Hertfordshire practices with 561 smokers over 35. The intervention arm received spirometry results as "lung age" with a Fletcher–Peto-style graphic; controls got the raw FEV1 number. Both arms were encouraged to quit and offered NHS stop-smoking referral. Salivary-cotinine-verified 12-month quit was **13.6% vs 6.4%, difference 7.2 points (95% CI 2.2–12.1), NNT ≈14**, with about 89% retention, and the effect reportedly did not depend on an abnormal result. The equation used was probably Morris & Temple. Cochrane (Clair 2019) rates biomedical-risk feedback low or very-low certainty, and Kotz 2009 (DOI 10.1183/09031936.00116308) found confronting smokers with airflow limitation added nothing over counselling [PK]. The communication methodology to replicate is **one clear number (lung age vs real age), a Fletcher–Peto-style curve with the user's position marked, an immediate referral or service offer, and a quit date**. Because quit rates did not differ by result, show lung age to everyone, but avoid false reassurance ("your lungs are fine, so smoking is OK") when the estimate is near chronological age.

#### Without a spirometer, show a smoking-attributable "lung-age gap" with a visible band

**No validated model predicts an individual's FEV1 from questionnaire data with useful precision.** Healthy between-person variation is huge: SD ≈ M·S ≈ 0.52 L for a 50-year-old 175 cm man, which is **about 17.5 years of lung age**, and about 0.40 L (16 years) for a 162 cm woman [D]. The average smoking deficit is smaller: 30 pack-years ≈ 0.22 L ≈ 7.5 lung-age years in men. A 0.3 L deficit is only z ≈ −0.57 (man, 50 y), and even 0.6 L is z ≈ −1.13, still above the LLN [D]. Lung-age sensitivity per 100 mL deficit is 4.1/4.3/3.4/3.1/3.5 years for men at 30/40/50/60/70 y and 7.5/5.1/4.0/4.0/4.6 for women [D]; a 50-year-old 175 cm man with deficits of 0/0.2/0.4/0.6 L has lung ages 50.0/56.5/62.5/69.0 [D].

The defensible approach is a population-expected deficit from a two-class Fletcher–Peto mixture. **The structure is evidence-based; the calibration constants are design parameters [M], not published values.** Published screeners supply the structural template for the susceptibility term: COPD-PS (Martinez 2008, DOI 10.1080/15412550801940721; five items, 0–10, ≥5 suggests obstruction), LFQ (Yawn 2010, DOI 10.2147/COPD.S7683; ≤18 suggests risk), CDQ (Price 2006, DOI 10.1159/000090142) and CAPTURE (Martinez 2017, DOI 10.1164/rccm.201603-0622OC) [PK]. They predict a binary obstruction label, not litres.

The user's requested inputs map as follows. Age, sex and height feed the GLI reference. Cigarettes/day and age started feed pack-years. Morning cough/phlegm and dyspnea raise the susceptibility probability, and dyspnea or a COPD-PS-style score ≥5 also triggers a "get spirometry / see a clinician" prompt; cough should either shift p_sus or add the Vestbo excess, never both. **Time to first cigarette is a dependence measure and should drive support intensity, not lung function. Vaping, heated tobacco and oral tobacco have no validated FEV1 coefficient and must never be converted to pack-years** (Section 1.3 handles them separately).

```
inputs: age, sex, height_cm, cpd, age_started, chronic_cough (bool), dyspnea_grade (0–4), region
PY        = (cpd/20) * max(0, age - age_started)            # subtract quit-years if collected
# 1. Reference (GLI Global; JRS-2014 if region == Japan)                       [V-DATA]
L, M, S   = gli_global_LMS(age, height_cm, sex)
slope_ref(a) = M(a+0.5) - M(a-0.5)                                              [D]
# 2. Expected smoking deficit (two-class mixture)
p_sus     = calibrated_logistic(β0 + β1·cough + β2·dyspnea + β3·log(PY) + β4·[age≥50])   [M] prior ≈0.25 [PK Løkke]
beta_pop  = 7.4 mL/PY (male) | 4.4 mL/PY (female)                                [PK Dockery]
D_sus     = beta_pop / p_prior          # ≈30 mL/PY men, ≈18 women                [M] mixture identity
deficit   = p_sus * D_sus * PY / 1000                       # litres
deficit   = min(deficit, M - M*(1 + L*S*(-2.5))**(1/L))     # cap at z = −2.5     [M]
FEV1_est  = M - deficit
# 3. Lung age by numerical inversion
lung_age  = bisect(a in [peak_age ≈21–22, 95] : M(a, height_cm, sex) == FEV1_est)
            # FEV1_est ≥ M(peak) → "≤25";  FEV1_est < M(95) → "95+"
gap_years = lung_age - age                                   # PRIMARY display metric
band      = lung_age at FEV1_est ± 0.674·M·S                 # 50% band ≈ ±12 y (man, 50)  [M]
# 4. Trajectories, t years from now
continue: FEV1(t) = FEV1_est + Σ slope_ref(age+k) - p_sus * excess * t
          excess  ≈ 0.031–0.036 L/yr men, ≈0.033 women                         [PK LHS-derived]
quit:     FEV1(t) = FEV1_est + p_sus * 0.047 [year 1 only] + Σ slope_ref(age+k)  [PK Scanlon]
# Plot on Fletcher–Peto axis (% of FEV1 at age 25). LLN (z = −1.645) and z = −2.5 are INTERNAL QA/cap lines only:
# Section 6 forbids displaying clinical thresholds or normal/abnormal bands to consumers.
```

The β coefficients must be fitted on an external dataset with both questionnaire and spirometry (NHANES 2007–2012 or UK Biobank); do not hard-code invented odds ratios. Report the mean absolute error in years on the app's "how we calculate this" page, and propagate uncertainty by Monte Carlo once calibration data exist. Present the output as **"estimated lung age based on people like you", never "your lung age"**, with no "diagnosis", "COPD" or "normal/abnormal" labels, and pair every result with an "ask for spirometry" call to action, which also restores the Step2quit active ingredient. An optional legacy mode can show Morris & Temple to mirror the trial, documented as running younger.

### 1.2 The Young Smoker Paradox is solvable with hours-to-weeks physiology, but only four parameters reach grade A

The paradox is that a 22-year-old with two years of smoking has a normal estimated lung age, so a lung-age display tells them nothing is wrong. The answer is to show acute, reversible harms that exist in young smokers now and recover on hours-to-weeks time scales. The research supports a composite **Reversible Bio-Toxicity Index (BTI)** built from three live domains (CO, nicotine, autonomic) and two multi-week domains (mucociliary, vascular), with smell as a slow partial-recovery domain and clonal replenishment as narrative only. Two of the brief's citations were wrong, and several requested parameters could not be verified; both are flagged below.

Each domain carries an evidence grade. **A** means primary, adequately powered and population-appropriate. **B** means primary but small, indirect or the wrong population. **C** means secondary or extrapolated. **D** means unsourced: do not ship.

#### Carbon monoxide: the best-evidenced live channel, with a 4.5-hour daytime half-life

**Exhaled CO after the last cigarette follows a mono-exponential decay with a half-life of 4.5 h (r² = 0.7; a slope estimate gives 4.3 h)** ([Sandberg 2011, PLoS ONE, DOI 10.1371/journal.pone.0028864](https://journals.plos.org/plosone/article?id=10.1371%2Fjournal.pone.0028864)) [V, grade A]. The same paper warns the decay rate depends on initial CO, so it is not a population constant, and found that a **12 ppm cut-off separated recent smokers from those abstinent about 8 h with 94% specificity and 90% sensitivity**. Sleep slows clearance through reduced ventilation: post-smoking half-life was **8.0 ± 1.6 h in men (n=5) and 4.3 ± 1.1 h in women (n=4)** ([PubMed 1498552](https://pubmed.ncbi.nlm.nih.gov/1498552/)) [V, grade B, hypothesis-generating only], and heavy smokers wake with raised COHb because the half-life is longer during sleep ([PMC1612791](https://pmc.ncbi.nlm.nih.gov/articles/PMC1612791/)) [V]. Mild exercise sharply reduces the half-life, but no magnitude was retrieved ([review](https://www.sciencedirect.com/science/article/pii/S1569904825001168)) [V, direction only]. Short exposures can show biphasic decay in animal models ([Shimazu 2000](https://m.jci.org/references/scholar/22208/B40)), so mono-exponential is a simplification.

**Premise correction: Weaver et al. 2000 (Chest 117(3):801–808) is not a room-air half-life paper.** Its headline **74 ± 25 min is the COHb half-life on 100% oxygen at atmospheric pressure**, from a retrospective study with missing early measurements ([EPA HERO 16421](https://hero.epa.gov/reference/16421/); [citing review](https://www.sciencedirect.com/science/article/pii/S2214750024000192)) [V], and one source says the figure came from volunteers, not patients, which cannot be resolved without full text. The widely circulated **room-air figure of about 320 min (5.3 h)**, falling to about 80 min on 100% O₂, comes from tertiary clinical references ([OSHA interpretation](https://www.osha.gov/laws-regs/standardinterpretations/1991-04-08-2); [FPNotebook](https://fpnotebook.com/ER/Lab/Crbxyhmglbn.htm)) [V, tertiary]. The 100% O₂ branch is irrelevant to this app and should not appear.

The absolute calibration layer is missing. Wald et al. 1981 (Thorax, DOI 10.1136/thx.36.5.366; 11,249 men) found **81% of cigarette smokers, 35% of cigar/pipe smokers and 1.0% of non-smokers above a 2% COHb cut-off** ([ORA](https://ora.ox.ac.uk/objects/uuid:e5e6ee8f-90e7-4c98-b651-1d63086ad7e9)) [V], but no CPD-stratified means. Andersson & Møller 2010 (n=37, DOI 10.1097/EJA.0b013e32833a55ea) found a Micro Smokerlyzer correlated highly with arterial COHb (rho = 0.964) but **under-read it with poor agreement**, and proposed an alternative conversion algorithm that is behind the paywall ([PubMed 20520557](https://www.ncbi.nlm.nih.gov/pubmed/20520557)) [V]. The only retrieved regression, `%HbCO = 10.315 + 0.203 × ppm` (r = 0.835), comes from **47 acute CO-poisoning patients and must not be used for smokers** ([SNU thesis](https://s-space.snu.ac.kr/handle/10371/9604)) [V]. **The brief's "COHb% ≈ 0.16 × ppm" could not be traced to a primary source; flag it as unsourced. The Coburn–Forster–Kane equation (J Clin Invest 1965, DOI 10.1172/JCI105250) was not retrieved and must not be reconstructed from memory**; in any case CFK is a continuous-exposure mass-balance model, and first-order superposition is the better engineering fit for discrete cigarette boluses. The SRNT 2020 update (Benowitz et al., DOI 10.1093/ntr/ntz132) reportedly **lowered the trial CO threshold to 5–6 ppm** and asks studies to report the monitor model ([CDC manuscript](https://stacks.cdc.gov/view/cdc/103507/cdc_103507_DS1.pdf); [secondary characterization](https://www.oaepublish.com/articles/jeea.2025.69)) [V, secondary for the number]. CO reflects about the past 24 hours; cotinine is the better abstinence biomarker except for NRT users ([PMC8026538](https://pmc.ncbi.nlm.nih.gov/articles/PMC8026538)) [V].

The product consequences follow directly. **If the app ever pairs with a breath-CO monitor, show ppm, the measured quantity, and never a converted COHb% unless a named, cited conversion is adopted. In the modeled v1, show only "estimated share of smoking-related CO cleared" and never a ppm or COHb number, because a displayed value would read as a measurement (Section 6).** After 24 h of abstinence (about 5.3 awake half-lives) the smoking-attributable CO burden is about 2.5% of peak, so **CO is a near-perfect "today" signal and a useless "this month" signal**. The folk claim "CO normalizes in 8–12 h" corresponds to about two half-lives, roughly 75% cleared, not normal [D]. The per-cigarette increment must be calibrated from a steady-state CPD anchor, not invented: for n cigarettes spread over a T_wake-hour day, steady-state peak ≈ `Δ / (1 − exp(−Δt/τ))` with `Δt = T_wake/n`, which can be inverted for Δ [D]. A 2025 study titled "Effect of collection time and reported cigarettes per day on exhaled carbon monoxide" ([PMC13536744](https://pmc.ncbi.nlm.nih.gov/articles/PMC13536744/)) is the highest-value fetch for that anchor. If the app pairs with a breath-CO device, a per-user τ fitted from the user's own readings beats the population constant and is a real differentiator.

```
CO_breath(t) = C_env   + Σ_i ΔCO_i   · exp(−(t − t_i)/τ(t))
COHb(t)      = COHb_env + Σ_i ΔCOHb_i · exp(−(t − t_i)/τ(t))
τ_awake = 4.5 h / ln2 = 6.49 h                          [V, A]
τ_sleep = τ_awake × 1.5–1.8  (declared approximation)    [M; anchors n=5/n=4, B]
exercise accelerator: NOT IMPLEMENTED (no magnitude)     [gap]
ΔCO_i, ΔCOHb_i: fitted from a published steady-state CPD anchor   [M; anchor D until fetched]
```

#### Nicotine: a 2-hour half-life explains the morning cigarette; cotinine's 16 h is unverified

**Nicotine's average half-life is about 2 h** (secondary source citing Benowitz, Hukkanen & Jacob 2009, Handb Exp Pharmacol, DOI 10.1007/978-3-540-69248-5_2) ([ARUP Consult](https://arupconsult.com/reference/19184645)) [V, secondary, grade C], giving τ_nic ≈ 2.89 h. It is metabolized mainly by CYP2A6, UGT and FMO, chiefly to cotinine ([Springer abstract](https://link.springer.com/content/pdf/10.1007/978-3-540-69248-5_2.pdf)) [V]. **The brief's 16 h cotinine half-life was not verified**; the only metabolite half-life found was about 6 h for trans-3′-hydroxycotinine, a different compound ([JBC review](https://www.jbc.org/article/S0021-9258(21)00511-1/fulltext)) [V]. Do not build the withdrawal-timeline mapping on cotinine until it is checked. No source links nicotine PK to a craving-symptom curve, so any such mapping is extrapolation.

The divergence between channels is a product opportunity. The app can honestly say that **the thing driving your urge right now has a 2.9 h time constant while the thing impairing oxygen transport has a 6.5 h time constant**, which explains why cravings spike before the toxicity number moves. Eight to ten hours of sleep spans 4–5 nicotine half-lives, so a smoker wakes nicotine-depleted (about 3–6% of bedtime level) but not CO-depleted, which is a clean mechanistic explanation of the morning cigarette for onboarding copy [D].

#### Mucociliary clearance: normal transit by day 15 is the paradox-solver's best dated milestone

**Nasal saccharin transit time (STT) in 33 smokers in a cessation program returned to the normal range by day 15 after quitting (P < 0.01) and stayed normal to 180 days** (Ramos 2011, Respirology 16(5):849–855, DOI 10.1111/j.1440-1843.2011.01985.x) ([Wiley](https://onlinelibrary.wiley.com/doi/10.1111/j.1440-1843.2011.01985.x)) [V, grade B]. The design was single-arm with heavy attrition (abstinent n = 23 at 15 days, 19 at 30, 15 at 60/90, 11 at 120 and 9 at 180), so the late subgroup is self-selected. Cross-sectional medians give the magnitude: **current smokers 15.9 min [10–27] vs non-smokers 8 [6–16] and ex-smokers with COPD 9.7 [6–12]** (Ito 2015, Respir Care, DOI 10.4187/respcare.03266) ([SAGE](https://journals.sagepub.com/doi/full/10.4187/respcare.03266)) [V], roughly a doubling of transit time. Polosa et al. 2021 observed restoration in people who quit 3–36 months earlier but call for prospective time-course studies ([SAGE](https://journals.sagepub.com/doi/full/10.1177/20406223211035267)) [V; note industry-funding sensitivities in this group's e-cigarette work]. STT is repeatable over 3 and 30 days, but the same authors state that **"it is not known if MCC impairment can be reversed when stopping smoking"** ([PMC7537769](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7537769/)) [V], which tempers Ramos.

**Cilia are about 7–15% shorter in healthy smokers, with the largest reduction (15%) in endobronchial biopsies, and six cilia-related genes are reduced** (Leopold 2009, PLoS ONE, DOI 10.1371/journal.pone.0008157) ([PMC2790614](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2790614/)) [V], but the clearance consequence in that paper is explicitly theoretical ([Figure 5](https://plos.figshare.com/articles/figure/_Theoretical_effect_of_smoking_on_ciliary_contribution_to_mucociliary_clearance_/542104)), and smoke impairs ciliogenesis itself (Tamashiro 2009, DOI [10.2500/ajra.2009.23.3280](https://doi.org/10.2500/ajra.2009.23.3280)) [V]. **No study retrieved measures cilia length before and after quitting in the same people**, so copy should say "clearance function recovers" (evidenced), not "your cilia regrow by day X". All recovery data are nasal; extending them to bronchial clearance is an assumption.

The published recovery is a step at day 15, not a curve. The recommended implementation is a **saturating exponential with T ≈ 5–7 days** so that 85–95% of recovery has occurred by day 15, which is an engineering choice [M], with an in-app note that only the day-15 endpoint is evidenced. **The canonical "cilia recover in 1–9 months" claim traces only to secondary paraphrases of the 1990 Surgeon General report.** WHO's rendering of that timeline says "1–9 months, coughing and shortness of breath decrease" and does not mention cilia ([WHO Q&A](https://www.who.int/news-room/questions-and-answers/item/tobacco-health-benefits-of-smoking-cessation)) [V]; ALA uses 1–9 months ([ALA](https://www.lung.org/quit-smoking/i-want-to-quit/benefits-of-quitting)) and ACS uses **1–12 months** ([ACS](https://www.cancer.org/cancer/risk-prevention/tobacco/guide-quitting-smoking/benefits-of-quitting-smoking-over-time.html)) [V]. Transient post-quit cough worsening is a real retention risk that could not be sourced (Ussher 2003, Tob Control, not retrieved): if the clearance curve improves while the user's cough worsens in week 2, unexplained, the user will distrust the index. Section 4 builds this into the "Quitter's Flu" state.

#### Vascular: young smokers show measurable chronic stiffness even with normal brachial BP

**One cigarette (1.2 mg nicotine) raised brachial and aortic BP, augmentation index and pulse-wave velocity within 15 minutes (P < 0.01), with no change after sham smoking** (Mahmud & Feely 2003, Hypertension, DOI 10.1161/01.HYP.0000047464.66901.60; n=28) ([AHA](https://www.ahajournals.org/doi/full/10.1161/01.hyp.0000047464.66901.60)) [V]. The same paper is the single most useful finding for the paradox: in **41 young chronic smokers vs 116 non-smokers, brachial BP did not differ, but aortic systolic BP (101 ± 8 vs 97 ± 9 mmHg) and augmentation index (0.7 ± 13 vs −5.7 ± 14) were higher and pulse-pressure amplification was lower (13.7 ± 8 vs 17.7 ± 5 mmHg), all P < 0.01** [V]. **A single cigarette lowered brachial flow-mediated dilation by 0.88 (regular) to 1.17 (light) percentage points** (Amato 2013, Atherosclerosis) ([PubMed 23528831](https://pubmed.ncbi.nlm.nih.gov/23528831/)) [V, grade A dose term], the only per-cigarette quantity verified in any domain. In young habitual smokers, shear-mediated dilation was attenuated in the brachial but not the carotid artery (Suzuki 2020, DOI 10.14814/phy2.14369) ([PMC7023886](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7023886/)) [V], so "your arteries" overclaims; the evidenced claim concerns peripheral conduit arteries. Acute hookah use also raises stiffness in adults aged 18–34 ([Am J Cardiol](https://www.ajconline.org/article/S0002-9149(18)31206-2/abstract)) [V].

Recovery is supported by a **2025 systematic review: cessation was consistently associated with improved PWV, AIx and FMD, with some effects within one month and sustained up to 24 months, moderate certainty for FMD from RCTs** ([Dundee Discovery](https://discovery.dundee.ac.uk/en/publications/vascular-health-after-quitting-smoking-or-switching-to-e-cigarett/)) [V]. The flagship cessation-FMD RCT (n=1,504 smokers, 5 pharmacotherapies, FMD before and 1 year after the target quit date, CO-verified) exists ([PMC2947952](https://pmc.ncbi.nlm.nih.gov/articles/PMC2947952)) [V], but **the "Johnson HM et al., JACC 2010" attribution is plausible but unconfirmed, and its FMD deltas were not retrieved** (Section 0 cites about +1 point at 1 year [PK]). **The decay time constant of the acute single-cigarette FMD drop was not found anywhere.** Model the domain as two components: an acute spike with **τ ≈ 0.5–1 h** (extrapolated from the 30-minute heart-rate return; a cigar study found no FMD difference at 5 h) [M, grade C] and a chronic offset with **T ≈ 30 days** (from the review's qualitative "within one month") [M, grade C]. Do not present a vascular decay curve as measured.

#### Autonomic: about 7 bpm of resting heart rate is the cigarettes, and wearables can check it

**One week of abstinence lowered 24-h heart rate by 7.3 ± 1.0 bpm (daytime −9.2 ± 1.1, night −3.7) and 24-h BP by 3.5 ± 1.1 / 1.9 ± 0.7 mmHg (night BP not significant), with higher pNN50 and HF power and lower daytime LF/HF** (Minami, Ishimitsu, Matsuoka 1999, Hypertension 33(1):586–590, DOI 10.1161/01.HYP.33.1.586; randomized-order crossover, 39 normotensive men) ([AHA](https://www.ahajournals.org/doi/10.1161/01.hyp.33.1.586)) [V, grade A]. Acutely, HR rose from about 84 to 90.5 bpm within 10 minutes of smoking, stayed elevated 20 minutes and **returned to baseline after 30 minutes** ([PMC3641479](https://pmc.ncbi.nlm.nih.gov/articles/PMC3641479/)) [V]; a review puts the acute rise at up to 10–15 bpm, **averaging about 7 bpm across the day**, with a >150% rise in plasma epinephrine ([PMC4958544](https://pmc.ncbi.nlm.nih.gov/articles/PMC4958544/)) [V; Benowitz & Burbank 2016 authorship is PK]. High-nicotine cigarettes kept cardiac output raised for an hour ([Chest](https://www.sciencedirect.com/science/article/abs/pii/S0012369215399207)) [V]. In CARDIA, **resting HR was 1.5–5 bpm higher in smokers in every race/sex group except Black men** ([PubMed 7797754](https://pubmed.ncbi.nlm.nih.gov/7797754/)) [V]. In 298 adults aged 20–29, smokers had higher resting HR and **female smokers fell 6.0 bpm and males 3.6 bpm short of age-predicted maximum HR**, with attenuated HR recovery only in women (Papathanasiou 2013, Hellenic J Cardiol 54(3):168–177) ([PDF](https://www.hellenicjcardiol.org/archive/full_text/2013/3/2013_3_168.pdf)) [V]. **In the CHRIS population study, HRV fell 9.8% (SDNN) and 8.9% (RMSSD) per 10 g of tobacco smoked per day** (PLoS ONE 2019, DOI 10.1371/journal.pone.0215053) ([PLoS ONE](https://journals.plos.org/plosone/article?id=10.1371%2Fjournal.pone.0215053)) [V, grade A dose term]. Successful quitters (n=20) had higher SDNN, RMSSD, pNN50, LF and HF than relapsers (n=42) (Harte & Meston 2013, DOI 10.1007/s12529-013-9295-0) ([Springer](https://link.springer.com/article/10.1007/s12529-013-9295-0)) [V; non-randomized contrast].

**The convergence of the 1-week abstinence drop (−7.3 bpm) with the review's average daytime elevation (~7 bpm) makes "about 7 beats per minute of your resting heart rate is the cigarettes" a defensible, memorable and user-checkable claim** [D]. Two constraints apply. Many wearables derive resting HR from sleep, where Minami's effect was less than half the daytime effect, so **expected deltas must be set against the sleep-derived metric (about −3.7 bpm), or the index will look unresponsive**. And Minami and Harte & Meston are male-only, Papathanasiou found HR-recovery effects only in women and CARDIA found none in Black men, so trajectories must not be identical for all users. No study tracks resting HR beyond 1 week after quitting, so the within-week curve is an interpolation: **T_auto ≈ 2–3 days**, giving 90–95% recovery by day 7 [M, grade C].

#### Small airways, FeNO and VO2max: narrative only, and FEF25-75 should be dropped

**A 2025 AJRCCM paper found that tobacco-exposed adults with oscillometry-defined small-airway dysfunction and preserved airflow had normal FEF25–75%, and that spirometry has poor sensitivity for SAD** (DOI [10.1164/rccm.202501-0028oc](https://doi.org/10.1164/rccm.202501-0028oc)) [V]. **The brief's proposed FEF25-75 marker is therefore insensitive in exactly the target population; drop it.** Impulse oscillometry detected SAD in asymptomatic smokers with preserved spirometry, but that cohort averaged 47 years and 26 pack-years ([PMC8449545](https://pmc.ncbi.nlm.nih.gov/articles/PMC8449545)) [V], and markers disagree with each other in "normal" smokers ([PMC9145514](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC9145514/)) [V]. Oscillometry needs clinic hardware, no reversibility data exist and no young-light-smoker norms were found, so **SAD gets weight 0**. FeNO is suppressed by smoking and rose after quitting in small studies, approximating non-smoker values by 4–8 weeks (n=19, [Chest](https://www.sciencedirect.com/science/article/abs/pii/S0012369215529966); n=9, [Clin Sci 2002](https://portlandpress.com/clinsci/article-abstract/103/1/15/67355/Increased-Nitric-Oxide-elimination-from-the)) [V], but another study found **no significant change over 3 months** ([PMC2697135](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2697135/)) [V]. Keep FeNO out of the index; if mentioned, explain the paradox that a rising value after quitting is recovery, not worsening.

For a 20–25-year-old, "you get out of breath on the stairs sooner" is the most motivating message, and two 2025 papers in young, physically active adults exist (MSSE, DOI 10.1249/MSS.0000000000003602, [PMC11878581](https://pmc.ncbi.nlm.nih.gov/articles/PMC11878581/); a gas-exchange-kinetics companion, [PMC13380561](https://pmc.ncbi.nlm.nih.gov/articles/PMC13380561/)) [V, existence only]. **No VO2max deficit and no post-quit fitness gain were retrieved, so no VO2max number may ship.** Papathanasiou 2007 is in **Eur J Cardiovasc Prev Rehabil 14(5):646–652, not Hellenic J Cardiol** (the Hellenic paper is the 2013 one) [V, correction].

#### Smell and clonal replenishment: slow partial recovery and the strongest narrative

**Twenty-eight quitters showed significant improvement in odor discrimination, identification and TDI scores 45 days after cessation, inversely associated with smoking duration** ([PubMed 30953390](https://pubmed.ncbi.nlm.nih.gov/30953390/)) [V, grade B], which favors the short-history young user. Recovery is incomplete for years: those who quit ≤15 years earlier remained impaired versus never-smokers (Siegel 2019, DOI 10.1002/alr.22357) ([Wiley](https://onlinelibrary.wiley.com/doi/10.1002/alr.22357)) [V], and a Japanese study found no relation with time since quitting ([PubMed 17956024](https://pubmed.ncbi.nlm.nih.gov/17956024/)) [V]. Frye 1990 showed long-term but reversible dose-related effects ([JAMA](https://jamanetwork.com/journals/jama/article-abstract/380894)) [V]; the quotable claim that recovery takes as long as the years smoked is a secondary characterization and unverified. **No taste data exist in these results; the common "taste and smell return in days" claim is unsupported.** Say "smell" and cite the 45-day study.

**Yoshida et al. 2020 (Nature 578:266–272, DOI 10.1038/s41586-020-1961-1) sequenced 632 single-cell-derived bronchial colonies from 16 people: smoking added roughly 1,000–10,000 mutations per cell, and near-normal cells were about fourfold more common in ex-smokers than current smokers and had longer telomeres** ([PMC7021511](https://pmc.ncbi.nlm.nih.gov/articles/PMC7021511/)) [V]. It is cross-sectional with no time constant, so it is a narrative module, never an animated curve. Its rhetoric is unusually strong for a user who dismisses lung age: the healthy cells were already there, protected from mutagenesis, and quitting lets them repopulate the lining.

#### The BTI formula, parameter table and weights

```
BTI(t) = Σ_k w_k · D_k(t),     D_k ∈ [0,1]  (0 = never-smoker state, 1 = heavy-smoker steady state),  Σ w_k = 1
D_k(t) = min(1, Σ_i a_k(CPD) · exp(−(t − t_i)/τ_k) + b_k(t))
b_k(t) = b_k(0) · exp(−(t − t_quit)/T_k)          # slow chronic offset after quit date
a_k(CPD): per-cigarette increment; calibrated so declared CPD reproduces the published steady-state
          smoker–nonsmoker gap (only VASC and HRV have published dose anchors)       [M]
```

| k | Domain | Live? | τ_k (fast) | T_k (slow) | Dose anchor | Grade | Notes |
|---|---|---|---|---|---|---|---|
| CO | COHb / exhaled CO | **Yes** | **6.49 h** awake; ×1.5–1.8 asleep | none | none verified | τ **A**; sleep **B**; dose **D** | Only primary, population-matched decay fit |
| NIC | Nicotine (urge channel) | Yes (modeled) | **2.89 h** | none | none verified | τ **C**; dose **D**; cotinine **D** | Verify Benowitz chapter |
| AUTO | HR / HRV / BP | **Yes (wearable)** | **~0.72 h** | **~2–3 d** (interpolated to 1-week endpoint) | **−9.8% SDNN, −8.9% RMSSD per 10 g/day** | τ **B**; T **C**; dose **A** | Expect ~half effect on sleeping HR; male-only recovery data |
| MCC | Mucociliary clearance | No (date-driven) | — | **~5–7 d** (85–95% by day 15) | none | **B** | Published data are a step at day 15 |
| VASC | Endothelium / stiffness | No (narrative) | **~0.5–1 h** (extrapolated) | **~30 d** | **−0.88 to −1.17 pp FMD/cigarette** | τ **C**; T **C**; dose **A** | Chronic young-adult abnormality with normal brachial BP |
| OLF | Smell | No (self-report) | — | **~45 d** to first improvement; incomplete for years | none | **B** | Faster with shorter history; no taste claims |
| SAD | Small airways | No | — | unknown | none | **D** | Weight 0, narrative only |
| GEN | Clonal replenishment | No | — | years, no constant | — | narrative | Never animate |

**Recommended v1 weights** (design choice by evidence grade × measurability × within-horizon responsiveness, with no empirical basis) [M]: **w_CO = 0.30, w_AUTO = 0.25, w_NIC = 0.15, w_VASC = 0.15, w_MCC = 0.10, w_OLF = 0.05, w_SAD = w_GEN = 0.** Revise against in-app engagement data.

**Display two numbers, not one.** Mixing hour-scale (CO, NIC) and week-scale (MCC, VASC, OLF) terms in one scalar makes the headline move fast and then stall, and it will read as broken when the hour terms bottom out on day 2 and nothing changes for a fortnight. Show an **"acute load"** (CO + NIC + AUTO-fast) and a **"recovery progress"** (MCC + VASC + OLF + AUTO-slow). **Only four parameters reach grade A: CO's τ, the CHRIS HRV dose term, the Amato FMD dose term and Minami's 1-week autonomic endpoint.** Shipping B/C curves is acceptable only with a visible provenance badge on each domain; D-grade numbers (per-cigarette ΔCOHb, cotinine τ, any VO2max figure, any SAD recovery curve) must not ship. **No existing "reversible toxicity" composite was found, so the BTI is novel and unvalidated**: nothing shows that displaying modeled biomarker recovery improves abstinence (Gate #2 tests that).

#### Re-grounding the canonical quit timeline

The popular "20 min / 8–12 h / 2 wk–3 mo / 1 / 5 / 10 / 15 yr" list is a guideline-consensus artifact; only the 1–9 month entry was read verbatim. Three early milestones can be replaced with primary kinetics, which is a real advantage over competitors reciting the 1990 list:

| Canonical claim | Re-grounded app copy | Source |
|---|---|---|
| 20 min: heart rate drops | "Within about 30 minutes, the heart-rate spike from your last cigarette has passed" | [PMC3641479](https://pmc.ncbi.nlm.nih.gov/articles/PMC3641479/) [V] |
| 8–12 h: CO normalizes | "About 75% of the CO from smoking clears in 9 waking hours; most is gone by 24 h" | [Sandberg 2011](https://journals.plos.org/plosone/article?id=10.1371%2Fjournal.pone.0028864) [V] |
| 1 week (not in canonical list) | "After a week, resting heart rate typically falls about 7 bpm (less during sleep)" | [Minami 1999](https://www.ahajournals.org/doi/10.1161/01.hyp.33.1.586) [V] |
| 2 wk–3 mo: circulation and lung function improve | "Nasal clearance returned to normal by day 15 in one study; vascular function starts improving within a month" | [Ramos 2011](https://onlinelibrary.wiley.com/doi/10.1111/j.1440-1843.2011.01985.x); [2025 review](https://discovery.dundee.ac.uk/en/publications/vascular-health-after-quitting-smoking-or-switching-to-e-cigarett/) [V] |
| 1–9 months: cough and breathlessness decrease (cilia) | Cite WHO/ACS by name as consensus; drop the cilia clause; note 9 vs 12 month disagreement | [WHO](https://www.who.int/news-room/questions-and-answers/item/tobacco-health-benefits-of-smoking-cessation); [ACS](https://www.cancer.org/cancer/risk-prevention/tobacco/guide-quitting-smoking/benefits-of-quitting-smoking-over-time.html) [V] |
| 45 days (not in canonical list) | "Smell measurably improved by 45 days in one study, faster for shorter smoking histories" | [PubMed 30953390](https://pubmed.ncbi.nlm.nih.gov/30953390/) [V] |
| 1, 5, 10, 15 yr risk milestones | Static "long-term" page cited to Surgeon General reports; outside the BTI | Not verified this session |

The late risk milestones are epidemiological projections a 22-year-old will not act on, and the Yoshida mechanism is a better long-horizon narrative. The 2020 Surgeon General report (*Smoking Cessation*) should be checked to see whether it revises any 1990 timing.

### 1.3 Alternative products need three exposure accumulators, and vaping never discounts a smoked cigarette

A single "cigarette-equivalent pack-year" cannot represent a world of bidis, hookah, heated tobacco, vapes and gutka. The evidence supports three parallel accumulators: **(a) combustion/particulate plus CO (lung tier)**, which drives the lung model and acute CO; **(b) nicotine (cardiovascular and addiction tier)**, which drives acute HR/BP, endothelial effects and dependence; and **(c) carcinogen tier, split into lung and oral sites**. Every product gets a weight per natural unit with a range and confidence. **Dual use is additive.** The scheme is an original synthesis: no published, validated multi-product pack-year algorithm exists, so it should be presented as such with a sensitivity analysis.

#### Dual users are exposed at least as much as smokers

**Exclusive vapers had 10–98% lower concentrations of exposure biomarkers (TSNAs, PAHs, most VOCs) than exclusive smokers in the PATH Wave 1 biomarker subsample (n=5,105), but still higher than never-users; exclusive smokers had 10–36% lower concentrations of several biomarkers than dual users, and among dual users toxicant levels rose with cigarette frequency** (Goniewicz 2018, JAMA Netw Open) ([UB ResearchConnect](https://researchconnect.buffalo.edu/en/publications/comparison-of-nicotine-and-toxicant-exposure-in-users-of-electron/); [Roswell Park](https://www.roswellpark.org/media/news/e-cigarette-users-have-lower-exposure-toxicants-long-they-dont-smoke-combustible)) [V]. Shahab et al. 2017 (Ann Intern Med, DOI 10.7326/M16-1107; n=181) found no clear between-group differences in nicotine after adjustment, and significantly lower TSNAs (including NNAL) and VOCs in long-term e-cigarette-only and NRT-only users ([PubMed 28166548](https://pubmed.ncbi.nlm.nih.gov/28166548/)) [V]. NASEM 2018 found **conclusive evidence that completely substituting e-cigarettes reduces exposure to numerous toxicants and carcinogens, and substantial evidence that experienced vapers' nicotine exposure can be comparable to smoking** ([NASEM ch. 3](https://www.nationalacademies.org/read/24952/chapter/3)) [V]. The derived dual-user multiplier on those biomarkers is about 1.11–1.56× an exclusive smoker [D]. The model rule is therefore: **the lung and carcinogen tiers use the cigarettes actually smoked at weight 1.0, the vaping terms are added on top, and the nicotine tier does not fall automatically on switching.**

#### Vaping adds symptoms, not demonstrated structural damage; switching helps the endothelium within a month

In an MGH longitudinal PATH analysis, **one-year respiratory-symptom incidence was 10.7% with no product, 11.8% exclusive vaping, 17.1% exclusive smoking and 19.7% dual use**, and exclusive vapers did not differ significantly from non-users ([Respiratory Therapy](https://respiratory-therapy.com/public-health/smoking/vaping-ecigarettes/vaping-smoking-tobacco-worse-outcomes/)) [V; Reddy et al., AJRCCM 2021 citation is PK]. A PATH Wave 2 analysis (n=28,171) found wheeze aOR 1.67 for exclusive vapers vs non-users and 0.68 vs exclusive smokers ([NAQC](https://www.naquitline.org/news/news.asp?id=442970)) [V, secondary], and a 2022 PATH analysis found the e-cigarette association sensitive to pack-year adjustment ([PubMed 35366322](https://pubmed.ncbi.nlm.nih.gov/35366322/)) [V]. Bhatta & Glantz 2020 (Am J Prev Med, DOI 10.1016/j.amepre.2019.07.028) reported e-cigarette use associated with respiratory disease independent of smoking ([UCSF](https://tobacco.ucsf.edu/node/81411)) [V], but Kenkel et al. replicated it and found **no association among never-smokers** ([NBER w27507](https://www.nber.org/papers/w27507.pdf)) [V]. A 2024 PATH transitions study found **complete switching associated with more wheeze resolution, and dual use without reduced smoking associated with less resolution than continued smoking** (Nicotine Tob Res, DOI 10.1093/ntr/ntae224) ([ScienceBlog](https://scienceblog.com/549379/switching-completely-to-e-cigarettes-improves-smokers-breathing-study-finds/)) [V].

The derived fraction of the smoking symptom excess attributable to exclusive vaping is 0.17 (MGH), about 0.57 (Li, log-odds) and about 0 (never-smokers), so the recommended **airway-irritation weight is central 0.15–0.2, range 0–0.6, low confidence** [D]. No source shows a structural pathway comparable to pack-year accrual, so **the structural tier for exclusive vaping is about 0 (≤0.05 placeholder)**. In the VESUVIUS RCT (George 2019, JACC 74(25):3112–3120, DOI 10.1016/j.jacc.2019.09.067; 114 smokers), **switchers' FMD improved 1.49 percentage points vs continuing smokers at 1 month, with no difference between nicotine and nicotine-free e-liquid** ([BHF](https://www.bhf.org.uk/what-we-do/our-research/impact-of-clinical-trials/vesuvius-trial); [qxmd](https://read.qxmd.com/doi/10.1016/j.jacc.2019.09.067)) [V], which implicates combustion constituents in endothelial dysfunction. Acute nicotine haemodynamics stay tied to the nicotine tier. **EVALI belongs to a separate illicit/THC-cartridge product flag, not to nicotine-vaping weights** (CDC's final count of 2,807 hospitalized cases and 68 deaths is PK, unverified).

Partial-recovery components after switching are real. **Nicotine-containing e-cigarette vapor reduced mucociliary function, including in vivo sheep tracheal mucus velocity, mainly via TRPA1** (Chung 2019, AJRCCM 200(9):1134–1145, DOI 10.1164/rccm.201811-2087OC) ([PMC6888648](https://pmc.ncbi.nlm.nih.gov/articles/PMC6888648)) [V]. **Premise correction: the 2019 paper's main finding concerns nicotine via TRPA1, not PG/VG.** The same group later found VG-containing aerosols reduced nasal CFTR activity in humans who vaped 7 days ([Front Pharmacol 2022](https://www.frontiersin.org/journals/pharmacology/articles/10.3389/fphar.2022.1012723/full)) [V]. Bronchoscopy showed 191 proteins altered in vapers vs 292 in smokers (79 shared), with MUC5AC raised in both (Ghosh 2018, [PMC5821909](https://pmc.ncbi.nlm.nih.gov/articles/PMC5821909)) [V], and **neutrophil elastase, MMP-2 and MMP-9 equally elevated in vapers and smokers** (Ghosh 2019, [PMC6884043](https://pmc.ncbi.nlm.nih.gov/articles/PMC6884043)) [V], both in small samples.

#### Heated tobacco lowers exposure, not proven risk

**HTP emissions of harmful constituents were ≥62% lower and particulate matter ≥75% lower than cigarettes, with 42–96% lower human exposure in switching studies; 20 of 31 studies were industry-affiliated**, with broadly consistent results (Simonavicius 2019, Tob Control, DOI 10.1136/tobaccocontrol-2018-054419) ([PMC6824610](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6824610/)) [V]. In Cochrane 2022 (Tattan-Birch, CD013790.pub2), **all RCTs were tobacco-industry funded, and NNAL at follow-up was higher in HTP users than in abstainers (log mean difference 0.50, 95% CI 0.34–0.66; moderate certainty)** ([Cochrane abstract](https://cochranelibrary.com/cdsr/doi/10.1002/14651858.CD013790.pub2/pdf/CDSR/CD013790/CD013790_abstract.pdf)) [V], about 1.65× abstainers if natural-log scale [D]. **On 7 July 2020 the FDA authorized an exposure-modification claim for IQOS and denied the risk-modification claim**, after TPSAC advised against a reduced-risk claim ([NAQC](https://www.naquitline.org/news/517720/FDA-Completes-Scientific-Review-Authorizes-Reduced-Exposure-Marketing-for-IQOS-Heated-Tobacco-Syste.htm); [Tobacco Tactics](https://tobaccotactics.org/?p=6989)) [V]. App copy must never say HTPs "heal" the lungs.

#### Bidis count one-to-one, not by tobacco mass

**A bidi holds about 216.8 mg of tobacco vs 696 mg in a cigarette, yet at >5 pack-years breath CO was higher in bidi smokers (18.9 ± 7.7 ppm) than cigarette smokers (13.6 ± 5.8 ppm); the authors concluded one bidi may be counted as one cigarette for pack-years** ([PubMed 20364610](https://pubmed.ncbi.nlm.nih.gov/20364610/)) [V]. In Mumbai cohorts, male all-cause mortality RR was **1.39 for cigarettes vs 1.78 for bidis** (Gupta & Mehta 2000, Bull WHO 78(7):877–883) ([SciELO](https://scielosp.org/article/bwho/2000.v78n7/877-883)) and adjusted **1.37 vs 1.64** (Gupta 2005) ([GHDx](https://ghdx.healthdata.org/node/283149)) [V]. Jha 2008 (NEJM, ~74,000 deaths) found smoking mortality RR 1.7 in men and 2.0 in women aged 30–69, with **tuberculosis the largest excess (RR 2.3 men, 3.0 women)** ([Fogarty/NIH](https://fic.nih.gov/News/GlobalHealthMatters/Pages/Smoking-India.aspx)) [V]. The PURE bidi substudy kept bidi and cigarette pack-years on the same scale, with symptoms highest in heavy bidi smokers ([DOAJ](https://doaj.org/article/02bde0c07c914cb9ba6969287c61d0c8)) [V]. **Premise correction: no published source supports a 0.25 or 0.5 bidi weighting; tobacco-mass weighting (0.31) would understate risk.** Use 1.0 (range 0.5–1.5) and turn on a region-aware TB-risk flag for South Asian users. The brief's "3–5× CO/tar" per bidi was not confirmed.

#### A hookah session is roughly 9× a cigarette's CO boost; convert it with wide uncertainty

In a 31-person crossover, **a waterpipe session of up to 45 minutes raised expired CO by 23.9 ppm vs 2.7 ppm for one cigarette, peak COHb was 3.9% vs 1.3%, peak plasma nicotine was similar (10.2 vs 10.6 ng/mL) and puff volume was 48.6 L vs 1.0 L** (Eissenberg & Shihadeh 2009, Am J Prev Med) ([PMC2805076](https://pmc.ncbi.nlm.nih.gov/articles/PMC2805076)) [V]; a replication found COHb 4.5% vs 1.2% ([WHO FCTC database](https://extranet.who.int/fctcapps/fctcapps/fctc/kh/wts/wts-database/waterpipe-tobacco-and-cigarette-smoking-direct-comparison)) [V]. The Primack 2016 meta-analysis, **published in Public Health Reports 131(1):76–85, not Nicotine Tob Res as the brief assumed**, pooled 17 studies: about 125× the smoke, 25× the tar, 2.5× the nicotine and 10× the CO of one cigarette ([PMC4716475](https://pmc.ncbi.nlm.nih.gov/articles/PMC4716475); [UPMC](https://www.upmc.com/media/news/primack-hookah-meta)) [V]. Raad 2011 (Chest, six cross-sectional studies) found waterpipe smokers' FEV1 SMD −0.43 vs non-smokers (about 4% predicted lower) and **no significant difference vs cigarette smokers** ([UB ResearchConnect](https://researchconnect.buffalo.edu/en/publications/effects-of-water-pipe-smoking-on-lung-function-a-systematic-revie/)) [V]. Use the measured session CO boost directly in the acute model, and a **lung-structural weight of about 5 cigarette-equivalents per session (range 1–25, very low confidence)**, the geometric mean of the COHb (3×) and eCO (9×) ratios [D]. Ask sessions/week, session length and whether the pipe is shared. Herbal "tobacco-free" shisha still produces CO from charcoal.

#### Smokeless and pouch use must not damage the lung avatar

Smokeless products involve no combustion, so **the lung tier is 0 for snus, gutka, khaini, zarda, mishri, gul, nicotine pouches and NRT**. The nicotine tier applies, and the carcinogen tier routes to an oral sub-module, high for gutka/khaini/betel quid and low for Swedish snus and pouches pending verification. Mumbai women, mainly smokeless users, had all-cause mortality RR 1.35 and adjusted 1.25 ([SciELO](https://scielosp.org/article/bwho/2000.v78n7/877-883); [GHDx](https://ghdx.healthdata.org/node/283149)) [V]. Snus cardiovascular and mortality estimates (Boffetta & Straif 2009; Byhamre 2021) and pouch biomarker studies are PK and largely industry-funded. **The lung avatar should not deteriorate with exclusive smokeless or pouch use; show separate oral-health and cardiovascular indicators.** Cigars, cigarillos and kreteks were not researched; their weights below are placeholders.

#### Weights per natural unit, relative to one manufactured cigarette

All values are derived inferences or design placeholders [D/M], not published constants.

| Product (unit) | wL lung/particulate | CO handling | wN nicotine | wC carcinogen (site) | Confidence |
|---|---|---|---|---|---|
| Manufactured cigarette (stick) | 1.0 | per-cigarette boost (~2.7 ppm eCO) | 1.0 | 1.0 (lung + oral) | Reference |
| **Bidi** (stick) | **1.0** [0.5–1.5] | ≥ cigarette (~1.4× per smoker) | 0.7 [0.3–1.2] | 1.0 [0.7–1.5] | Moderate (lung, CO); low (nicotine) |
| Kretek (stick) | 1.0 [1.0–1.5] | ≈ cigarette | 1.0 | 1.0 | **PLACEHOLDER** |
| Cigarillo, inhaled (stick) | 1.0 [0.5–2] | ≈ cigarette | 1.0 | 1.0 (oral higher) | **PLACEHOLDER**; ask "Do you inhale?" |
| Large cigar | not set | — | — | High oral | **Do not ship without data** |
| **Hookah** (session, ~45 min, 1 smoker) | **5** [1–25] | Session boost directly: eCO +24 ppm, COHb peak ~4–4.5% | 1.6 [1–2.5] | 5 [1–25] | Very low (lung, carcinogen); moderate (CO, nicotine) |
| **HTP** (heatstick) | **0.2** [0.05–0.6] | ≈0 [0–0.1] (not retrieved) | 0.85 [0.7–1.0] (not retrieved) | 0.2 [0.05–0.6] | Moderate-low; industry-dominated; exposure ≠ risk |
| **E-cigarette**, exclusive (per cigarette-equivalent or vaping day) | **0.0–0.05** structural + irritation state 0.15–0.2 [0–0.6] | 0 | **1.0** [0.5–1.0] | 0.05 [0.02–0.3] (lung) | Low (lung); moderate (nicotine, carcinogen) |
| **Dual** (cig + EC) | Cigarettes at 1.0 each, no discount, × [1.0–1.5] + EC irritation | Driven by cigarettes | Sum | Sum | Moderate |
| Snus (portion) | **0** | 0 | PLACEHOLDER | Low, oral | Low |
| Gutka / khaini / zarda / betel quid / mishri | **0** | 0 | PLACEHOLDER | **High, oral** | Low-moderate |
| Nicotine pouch | **0** | 0 | PLACEHOLDER | ~0, oral (verify TSNA traces) | Low |
| NRT | 0 | 0 | ≈ smoker level possible | ~0 | Moderate |

```
for each day d, product p (units in natural units):
  E_lung(d)  = CPD_cig(d)·1.0 + Σ_p wL_p·units_p,d                 # combustion/particulate
  E_CO(d)    = measured or modeled per-event CO boost (NOT cig-eq)   # feeds Section 1.2 CO model
  E_nic(d)   = CPD_cig(d)·1.0 + Σ_p wN_p·units_p,d                 # CV/addiction
  E_carc_lung(d), E_carc_oral(d) = Σ_p wC_p,site·units_p,d
  E_irrit(d) = 1 if any inhaled non-combusted aerosol (EC/HTP) that day else 0
PackYear_eq(lung) = Σ_d E_lung(d) / 20 / 365.25
Dual use: never subtract; optional multiplier on E_lung 1.0 [1.0–1.5]
Display: show avatar damage as a band when non-cigarette products are >20% of E_lung   [M]
```

Inputs are sticks/day for bidi, kretek, cigarillo and HTP; sessions/week, minutes and sharing for hookah; days/week plus a self-rated "about how many cigarettes' worth" for vapes (ml/day × mg/ml optional); uses/day and type for smokeless; pouches/day and mg for pouches. Regional defaults switch on bidi, gutka and the TB flag in South Asia, hookah in the Middle East and North Africa, kretek in Indonesia, and snus/pouches in Northern Europe.

Recovery after switching should be split by component. The multipliers below are fractions of the full "quit everything" recovery rate, all design inferences [M]; confidence is high for CO, moderate for FMD and symptoms, and low for MCC and proteases.

| Recovery component | Quit all | Exclusive EC | Exclusive HTP | Smokeless/pouch/NRT | Dual (cig + EC) | Hookah/bidi continuing |
|---|---|---|---|---|---|---|
| CO / COHb | 1.0 | **1.0** | 0.9–1.0 | **1.0** | No credit (cigarettes drive it) | 0 on session days |
| Endothelial / FMD | 1.0 | **0.8–1.0** | 0.5–0.9 | 0.6–0.9 | Proportional to cigarette reduction | 0–0.3 |
| Acute HR/BP (nicotine) | 1.0 | **0–0.2** | 0–0.2 | 0–0.2 | 0 | 0 |
| Mucociliary clearance | 1.0 | **0.4–0.8** | unknown | 0.8–1.0 (lung) | 0–0.3 | ~0 |
| Airway inflammation / proteases | 1.0 | **0.3–0.7** | unknown | 1.0 (lung) | ~0 | ~0 |
| Respiratory symptoms | 1.0 | **0.8–1.0** | unknown | 1.0 | 0–0.3 unless CPD falls substantially | 0 |
| Lung-structural accrual | Stops | **Stops** (≤0.05) | Partial (0.05–0.6) | **Stops** | Full cigarette count | Continues at product weights |

#### Present e-cigarettes as an evidence-based quit aid where legal, and dual use as a transition

**Cochrane 2025 (Lindson et al., CD010216.pub10, searched to 1 March 2025) found nicotine e-cigarettes produced more 6-month quits than NRT: RR 1.55 (95% CI 1.28–1.88), I² = 0%, 9 studies, 2,703 participants, high certainty, about 3 more quitters per 100** ([Cochrane Library](https://www.cochranelibrary.com/cdsr/doi/10.1002/14651858.CD010216.pub10/full)) [V]. A 2026 update reportedly gives **RR 1.61 (1.23–2.12), 11 studies, 4,114 participants**, drawing on 80 RCTs ([Pharmaceutical Journal](https://pharmaceutical-journal.com/article/news/vapes-more-effective-than-other-smoking-cessation-methods-cochrane-review-finds); [Cochrane news 2026](https://www.cochrane.org/about-us/news/vapes-help-more-people-quit-smoking-other-methods)) [V, secondary; not verified on the Cochrane Library]. Observational PATH analyses reporting lower quit odds among vapers are confounded by heavier smokers taking up vaping, and RCTs outrank them. The product logic is a **"dual-use timer"**: if dual use persists beyond a configurable window (4–12 weeks, a design choice) without a drop in cigarettes/day, prompt toward complete switching or quitting. E-cigarette sale is banned in India and several other countries [PK], so the recommendation must be market-gated. **Do not hard-code "95% less harmful"**: the PHE 2015 figure drew partly on an expert-panel MCDA (Nutt 2014) and was criticized in The Lancet and BMJ [PK, unverified]; use tier-specific ranges and state that long-term (>10 year) vaping outcomes are unknown.

## Section 2. Addiction neuroscience and third-wave interventions: acceptance of the body's urge is the one confirmed mechanism

### 2.0 The January 2026 BMJ EBM meta-analysis is real, low-certainty, and dominated by one ACT trial

**The January 2026 meta-analysis exists: Chu S et al., "Efficacy of smartphone apps used alone or with traditional interventions for smoking cessation: a systematic review and meta-analysis," BMJ Evidence-Based Medicine 2026;31(4):242–253, DOI 10.1136/bmjebm-2025-113971, PMID 41529951**, press release 13 January 2026, funded by the China Association on Tobacco Control for Health, 31 RCTs and 12,802 participants aged ≥15, searched to August 2025 ([PubMed 41529951](https://pubmed.ncbi.nlm.nih.gov/41529951/); [BMJ press release](https://bmjgroup.com/phone-apps-nearly-3-times-as-good-as-no-basic-support-for-quitting-smoking-long-term/); [EurekAlert](https://www.eurekalert.org/news-releases/1112127)) [V].

| Comparison (6-month continuous abstinence unless stated) | RR (95% CI) | Studies / N | I² | GRADE |
|---|---|---|---|---|
| Apps vs no/minimal support | **2.85 (1.61–5.05)** | 4 / 1,402 | 0% | Low |
| Apps + traditional interventions vs traditional alone | **1.98 (1.24–3.16)** | 4 / 2,163 | 85.7% | Low |
| Apps + pharmacotherapy vs pharmacotherapy alone | **1.77 (1.09–2.88)** | 3 / 1,502 | 86.0% | Low |
| Psychological-theory apps vs traditional-behavioral apps, 3 months | **+69%** | 2 / 2,565 | — | **High** |
| Psychological-theory apps vs traditional-behavioral apps, 6 months | **+36%** | 4 / 3,258 | — | **High** |

The authors call the findings "exploratory" and say they need confirmation in higher-quality trials with longer follow-up [V]. Three readings matter for the build. First, the "nearly 3 times" headline rests on four small studies and conflicts with Cochrane 2019 (smartphone apps vs less intensive support RR 1.00, 0.66–1.52, very low certainty; [Cochrane](https://www.cochranelibrary.com/cdsr/doi/10.1002/14651858.CD006611.pub5/full)) [V] and a 2024 Respirology meta-analysis (RR 0.93, 0.79–1.09; [Respirology, DOI 10.1111/resp.14673](https://onlinelibrary.wiley.com/doi/full/10.1111/resp.14673)) [V]. No 2025–2026 Cochrane update of CD006611 was found. Second, **the only high-certainty comparison is theory-based vs traditional apps, and 2,415 of its 2,565 three-month participants are plausibly the iCanQuit trial**, so it is strong single-trial evidence, not broad replication (inference; the included-trial list was not retrieved). Third, the add-on comparisons have I² around 86%, so the magnitude of any app-plus-medication benefit varies widely by app. A 2025 NEJM Perspective notes there are **no LMIC-based app trials** ([NEJM, DOI 10.1056/NEJMp2500683](https://www.nejm.org/doi/full/10.1056/NEJMp2500683)) [V], so a global app extrapolates outside its evidence base. Claims the app may make: "Pooled trial evidence suggests apps may improve quitting compared with minimal support (low-certainty evidence)" and "The strongest evidence is for acceptance-based app content." Claims to avoid: "apps triple your chances."

### 2.1 ACT beats guideline-based CBT on a phone, not on the web, and only body-and-emotion acceptance mediates

#### The Fred Hutch trial record

| Trial | Design | Result | Status |
|---|---|---|---|
| **iCanQuit** (Bricker 2020, JAMA Intern Med 180(11):1472–1480, NCT02724462) | ACT app vs NCI QuitGuide, n=2,415, 12 months | **30-day PPA at 12 mo 28.2% vs 21.1%, OR 1.49 (1.22–1.83), NNT 14** | [V] ([Fred Hutch](https://www.fredhutch.org/en/news/releases/2020/09/fred-hutch-led-clinical-trial-shows-new-smartphone-app-helps-smokers-quit.html); [AAFP](https://www.aafp.org/afp/2021/0401/p441)) |
| iCanQuit, high dependence | Secondary | 24% vs 17%, OR 1.47 | [V] ([PubMed 36683573](https://pubmed.ncbi.nlm.nih.gov/36683573)) |
| iCanQuit, mental-health disorders (770 vs 785) | Secondary | Cessation, engagement, satisfaction all greater | [V] ([Santiago-Torres 2024](https://onlinelibrary.wiley.com/doi/10.1155/2024/1055801)) |
| iCanQuit, Black adults | Secondary | 28% vs 20% complete-case (OR 1.60); n.s. under missing-as-smoking | [V] ([Addiction 2022](https://onlinelibrary.wiley.com/doi/abs/10.1111/add.15721)) |
| **WebQuit** (Bricker 2018, Addiction 113(5):914–923) | ACT website vs Smokefree.gov, n=2,637, 88% retention | **24% vs 26%, OR 0.91 (0.76–1.10); Bayes factor 0.17 (evidence of no difference)** | [V] ([PMC5930021](https://pmc.ncbi.nlm.nih.gov/articles/PMC5930021/)) |
| **QuitBot** ("Ellen" chatbot) pilot | vs SmokefreeTXT | 63% vs 38.5% 3-month 30-day PPA among those viewing all 42 days (complete-case pilot); Phase III NCT04308759 not yet reported | [V] ([JMIR mHealth 2024;12:e57318](https://mhealth.jmir.org/2024/1/e57318)) |
| **ACT on Vaping** pilot (Heffner 2025, NTR, DOI 10.1093/ntr/ntaf112) | Ages 18–30, n=61 | Satisfaction 3.8/5; attrition ~23% app vs ~3% control; full trial NCT06909500 (n≈1,178) pending | [V] ([PMC13101998](https://pmc.ncbi.nlm.nih.gov/articles/PMC13101998/)) |
| ACT meta-analysis (Fan 2025, Worldviews Evid Based Nurs) | ACT vs all controls | RR 1.48 (1.03–2.14), I² = 81% | [V] ([Wiley](https://sigmapubs.onlinelibrary.wiley.com/doi/10.1111/wvn.70086)) |
| Hernández-López 2009 (group ACT vs group CBT) | N≈81 | ~30% vs 13% at 12 months | [PK] |

iCanQuit has **8 levels built on two ACT processes, acceptance of cravings and values-guided action; levels 2–4 hold 26 acceptance exercises and later levels 25 exercises on smoke-free activities, withdrawal, slips, depression and weight**. When a user records a lapse, **the app encourages but does not require a new quit date and a return to levels 1–4** ([Santiago-Torres 2024](https://onlinelibrary.wiley.com/doi/10.1155/2024/1055801)) [V]. The CBT contrast is precise: **iCanQuit "teaches users to accept urges and let them pass," while QuitGuide "emphasizes avoiding high-risk situations and keeping hands and mouths busy"** [V].

**The serial mediation is the most important design input in Section 2: iCanQuit → engagement (logins, minutes, unique days) → increased acceptance of internal cues from baseline to 3 months → cessation, and the acceptance that mediated was of physical sensations and emotions, not of thoughts; valued living did not mediate** (Bricker 2021, JMIR mHealth 9(11):e32847) ([PMC8663588](https://pmc.ncbi.nlm.nih.gov/articles/PMC8663588/)) [V]. The same pattern held in dual users ([PMC12360788](https://pmc.ncbi.nlm.nih.gov/articles/PMC12360788/)) [V]. Combined with the null WebQuit result, ACT content is not sufficient by itself; short, repeated, on-demand smartphone practice is what plausibly drives the effect. **The app's core drill should therefore be "notice and allow the bodily urge", with emotion acceptance second; defusion and values support motivation, but their causal role is unproven.**

#### Keep the CBT scaffold, swap the coping module

Standard behavioral support is well codified: 43 smoking-cessation BCTs (Michie 2011, Addict Behav, DOI 10.1016/j.addbeh.2010.11.016), the 93-item BCT Taxonomy v1 (Michie 2013, DOI 10.1007/s12160-013-9486-6) and the NCSCT competences (Michie 2011, DOI 10.1007/s12160-010-9235-z) [PK]. The recommended hybrid keeps the BCT scaffold (quit date, pharmacotherapy advice and adherence prompts, self-monitoring, feedback on progress and money saved, relapse planning, ex-smoker identity) and **replaces the coping-with-urges module with ACT acceptance and urge surfing**, which is exactly the contrast iCanQuit tested. Avoidance tips such as removing cigarettes from the home can remain as secondary environmental advice, not the primary coping mode.

#### Ironic-process rebound bans suppression language

**Smokers told to suppress smoking thoughts smoked less during the suppression week but significantly more than other groups the following week** (Erskine, Georgiou, Kvavilashvili 2010, Psychol Sci, DOI 10.1177/0956797610378687; n=85) ([BPS Research Digest](https://www.bps.org.uk/research-digest/stubbing-out-thoughts-smoking-leads-smokers-end-smoking-more)) [V; direction only, effect sizes not retrieved]. Wegner's white-bear studies showed suppression followed by **more** thoughts once expression was allowed (J Pers Soc Psychol 1987, DOI 10.1037/0022-3514.53.1.5) ([PDF](https://dtg.sites.fas.harvard.edu/DANWEGNER/pub/Wegner,Schneider,Carter,&White%201987.pdf)) [V], and Wegner's 1994 model explains why stress and cognitive load make the ironic monitor dominate [PK]. Smokers who showed suppression-related facial expressions during cue exposure later valued smoking more (Sayers & Sayette 2013, DOI [10.1177/0956797613479977](https://doi.org/10.1177/0956797613479977)) [V]. A 2012 follow-up was inconsistent on whether desire mediates the rebound ([Springer](https://link.springer.com/article/10.1007/s00213-011-2391-4)) [V]. No trial has tested app copy wording directly, so the rules below are extrapolated.

| Banned / flagged copy | Preferred copy |
|---|---|
| "Don't think about smoking" · "Get it out of your head" | "Notice it" · "Make room for it" |
| "Fight / beat / crush the craving" · "Resist" · "Block the urge" | "Ride it out" · "Cravings rise and fall" |
| "Push it away" · "Stay strong and ignore it" | "Let it be there while you…" · "You don't have to obey it" |
| Any "zap / delete the thought" mechanic | "Thanks, mind" · "That's a thought, not an order" |
| "Get your mind off smoking" (as distraction) | "Choose something that matters to you while the urge is here" |

Distraction is allowed when framed as a valued choice; a single focused distracter reportedly eliminated the paradoxical effect in Wegner's work (secondary, unverified).

#### ACT micro-exercises (paraphrased metaphors; original wording)

The six ACT processes are acceptance, defusion, present-moment contact, self-as-context, values and committed action (Hayes, Strosahl & Wilson, *ACT*, 2nd ed., Guilford 2012; Hayes 2006, DOI [10.1016/j.brat.2005.06.006](https://doi.org/10.1016/j.brat.2005.06.006)) [PK]. The metaphors below are paraphrased and attributed, not verbatim scripts, which keeps the app clear of copyright. None has been tested as a standalone module, and no trial isolates individual metaphors.

| Exercise | Duration | ACT process | Mechanic (original design) |
|---|---|---|---|
| **Shape the Craving** | 60 s | Acceptance (body) — the confirmed mediator | User gives the urge a location, size, color, temperature and movement |
| **Bus Driver** (after "Passengers on the Bus") | 60–90 s | Defusion + values | User picks 2–3 "passengers" ("Just one won't hurt", "I'm stressed", restless hands); they ride as bubbles; user taps "Keep driving" toward a value card; bubbles stay but shrink. Close: "They can ride along. You're still driving." |
| **Drop the Rope** (after "Tug-of-war with a monster") | 45 s | Acceptance | User pulls (struggle animation intensifies), then taps "Drop the rope"; the monster remains, hands are free; prompt: "What will you do with your hands now?" |
| **Thought Stream** (after "Leaves on a Stream", Hayes 2005) | 60 s | Defusion | User types or picks a smoking thought; it floats away on a leaf. **No delete or zap button** |
| **Name It** (Harris, *ACT Made Simple*) | 20 s | Defusion | "I need a smoke" becomes "I'm noticing the thought that I need a smoke… and I can choose what I do next" |
| **Chessboard** | 45 s | Self-as-context | User is the board holding pro- and anti-smoking pieces, not a player |
| **Values Compass** | 2–3 min onboarding; weekly refresh | Values + committed action | Pick top values (family, health, money, freedom, role model); link one daily "small step" |
| **White Bear Demo** | 60 s onboarding | Psychoeducation | "For 30 seconds, try not to think of a white bear. Tap each time it pops up." Show the count, then: "That's why this app won't ask you to push cravings away." **Never use a cigarette as the target** (cue priming) |

#### The 180-second Urge Surfer

**Brief urge-surfing instructions did not reduce urge intensity but did reduce cigarettes smoked over the following 7 days** (Bowen & Marlatt 2009, Psychol Addict Behav 23(4):666–671; N=123 college smokers) ([ResearchGate](https://www.researchgate.net/publication/40755906_Surfing_the_Urge_Brief_Mindfulness-Based_Intervention_for_College_Student_Smokers)) [V], so the mechanism is changing the response to urges, not eliminating them. Mindfulness training beat the ALA Freedom From Smoking program at 17 weeks, **31% vs 6% point-prevalence abstinence (p=0.01)** ([Brewer 2011](https://www.researchgate.net/publication/51461381_Mindfulness_training_for_smoking_cessation_Results_from_a_randomized_controlled_trial)) [V, secondary]; end-of-treatment was 36% vs 15% (p=.063), which reconciles the brief's figure, and **the DOI appears to be 10.1016/j.drugalcdep.2011.05.027, not 2011.03.027** [PK correction]. Mindfulness training weakened the craving-smoking link without removing craving (Elwafi 2013, [PMC3619004](https://pmc.ncbi.nlm.nih.gov/articles/PMC3619004)) [V]. The Craving to Quit app (Garrison 2020, NTR, DOI 10.1093/ntr/nty126; n=556) improved abstinent days during the quit period but showed **no group difference at 6 months (overall 11.1%)** ([PubMed 29917096](https://pubmed.ncbi.nlm.nih.gov/29917096/)) [V], and a 58-county California trial of app-based mindfulness telehealth found OR 2.00 (1.03–3.87) for abstinence days ([JNCI Cancer Spectrum 2023](https://academic.oup.com/jncics/article/7/6/pkad095/7407349)) [V]. Cochrane 2022 found no clear long-term benefit of mindfulness [PK]. The Bowen & Marlatt DOI in the brief (10.1037/a0017811) could not be verified; the recalled alternative is 10.1037/a0017127 [PK]. **The widely repeated "cravings pass in 3–5 minutes" has no primary source in these notes; say "urges rise and fall; many ease within minutes."**

The protocol below is a design synthesis from Bowen & Marlatt, Brewer's RAIN sequence (Recognize, Allow, Investigate, Note) [PK] and the iCanQuit mediation result. It has not been trial-tested as specified.

| Time | Step | User action | Narration (original, paraphrase-level) |
|---|---|---|---|
| 0–10 s | **Check-in** | Rate urge 0–10; optional context chip (stress / after meal / coffee / alcohol / boredom / people smoking) | "Thanks for opening this instead of the pack. You don't have to make this urge go away — we'll just watch it together." |
| 10–30 s | **Anchor** | Two slow breaths paced by an expanding circle (~4 s in, 6 s out) | "Feel your feet on the floor. Let the breath set the pace." |
| 30–70 s | **Locate & label (body)** | Tap a body map (mouth, throat, chest, stomach, hands, head); pick words (tight, buzzy, hollow, warm, restless, pulling) | "Where is the urge living right now? What does it feel like — not what it's telling you to do, just how it feels." |
| 70–130 s | **Ride the wave** | Wave tracks the breath with the user as a surfer on the crest; optional "just one" thought bubble floats past | "Urges rise, peak, and fall. It may get stronger before it eases — that's normal. You're on the board, not under the water. If 'just one' shows up, notice it: that's a thought, not an order." |
| 130–160 s | **Allow & notice change** | Tap "still rising / steady / easing" | "Whatever it's doing is OK. Make a little room for it — the way you'd let a wave pass under you." |
| 160–180 s | **Re-rate & choose** | Rate 0–10 again; pick one valued next action; log "Surfed ✓" | "You rode out [X] seconds of a craving without smoking. What's one thing you'll do next that matters to you?" |

Five rules come from the evidence. **Success is "didn't smoke / chose an action", never an intensity drop**, so celebrate even when the post-rating is higher, and never show a failed state. Body location and sensation labelling dominate because that is the confirmed mediator. No suppression verbs appear anywhere. "Surf again" and "longer surf" buttons let the user chain rounds, because one 3-minute window may not span a craving. Pre/post ratings and context are logged to feed personal insights ("Your urges dropped an average of 2 points in 3 minutes"; "Most happen after coffee") and the lapse chain analysis. Position urge surfing as an in-the-moment tool alongside pharmacotherapy, not a standalone cure, given uncertain 6-month durability. Section 2.5 explains why the breathing pace inside the Anchor and Ride steps should be about 0.1 Hz, and Section 4 specifies its haptics.

### 2.2 JITAI and EMA: ship the trial-proven rules score first and layer machine learning on top

#### The framework and the three smoking precedents

A JITAI maps **tailoring variables** onto **intervention options** (always including "nothing") at **decision points**, via **decision rules**, to move a **proximal outcome** toward a **distal outcome**, targeting moments of vulnerability, opportunity and receptivity (Nahum-Shani et al., Ann Behav Med 2018;52(6):446–462, DOI 10.1007/s12160-016-9830-8) ([U-M d3c](https://d3c.isr.umich.edu/mobilehealth/)) [V; component wording PK]. Micro-randomized trials randomize each person at every decision point to estimate proximal causal effects and their decay (Klasnja 2015, DOI 10.1037/hea0000305) [PK]; in HeartSteps the proximal effect declined over study days [PK]. The 2026 Annual Review by Nahum-Shani & Murphy names three field-level problems: people cannot engage when they most need it, engagement is generally suboptimal, and **fixed deterministic rules cannot adapt to habituation** ([PubMed 40939059](https://pubmed.ncbi.nlm.nih.gov/40939059/)) [V]. A meta-analysis of JITAIs and EMIs for mental health found a small effect, **g = 0.15 (0.05–0.26)** ([PubMed 41027677](https://pubmed.ncbi.nlm.nih.gov/41027677/)) [V].

| Program | Mechanism | Key numbers | Status |
|---|---|---|---|
| **Smart-T / Smart-T2** (Businelle, Hébert; Univ. of Oklahoma) | Weighted 6-item EMA score at each of 5 prompted EMAs/day; immediate messages tailored to elevated factors | Estimator flagged **80% of lapses within 4 h at 17% false-positive rate** ([NCT03740490 protocol](https://cdn.clinicaltrials.gov/large-docs/90/NCT03740490/Prot_SAP_000.pdf)); pilot (n=81) CO-verified 7-day PPA at 12 wk 22% vs 15% vs 15% ([JMIR 2020;22(3):e16907](https://www.jmir.org/2020/3/e16907/)); **full RCT (JAMA Netw Open, 14 Aug 2025, DOI 10.1001/jamanetworkopen.2025.26691; N=454 low-income adults, both arms NRT): biochemically verified 7-day PPA at 26 wk 16.4% vs 10.0% for QuitGuide (ITT); 23.1% vs 14.3% complete-case** ([JAMA Netw Open](https://jamanetwork.com/journals/jamanetworkopen/fullarticle/2837640)) | [V] |
| **Quit Sense** (Naughton; UEA/Cambridge) | Pre-quit "train the app" logging of each cigarette with cues + GPS; geofences around repeated smoking places; post-quit dwell-triggered tailored support; fully on-device, no internet needed | Feasibility RCT N=209: **verified 6-month sustained abstinence 11.5% vs 2.9%, aOR 4.57 (1.23–16.94)**, but only 39% saliva return; 75% installed and set a quit date; ~51% engaged >1 week; no between-group differences in hypothesized mechanisms ([PMC10256891](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC10256891/); [NIHR KQYT5412](https://www.journalslibrary.nihr.ac.uk/phr/KQYT5412)); no full efficacy RCT found | [V] |
| **Sense2Stop** (Spring, Murphy, Kumar) | MRT; chest-band ECG/respiration → cStress on phone labels each minute; stressed/non-stressed minutes randomized to prompt | 75 smokers, 4 days pre-quit + 10 post; **2.5–3 prompts/day**; proximal outcomes over 2 h ([PubMed 34375749](https://pubmed.ncbi.nlm.nih.gov/34375749/)); results only in a 2023 conference abstract | [V] |

**Smart-T is the strongest efficacy evidence for a smoking JITAI**, and its six risk factors are **urge, stress, cigarette availability, alcohol use, motivation to quit and proximity to others smoking** ([JMIR 2016 e275](https://www.jmir.org/2016/10/e275/)) [V]. Messages tailored to urge, availability or stress were followed by larger reductions in that same factor (Hébert 2018, [PubMed 29121530](https://pubmed.ncbi.nlm.nih.gov/29121530)) [V], and the Smart-T arm showed a weaker negative-affect-to-urge link ([Frontiers 2022](https://www.frontiersin.org/journals/digital-health/articles/10.3389/fdgth.2022.864003/full)) [V]. **The exact item weights and thresholds were not obtained**, two "62%" summaries of the 2016 paper could not be reconciled, and a fragment about availability weighting must not be implemented without the full text. The JAMA paper calls the intervention "Smart-T" while a 2022 analysis calls it "Smart-T2". **No Smart-T3 record was found.** The Quit Sense geofence rule is: a geofence forms when the user reports smoking **more than once** in a place (the Q Sense pilot required more than four); v2 also adds post-quit lapse locations. Trigger timing is described two ways: **dwell ≥5 minutes** (protocol) or **dwell 1–15 minutes, re-triggering after 3 hours** (2025 process evaluation, [PMC12290499](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC12290499/)) [V]. Radius and clustering algorithm were not obtained.

#### Machine learning predicts well within groups and poorly for new people

| Study | Data | Best group AUC | New-individual AUC |
|---|---|---|---|
| Perski 2023 (NTR 25(7):1330–1339; Smoke Free app) | N=791, 37,002 entries, **7.6% lapses**, ≥20 craving entries per user | **0.969** (0.961–0.978) | range **0.482–1.000** |
| Perski 2024 (PLOS Digit Health; Fitbit Charge 4 HR + steps) | 38 people, 16 EMAs/day × 10 days | 0.899 → **0.952** with Fitbit | median **0.639 → 0.745** |
| Leppin, Perski 2026 (PLOS ONE 21(5):e0349028) | 37 people, 16 EMAs/day × 10 days | — | median lapse AUC **0.659**; "modest" |
| Hébert 2021 (Drug Alcohol Depend 218:108340) | n=74, 5 EMAs/day × 4 wk | Cox hazard model; 31 candidates, 7 significant | no AUC reported |

Sources: [PubMed 36971111](https://pubmed.ncbi.nlm.nih.gov/36971111/); [PMC11343380](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC11343380/); [PLOS ONE 2026](https://journals.plos.org/plosone/article?id=10.1371%2Fjournal.pone.0349028); [PMC8496911](https://pmc.ncbi.nlm.nih.gov/articles/PMC8496911/) [V].

**Leppin 2026 concludes that ML alone "is unlikely to be sufficient" and is best combined with rules, and that reducing the EMA feature set had negligible impact on lapse prediction**, which is direct evidence that a short, low-burden EMA works [V]. The gap between within-sample group AUCs (0.90–0.97) and new-individual medians (0.64–0.75) is the key engineering fact: random pooled splits leak each person's patterns into both sets. **Validate with leave-one-subject-out and time-forward splits and report per-user AUC distributions.** No 2023–2026 consumer-smartwatch HRV/EDA craving or lapse study with an AUC was found, so **wearable features must be optional and degrade gracefully**. The best consumer-wearable evidence is Fitbit heart rate plus steps. puffMarker (Saleheen 2015, UbiComp, DOI 10.1145/2750858.2805832; 61 newly abstinent smokers) is a lapse *detector* using chest respiration and wrist IMU ([PubMed 26543927](https://pubmed.ncbi.nlm.nih.gov/26543927/)) [V], and a smartwatch study cites **78% sensitivity and 88% specificity** for smoking detection ([JMIR Form Res 2024](https://www.sciencedirect.com/org/science/article/pii/S2561326X24006553)) [V], good enough to auto-suggest a log ("Did you just smoke?") but not ground truth. Against Section 0's Gate #3 criterion (median within-person AUC ≥0.75), the published medians of 0.64–0.75 put JITAI prediction at risk 4, which is why the rules layer must stand alone.

#### Logging is measurement, not a habit-circuit treatment

**No evidence shows that logging cigarettes changes striatal habit circuitry.** The dorsal-striatum "actions to habits to compulsion" model (Everitt & Robbins 2005, DOI 10.1038/nn1579; 2016, DOI 10.1146/annurev-psych-122414-033457) is largely animal-based theory and is contested by goal-directed accounts (Hogarth 2020, DOI [10.1038/s41386-020-0600-8](https://doi.org/10.1038/s41386-020-0600-8)) [PK]. McFall 1970 found reactivity depends on *what* is logged: recording cigarettes smoked tended to increase smoking, recording urges resisted decreased it (DOI 10.1037/h0030087) [PK], and EMA reactivity in smoking is generally small (Shiffman 2009; Rowan 2007) [PK]. Quit Sense found no mechanism differences despite its pre-quit logging [V]. The copy rule is: **"Logging helps you notice your patterns and teaches the app when you're most at risk"**, never "logging rewires your brain's habit center." Post-quit, frame "urges resisted" logs as a mastery record. **The baseline must keep normal smoking and lead to an abrupt quit date**, because gradual reduction was not non-inferior to abrupt quitting (Lindson-Hawley 2016, Ann Intern Med, DOI 10.7326/M14-2805: 4-week abstinence 39.2% vs 49.0%; 6-month 15.5% vs 22.0%) [PK]. An adapted SRBAI automaticity item (Gardner 2012, DOI 10.1186/1479-5868-9-102) per cigarette lets the product *measure* whether awareness logging lowers self-rated automaticity, a testable claim rather than an assumed one.

#### The 5–7-day Pre-Quit Mindful Baseline

Precedents ran pre-quit monitoring for 4–7 days: Sense2Stop 4 days, Smart-T 7 days at 5 EMAs/day with **87% compliance and 15% saying 5/day was too many** ([PMC5187451](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5187451/)) [V]. Substance-use EMA compliance averages **about 75%** across roughly 125 studies (Jones 2019, Addiction) ([OSF](https://osf.io/thmgy/overview)) [V]; sources conflict on whether prompts per day lower compliance. The protocol below is a design recommendation [R], not a validated specification.

| Element | Specification |
|---|---|
| Length | **7 days default** (one full weekday/weekend cycle); minimum 5 when data quota met |
| Per-cigarette log | Event-contingent, **≤20 s, one screen**: timestamp† and geofence cluster ID† (passive); location type (home/work/car/outside/bar-restaurant/other); activity (work break, after meal, coffee, alcohol, driving, socializing, screens, waking, before bed); others smoking (Y/N), alone/with others; craving before lighting 0–10; valence −2..+2 and arousal low/high (2-tap circumplex); "How automatic was this?" 1–5 (SRBAI-adapted); "How much did you enjoy it?" 0–10; optional "mindful cigarette" noticing (taste, smell, throat, mood after) ≤1–2/day |
| Back-fill | "Missed a log? Tap +1 with an approximate time"; store `approx=true` so the model down-weights it |
| Random EMAs | **4/day**, stratified across waking blocks, ≥90 min apart, 20-min expiry. Items: craving 0–10, stress 0–10, valence/arousal, cigarettes available (Y/N/with difficulty), others smoking nearby, alcohol in last 2 h, motivation to quit 0–10 (**the Smart-T six, so the rules score runs from day 1**), smoked since last prompt (catches missed logs), "Is now a good time for a tip?" (receptivity) |
| Expected compliance | ~75–87% |
| Personalization quota | **≥30 logged cigarettes + ≥15 answered EMAs** before per-user weights activate (cf. Perski's ≥20-entry rule) |
| Data yield (illustrative) | 15 CPD × 7 d ≈ 105 positives; 4 EMA × 7 × 0.8 ≈ 22 prompt moments; passive samples every 15 min ≈ 448 windows, labelled negative if no log within ±30 min. A 5-CPD smoker yields only ~35 positives → rely on population prior and shrinkage |
| Quit transition | Abrupt quit date; switch target from "smoke" to "craving/lapse risk"; keep per-user offsets; weight post-quit data more heavily |

The critical caveat is distribution shift. Pre-quit ad-lib smoking is driven mainly by stimulus and context (Shiffman 2002, DOI 10.1037/0021-843X.111.4.531), whereas post-quit lapses are tied more to rising negative affect and urges over the preceding hours (Shiffman 1996, DOI 10.1037/0022-006X.64.2.366; Shiffman & Waters 2004, DOI 10.1037/0022-006X.72.2.192) [PK]. **A baseline-trained model therefore predicts cue-exposure and craving-likely windows, a proxy that must be re-anchored with post-quit craving and lapse labels.** With roughly half of Quit Sense users engaging for more than a week, the baseline itself is a disengagement risk, so the model must work from a partial baseline.

#### Input features, model ladder and thresholds

**Prediction target:** per 15–30-minute window, "craving ≥7/10, cigarette logged, or lapse logged within the next 60 minutes"; pre-quit positives are cigarettes, post-quit positives are high craving or lapses (separate output head or re-weighting).

| Feature group | Features (~30–60 total, computed on-device) |
|---|---|
| Time | `sin/cos(2π·h/24)`, `sin/cos(2π·d/7)`, weekend flag, minutes since waking (first unlock) |
| Recency/counts | minutes since last cigarette/lapse and since last craving ≥7; cigarettes logged in last 1, 3, 24 h; **baseline-hour smoking rate** (this hour's mean across baseline days, a strong personal prior) |
| EMA state | craving, stress, valence: last value, exponentially decayed mean, change since previous |
| Smart-T six + score | last urge, stress, availability, alcohol, motivation, others-smoking, and the rules score itself |
| Place | top-k geofence cluster one-hot + "other"; dwell minutes; smoking-associated cluster flag (≥2 logs); place type |
| Phone context | screen on/off, unlocks in last 30 min, charging, headphones, activity state (still/walking/vehicle), calendar busy, ambient-noise bucket where permitted |
| Wearable (nullable) | HR minus user's resting baseline for this hour, steps in last 15 min, sleep flag, HRV only where exposed, with missingness indicators |

| Layer | Model | Personalization | Notes |
|---|---|---|---|
| **L0** | Smart-T-style weighted rules score | none needed | Cold-start and fallback; **the only layer with RCT efficacy**; weights from Businelle 2016 once verified |
| **L1** | Logistic regression, population-pretrained (<100 parameters) | Per-user MAP/Laplace update toward a Gaussian prior centered on population weights, nightly on device (closed form or a few L-BFGS/SGD steps) | Shrinkage handles light smokers |
| **L2** | Gradient-boosted trees (100–300 trees, depth 3–5) via ONNX | Per-user Platt calibration + bias term (on-device boosting is non-trivial) | Tree ensembles were best in Perski 2023/2024 |
| **L3 (later)** | Small GRU or temporal CNN over last 24–48 h | Fine-tune final layer only | Only after MRT data justify it |

Model sizes and latencies are order-of-magnitude estimates; take MB and ms figures from in-house profiling. Use **class weights or focal loss rather than SMOTE on time series**, pick thresholds on PR curves, and report per-user ROC-AUC and PR-AUC, Brier score and reliability curves, **event recall (share of lapses or high cravings preceded by a prompt within 60–240 min, comparable to Smart-T's 4-hour window)**, false prompts per day and micro-randomized proximal effects (Saito & Rehmsmeier 2015; Niculescu-Mizil & Caruana 2005) [PK]. Use Platt scaling for small per-user data and isotonic only for population calibration.

#### Decision rules, prompt budget and receptivity

```
DECISION POINTS: every 15–30 min waking (passive check) | each EMA or log | geofence dwell event | user "craving now" tap
OPTIONS: nothing | urge-surfing or 0.1 Hz breathing prompt | geofence if-then plan reminder |
         social/support message | NRT-use reminder (Section 2.6)
RULE:
  p = calibrated_risk(L0 ⊕ L1/L2)
  if user_tap:                                  deliver SOS immediately (unlimited, zero-cost)
  elif p ≥ θ_user and prompts_today < BUDGET and minutes_since_last ≥ 90
       and receptive() and not quiet_hours():
       with prob ρ ∈ [0.3, 0.5] (optimization phase): deliver NOTHING and log (micro-randomized)
       else deliver message matched to the elevated Smart-T factor(s)
  elif p ≥ θ_user and not receptive():          defer up to 15 min, then re-check
  else:                                         passive UI cue only (widget: "higher-risk hour")
  θ_user chosen so E[proactive prompts/day] ≤ BUDGET
BUDGET: 3/day default (Sense2Stop dose), user-adjustable 0–5; baseline random EMAs ≤4/day;
        post-quit EMAs taper 3/day (weeks 1–2) → 1–2/day
receptive(): unlocked in last 5 min OR screen on; not calendar-busy; activity ≠ in_vehicle
quiet_hours(): sleep window OR driving
habituation: rotate message types; lower per-type frequency after 3 ignores
LOG every decision: timestamp, p, θ, randomization probability, context, option, response
```

Receptivity is predictable from phone context (Künzler 2019, DOI 10.1145/3369805; Mishra 2021, DOI 10.1145/3463492) [PK]. A contextual bandit (Thompson sampling) is a reasonable later step once per-user data accumulate, but no published smoking application was verified. Logging randomization probabilities with every decision is what lets the team estimate causal excursion effects and detect the habituation the 2026 Annual Review warns about.

### 2.3 Behavioral economics: gain-framed words, loss-framed numbers, and costs moved to "now"

#### The equations and their parameters

Cumulative prospect theory (Tversky & Kahneman 1992, J Risk Uncertain 5:297–323, DOI 10.1007/BF00122574) gives a parameterized value and weighting model ([Wakker CPT notes](https://personal.eur.nl/wakker/miscella/calculate.cpt.kobb/index.htm); [Birnbaum calculator](https://psych.fullerton.edu/mbirnbaum/calculators/cpt_calculator.htm)) [V]:

```
v(x) =  x^α            for x ≥ 0      α = 0.88
v(x) = −λ·(−x)^β       for x < 0      β = 0.88, λ = 2.25
w(p) = p^γ / (p^γ + (1−p)^γ)^(1/γ)    γ = 0.61 (gains), δ = 0.69 (losses)
Hyperbolic discounting:  V = A / (1 + k·D)     (D = delay in days)
```

**These are median estimates from monetary lotteries, individual preferences vary considerably, and transfer to health outcomes and smokers is an assumption** ([cognitivemodels docs](https://rdrr.io/github/JanaJarecki/cognitivemodels/man/cpt.html)) [V]; critiques of small-stakes loss aversion and a 2024 meta-analysis suggesting mean λ somewhat below 2.25 were not retrieved [PK]. Treat the numbers as **design heuristics for A/B hypotheses, not predicted effect sizes.** Computed implications [D]: a loss weighs 2.25× an equal gain; splitting a loss into n parts raises its felt size by n^0.12 (1.087× for 2, 1.141× for 3, 1.181× for 4); splitting a gain into N events raises it by N^0.12 (1.26× for 7, 1.50× for 30, 2.03× for 365); loss weighting gives w(0.01) = 0.040 and w(0.10) = 0.170, so small described risks are over-weighted.

**Smokers discount the future more steeply: current smokers discounted delayed money more than never- and ex-smokers, who did not differ, and the hyperbolic model beat the exponential in 74 of 89 comparisons** (Bickel, Odum & Madden 1999, Psychopharmacology 146:447–454; n = 23/22/21) ([USU](https://digitalcommons.usu.edu/psych_facpub/54)) [V]. **DOI correction: the Springer record uses 10.1007/PL00005490, not 10.1007/s002130051097 as given in the brief.** Across addictions, steeper discounting gives **d = 0.58 in 57 methodologically equivalent comparisons (n=3,329)** and d = 0.15 across all 64 (MacKillop 2011, DOI 10.1007/s00213-010-2048-6) ([Bath](https://researchportal.bath.ac.uk/en/publications/delayed-reward-discounting-and-addictive-behavior-a-meta-analysis/)) [V]. Episodic future thinking reduced discounting (**d = 0.65**) and lab cigarette self-administration (**d = 0.58**) (Stein 2016, DOI 10.1007/s00213-016-4410-y) ([Springer](https://link.springer.com/10.1007/s00213-016-4410-y)) [V], but a web replication found no craving effect and a demand-characteristic signal ([PMC9812225](https://pmc.ncbi.nlm.nih.gov/articles/PMC9812225)) [V]. Group k values were not retrieved, so the illustration uses hypothetical k: at k = 0.001/day a harm 30 years away retains 8.4% of its value, at k = 0.01/day 0.9% [D].

#### Framing evidence reconciles gain-framed copy with loss-framed counters

**Gain-framed messages beat loss-framed ones for prevention behaviors (r = 0.083, p = 0.002; 94 studies), with the gain advantage strongest for smoking cessation, and effects larger on behavior than on intention** (Gallagher & Updegraff 2012, DOI 10.1007/s12160-011-9308-7) ([Epistemonikos](https://www.epistemonikos.org/en/documents/92c502e2262254e4500fda3f7c063fc38b468809)) [V]. Money clearly works: **Cochrane 2025 (Notley et al., CD004307.pub7) found incentives RR 1.52 at ≥6 months (I² = 23%, 39 studies, 18,303 participants, high certainty), RR 1.46 after excluding trials still paying at follow-up, and RR 2.13 (1.58–2.86) in pregnancy** ([Cochrane](https://cochranelibrary.com/cdsr/doi/10.1002/14651858.CD004307.pub7/information)) [V]. Halpern 2015 (NEJM, DOI 10.1056/NEJMoa1414293; 2,538 CVS employees and family) found **~90% acceptance of reward programs vs 13.7% for deposit contracts; 6-month sustained abstinence 15.7% rewards vs 10.2% deposits vs 6.0% usual care among all randomized**, while deposits were about twice as effective as rewards among people who would accept either ([Penn CHIBE](https://chibe.upenn.edu/news/deposit-based-financial-incentive-programs-for-smoking-cessation-are-superior-to-reward-based-programs/); [NAQC](https://www.naquitline.org/news/231700/-Randomized-Trial-of-Four-Financial-Incentive-Programs-for-Smoking-Cessation..htm)) [V; the 52.3% deposit-acceptor figure is secondary]. **Framing alone, without money, has no demonstrated abstinence effect, and no study tested a CPT-optimized display inside a cessation app.**

#### The minutes-of-life conversion has been updated to about 20 minutes per cigarette

**Jackson, Jarvis & West (Addiction 2025, DOI 10.1111/add.16757) estimate about 20 minutes of life expectancy lost per cigarette on average (17 for men, 22 for women)**, from the British Doctors and Million Women studies, commissioned by the UK Department of Health and Social Care ([drugsandalcohol.ie](https://www.drugsandalcohol.ie/42487); [ScienceAlert](https://www.sciencealert.com/just-one-cigarette-steals-20-minutes-of-your-life-expectancy-study-finds)) [V]. It supersedes Shaw, Mitchell & Dorling's 2000 male-only **11 minutes** (BMJ 320:53; 6.5-year gap ÷ 311,688 cigarettes = 10.97 min) ([PMC](https://pmc.ncbi.nlm.nih.gov/articles/pmid/10617536)) [V]. Both are crude averages that assume each cigarette contributes equally; duration matters more than intensity, so "minutes per cigarette" is a communication device, not a dose-response law. A 10-a-day smoker quitting on 1 January avoids about 50 days of lost life by year end, and a pack of 20 is almost 7 hours [V/D].

#### Framing equations for the app

```
Inputs:  C0 = baseline cigarettes/day;  P = local pack price;  S = cigarettes/pack;  p_c = P/S
         t  = days since quit (fractional, live);  n(t) = cigarettes logged since quit
         m  = minutes of life expectancy per cigarette: 20 default; 17 (male) / 22 (female) if sex given;
              11 "conservative" option, or display range "11–20"
Cigarettes not smoked:   N(t) = max(0, C0·t − n(t))
Money kept:              M(t) = p_c · N(t)          projection M_year = 365·C0·p_c
Life expectancy kept:    L(t) = m · N(t) minutes    label: "average estimate from UK studies; your own risk differs"
Next-cigarette cost (craving screen, segregated chips):   −p_c (certain, now) | −m min (expected) | streak status
Streaks:  current run (resets on slip) + total smoke-free days (NEVER erased); money and minutes kept never erased
```

Prices must come from the user or from a maintained price table that shows its date and source.

| Rule | Design | Basis |
|---|---|---|
| **R1 Reference-point reset** | On the quit date, make smoke-free status the reference by endowing a live balance (money kept, minutes kept, smoke-free hours); show a cigarette as a decrement of that balance | λ ≈ 2.25 [V parameters; design inference] |
| **R2 Hedonic editing flips after a lapse** | During a craving: segregate the prospective loss into 3–4 chips (money, minutes, streak, acute body signal), ~14–18% larger felt loss. After a slip: integrate the loss into one line and segregate gains ("you kept 41 of 42 days, £N, M hours") | CPT curvature [D]; Thaler 1985 principles [PK] |
| **R3 Segregate gains over time** | Each smoke-free day and resisted craving is a separate "deposit" with its own micro-celebration plus the cumulative total | 30 gains ≈ 1.5× a lump [D] |
| **R4 Avoid probabilistic risk as the lever** | Convert risk into certain, immediate units | Discounting and optimism bias |
| **R5 Make costs D ≈ 0** | Money lost now and acute body signals (Section 1.2: CO, heart rate) before long-term disease risk | Hyperbolic discounting [V] |
| **R6 Bring rewards closer** | Next milestone in hours/days ("72 h smoke-free in 9 h"; "£50 in 3 days") | Hyperbolic discounting |
| **R7 EFT micro-prompts** | 20–60 s vivid prompt about a user-entered positive future event during cravings or check-ins; label "promising, unproven for quitting" | Stein 2016 [V] |
| **R8 Copy vs counters** | Notifications and coaching are gain-framed ("You've kept £N"); loss lives only in the numbers, never in fear or disease imagery | Gallagher & Updegraff [V] |
| **R9 Two-tier incentives** | Default: rewards for verified milestones (~90% uptake). Opt-in: deposit/commitment contract for the motivated minority; never mandatory | Halpern 2015 [V] |
| **R10 Verification** | Real-money incentives require CO or cotinine verification, or they become gameable self-report; real-money deposits need legal review (gambling, escrow, store rules) | Trial designs |

**Ethics rules.** Always label life-expectancy figures as population averages and never say "this cigarette *will* take 20 minutes from you." No fear or disgust imagery in the craving flow. Let users turn off loss chips. Avoid aggressive loss framing in pregnancy and for users with depression or anxiety flags, and test every framing change for harm (drop-out, negative affect) as well as benefit. An optional 5-trial adjusting-delay task could estimate a user's k and target more immediacy framing at high-k users; it is untested in apps.

### 2.4 The Abstinence Violation Effect: a slip must never reset the number the user cares about

**Definitions.** A lapse is any smoking after quitting, even a puff; a relapse is a return to regular smoking, for example smoking on 7 consecutive days or at least once in each of 2 consecutive weeks (Hughes et al. 2003, NTR, DOI [10.1080/1462220031000070552](https://doi.org/10.1080/1462220031000070552)) [PK]. The Russell Standard tolerates ≤5 cigarettes after a 2-week grace period (West 2005) [PK]. Marlatt's AVE has an affective component (guilt, self-blame) and a cognitive one: **people who attribute a lapse to internal, stable, global causes beyond their control are more likely to abandon abstinence** ([Larimer, Palmer & Marlatt 1999, PMC6760427](https://pmc.ncbi.nlm.nih.gov/articles/PMC6760427/)) [V].

**Evidence in smokers.** Characterological attributions for lapses predicted worse outcomes, and attributions predicted for hypothetical lapses did not match those for actual lapses (Curry, Marlatt & Gordon 1987, J Consult Clin Psychol 55(2):145–149) ([PMC4636196](https://pmc.ncbi.nlm.nih.gov/articles/PMC4636196/)) [V, secondary]. In EMA data, lapsers who attributed the lapse to controllable causes felt worse and more guilty, and **AVE intensity was unrelated to amount smoked, abstinence length or coping** (Shiffman 1997, Cogn Ther Res, DOI 10.1023/A:1021853301255) ([Springer](https://link.springer.com/article/10.1023/A:1021853301255)) [V]. **Lapses produce immediate drops in self-efficacy, and day-to-day post-lapse self-efficacy predicted progression to relapse even controlling for concurrent smoking** (Shiffman 2005, J Pers) ([Wiley](https://onlinelibrary.wiley.com/doi/10.1111/j.0022-3506.2005.00364.x)) [V]. **Smoking in weeks 1–2, especially week 2, robustly predicted failure: more than 80% of active-patch participants who smoked in week 2 were smoking at 6 months** (Kenford 1994, JAMA 271(8):589–594, DOI 10.1001/jama.271.8.589) [V, secondary summary]; first-day smoking also predicts long-term outcome (Westman 1997, [PubMed 9040302](https://pubmed.ncbi.nlm.nih.gov/9040302/)) [V]. An adolescent EMA study reported the first lapse marked relapse onset in 59.6% of lapsers, with the rest relapsing a mean 4.7 days later ([ResearchGate](https://www.researchgate.net/publication/44625057_Dynamic_Effects_of_Self-Efficacy_on_Smoking_Lapses_and_Relapse_Among_Adolescents)) [V, attribution uncertain]. Cochrane 2019 found behavioral relapse prevention for people who have already quit showed no clear benefit, while extended varenicline helped (RR ≈1.23) [PK], so medication adherence belongs in the lapse flow. Lally 2010 found **missing one opportunity did not materially affect habit formation** (median 66 days to 95% of the automaticity plateau, range 18–254; DOI [10.1002/ejsp.674](https://doi.org/10.1002/ejsp.674)) [PK].

**No empirical study was found showing that gamified streak resets cause disengagement**; the recommendation to keep cumulative totals rests on AVE theory and Lally, and should be A/B tested. Self-compassion training reduced daily smoking faster, mainly among highly self-critical participants (Kelly 2010, DOI [10.1521/jscp.2010.29.7.727](https://doi.org/10.1521/jscp.2010.29.7.727)) [PK], and shame displays predicted relapse in alcohol (Randles & Tracy 2013) [PK]. The evidence is small but consistent with non-judgmental language.

#### The "Slip Response" protocol

This is a design synthesis, not trial-tested as specified.

```
TRIGGER: user taps "I smoked" OR check-in reports cigarettes > 0
  Q1 (one tap) "How many?"  [1] [2–5] [more than 5] [I've been smoking regularly]
  route:
    1–5 cigarettes                         → LAPSE pathway
    ≥7 consecutive smoking days logged
      OR "I'm smoking again"                → RELAPSE / RE-QUIT pathway
  (Russell ≤5 rule used INTERNALLY only for routing and outcome reporting; never shown to users)

LAPSE pathway
  S1 Immediate response (≤3 sentences; no red; no "streak lost" animation)
  S2 Attribution reframe (internal/stable/global → external/temporary/specific/controllable)
  S3 Chain analysis (≈45 s, chips + "other")
  S4 Self-compassion micro-exercise (auto-offered if a self-critical chip is chosen or onboarding item is high)
  S5 Plan update: auto-generate one if-then plan; remove access; NRT adherence check or suggestion
  S6 Recommit: default "Keep my quit going from now"; optional new quit date + replay acceptance levels
  S7 Metrics repair (below)
  if lapse in days 0–14: same-day follow-up check-in; extra Urge Surfer nudge at the logged trigger
                         time next day; offer quitline or coach

RELAPSE pathway
  "Plan your next quit": new date, pharmacotherapy review, quitline connection; keep all history and badges
```

**Exact copy (original wording):**

| Step | Copy |
|---|---|
| S1 Immediate | "Thanks for logging this — that honesty is part of quitting. One cigarette is a slip, not a restart: your smoke-free days still count. Let's take 60 seconds to learn from it." |
| S2 Reframe prompt | "Which feels closer? (a) 'I'm just not able to quit' (b) 'That situation was tough and I didn't have a plan for it yet.'" |
| S2 Response (either answer) | "(b) is almost always closer to the truth — slips usually follow specific situations, and situations can be planned for." |
| S4 Self-compassion (Neff's three parts: mindfulness, common humanity, kindness; Neff 2003, DOI 10.1080/15298860309032 [PK]) | "This is a hard moment." · "Slips happen to lots of people who are quitting." · "May I be patient with myself while I get back on track." |
| S4 Alternative prompt | "What would you say to a friend who just had one cigarette?" |
| S5 If-then plan template | "If I'm at [place] with [people] and feel [the pull], then I'll [step outside for 3 breaths, open Urge Surfer, hold a drink in my smoking hand]." |
| S5 NRT check | "Did you use your patch today?" |
| S7 Daily goal | "Today's goal: get back to 0." |
| Relapse pathway | "Most people take several tries to quit for good; each one teaches you something." (**needs a supporting source before use**) |

**Root-cause (chain analysis) questions**, each as chips plus "other":

| Question | Chips |
|---|---|
| When? | time of day, day of week (prefilled) |
| Where? | home, car, work, bar, friend's place |
| Who? | alone, with smokers, partner, colleagues |
| Feeling just before? | stressed, angry, low, bored, celebrating + **HALT** check (Hungry, Angry, Lonely, Tired) |
| Other substances? | alcohol, coffee |
| Access? | bought it, bummed it, had a stash |
| The thought that tipped it? | "just one", "I deserve it", "I've already blown it today", "nobody will know" |
| How did it feel afterwards? | free text + chips; surfaces disconfirming experience ("not as good as I expected"), in Brewer-style curiosity |

**Streak-repair mechanics.** Never reset the cumulative "smoke-free days" total and show it as the primary number; show "current run" as secondary. Add a "never miss twice" prompt grounded in Lally 2010. Award a **"Back on track"** badge after 24 h smoke-free following a slip and a **"Comeback"** badge after 7 days. Aggregate chain analyses into a "Your top 3 triggers" card that feeds pre-emptive time- or location-based nudges (Section 2.2). Section 4 specifies the avatar's "post-slip damage control" state and haptics, which must show a dip and recovery rather than a collapse.

**Language rules.** Use "slip" or "lapse" for a single episode and "smoking again" rather than "relapse" or "failed" in user-facing copy. Never use "cheated", "fell off the wagon", "weak", "willpower", "clean/dirty" or "ruined". Use identity-forward language ("you're becoming a non-smoker"). Add an optional onboarding item, "When I slip up, I'm hard on myself" (agree/disagree), and route high scorers to self-compassion content earlier.

### 2.5 Approach Bias Modification is largely null; 0.1 Hz breathing gives a small acute craving benefit

#### ApBM: the largest smoking trial found nothing

**Wittekind et al. 2026 (Am J Psychiatry, DOI 10.1176/appi.ajp.20250189; DRKS00019221) randomized 351 German adults with tobacco dependence, all given a one-day CBT program, to ApBM, sham or no add-on: Russell Standard biochemically verified prolonged abstinence at 6 months was 19.3% vs 17.4% vs 16.2%, not significant**, and craving, dependence and consumption fell equally in all groups ([AJP](https://psychiatryonline.org/doi/10.1176/appi.ajp.20250189); [Mental Elf](https://www.nationalelfservice.net/mental-health/addiction/approach-bias-modification-for-smoking-cessation-nhs-contender-or-game-over/)) [V]. A companion fMRI RCT found no change in cue reactivity ([Sci Rep 2026](https://www.nature.com/articles/s41598-026-45748-y)) [V]. Smartphone ApBM (Machulska 2023; N=131; 14 consecutive daily home sessions) reduced cigarettes more than no training, but **active and sham both reduced dependence more than no training, and bias change did not mediate outcomes** ([Siegen repository](https://dspace.ub.uni-siegen.de/handle/ubsi/1919); [protocol](https://trialsjournal.biomedcentral.com/counter/pdf/10.1186/s13063-019-3835-0.pdf)) [V]. Machulska 2016 in psychiatric inpatients found a larger reduction in consumption at 3 months than a 50/50 push/pull sham, again with no evidence that reduced bias was the mechanism; **it was published in J Psychiatr Res 76:44–51, not Addict Behav as the brief stated** [V]. Meta-analyses of cognitive bias modification for addiction give **g = 0.08 (−0.02 to 0.18), not significant, across 25 RCTs** (Cristea 2016, [PMC5017662](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5017662/)) [V]. The only positive long-term signal is a 2026 Behav Res Ther snippet reporting more abstinence 4 years later vs sham ([ScienceDirect](https://www.sciencedirect.com/science/article/pii/S0005796726001439)) [V snippet only; sample and design unverified]. The Australian swipe-based Modif-i Tobacco trial (ACTRN12624000633583) has no results ([ANZCTR](https://anzctr.org.au/ACTRN12624000633583.aspx)) [V].

**Recommendation: ship ApBM, if at all, as an optional, clearly labelled "experimental" mini-game ("research results are mixed"), never in the craving SOS flow and never in efficacy claims; Section 0's MOST screening should test it against sham and drop it if null (pivot P6).** If built, mirror only the verified trial features:

| Parameter | Specification | Status |
|---|---|---|
| Schedule | Daily sessions on 14 consecutive days | [V] Machulska 2023 |
| Active task | Smoking images **pushed** away (swipe up/away with shrinking zoom-out); neutral/positive images **pulled** (enlarging) | [V] task structure |
| Sham | Smoking images pushed and pulled 50/50 | [V] Machulska 2016 |
| Trials per session, image sets, "90/10 avoid ratio" | **Not verified; do not specify as evidence-based** | Gap |
| Evaluation | Internal randomized A/B against sham; log cigarettes/day and abstinence, not only in-app bias scores | [R] |

#### Slow-paced breathing: small, consistent, acute

**Roxburgh et al. 2026 (Addiction, DOI 10.1111/add.70542; searches to November 2025) found controlled breathing and HRV biofeedback reduced craving across substances including nicotine: g = 0.30 (0.12–0.48), I² = 23.5%, 12 studies, n=696**; withdrawal g = 0.46 (−0.28 to 1.19) was uncertain and no nicotine-only estimate was reported ([drugsandalcohol.ie](https://www.drugsandalcohol.ie/46435/); [Addiction press release](https://addictionjournal.org/press-release/controlled-breathing-may-reduce-drug-cravings-new-study-finds/)) [V]. Press summaries disagree on whether breathing types differed. **Yogic breathing reduced all craving measures immediately in 96 abstaining smokers, with no effect at 24 h and low adherence** (Shahab, Sarkar & West 2013, Psychopharmacology 225(4):875–882, DOI 10.1007/s00213-012-2876-9) ([UCL Discovery](https://discovery.ucl.ac.uk/id/eprint/1380458/)) [V]. Deep breaths every 30 minutes reduced withdrawal and craving in about 21 smokers (McClernon 2004, DOI 10.1016/j.addbeh.2004.02.005) ([Duke](https://scholars.duke.edu/publication/697782)) [V]. Exhale-focused cyclic sighing improved mood and lowered respiratory rate more than mindfulness at 5 min/day for a month in a non-smoking sample (Balban 2023, Cell Rep Med, DOI 10.1016/j.xcrm.2022.100895) ([PMC9873947](https://pmc.ncbi.nlm.nih.gov/articles/9873947/)) [V]. HRV biofeedback has small-to-moderate general effects across 58 studies (Lehrer 2020, DOI 10.1007/s10484-020-09466-z) [V]. **The 0.1 Hz resonance mechanism itself (baroreflex resonance, maximal HR oscillation; Lehrer & Gevirtz 2014; Vaschillo 2006, individual range ~4.5–7 bpm) and the inhale:exhale optimum (Van Diest 2014) are recalled, not verified [PK].** No RCT tests a 6-bpm smartphone pacer on smoking abstinence. Combined with breathing apps' 0.0% median day-30 retention (Section 0), the pacer belongs **inside** the Urge Surfer and SOS flows.

| Pacer parameter | Default | Status |
|---|---|---|
| Rate | **6.0 breaths/min (0.1 Hz, 10-s cycle)**, adjustable 4.5–7.0 bpm | Mechanism [PK] |
| Ratio | **Inhale 4 s : exhale 6 s (40:60)** | Design choice [M]; exhale emphasis motivated by Balban |
| Duration | Minimum 2 min; recommended 5 min | Balban dose [V] |
| Variant | "Cyclic sigh": double nasal inhale, long mouth exhale, 5 min | Balban [V] |
| Feedback | Haptic + visual pacing (Section 4), pre/post craving 0–10 | [R] |
| Repetition | Offer short repeated bouts during the first abstinent days (McClernon every-30-min design; Shahab decay by 24 h) | [V] basis |
| Personal resonance frequency | Only with beat-to-beat HR (chest strap or validated camera PPG): step 6.5→4.5 bpm in 2-min blocks, pick the rate with largest HR oscillation amplitude | Protocol [PK, unverified] |
| Safety | Exclude cyclic hyperventilation-with-retention from craving flows (dizziness) | Inference |
| Claim | "May ease a craving in the moment (small effect)"; never "quit aid" | [R] |

#### The 180-second "Move" option: strong acute evidence, but not at 3 minutes

**Acute exercise reduces cigarette craving robustly: IPD meta-analysis SMD −1.91 (−2.59 to −1.22) for strength of desire across 15 studies and −2.03 for desire to smoke across 17, all in the same direction** (Haasova 2013, Addiction) ([Exeter ORE](https://ore.exeter.ac.uk/repository/handle/10871/21859)) [V]. **Effects lasted up to 50 minutes and time to next cigarette was 2–3× longer; the shortest effective doses were 5 minutes of isometric exercise and 15 minutes at 24% heart-rate reserve** (Taylor, Ussher & Faulkner 2007) ([Plymouth](https://researchportal.plymouth.ac.uk/en/publications/the-acute-effects-of-exercise-on-cigarette-cravings-withdrawal-sy-2)) [V]. By intensity, reductions on a 0–100 scale were **−9.22 light, −34.57 moderate and −31.29 vigorous** (Haasova 2014) [V]. **No study tests bouts of 3 minutes or less, so the 180-s move is an adherence-friendly entry point, not an evidence-based dose.** Offer a 3-minute starter (brisk walk, stairs, wall-sit or isometric holds) ending with "keep going to 5–10 min for a stronger effect", plus a 10–15-minute walk option; encourage moderate intensity; and A/B test 3 vs 5 vs 10 minutes on in-app craving ratings. Because the effect lasts about 50 minutes, pair the move with planning for the next high-risk window.

### 2.6 Pharmacotherapy: the app reminds, quotes the label and escalates; it never calculates a dose

#### Efficacy anchors, with the metric stated

**Premise correction: the 2023 Cochrane component network meta-analysis reports odds ratios with 95% credible intervals, not risk ratios** (Lindson et al., CD015226.pub2, DOI 10.1002/14651858.CD015226.pub2; searched to 29 April 2022; >150,000 people) ([Cochrane Library](https://www.cochranelibrary.com/cdsr/doi/10.1002/14651858.CD015226.pub2/full); [Oxford news](https://www.ox.ac.uk/news/2023-09-12-e-cigarettes-varenicline-and-cytisine-found-be-most-effective-stop-smoking-aids)) [V]. Do not mix ORs and RRs in one table.

| Agent | Metric vs no pharmacotherapy/placebo (≥6 mo abstinence) | Evidence | Source |
|---|---|---|---|
| Nicotine e-cigarettes | **OR 2.37** (CrI 1.73–3.24) | 16 RCTs, 3,828; high | CNMA 2023 [V] |
| Varenicline | **OR 2.33** (2.02–2.68) | 67 RCTs, 16,430; high | CNMA 2023 [V] |
| Cytisine | **OR 2.21** (1.66–2.97) | 7 RCTs, 3,848; high | CNMA 2023 [V] |
| Combination NRT | **OR 1.93** (1.61–2.34) | certainty not rated | [Livingstone-Banks 2024, Addiction, DOI 10.1111/add.16624](https://onlinelibrary.wiley.com/doi/10.1111/add.16624) [V] |
| Nortriptyline | OR 1.35 (1.02–1.81) | 10 RCTs; moderate | CNMA 2023 [V] |
| Varenicline (pairwise) | **RR 2.32** (2.15–2.51) | 41 studies, 17,395; high | [Cochrane CD006103.pub9](https://www.cochranelibrary.com/cdsr/doi/10.1002/14651858.CD006103.pub9/full) [V] |
| Cytisine (pairwise) | **RR 1.30** (1.15–1.47), I² = 83% | 4 studies, 4,623; moderate | CD006103.pub9 [V] |
| Cytisine vs varenicline | RR 1.00 (0.79–1.26); conflicts with pub8's 0.83 (0.66–1.05) | low | CD006103 [V; check current version] |

Cytisine's pairwise RR (1.30) is much lower than its CNMA OR (2.21) because the analyses use different study sets and metrics; say so if both appear. Serious adverse events showed no clear difference for e-cigarettes, varenicline, cytisine or NRT in the CNMA (low certainty), while varenicline SAEs were RR 1.23 in the pairwise review (moderate) [V]. **Combination NRT (patch plus a fast-acting form) beats a single form (high certainty), pre-loading before the quit date is supported, and 4 mg gum beats 2 mg only in higher-dependence smokers** ([Addiction 2024](https://onlinelibrary.wiley.com/doi/10.1111/add.16624)) [V]; effect sizes for pre-loading and the NRT-forms review (CD013308) were not retrieved.

**Cytisinicline (3 mg three times daily) worked in two phase 3 trials.** ORCA-2 (JAMA 2023; n=810): 12-week arm continuous abstinence weeks 9–12 **32.6% vs 7.0%**, weeks 9–24 21.1% vs 4.8% ([JAMA](https://jamanetwork.com/journals/jama/fullarticle/2807079)) [V]. ORCA-3 (JAMA Intern Med, 21 April 2025; n=792; weekly CO <10 ppm): weeks 9–12 **30.3% vs 9.4%, OR 4.4 (2.6–7.3)**; 6-week arm 14.8% vs 6.0% ([PMC12012700](https://pmc.ncbi.nlm.nih.gov/articles/PMC12012700/)) [V]. ORCA-V1 (vaping) found 31.8% vs 15.1% e-cigarette abstinence [V]. **Cytisinicline is not FDA-approved: the FDA issued a Complete Response Letter on 22 June 2026 citing cGMP observations at a former third-party manufacturer and unfinished labeling; the company reports no efficacy or safety deficiencies, plans to resubmit in Q4 2026 and expects a possible decision in the first half of 2027** ([Drugs.com](https://www.drugs.com/history/cytisinicline.html); [Achieve 8-K](https://www.sec.gov/Archives/edgar/data/0000949858/000119312526344571/achv-ex99_1.htm); [10-Q](https://www.sec.gov/Archives/edgar/data/0000949858/000119312526344624/achv-20260630.htm)) [V]. Whether Achieve had resubmitted by 21 October 2026 is unknown.

**WHO's first clinical tobacco-cessation guideline (2 July 2024) recommends varenicline, NRT (including combination NRT), bupropion and cytisine, combined with behavioral support, and recommends digital interventions "as an adjunct to other support or as a self-management tool"** ([WHO](https://www.who.int/news/item/02-07-2024-who-releases-first-ever-clinical-treatment-guideline-for-tobacco-cessation-in-adults); [executive summary](https://www.ncbi.nlm.nih.gov/books/n/who377825/fm-ch2/)) [V]. **Cytisine joined the core WHO Essential Medicines List in the 24th list released 5 September 2025, not 2023 as the brief guessed** ([ASH](https://ash.org/new-tobacco-cessation-drug-added-to-who-eml-cytisine/)) [V, secondary]. For smokeless users WHO names varenicline or NRT.

**Premise correction on app-plus-medication synergy: no source supports "2025–2026 meta-analyses show superior outcomes when apps are paired with NRT, varenicline or cytisine."** The evidence that exists is Chu 2026's apps + pharmacotherapy vs pharmacotherapy comparison (**RR 1.77, 1.09–2.88; 3 studies; I² = 86%; low certainty**) and the JMIR 2023 meta-analysis (**OR 1.79, 1.38–2.33; 3 trials**), plus Pivot's 19% vs 9% with NRT in both arms (Sections 0 and 2.0) [V]. Defensible wording: "International guidelines (WHO 2024) recommend combining stop-smoking medication with behavioral support and recommend digital tools as an adjunct; pooled trials suggest adding an app to medication may improve quitting (low-certainty evidence)." The Cochrane reviews on combined pharmacotherapy and behavioral support (CD008286, CD009670) and on adherence interventions (CD009164) were not retrieved.

#### Label-quoted NRT reference content

US OTC Drug Facts give fixed regimens the app can **quote verbatim, attributed to the label**, after the user selects their product and strength.

| Product | Strength rule (label text) | Schedule (label) | Limits and technique (label) | Source |
|---|---|---|---|---|
| **Gum** (nicotine polacrilex) | 4 mg if first cigarette within 30 min of waking; 2 mg otherwise | Wk 1–6: 1 piece every 1–2 h; wk 7–9: every 2–4 h; wk 10–12: every 4–8 h | **≥9 pieces/day for first 6 weeks; ≤24/day.** Chew slowly until it tingles, park between cheek and gum, repeat until tingle mostly gone (~30 min). No eating or drinking 15 min before or while chewing. Second piece within the hour allowed for strong cravings; never chew one right after another | [DailyMed gum](https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=673fd19f-69b3-4f73-b9b4-18b5f4cbf69c); [Nicorette](https://www.nicorette.com/usage-science/using-nicorette/nicotine-gum-dosage) [V] |
| **Patch** (NicoDerm CQ) | >10 CPD: Step 1; ≤10 CPD: do not use Step 1, start Step 2 | Step 1 21 mg wk 1–6; Step 2 14 mg wk 7–8; Step 3 7 mg wk 9–10 | Start on quit day; clean, dry, hairless skin; one new patch every 24 h; **used patches still dangerous to children and pets** | [DailyMed patch PDF](https://dailymed.nlm.nih.gov/dailymed/getFile.cfm?setid=93b2d1b9-83c1-40b5-b6af-90c38c8d6cef&type=pdf); [OTCLabels](https://otclabels.com/lib/otc/otc-meds/nicoderm-cq/) [V] |
| **Lozenge** | 4 mg if first cigarette within 30 min; 2 mg otherwise | Wk 1–6: 1 every 1–2 h; wk 7–9: every 2–4 h; wk 10–12: every 4–8 h | **≥9/day first 6 weeks; ≤5 in 6 h; ≤20/day** | [DailyMed lozenge](https://dailymed.nlm.nih.gov/dailymed/fda/fdaDrugXsl.cfm?setid=991704ed-781a-489b-8b56-0b558e8fc385); [UCSF Rx for Change](https://rxforchange.ucsf.edu/download.php?file=Nicotine+lozenge.pdf) [V] |

The patch course is 10 weeks and gum/lozenge 12 weeks, so the program timeline must follow the product entered. Unverified items that need DailyMed checks before display: the patch's bedtime-removal option for vivid dreams and the ≤10 CPD schedule; lozenge technique; mini-lozenge, inhaler and spray regimens; "Ask a doctor before use" and "Stop use" wording; the varenicline titration (recalled as 0.5 mg daily days 1–3, 0.5 mg twice daily days 4–7, 1 mg twice daily from day 8 for 12 weeks); EAGLES (Lancet 2016); the December 2016 boxed-warning removal; the 2021 nitrosamine recall; the Tabex 25-day taper; and NICE NG209/NCSCT combination dosing [PK]. "Avoid acidic drinks such as coffee" is coaching, not label text.

#### Why the app must not pick the strength

The FDA lists **"software functions that keep track of medications and provide user-configured reminders for improved medication adherence"** among enforcement-discretion examples, and its guidance includes **"coaching patients to adhere to pre-determined medication dosing schedules by simple prompting"** ([FDA examples page](https://www.fda.gov/medical-devices/device-software-functions-including-mobile-medical-applications/examples-software-functions-which-fda-will-exercise-enforcement-discretion); [FDA guidance](https://www.fda.gov/regulatory-information/search-fda-guidance-documents/policy-device-software-functions-and-mobile-medical-applications)) [V]. Enforcement discretion is not an exemption ([NIH SEED](https://seed.nih.gov/sites/default/files/2024-12/FDAs-Enforcement-Discretion-Policy.pdf)) [V]. **Apple Guideline 1.4.2 requires drug dosage calculators to come from the manufacturer, a hospital, university, insurer, pharmacy or other approved entity, or to have FDA or equivalent approval**, and Apple has not defined the term ([Apple forums 774177](https://developer.apple.com/forums/thread/774177)) [V]. **Asking time-to-first-cigarette and auto-assigning 4 mg vs 2 mg, or asking CPD and auto-assigning a patch step, edges toward a dosage calculator** even though the rules are printed on the label. Show the label rule as text and let the user choose.

```
NRT / MEDICATION MODULE (state machine)
  SELECT_PRODUCT   → user picks: patch | gum | lozenge | other NRT | varenicline | cytisine | none
                     country catalogue hides/flags products not licensed in user's market
                     (cytisinicline: "not approved in the US" as of Oct 2026)
  ENTER_REGIMEN    → user ENTERS strength and schedule from pack Drug Facts / SmPC / prescriber
                     app MAY display: "Your pack's Drug Facts says…" + quoted label table (read-only)
                     app MUST NOT: compute, select, titrate or suggest a dose
  REMINDERS        → user-configured times/intervals; taper dates exist ONLY if user entered them
  LOG_USE          → per-dose taps; patch-on days; course progress
  ADHERENCE_CHECK  → if count < label minimum (≥9/day wk 1–6) or > label maximum (24 gum, 20 lozenges, 5/6 h):
                       show "Check your label or ask a pharmacist" — NEVER "take more/less"
  TECHNIQUE        → animated gum chew–tingle–park (~30 min), 15-min no food/drink rule, patch site and disposal
  SIDE_EFFECTS     → log hiccups, nausea, jaw/mouth soreness, skin irritation, sleep disturbance, palpitations
                       → technique review + "talk to a pharmacist or doctor"
  RED_FLAG         → chest pain, irregular heartbeat, nicotine-overdose signs, pregnancy/breastfeeding,
                     recent heart attack or stroke, mood change or suicidal thoughts on varenicline
                       → immediate escalation copy (exact wording from label warnings; not yet retrieved)
  LAPSE_LINK       → Slip Response (Section 2.4) asks "Did you use your patch today?" if a regimen is active
  JITAI_LINK       → NRT-use reminder is one JITAI option (Section 2.2), within the prompt budget
  "FINISH THE COURSE" nudges supported by label course lengths and ORCA-3's 12- vs 6-week result
```

Module disclaimer: **"Follow your product label and your clinician's or pharmacist's instructions. This app does not provide medical advice or determine doses."** If dose logic is ever added, it needs regulatory clearance and Apple-approved-entity status. Whether the app can change actual medication adherence is unproven; the link between adherence and abstinence (Shiffman 2008, Raupach 2014) was not retrieved, so no adherence effect sizes can be quoted.

## Section 3. Clinical onboarding: 12 original taps classify dependence, trigger phenotype, readiness and threat-efficacy

The onboarding questionnaire borrows **constructs and factual bands** from validated instruments and writes every item in **original wording**. Copyright protects expression, not facts, so asking time-to-first-cigarette and cigarettes per day in the app's own words with the standard numeric bands is defensible; counsel should confirm before commercial launch. **The phenotype scheme, items and thresholds below are a proposed design, not a validated instrument**, and the app must say its items are "informed by" FTND/HSI, WISDM, TTM and EPPM, never that they carry those instruments' validity.

### 3.1 What the source instruments allow

| Instrument | What to borrow | Licensing / status | Key evidence |
|---|---|---|---|
| **FTND/FTCD** (Heatherton 1991, Br J Addict 86(9):1119–27; renamed FTCD 2012) | Nothing verbatim | **No source confirms public-domain status**; UW ARC says permission must come from the author ([UW ARC](https://arc.psych.wisc.edu/self-report/fagerstrom-test-for-nicotine-dependence-ftnd/)) [V] | 6 items, 0–10. **Cutoffs conflict**: NIDA CTN 0–2/3–4/5/6–7/8–10 ([CTN](https://ctnlibrary.org/cde/2195870/)); AHS <4/4–6/7–10; HSE 5–7/8+ [V]. Name the scheme adopted; never call one "the" FTND cutoff |
| **HSI** (Heatherton 1989, Br J Addict 84(7):791–800) | TTFC and CPD bands (factual) | Factual bands; cite the paper | TTFC ≤5/6–30/31–60/>60 min = 3/2/1/0; CPD ≤10/11–20/21–30/≥31 = 0/1/2/3; total 0–6; **PhenX bands low 0–1, moderate 2–4, high 5–6** ([PhenX 330201](https://www.phenxtoolkit.org/protocols/view/330201)) [V]; floor effects in light smokers ([NIDA](https://datashare.nida.nih.gov/instrument/heaviness-of-smoking-index)) [V] |
| **TTFC alone** (Baker 2007, NTR 9 Suppl 4:S555–S570) | Override flag | — | **Most of the FTND's predictive power came from TTFC**, which beat FTND, HSI, NDSS and WISDM; it indexes "heavy, uninterrupted, and automatic smoking" ([PMC2933747](https://pmc.ncbi.nlm.nih.gov/articles/PMC2933747)) [V]. **DOI correction: 10.1080/14622200701673480, not 10.1080/14622200701712568** |
| **PS-ECDI** (Foulds 2015, NTR, DOI 10.1093/ntr/ntu204) / **EDS** (PROMIS-derived) | Structure of "first vape after waking" | Contact authors for permission | PS-ECDI 10 items, 0–20; bands 0–3/4–8/9–12/≥13 ([Penn State](https://med.psu.edu/departments-faculty/center-for-research-on-tobacco-and-health/nicotine-dependence-index)) [V] |
| **WISDM-68 / Brief WISDM-37** (Piper 2004, DOI 10.1037/0022-006X.72.2.139; Smith 2010) | Construct taxonomy only | **Author permission required** ([CROM](https://www.coresta.org/crom/psychometric/wisconsin-inventory-smoking-dependence-motives)) [V] | 13 motives; Brief: 11 subscales, PDM = automaticity, loss of control, craving, tolerance (4 items each) + 7 SDM × 3 items = 37 [V/D] |
| **Horn "Why Do You Smoke?"** (NIH/NCI) | Factor taxonomy | US government publication, probably public domain (17 U.S.C. §105, legal inference) | 6 factors × 3 items; 11+ high, ≤7 low ([UCLA](https://www.uclahealth.org/smokefree/Workfiles/Why-do-you-smoke.pdf)) [V]; **no social factor; no predictive validity found** |
| **Velicer Self-Efficacy/Temptation** (1990, Addict Behav 15:271–283) | Positive-affect/social vs negative-affect vs habitual/craving split | Licensing not retrieved | 20-item long form; 957 volunteers ([URI CPRC](https://web.uri.edu/cprc/measures/smoking/self-efficacy-temptation-long-form/)) [V]; supplies the missing **social** axis |
| **TTM staging** (DiClemente 1991, DOI 10.1037/0022-006X.59.2.295) | Algorithm logic | Factual | **Preparation = intends within 30 days AND ≥1 past-year 24-h quit attempt** ([UMBC](https://habitslab.umbc.edu/staging-algorithms)) [V]. **Cochrane (Cahill 2010): stage-matched interventions no better than non-staged, and advice must not be restricted by stage** ([CD004492.pub4](https://cochranelibrary.com/cdsr/doi/10.1002/14651858.CD004492.pub4/information)) [V] |
| **MTSS** (Kotz, Brown & West 2013) | Desire × timing concept | Licensing unknown; anchors are distinctive text | **Published in Drug Alcohol Depend 128:15–19, not Psychopharmacology**; N=2,483; quit-attempt odds 6.8× top vs bottom (4.7–9.9); AUC 0.67 ([CROM](https://www.coresta.org/crom/psychometric/motivation-stop-scale)) [V] |
| **RBD scale / EPPM** (Witte 1992, 1996) | Threat (severity + susceptibility) vs efficacy (response + self) logic and critical value | Licensing not found | 12 items, 3 per construct; **CV = efficacy sum − threat sum; positive = danger control, negative = fear control → lead with efficacy** ([Pitt notes](https://sites.pitt.edu/~super1/lecture/lec9151/013.htm); [PMC7643556](https://pmc.ncbi.nlm.nih.gov/articles/PMC7643556/table/table-1)) [V] |

**Fear appeals work best with efficacy.** Witte & Allen 2000 found strong fear plus high efficacy produced the most behavior change and strong fear plus low efficacy the most defensive avoidance and reactance ([PubMed 11009129](https://pubmed.ncbi.nlm.nih.gov/11009129/)) [V]. Tannenbaum 2015 (127 articles, N=27,372) found **d = 0.29**, larger with efficacy statements, and no conditions under which fear appeals backfired ([PubMed 26501228](https://pubmed.ncbi.nlm.nih.gov/26501228/)) [V], though Kok and colleagues dispute this for low self-efficacy audiences ([PMC6190830](https://pmc.ncbi.nlm.nih.gov/articles/PMC6190830)) [V]. Bigsby & Albarracín found **response-efficacy information**, not self-efficacy information, increased the behavioral effect ([UPenn PDF](https://www.asc.upenn.edu/sites/default/files/2022-06/Bigsby%20and%20Albarracin.pdf)) [V], so efficacy-first copy should emphasize "this works" (for example, combination NRT RR 1.25 vs single NRT; Lindson 2019, CD013308, high certainty; [NIHR](https://evidence.nihr.ac.uk/alert/using-both-nicotine-patches-and-gum-together-improves-the-chances-of-quitting-smoking/)) [V]. A full Whiteley health-anxiety screen (14 items, cutoff 5; [PMC4388630](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4388630/)) does not fit 90 seconds and could stigmatize; use a soft opt-out instead.

**Tailoring effects are small.** Tailored print gives weighted mean **r = .074** across 57 studies (Noar 2007, [PubMed 17592961](https://pubmed.ncbi.nlm.nih.gov/17592961/)) [V]. In Cochrane print self-help (CD001118.pub4), **tailored vs standard materials with matched contact gave RR 1.07 (0.89–1.30), while tailored multiple mailings vs a single standard mailing gave RR 1.42 (1.20–1.68)** ([PMC7112723](https://pmc.ncbi.nlm.nih.gov/articles/PMC7112723/table/CD001118-tbl-0005)) [V]. Most of the benefit therefore comes from repeated, interactive contact, not a one-off classification. **No trial shows that matching interventions to smoking-motive phenotypes improves cessation; this is the biggest evidence gap in Section 3** (Section 0's A11 at risk 3–4).

### 3.2 The item set (original wording; one item per screen; auto-advance)

| # | Domain | Item | Options → points |
|---|---|---|---|
| 1 | Product | "What do you use right now?" | Cigarettes / Vapes / Both / Other tobacco (routes to Section 1.3 product inputs and items 2–3b) |
| 2 | Dependence (TTFC) | "After you wake up, how soon do you usually have your first cigarette?" | ≤5 min = 3 · 6–30 min = 2 · 31–60 min = 1 · >60 min = 0 |
| 3 | Dependence (CPD) | "On a typical day, about how many cigarettes do you smoke?" | ≤10 = 0 · 11–20 = 1 · 21–30 = 2 · ≥31 = 3 (exact CPD also captured for Sections 1.1 and 2.3) |
| 3b | Conditional (vape/both) | "After you wake up, how soon do you usually first vape?" | Same bands, 3–0 |
| 4 | Trigger: AFFECT | "I reach for a cigarette to take the edge off when I'm stressed, anxious, angry or down." | Never 0 · Rarely 1 · Sometimes 2 · Often 3 · Almost always 4 |
| 5 | Trigger: CUE | "Certain places, times or routines (coffee, after meals, driving, breaks) switch on an urge to smoke." | 0–4, same anchors |
| 6 | Trigger: AUTOMATIC | "I often light up without really deciding to, out of habit or boredom." | 0–4 |
| 7 | Trigger: SOCIAL | "I smoke most when I'm around other smokers, or out drinking or socialising." | 0–4 |
| 8 | Readiness | "Where are you with quitting right now?" | Not planning to in the next 6 months (PC) · Thinking about it in the next 6 months (C) · Planning to quit in the next 30 days (→ 8b) · Already quit, under 6 months (A) · Quit 6+ months, staying quit (M) · "I want to cut down first" (reduction pathway; PC/C tone) |
| 8b | Conditional | "In the past year, have you gone at least 24 hours without smoking because you were trying to quit?" | Yes → Preparation · No → Contemplation |
| 9 | EPPM severity | "If I keep smoking, the damage to my health could be serious." | 1–7 strongly disagree → strongly agree |
| 10 | EPPM susceptibility | "I'm likely to get a smoking-related illness if I don't stop." | 1–7 |
| 11 | EPPM response efficacy | "Stopping smoking would really lower my health risks." | 1–7 |
| 12 | EPPM self-efficacy | "I'm confident I can quit, with the right support." | 1–7 |
| 13 | Optional defensive-avoidance probe | "Honestly, I'd rather not think about what smoking does to my health." | 1–7 |
| opt | Self-criticism (Section 2.4) | "When I slip up, I'm hard on myself." | Agree / Disagree |

Section 1's lung-model inputs (age, sex, height, age started, morning cough, breathlessness) and product details are collected on a separate "build your lung model" screen, framed as optional, so they do not count against the 90-second classification budget. **No per-item mobile timing norm exists**: smartphones take about 1.1–1.4× as long as PCs ([RECSM WP46](https://www.upf.edu/documents/3966940/3986764/RECSM_wp046.pdf); [SurveyMonkey](https://surveymonkey.com/curiosity/why-do-surveys-take-longer-to-complete-on-mobile/)) [V], and 90 seconds for 12–15 taps requires ≲6 s per item, which is unverified. Keep stems ≤15 words, ≤6 large targets, identical anchors within the trigger and EPPM blocks, no grids and no free text; instrument per-screen dwell, back-navigation, straight-lining and abandonment; cut item 13, then 3b, if the median exceeds 90 s.

### 3.3 Scoring rubric

```
DEPENDENCE
  HSI = item2 + item3                                   # 0–6
  tier = LOW (0–1) | MODERATE (2–4) | HIGH (5–6)        # PhenX bands
  if item2 == 3 (TTFC ≤5 min): tier = max(tier, MODERATE_HIGH)        # Baker 2007 override
  if product in {vape, both} and item3b ≥ 2: tier = min(HIGH, tier + 1)   # heuristic
  if product == vape only: tier from item3b alone; ≥2 → MODERATE+      # until licensed e-cig measure

TRIGGER PHENOTYPE
  scores = {AFF: item4, CUE: item5, AUTO: item6, SOC: item7}
  if max(scores) ≤ 1:                          phenotype = LOW_TRIGGER (dependence-led dashboard)
  elif max − min ≤ 1 and max ≥ 3:              phenotype = DIFFUSE (balanced dashboard)
  else: primary = argmax(scores), tie-break AFF > AUTO > CUE > SOC
        secondary = second-highest if ≥ 3
  store raw scores; EMA check-ins (Section 2.2) re-weight them later (Bayesian prior; not validated)
  NOTE: AUTO overlaps HSI/TTFC (both PDM-like) — do not double-count in risk scores

READINESS
  stage = PC | C | P | A | M from item8 (+item8b)
  "cut down first" → PC/C tone + reduction plan offered (quit-plan CTA still visible)

EPPM
  T = item9 + item10 (2–14);  E = item11 + item12 (2–14);  CV = E − T (−12..+12)
  HIGH = sum ≥ 10 (mean ≥5, "somewhat agree")            # threshold not validated
  quadrant:
    T≥10 & E≥10                          → DANGER_CONTROL: standard risk + action messaging
    (T≥10 & E<10) or CV ≤ −3 or item13 ≥ 5 → FEAR_CONTROL_RISK: efficacy-first; no graphic or
                                            loss-framed imagery; small wins; suppress threat copy
                                            until E ≥ 10 on re-measurement
    T<10 & E≥10                          → LOW_RELEVANCE: personalised risk + gain-framed benefits
    T<10 & E<10                          → LOW_LOW: low-pressure motivation; build efficacy before threat
  behavioral DA signals: rapid dismissal of health cards, opting out of health notifications
```

The tie-break order puts affect first because negative affect rises in the hours before stress-attributed lapses ([USUHS](https://scholar.usuhs.edu/en/publications/negative-affect-and-smoking-lapses-a-prospective-analysis/)) [V] and press coverage of WISDM-68 tied automaticity, stress relief and smoking environments to relapse with no social signal ([HealthDay](https://www.healthday.com/health-news/mental-health/why-light-up-519158.html)) [V, secondary]. Because negative affect predicts lapses only in momentary data ([RAND EP20110026](https://www.rand.org/pubs/external_publications/EP20110026.html)) [V], the onboarding affect item is a prior to be updated by in-app check-ins. Single items cannot yield α, so reliability must come from test-retest and in-app re-measurement; validate against the Brief WISDM and RBD in a permissioned sub-sample.

### 3.4 Phenotype → dashboard and notification-tone mapping

| Classification | Dashboard hero card (first) | Notification tone and timing |
|---|---|---|
| **High dependence** (HSI 5–6 or TTFC ≤5 min) | Medication planner: combination NRT (patch + fast-acting) and pre-quit option shown as label-quoted education (Section 2.6), withdrawal tracker | Practical, reassuring ("withdrawal peaks then fades"); morning-weighted |
| **AFFECT** | Stress toolkit: 0.1 Hz breathing, Urge Surfer, ACT defusion, mood check-in; "stress → urge" insight chart | Warm, validating; triggered by mood check-ins or user-defined stressful times |
| **CUE** | Trigger map: user-tagged places and routines, if-then swap plans, optional geofence alerts (Section 2.2 Quit Sense pattern) | Brief, specific, anticipatory ("Coffee time — your swap is ready"); time- and place-anchored |
| **AUTOMATIC** | Awareness log with friction tools (delay timer), streaks, "cigarettes you didn't notice" stats | Light, curious, playful; randomized "mindful moment" prompts |
| **SOCIAL** | Social plan: event planner, refusal-script practice, buddy invites | Upbeat, peer-oriented; scheduled before known social events (Friday evenings, weekends) |
| **Precontemplation / cut down** | Motivation hub: personal reasons, money and health gains, reduction goals; quit-plan CTA visible but not default | Non-judgmental, curiosity-based, low frequency; no quit-date pushes |
| **Preparation** | Quit-date setup, NRT education, Pre-Quit Mindful Baseline (Section 2.2) | Action-oriented countdown |
| **EPPM fear-control risk** | "How quitting works" success stats (response efficacy) and small wins; graphic risk cards hidden; Lung Age shown only after opt-in | Encouraging, efficacy-first |

Phenotype tone must stay inside the global rules from Section 2: no suppression verbs, gain-framed copy, a 3/day proactive prompt cap, and no stage gating of quit tools. The CUE, AUTOMATIC and SOCIAL technique choices are theory-consistent but unsupported by phenotype-matching trials, so test "phenotype-matched vs generic hero card" in an A/B experiment with 7-day engagement and 30-day self-reported abstinence as outcomes. Section 4 maps the EPPM quadrant onto the avatar: fear-control users see the recovery-focused view by default.

## Section 4. UI/UX: show the damage once, then animate recovery the user caused

### 4.1 Visual-harm evidence sets the avatar's emotional range

**Pictorial warnings beat text on 12 of 17 outcomes across 37 studies (N=33,613), including attention, emotional reaction and quit intentions** (Noar et al., Tob Control 2016;25(3):341–354) ([CDC Stacks](https://stacks.cdc.gov/view/cdc/42078)) [V]. **In a 4-week RCT of 2,149 smokers, pictorial pack warnings raised quit attempts (40% vs 34%) and 7-day abstinence (5.7% vs 3.8%)** (Brewer, JAMA Intern Med 2016) ([UNC](https://sph.unc.edu/?p=265319)) [V]. Pictorial warnings also triggered more reactance than text ([Newswise](https://www.newswise.com/articles/view/633903/?sc=sphn)) [V]. No study tests an animated, data-driven organ avatar for cessation; photoaging (Brinker, Burford 2013), plaque-image (Bovet 2002) and self-affirmation (Harris 2007) studies are recalled, not verified [PK]. Four rules follow. **Show a personalized harm visual once at onboarding** (the avatar at quit-day state, computed from Section 1 inputs), skippable and hideable later, then make recovery the default narrative ("delta since quit day"). **Never render gore**: stylized speckle, no necrotic textures, no blood, because the avatar is seen daily including during cravings and slips. **Make personalization visible** with a "Why does my lung look like this?" sheet listing the user's inputs and the Section 1 provenance badges. **Pair every harm visual with an efficacy cue and a one-tap plan** (EPPM, Section 3), and hide the harm reveal by default for fear-control users. An optional 20–30-second values affirmation before the reveal is an A/B arm, not a requirement.

### 4.2 Quitter's Flu peaks in weeks 1–2, not 2–4

**Among 174 smokers in a 7-week program, those abstinent at 6 weeks had significant increases in cold symptoms (sore throat, coughing, deafness, sneezing) and mouth ulcers after 1 and 2 weeks of abstinence (ulcers p = 0.004 and 0.008), and the authors advised telling smokers in advance because preparation "may reduce their impact"** (Ussher, West, Steptoe, McEwen, Tob Control 2003;12(1):86–88, DOI 10.1136/tc.12.1.86) ([PMC1759110](https://pmc.ncbi.nlm.nih.gov/articles/PMC1759110)) [V]. It was a single uncontrolled cohort; press coverage reported symptoms subsiding by six weeks ([HealthDay](https://www.healthday.com/health-news/digestive-system/as-if-quitting-smoking-wasn-t-hard-enough-511915.html)) [V]. **Premise correction: the best-documented window is weeks 1–2, earlier than the brief's weeks 2–4.** Most withdrawal symptoms fall sharply over the first days and more slowly through weeks 2–3 ([UT Health](https://scholars.uthscsa.edu/en/publications/reports-of-smoking-withdrawal-symptoms-over-a-21-day-period-of-ab/)) [V], and anxiety, irritability and depressed mood rise significantly in the first 24 hours (Conti 2020 meta-analysis) ([St Andrews](https://research-repository.st-andrews.ac.uk/bitstream/10023/23233/1/Conti_2020_Severity_of_negative_mood_NBR_AAM.pdf)) [V]. Hughes 2007 (NTR 9(3):315–327) is the standard time-course reference; its contents were not retrieved.

**Implementation.** A server-configurable `clearance` state runs **day 3 to day 42 with peak emphasis on days 7–21**, entered by days-since-quit or by a "more cough/phlegm/sore throat" check-in. Anticipatory copy goes out on day 2–3 as a notification and card: **"Some people notice more coughing, a sore throat or cold-like symptoms in the first couple of weeks. It's common and usually temporary. Your lungs are adjusting."** The mechanism is unverified, so hedge it ("Many doctors think this is partly your airways clearing out"). On the avatar, the cough must read as cleanup: raise `ciliaMotility` (faster, more coordinated upward wave), spawn debris particles that travel up and out and dissolve at the trachea, lower `tarDensity` visibly with each exit, draw `bronchialInflammation` in amber "repair" tint, and offer a "cough log" button that fires the `coughClear` trigger (1.5 s burst) and records a data point. A clinician-reviewed **"When to get checked"** list (coughing blood, chest pain, breathlessness, fever, symptoms beyond the window) is mandatory; thresholds need clinical sign-off. Add a one-tap EMA during the window, "Do you think these symptoms mean quitting is bad for you?", and track it against lapses to test Ussher's misattribution hypothesis.

### 4.3 Lung avatar state machine: Rive Data Binding, not Inputs

**Premise correction: Rive has deprecated state-machine Inputs.** The docs say "⚠️ DEPRECATED: Use Data Binding instead of Inputs… For new projects: Use Data Binding… Plan to migrate from Inputs to Data Binding as soon as possible" ([rive-docs inputs.mdx](https://github.com/rive-app/rive-docs/blob/main/editor/state-machine/inputs.mdx)) [V]. Bind the five lung variables as **number properties on a View Model**. 1D blend states mix timelines from a single numeric property, but **"this mixing is not linear, but is additive"**, so key only one or two properties per timeline ([states.mdx](https://github.com/rive-app/rive-docs/blob/main/editor/state-machine/states.mdx)) [V]. Layers run in parallel and **the lower layer takes priority** when layers key the same property ([layers.mdx](https://github.com/rive-app/rive-docs/blob/main/editor/state-machine/layers.mdx)) [V]. Converters include **Range Map, Interpolator, Formula and Color Interpolator** ([converters.mdx](https://github.com/rive-app/rive-docs/blob/main/editor/data-binding/converters.mdx)) [V].

| Runtime | Load / bind | Set a number property | Source [V] |
|---|---|---|---|
| Flutter (`rive` 0.14.x, `rive_native` 0.1.11) | `File.asset('assets/lung.riv', riveFactory: Factory.rive)` → `RiveWidgetController(file, stateMachineSelector: StateMachineSelector.byName('Lung'))` → `controller.dataBind(DataBind.auto())` | `vmi.number('tarDensity')!.value = x` (also `.addListener`, `.dispose()`); pause with `controller.active = false` | [data-binding.mdx](https://github.com/rive-app/rive-docs/blob/main/runtimes/flutter/data-binding.mdx) |
| Apple "New Runtime" | `try await artboard.createStateMachine(binding: viewModelInstance)` | `viewModelInstance.setValue(of: NumberProperty(path: "tarDensity"), to: x)` (main actor; queued) | [apple data-binding.mdx](https://github.com/rive-app/rive-docs/blob/main/runtimes/apple/data-binding.mdx) |
| Android Compose | `val vmi = rememberViewModelInstance(riveFile, source)` | `vmi.setNumberProperty("tarDensity", x)`; read via `vmi.numberPropertyFlow(...)` | [android data-binding.mdx](https://github.com/rive-app/rive-docs/blob/main/runtimes/android/data-binding.mdx) |

Initial values are not applied until the state machine advances [V]. **Shader alternative or overlay:** Flutter `FragmentProgram.fromAsset()` → `fragmentShader()` with `setFloat(index, v)` or `getUniformFloat('uTar').set(v)` ([Flutter engine painting.dart](https://github.com/flutter/flutter/blob/stable/engine/src/flutter/lib/ui/painting.dart)); Android `RuntimeShader` (AGSL, **API 33+**) with `setFloatUniform("uTar", v)` ([RuntimeShader](https://developer.android.com/reference/android/graphics/RuntimeShader)) [V]. Use uniforms `uTar`, `uInflam`, `uCilia`, `uO2`, `uBreath` (0–1) and `uTime`, and stop advancing `uTime` under Reduce Motion. Rive is 2D, which suits a stylized avatar with reliable low-end Android performance (Section 0, B5).

**View Model `Lung`.** Numbers: `tarDensity`, `bronchialInflammation`, `ciliaMotility`, `alveolarOxygenation`, `respirationRate`, `breathPhase`. Enum `mode` ∈ {`inspect`, `craving`, `slip`, `clearance`}. Triggers `milestone`, `coughClear`. Layers: **L1** breath loop (1D blend inhale/exhale driven by `breathPhase`); **L2** tissue (1D blend clean↔tarred by `tarDensity`); **L3** airway (calm↔inflamed by `bronchialInflammation`); **L4** cilia (looping travelling wave; speed via app-side time scaling or Formula converter); **L5** mode overlays (Any State → mode states), placed lowest so mode overlays win.

#### Binding the Section 1 models to the avatar

The notes specify the visual channels but not the physiology-to-avatar binding, so the binding below is a design proposal [R] that keeps each variable tied to a Section 1 quantity with a known evidence grade. Every variable remains a **visual metaphor, not a measurement**, and the inspect sheet shows the underlying number and grade.

| VM variable (0–1 unless stated) | Proposed source (Section 1) | Evidence grade of source | Visual channels (from notes) | Mapping (pre-smoothing) | Transition |
|---|---|---|---|---|---|
| `tarDensity` | Quit-day value from lung-tier pack-year-equivalent (Section 1.3 `PackYear_eq`, normalized); then reduced by the "recovery progress" composite (Section 1.2) | Structure B/C; metaphor | Soot-speckle opacity, tissue saturation, airway particles | opacity = 0.85·t; saturation × (1 − 0.55·t); particles = round(400·t) (shader) or Range Map 0–1 → 0–100% | Daily reveal yesterday → today over 2.5 s |
| `bronchialInflammation` | Acute load (CO + NIC + AUTO-fast) plus E_irrit for vapers (Section 1.3) | CO τ A; NIC C; AUTO B | Airway-wall warm hue, wall thickness, vessel glow | hue neutral pink → **amber (#F6B26B family), never saturated red**; wall scale 1.00 → 1.12; glow α 0.4·i | Spring, ~1.5 s settle |
| `ciliaMotility` | 1 − D_MCC (Section 1.2, T ≈ 5–7 d; ×0.4–0.8 recovery for exclusive vapers) | B | Travelling-wave speed and amplitude along bronchi (upward = clearance) | speed 0.2 → 1.5 cycles/s (**visual metaphor, not physiological rate**); amplitude 0.2 → 1.0; phase coherence ↑ | Spring ~1 s; continuous phase accumulator |
| `alveolarOxygenation` | 1 − D_CO (Section 1.2 CO superposition, τ 6.49 h awake) | A (τ) | Alveolar brightness, bloom, color temperature | slate #5B6573 → peach-coral #FFB59E; bloom 0 → 0.6; sparkle ↑ | Color Interpolator or spring ~2 s |
| `respirationRate` (bpm, clamp 4–20) | Resting display rate in `inspect`; **locked to 6 bpm (4 s in / 6 s out) in `craving`** (Section 2.5); optional mic breath detection (Section 5) | Pacer [M] | Breath loop period; chest scale amplitude | period = 60/rate s; scale amplitude 2–4% | **Phase-continuous** (below) |

#### Mode state machine

| From → To | Trigger | Avatar behavior | Haptics | Gamification |
|---|---|---|---|---|
| `onboarding_reveal` → `inspect` | Lung model computed; user taps "See my lungs" (skippable) | Quit-day state shown once; efficacy cue + plan on same screen | none | none |
| `inspect` (default) | App open | Delta reveal: animate last-seen snapshot → current over 2–2.5 s; fire `milestone` if a threshold is crossed | ≤3 discrete events/session tied to animation peaks | Badges allowed |
| `inspect` → `craving` | SOS tap (anywhere), widget, shortcut, Live Activity, or JITAI prompt accepted | Particles and cilia freeze; only breath loop at 6 bpm; background #0E0E0E | 0.1 Hz pacer, 18 cycles | **Off** (no toasts or badges mid-session) |
| `craving` → `inspect` | 180 s complete, "I'm OK now", or exit | "You rode it out" + 0–10 re-rating; subtle oxygen-glow pulse (skipped under Reduce Motion) | one `.success`-class event after rating | Optional badge **after** rating |
| `craving` → `craving` | "Surf again" / "longer surf" | Restart countdown | Pacer continues phase-locked | Off |
| `inspect` → `slip` | User taps "I smoked" or check-in reports cigarettes > 0 (**never inferred and announced**) | **Small transient haze**: +0.05 `tarDensity` for the slip day, decaying visually over 24–72 h of abstinence; **never reset to quit-day state**; cumulative days unchanged | near-silent; one soft confirm on "Back on track" | Off until the next-step commit |
| `slip` → `inspect` | User commits to a next step (Section 2.4 Slip Response) | Return to inspect | `.soft` impact / Android `CONFIRM` | "Back on track" badge after 24 h smoke-free |
| `inspect` → `clearance` (overlay) | Day 3–42 after quit or symptom check-in | Cleanup animation; amber repair tint; debris exits | "Clear-out" pattern on cough log | "Logged a Clearance-window symptom" badge |
| any → `support_escalation` | ≥3 slips in 7 days, or ≥7 consecutive smoking days | Neutral | none | Gamification replaced by quitline and pharmacotherapy information (Section 2.6) |

**Motion math.** Breathing is phase-continuous: keep `φ += dt·rate/60`, map `φ mod 1` to `breathPhase`, and for 4:6 pacing use inhale fraction 0.4: `p = φ' < 0.4 ? easeInOutSine(φ'/0.4) : 1 − easeInOutSine((φ' − 0.4)/0.6)`. Smooth `rate` with a spring, never `breathPhase`. Use a **critically damped spring** `x'' = −2ω·x' − ω²·(x − target)`, whose error decays as `(1+ωt)·e^(−ωt)`, giving a 2% settle time ≈ **5.83/ω** (ω ≈ 3.9 rad/s for 1.5 s); integrate with semi-implicit Euler with dt clamped ≤1/30 s [D]. **Smooth in one place only**, in app code (testable, respects Reduce Motion), not also in Rive Interpolator converters, or the lag stacks; stop writing values at rest to save power.

**Reduced motion.** Apple's HIG asks apps to reduce "automatic and repetitive animations, including zooming, scaling, and peripheral motion," tighten springs and replace movement with fades ([HIG Accessibility](https://developer.apple.com/design/human-interface-guidelines/accessibility)) [V]. Check iOS `UIAccessibility.isReduceMotionEnabled`, Flutter `MediaQuery.disableAnimationsOf(context)` (stable; `MediaQueryData.reduceMotion` exists only on master), and Android `ValueAnimator.areAnimatorsEnabled()` (API 26) [V]. Under Reduce Motion, freeze cilia (static arrow-density pattern), replace breath scaling with a slow opacity pulse or a text/haptic countdown, drop particles (static texture plus numeric label), disable rotation, bloom and parallax, and use ω ≈ 12 or a 200 ms cross-fade. WCAG 2.3.3 (AAA) asks apps to support motion preferences ([WCAG](https://github.com/w3c/wcag/blob/main/understanding/21/animation-from-interactions.html)) [V].

### 4.4 OLED color system and typography

Material's dark baseline is **#121212**, chosen over black for shadow visibility and eye strain, with OLED battery savings listed as a benefit ([MDC Dark.md](https://github.com/material-components/material-components-android/blob/master/docs/theming/Dark.md); [colors.xml](https://github.com/material-components/material-components-android/blob/master/lib/java/com/google/android/material/color/res/values/colors.xml)) [V]. Material 3 dark roles use neutral tones 4 (container lowest), 6 (background/surface), 10, 12, 17, 22 and 24, with on-surface 90 ([Color.md](https://github.com/material-components/material-components-android/blob/master/docs/theming/Color.md)) [V]. WCAG requires **4.5:1** for text, **3:1** for large text and meaningful UI cues, and **24×24 CSS px** targets ([1.4.3](https://github.com/w3c/wcag/blob/main/understanding/20/contrast-minimum.html); [1.4.11](https://github.com/w3c/wcag/blob/main/understanding/21/non-text-contrast.html); [2.5.8](https://github.com/w3c/wcag/blob/main/understanding/22/target-size-minimum.html)) [V]; platform minimums are **44×44 pt on iOS** and **48×48 dp on Android** ([HIG](https://developer.apple.com/design/human-interface-guidelines/accessibility); [Android](https://developer.android.com/guide/topics/ui/accessibility/apps)) [V]. Apple notes **red signals danger in some cultures but is positive in others** and warns against relying on color alone ([HIG Color](https://developer.apple.com/design/human-interface-guidelines/color)) [V]. The color-emotion literature ("blue calms, red alarms") was not verified, so the palette rests on HIG guidance and contrast math. Contrast ratios below were computed with the WCAG luminance formula [D].

| Token | Hex | Contrast on #131313 | Use |
|---|---|---|---|
| `bg.canvas` | #000000 | — | Static craving-mode backdrop only (nothing scrolls over it) |
| `bg.base` | #0E0E0E | — | Craving mode background |
| `surface` | #131313 | — | Default background (≈ MDC #121212) |
| `surface.container` | #1F1F1F | — | Cards |
| `surface.high` | #2A2A2A | — | Sheets, elevated cards |
| `surface.highest` | #353535 | — | Pressed states, chips |
| `on.surface` | #E2E2E2 | 14.3:1 | Primary text |
| `on.surface.variant` | #9E9E9E | 6.9:1 | Secondary text (#7A7A7A = 4.33:1 **fails**) |
| `accent.oxygen` (inspect) | #4FD1C5 | 9.96:1 | Progress, oxygen |
| `accent.tissue` (inspect) | #FFB59E | 10.93:1 | Healthy tissue, warmth |
| `accent.data` | #C6B8FF | 10.35:1 | Secondary data |
| `accent.calm` (craving) | #8AB4F8 | 8.82:1 | SOS button fill with label #0B1B33 (8.18:1); **no red, no amber** |
| `accent.repair` (slip, inflammation) | #F6B26B | 10.17:1 | Post-slip; button text #2B1700 (9.38:1); **no red, no error styling** |
| `danger.soft` | #F28B82 | 7.78:1 | **Only** clinical red-flag safety copy |

Use #000 only behind static content because many OLED panels smear when scrolling from black to grey (widely reported, not sourced; validate on Samsung and Pixel panels). Blue vs amber mode distinction differs in both hue and luminance, which is robust for red-green deficiencies, but verify with a CVD simulator, attach a text label, icon and distinct layout to every state, and encode `tarDensity` as speckle texture, not hue alone. Implement a native dark theme rather than Android Force Dark.

**Typography.** Use system fonts with Dynamic Type; iOS defaults at "Large" are Large Title 34/41, Title 1 28/34, Title 2 22/28, Title 3 20/25, Headline 17/22 semibold, Body 17/22, Callout 16/21, Subhead 15/20, Footnote 13/18, Caption 1 12/16, Caption 2 11/13 ([HIG Typography](https://developer.apple.com/design/human-interface-guidelines/typography)) [V]. **All counters use tabular digits**: SwiftUI `.monospacedDigit()` (iOS 15+) and Flutter `FontFeature.tabularFigures()` [V]; Compose `fontFeatureSettings = "tnum"` is unverified. Hero counters (days smoke-free, money kept) at about 48–64 pt semibold, capped so they never wrap; craving countdown 56–72 pt with a ring; body 17 pt iOS / Material Body Large 16 sp (M3 scale unverified). Test at accessibility sizes AX1–AX5 and shrink the avatar frame rather than truncating text.

### 4.5 Haptic patterns for progress, the 180-second craving pacer and post-slip control

Core Haptics (iOS 13+) offers `hapticTransient` and `hapticContinuous` events with `hapticIntensity` and `hapticSharpness` (0–1); parameter curves interpolate linearly and apply to the whole pattern; `CHHapticAdvancedPatternPlayer` supports `loopEnabled` and `loopEnd` ([CHHapticParameterCurve](https://developer.apple.com/documentation/corehaptics/chhapticparametercurve); [advanced player](https://developer.apple.com/documentation/corehaptics/chhapticadvancedpatternplayer)) [V]. AHAP's documented duration key is `Duration` while Apple samples use `EventDuration`, and unsupported keys are silently ignored, so **build patterns in code** ([AHAP docs](https://developer.apple.com/documentation/corehaptics/representing-haptic-patterns-in-ahap-files)) [V]. Apple's HIG says to use haptics consistently, complement other feedback, avoid overuse, prefer short haptics for discrete events and make haptics optional ([HIG](https://developer.apple.com/design/human-interface-guidelines/playing-haptics)) [V]. Android offers `VibrationEffect.Composition` primitives (API 30/31; **compositions have no fallback, so one unsupported primitive fails the whole effect**), amplitude waveforms (check `hasAmplitudeControl()`), and **`BasicEnvelopeBuilder` (API 36), whose effects must end at zero intensity** ([Composition](https://developer.android.com/reference/android/os/VibrationEffect.Composition); [BasicEnvelopeBuilder](https://developer.android.com/reference/android/os/VibrationEffect.BasicEnvelopeBuilder); [custom effects](https://developer.android.com/develop/ui/views/haptics/custom-haptic-effects)) [V]. Android's guidance: delays ≥50 ms for discernible gaps, scale steps ≥1.4× (0.5/0.7/1.0), start and end waveforms at zero, and **"Given the choice of buzzy haptics or no haptics for touch feedback, choose no haptics"** ([principles](https://developer.android.com/develop/ui/views/haptics/haptics-principles)) [V]. Vibrotactile pacing research (Miri et al., PIV, ACM TOCHI 2020; PIV++ is the separate CHI 2020 paper) favored **frequency-based, strong-exhale-phased patterns** ([Stanford HCI](https://hci.stanford.edu/publications/paper.php?id=384)) [V]. No RCT of phone haptic breathing for tobacco craving exists.

| Meaning | iOS | Android | Used in |
|---|---|---|---|
| Neutral tap / select | `UIImpactFeedbackGenerator(style: .soft)` or `.sensoryFeedback(.selection, …)` | `HapticFeedbackConstants.CONFIRM` / `PRIMITIVE_TICK` @0.5 | Inspect: tapping lung regions |
| Progress / milestone | `.sensoryFeedback(.success, trigger:)` | `PRIMITIVE_SLOW_RISE` @0.5 → 60 ms → `PRIMITIVE_CLICK` @0.7 | Delta-reveal end, badge |
| Breath pacer | Continuous events + intensity curve (below) | Envelope / waveform / primitives (below) | Craving only |
| "Clear-out" (cough log) | 3× `hapticTransient` 80 ms apart, intensity 0.3→0.5, sharpness 0.6 | 3× `PRIMITIVE_LOW_TICK` @0.5, 0.7, 1.0 with 60 ms gaps | Clearance window |
| Commit after slip | `UIImpactFeedbackGenerator(style: .soft)` once | `CONFIRM` | "Back on track" |
| **Never used** | `.error`, `.warning`, heavy/rigid impacts | `REJECT`, buzzy long waveforms | Slip and craving modes |

**(a) Daily progress:** at most about 3 haptic events per session outside user taps, each tied to an animation peak with matched intensity and sharpness. **(b) Craving emergency: 0.1 Hz pacer, 18 × (4 s inhale + 6 s exhale) = exactly 180 s**, exhale-weighted per PIV: a gentle rising, low-sharpness continuous vibration on inhale and a stronger onset with slow decay on exhale (variant A), A/B-tested against a soft transient train on exhale (variant B). Offer haptics-only, visuals-only or both, and an intensity slider at 0.5/0.7/1.0. **Drive animation phase and haptic triggers from one monotonic clock**; never let a haptic loop free-run for 180 s detached from the visual. **(c) Post-slip:** near-silent, one soft confirmation when the user commits to a next step, and no error, warning or REJECT haptics anywhere, because a haptic used for failure teaches "you failed."

```swift
// iOS Core Haptics — verified API names; ControlPoint initializer labels unverified
final class BreathPacer {
  private var engine: CHHapticEngine?; private var player: CHHapticAdvancedPatternPlayer?
  func prepare() throws {
    guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }  // visual-only fallback
    let e = try CHHapticEngine(); e.playsHapticsOnly = true
    e.resetHandler = { [weak self] in try? self?.engine?.start(); try? self?.rebuild() }
    try e.start(); engine = e; try rebuild()
  }
  private func rebuild() throws {   // one 10 s cycle: inhale 0–4 s, exhale 4–10 s
    let inhale = CHHapticEvent(eventType: .hapticContinuous, parameters: [
        .init(parameterID: .hapticIntensity, value: 0.45), .init(parameterID: .hapticSharpness, value: 0.10)],
        relativeTime: 0, duration: 4.0)
    let exhale = CHHapticEvent(eventType: .hapticContinuous, parameters: [
        .init(parameterID: .hapticIntensity, value: 0.70), .init(parameterID: .hapticSharpness, value: 0.20)],
        relativeTime: 4.0, duration: 6.0)
    let curve = CHHapticParameterCurve(parameterID: .hapticIntensityControl, controlPoints: [
        .init(relativeTime: 0.0, value: 0.15), .init(relativeTime: 4.0, value: 0.60),
        .init(relativeTime: 4.15, value: 1.00), .init(relativeTime: 9.8, value: 0.05)], relativeTime: 0)
    let p = try engine!.makeAdvancedPlayer(with: CHHapticPattern(events: [inhale, exhale], parameterCurves: [curve]))
    p.loopEnabled = true; p.loopEnd = 10.0; player = p
  }
  func start() throws { try player?.start(atTime: CHHapticTimeImmediate) }   // stop at 180 s or exit
  func stop()  throws { try player?.stop(atTime: CHHapticTimeImmediate) }
}
```

```kotlin
// Android — verified API names/levels; tiered fallback. Attributes: USAGE_MEDIA (API 33)
fun breathCycle(v: Vibrator): VibrationEffect? = when {
  Build.VERSION.SDK_INT >= 36 && v.areEnvelopeEffectsSupported() ->
    VibrationEffect.BasicEnvelopeBuilder().setInitialSharpness(0.10f)
      .addControlPoint(0.40f, 0.10f, 4000)   // inhale: smooth rise
      .addControlPoint(0.70f, 0.20f, 150)    // exhale onset
      .addControlPoint(0.00f, 0.15f, 5850)   // exhale decay — MUST end at 0
      .build()
  v.hasAmplitudeControl() -> {                // 100 × 100 ms, starts/ends near 0
    val t = LongArray(100) { 100L }
    val a = IntArray(100) { i -> if (i < 40) 4 + i * 3 else ((99 - i) * 180 / 59) }
    VibrationEffect.createWaveform(t, a, -1) }
  Build.VERSION.SDK_INT >= 30 && v.areAllPrimitivesSupported(
      VibrationEffect.Composition.PRIMITIVE_SLOW_RISE, VibrationEffect.Composition.PRIMITIVE_QUICK_FALL) ->
    VibrationEffect.startComposition()
      .addPrimitive(VibrationEffect.Composition.PRIMITIVE_SLOW_RISE, 0.5f)
      .addPrimitive(VibrationEffect.Composition.PRIMITIVE_QUICK_FALL, 0.7f, 3500) // 4000 − slowRise duration
      .compose()
  else -> null   // visual-only rather than buzzy
}
// Re-trigger every 10 s from the animation clock (18 cycles = 180 s); v.cancel() on exit.
```

Whether Core Haptics continues when backgrounded or screen-locked, the maximum continuous-event duration, and whether Android vibration settings attenuate `USAGE_MEDIA` were not verified; test on devices.

### 4.6 SOS and post-slip micro-interactions

**Craving SOS (target under 2 s from intent to breathing).** A persistent "Craving" button with icon on every main screen, bottom-center, ≥64 pt/dp visual and ≥72 pt hit area, plus an app-icon long-press shortcut, home-screen widget and an optional iOS Live Activity for the countdown (ActivityKit, iOS 16.1+; [Apple](https://developer.apple.com/documentation/activitykit)) [V]. A tap starts immediately with no confirmation: `mode = craving`, background #0E0E0E, accent #8AB4F8, avatar simplified to the 6-bpm breath loop, pacer at cycle 1. Layout: a 180-s countdown ring with tabular "2:47" counting **down**; a center breath circle (or the lung) expanding 4 s and contracting 6 s with cross-fading "Breathe in" / "Breathe out" (≤3 words); one large "I'm OK now" control and a small "Other ways" link (Urge Surfer audio, move option, call a buddy). One instruction at a time, no other numbers, no badges; VoiceOver/TalkBack announce each phase. At 180 s: "You rode it out" plus the 0–10 re-rating, then an optional badge. Early exit always available and logged silently. The Urge Surfer script (Section 2.1) runs on this same 180-s clock.

**Post-slip ("damage control").** Entry only from the neutral "I smoked" control or a check-in; never infer a slip and announce it. Amber/peach on #131313, no red, no shake, no error haptics, a small transient haze on the avatar that never resets it, and cumulative smoke-free days unchanged. Copy: **"A slip is one moment, not the whole story."** → "What was going on?" (chips) → "What's your next step?" (plan for that trigger, use SOS next time, restart the run now), then the full Section 2.4 protocol. Avoid "relapse," "failed," "reset" and "start over." One soft haptic on "Back on track"; repeated slips (≥3 in 7 days) escalate to quitline and pharmacotherapy information rather than more gamification.

**Gamification.** The main experimental evidence is Smoke Free's exploratory full-vs-reduced RCT (28,112 smokers; daily missions plus badges; creator is an author with financial interest) ([F1000Research](https://f1000research.com/articles/7-1524/v2)) [V]; the brief's "Crane 2019 Addiction DOI 10.1111/add.14440" could not be confirmed, and the 2019 Addiction paper found is the Jackson protocol ([UCL](https://discovery.ucl.ac.uk/id/eprint/10073536/)) [V]. Reward plausible active ingredients ("Craving surfed", "First week of cravings beaten", "Used a plan after a slip"), use daily one-skill missions, make cumulative smoke-free days the never-resetting primary counter, avoid leaderboards and loss-framed streak notifications ("Don't lose your streak!"), and switch gamification off during craving and slip modes. Pre-register an avatar-on vs avatar-off A/B test on 30-day retention and 3-month self-reported abstinence, which is Section 0's Gate #2 in product form.

## Section 5. Technical architecture: Flutter, encrypted SQLite and an on-device everything

All package versions below are live registry values fetched on 2026-10-21 from pub.dev, npm and Maven Central [V-DATA]; platform API names come from Apple and Android developer documentation fetched directly [V].

### 5.1 Stack: Flutter with two native escape hatches

**Recommendation: Flutter (Dart ≥3.10, Flutter ≥3.44), with thin native Swift/Kotlin modules for HealthKit background delivery and for low-latency microphone capture and DSP.** Flutter has the most complete single-codebase coverage of every hard requirement: `health` 13.3.2 (HealthKit and Health Connect, including Health Connect history and background permission methods), drift 2.35.2 on `sqlite3` 3.7.1 (SQLCipher or SQLite3MultipleCiphers selectable by build hook), `rive` 0.14.11 on the native Rive renderer via `rive_native` 0.1.11, `record` 7.1.2 (raw PCM16 streaming), flutter_local_notifications 22.3.2, workmanager 0.10.10, flutter_secure_storage 11.2.0, permission_handler 13.0.2, audio_session 0.2.4, native_geofence 1.3.1, flutter_onnxruntime 1.9.0 and tflite_flutter 0.12.1 (last published 2025-10-28) ([pub.dev health](https://pub.dev/packages/health); [drift](https://pub.dev/packages/drift); [rive](https://pub.dev/packages/rive); [record](https://pub.dev/packages/record)) [V-DATA]. `geofence_service` is discontinued, replaced by `geofencing_api` [V-DATA]. `record` 7.1.2 and `sentry_flutter` 10.1.0 require Flutter ≥3.44, so that release must exist as stable.

| Option | Strengths | Blocking weakness | Verdict |
|---|---|---|---|
| **Flutter** | First-party Rive runtime (0.14.x) with native renderer; encrypted SQLite as a build option with SBOM and SLSA attestation; `health` covers both platforms | `health` README does not cover HealthKit background delivery; `record` cannot set iOS `.measurement` mode | **Recommended** |
| React Native ≥0.82 (0.88.0 published 2026-10-15) | `@kingstinct/react-native-healthkit` 16.2.0, `react-native-health-connect` 4.1.3, `op-sqlite` 18.2.5 (SQLCipher target), `@shopify/react-native-skia` 2.14.0 | Rive runtime mid-migration to `@rive-app/react-native` 0.5.5 (Nitro); `react-native-health` stale since 2024 | Second choice for JS-heavy teams |
| Kotlin / Compose Multiplatform | iOS UI stable since 1.8.0 (May 2025); SQLDelight 2.4.1 + `net.zetetic:sqlcipher-android` 4.19.1 | No first-party Compose MP Rive runtime found; no verified cross-platform health library | For Kotlin-first teams willing to hand-write HealthKit interop |

Sources: [npm react-native](https://www.npmjs.com/package/react-native); [rive-react-native README](https://github.com/rive-app/rive-react-native/blob/main/README.md); [JetBrains blog](https://blog.jetbrains.com/kotlin/2025/05/compose-multiplatform-1-8-0-released-compose-multiplatform-for-ios-is-stable-and-production-ready/) [V]. The Rive Flutter README warns of possible rendering discrepancies under Impeller ([README](https://github.com/rive-app/rive-flutter/blob/master/README.md)) [V]; use `Factory.rive` and test on devices.

```
┌──────────────────────────── Flutter (Dart) ─────────────────────────────┐
│ UI: Rive Lung VM + fragment shaders │ Onboarding │ Urge Surfer │ SOS     │
│ Domain: lung model (S1.1) · BTI (S1.2) · exposure tiers (S1.3)           │
│         rules L0 + LR/GBT risk (S2.2) · framing math (S2.3) · Slip flow  │
│ Data: drift → sqlite3 3.x (SQLCipher/SQLite3MC) — encrypted, on-device   │
│ ML: flutter_onnxruntime (GBT/LR) │ LiteRT (later temporal model)         │
│ Scheduling: notification planner (≤48 pending iOS) · WorkManager · BGTask│
├────────────── native iOS (Swift) ──────────────┬──── native Android ─────┤
│ AppDelegate: HKObserverQuery +                  │ Health Connect client   │
│   enableBackgroundDelivery → HKAnchoredObjectQuery│ Changes tokens, WorkMgr│
│ AVAudioEngine/AVAudioSinkNode (.measurement)    │ Oboe/AAudio UNPROCESSED │
├─────────────── shared C/C++ `breathdsp` via dart:ffi (XCFramework / NDK) ─┤
│ init(cfg) · push(pcm, n, ts) · poll(events) — ~30–60 Hz feature events    │
└────────────────────────────────────────────────────────────────────────────┘
Network (optional only): E2E-encrypted backup blobs · signed model/content downloads · opt-in telemetry
```

### 5.2 Encrypted local database: `sqlite3` 3.x build hooks, because `sqlcipher_flutter_libs` is end-of-life

**Premise correction: `sqlcipher_flutter_libs` is EOL.** Its latest version is `0.7.0+eol`, whose metadata says "Not used anymore, update to version 3.x of package:sqlite3 instead" and "Starting from version 0.7.0, this package no longer does anything" ([pub.dev](https://pub.dev/packages/sqlcipher_flutter_libs)) [V]. The sqlite3 3.0.0 changelog says to drop both `sqlite3_flutter_libs` and `sqlcipher_flutter_libs` ([CHANGELOG](https://github.com/simolus3/sqlite3.dart/blob/main/sqlite3/CHANGELOG.md)) [V]. Each `package:sqlite3` release ships prebuilt upstream SQLite, SQLite3MultipleCiphers and a SQLCipher community build, selected in `pubspec.yaml`; the SQLCipher build links OpenSSL on Android and may lag the SQLite version; binaries carry sha256 verification, **SLSA level 3 attestations since 3.5.2** and CycloneDX SBOMs ([hook.md](https://github.com/simolus3/sqlite3.dart/blob/main/sqlite3/doc/hook.md)) [V]:

```yaml
hooks:
  user_defines:
    sqlite3:
      source: sqlite3mc   # or: sqlcipher   (default: sqlite3 = unencrypted)
```

SQLCipher uses 256-bit AES; `PRAGMA key = 'passphrase'` runs PBKDF2, while a raw key **"64 character hex string… converted directly to 32 bytes"** skips it, and **PRAGMA key must be the first operation** after open ([SQLCipher README](https://github.com/sqlcipher/sqlcipher/blob/master/README.md)) [V]. **Realm Device SDKs and Atlas Device Sync reached end-of-life on 30 September 2025**; avoid Realm for new work ([MongoDB](https://mongodb.com/community/forums/t/update-to-end-of-life-and-deprecation-notice/297168)) [V].

| Step | Specification | Source |
|---|---|---|
| Key generation | 32 random bytes (`Random.secure()`) on first launch | [R] |
| Key storage, iOS | flutter_secure_storage `IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device)` = `kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly`: readable by background tasks after first unlock, never migrates to a new device | [Apple](https://developer.apple.com/documentation/security/ksecattraccessibleafterfirstunlockthisdeviceonly) [V] |
| Key storage, Android | Default `AndroidOptions()`: RSA/ECB/OAEPWithSHA-256AndMGF1Padding key cipher + AES/GCM/NoPadding storage cipher (Jetpack `encryptedSharedPreferences` no longer recommended); Auto Backup can break key unwrap | [README](https://github.com/juliansteenbakker/flutter_secure_storage/blob/develop/README.md) [V] |
| Open | drift `NativeDatabase` setup: `PRAGMA key = "x'<64 hex>'"` → (SQLCipher, optional) `PRAGMA cipher_memory_security = ON` → `PRAGMA foreign_keys = ON` → `PRAGMA journal_mode = WAL`; verify with `PRAGMA cipher_version` (SQLCipher) or `PRAGMA cipher` (SQLite3MC) and **fail closed** if empty; test that a wrong key fails | Pragma names for memory security and version are [PK] |
| Cipher choice | `sqlite3mc` (no OpenSSL on Android, newer SQLite) vs `sqlcipher` (widely audited format); choose once — switching needs ATTACH + `sqlcipher_export()` | [V] |
| `STRICT` tables | Need SQLite ≥3.37; check `SELECT sqlite_version()` at startup | [V/PK] |
| Secure Enclave / StrongBox | Optional; SE is P-256 only and cannot import keys; StrongBox is slower and "not necessary" for most apps; if used, ECIES-wrap the DB key without biometry or background opens fail | [Apple](https://developer.apple.com/documentation/security/protecting-keys-with-the-secure-enclave); [Android Keystore](https://developer.android.com/privacy-and-security/keystore) [V] |
| iOS file | Application Support; `isExcludedFromBackupKey = true` **re-applied after every save/VACUUM** ("common file operations cause this property to reset"); `FileProtectionType.completeUntilFirstUserAuthentication` for background writes | [Apple](https://developer.apple.com/documentation/foundation/urlresourcekey/isexcludedfrombackupkey) [V] |
| Android backup | `dataExtractionRules` (API 31+) excluding `database` (DB, `-wal`, `-shm`) and secure-storage prefs from `<cloud-backup>` and `<device-transfer>`; matching `fullBackupContent` for ≤API 30; `allowBackup="false"` (does not stop device-to-device on some OEMs) | [Auto Backup](https://developer.android.com/identity/data/autobackup) [V] |
| iCloud | **No PHI in iCloud** (App Review 5.1.3(ii)); no health data for advertising (5.1.3(i)); guidelines updated 16 Oct 2026 | [App Review Guidelines](https://developer.apple.com/app-store/review/guidelines/) [V] |
| Optional E2E backup | App-managed: rows → `sync_outbox` → client-side XChaCha20-Poly1305 or AES-256-GCM with a key from a user recovery code (Argon2id); server stores opaque blobs | [R] |

#### Schema DDL

Conventions: `STRICT` tables; `id TEXT` = on-device UUIDv7 (time-sortable, merge-safe); event times as `*_utc_ms INTEGER` + `tz_offset_min` + `tz_id` (preserves local time-of-day features for Section 2.2 across travel and DST); every user-data table carries `created_at_utc_ms`, `updated_at_utc_ms`, `deleted_at_utc_ms` (tombstone), `rev`, `sync_state` (0 local, 1 dirty, 2 synced), abbreviated below as `/* audit cols */`; booleans INTEGER 0/1; enums TEXT with CHECK; JSON as TEXT with `json_valid()`. The DDL is from the architecture notes [R]; **lines marked `-- [integration]` are this report's edits** so the schema stores Section 1.3 products, Section 3's original onboarding items and Section 1 model outputs.

```sql
-- audit cols = created_at_utc_ms INTEGER NOT NULL, updated_at_utc_ms INTEGER NOT NULL,
--              deleted_at_utc_ms INTEGER, rev INTEGER NOT NULL DEFAULT 0, sync_state INTEGER NOT NULL DEFAULT 0

-- identity & consent
CREATE TABLE user_profile (
  id TEXT PRIMARY KEY, display_name TEXT, birth_year INTEGER, sex_at_birth TEXT,
  height_cm REAL, age_started_smoking REAL,                       -- [integration] S1.1 lung model
  country_code TEXT, locale TEXT, tz_id TEXT NOT NULL,
  cigs_per_day_baseline REAL, years_smoked REAL, pack_price_minor INTEGER, cigs_per_pack INTEGER, currency TEXT,
  hsi_score INTEGER,                                              -- [integration] FTND not used (S3)
  /* audit cols */) STRICT;

CREATE TABLE consent_log (                                         -- append-only; GDPR accountability
  id TEXT PRIMARY KEY, purpose TEXT NOT NULL CHECK (purpose IN
    ('core','healthkit','health_connect','microphone','location','notifications',
     'analytics','crash_reports','research','e2e_backup')),
  granted INTEGER NOT NULL, policy_version TEXT NOT NULL, at_utc_ms INTEGER NOT NULL, tz_offset_min INTEGER NOT NULL
) STRICT;

-- onboarding & phenotyping
CREATE TABLE onboarding_responses (
  id TEXT PRIMARY KEY, instrument TEXT NOT NULL,                   -- [integration] e.g. 'onb_core' (original items, S3)
  instrument_version TEXT NOT NULL, item_code TEXT NOT NULL,       -- 'ttfc','cpd','aff','cue','auto','soc','stage',...
  value_num REAL, value_text TEXT, answered_at_utc_ms INTEGER NOT NULL, tz_offset_min INTEGER NOT NULL,
  dwell_ms INTEGER,                                                -- [integration] S3 paradata
  /* audit cols */, UNIQUE (instrument, instrument_version, item_code)) STRICT;

CREATE TABLE phenotype_scores (
  id TEXT PRIMARY KEY, phenotype_code TEXT NOT NULL,               -- 'dep_tier','trig_primary','stage','eppm_quadrant',...
  score REAL NOT NULL, method TEXT NOT NULL, model_version_id TEXT REFERENCES model_versions(id),
  computed_at_utc_ms INTEGER NOT NULL, /* audit cols */) STRICT;
CREATE INDEX ix_phenotype_code_time ON phenotype_scores(phenotype_code, computed_at_utc_ms);

-- [integration] Section 1 model outputs (estimates; never diagnostic)
CREATE TABLE lung_estimates (
  id TEXT PRIMARY KEY, computed_at_utc_ms INTEGER NOT NULL,
  reference_eq TEXT NOT NULL CHECK (reference_eq IN ('gli_global','jrs_2014','gli_2012','morris_temple_legacy')),
  pack_years_eq REAL, p_sus REAL, fev1_pred_l REAL, fev1_est_l REAL,
  lung_age_y REAL, gap_y REAL, band50_lo_y REAL, band50_hi_y REAL,
  bti_acute REAL, bti_recovery REAL, inputs_hash TEXT NOT NULL, model_version_id TEXT REFERENCES model_versions(id),
  /* audit cols */) STRICT;

-- quit journey
CREATE TABLE quit_attempts (
  id TEXT PRIMARY KEY, target_quit_utc_ms INTEGER NOT NULL, started_utc_ms INTEGER, ended_utc_ms INTEGER,
  end_reason TEXT CHECK (end_reason IN ('relapse','abandoned','success_6m', NULL)),
  method TEXT, tz_offset_min INTEGER NOT NULL, /* audit cols */) STRICT;

CREATE TABLE smoking_events (                                      -- every cigarette / session logged
  id TEXT PRIMARY KEY, quit_attempt_id TEXT REFERENCES quit_attempts(id),
  occurred_at_utc_ms INTEGER NOT NULL, tz_offset_min INTEGER NOT NULL, tz_id TEXT,
  product TEXT NOT NULL CHECK (product IN ('cigarette','rolled','bidi','kretek','cigarillo','cigar','pipe',
         'hookah','ecig','heated','snus','smokeless_sa','pouch','other')),   -- [integration] S1.3 products
  quantity REAL NOT NULL DEFAULT 1, unit TEXT,                     -- [integration] 'stick','session','portion','vape_day'
  session_minutes REAL, shared INTEGER,                            -- [integration] hookah inputs
  context_location TEXT, context_activity TEXT, context_social TEXT,
  mood_valence INTEGER, stress_0_10 INTEGER, craving_0_10_before INTEGER,
  automaticity_1_5 INTEGER, enjoyment_0_10 INTEGER, geofence_cluster_id TEXT,   -- [integration] S2.2 baseline log
  trigger_codes TEXT CHECK (trigger_codes IS NULL OR json_valid(trigger_codes)),
  logged_retrospectively INTEGER NOT NULL DEFAULT 0, source TEXT NOT NULL DEFAULT 'manual',
  /* audit cols */) STRICT;
CREATE INDEX ix_smoking_time ON smoking_events(occurred_at_utc_ms) WHERE deleted_at_utc_ms IS NULL;
CREATE INDEX ix_smoking_attempt ON smoking_events(quit_attempt_id, occurred_at_utc_ms);

CREATE TABLE cravings (
  id TEXT PRIMARY KEY, quit_attempt_id TEXT REFERENCES quit_attempts(id),
  onset_utc_ms INTEGER NOT NULL, tz_offset_min INTEGER NOT NULL,
  intensity_0_10 INTEGER NOT NULL CHECK (intensity_0_10 BETWEEN 0 AND 10),
  duration_s INTEGER, trigger_codes TEXT,
  intervention TEXT CHECK (intervention IN ('urge_surfer','breathing','defusion','distraction',
                            'nrt_fast','call_buddy','move','none', NULL)),
  intervention_session_id TEXT REFERENCES breath_sessions(id), intensity_after_0_10 INTEGER,
  outcome TEXT CHECK (outcome IN ('resisted','lapsed','unknown')),
  prompted_by_prediction_id TEXT REFERENCES predictions(id), /* audit cols */) STRICT;
CREATE INDEX ix_cravings_time ON cravings(onset_utc_ms);

CREATE TABLE lapses (
  id TEXT PRIMARY KEY, quit_attempt_id TEXT NOT NULL REFERENCES quit_attempts(id),
  smoking_event_id TEXT REFERENCES smoking_events(id), craving_id TEXT REFERENCES cravings(id),
  occurred_at_utc_ms INTEGER NOT NULL, tz_offset_min INTEGER NOT NULL,
  severity TEXT CHECK (severity IN ('slip','lapse','relapse')),   -- internal routing only (S2.4)
  chain_json TEXT CHECK (chain_json IS NULL OR json_valid(chain_json)),   -- [integration] chain-analysis answers
  reflection_text TEXT, /* audit cols */) STRICT;

-- EMA
CREATE TABLE ema_prompts (
  id TEXT PRIMARY KEY, schedule_kind TEXT NOT NULL CHECK (schedule_kind IN ('random','fixed','event','jitai')),
  scheduled_utc_ms INTEGER NOT NULL, delivered_utc_ms INTEGER, opened_utc_ms INTEGER,
  expires_utc_ms INTEGER NOT NULL, tz_offset_min INTEGER NOT NULL, questionnaire_id TEXT NOT NULL,
  notification_id TEXT REFERENCES notifications_log(id),
  status TEXT NOT NULL CHECK (status IN ('pending','delivered','answered','missed','cancelled')),
  /* audit cols */) STRICT;
CREATE INDEX ix_ema_status_time ON ema_prompts(status, scheduled_utc_ms);
CREATE TABLE ema_responses (
  id TEXT PRIMARY KEY, prompt_id TEXT NOT NULL REFERENCES ema_prompts(id), item_code TEXT NOT NULL,
  value_num REAL, value_text TEXT, rt_ms INTEGER, answered_utc_ms INTEGER NOT NULL,
  /* audit cols */, UNIQUE(prompt_id, item_code)) STRICT;

-- pharmacotherapy (user-entered regimens only — S2.6)
CREATE TABLE nrt_regimens (
  id TEXT PRIMARY KEY, quit_attempt_id TEXT REFERENCES quit_attempts(id),
  product TEXT NOT NULL CHECK (product IN ('patch','gum','lozenge','inhaler','spray','varenicline','cytisine','bupropion','other')),
  strength_mg REAL, schedule_json TEXT CHECK (schedule_json IS NULL OR json_valid(schedule_json)),
  entered_by TEXT NOT NULL DEFAULT 'user' CHECK (entered_by = 'user'),   -- [integration] never app-computed
  start_utc_ms INTEGER NOT NULL, planned_end_utc_ms INTEGER, ended_utc_ms INTEGER, /* audit cols */) STRICT;
CREATE TABLE nrt_doses (
  id TEXT PRIMARY KEY, regimen_id TEXT NOT NULL REFERENCES nrt_regimens(id),
  taken_utc_ms INTEGER NOT NULL, tz_offset_min INTEGER NOT NULL, dose_mg REAL,
  was_scheduled INTEGER NOT NULL DEFAULT 1, side_effects TEXT, /* audit cols */) STRICT;
CREATE INDEX ix_nrt_doses ON nrt_doses(regimen_id, taken_utc_ms);

-- wearables
CREATE TABLE wearable_samples (                                    -- raw imports, 90-day retention
  id TEXT PRIMARY KEY, platform TEXT NOT NULL CHECK (platform IN ('healthkit','health_connect')),
  external_id TEXT NOT NULL,                                       -- HKObject UUID / HC Metadata.id
  metric TEXT NOT NULL CHECK (metric IN ('rhr_bpm','hr_bpm','hrv_sdnn_ms','hrv_rmssd_ms',
         'resp_rate_brpm','spo2_pct','vo2max_ml_kg_min','steps','sleep_stage')),
  value REAL NOT NULL, start_utc_ms INTEGER NOT NULL, end_utc_ms INTEGER NOT NULL,
  tz_offset_min INTEGER, source_app TEXT, source_device TEXT, motion_context TEXT,
  imported_at_utc_ms INTEGER NOT NULL, deleted_at_utc_ms INTEGER, UNIQUE(platform, external_id)) STRICT;
CREATE INDEX ix_ws_metric_time ON wearable_samples(metric, start_utc_ms);
CREATE TABLE health_sync_state (
  platform TEXT NOT NULL, data_type TEXT NOT NULL, hk_anchor BLOB,
  hc_changes_token TEXT, hc_token_obtained_utc_ms INTEGER,         -- HC tokens expire within 30 days
  last_success_utc_ms INTEGER, last_error TEXT, PRIMARY KEY (platform, data_type)) STRICT;
CREATE TABLE biomarker_snapshots (                                 -- derived daily indices, long retention
  id TEXT PRIMARY KEY, day_local TEXT NOT NULL, metric TEXT NOT NULL,
  agg TEXT NOT NULL CHECK (agg IN ('mean','median','min','max','sum','last')),
  value REAL NOT NULL, n_samples INTEGER NOT NULL, baseline_median REAL, baseline_mad REAL, robust_z REAL,
  baseline_window_days INTEGER, platform TEXT NOT NULL, computed_at_utc_ms INTEGER NOT NULL,
  /* audit cols */, UNIQUE(day_local, metric, agg, platform)) STRICT;

-- Urge Surfer (no raw audio is ever stored)
CREATE TABLE breath_sessions (
  id TEXT PRIMARY KEY, started_utc_ms INTEGER NOT NULL, tz_offset_min INTEGER NOT NULL,
  planned_s INTEGER NOT NULL DEFAULT 180, completed_s INTEGER,
  mode TEXT NOT NULL CHECK (mode IN ('mic','touch','pacer_only')),
  target_exhale_s REAL NOT NULL DEFAULT 6, target_inhale_s REAL NOT NULL DEFAULT 4,
  n_exhales_detected INTEGER, mean_exhale_s REAL, sd_exhale_s REAL, mean_breath_rate_bpm REAL,
  adherence_pct REAL, median_snr_db REAL, calib_noise_floor_dbfs REAL, calib_exhale_peak_dbfs REAL,
  device_model TEXT, audio_route TEXT, craving_before_0_10 INTEGER, craving_after_0_10 INTEGER,
  /* audit cols */) STRICT;

-- ML
CREATE TABLE model_versions (
  id TEXT PRIMARY KEY, name TEXT NOT NULL, semver TEXT NOT NULL,
  runtime TEXT NOT NULL CHECK (runtime IN ('onnxruntime','litert','rules')),
  artifact_sha256 TEXT NOT NULL, feature_schema_version TEXT NOT NULL,
  activated_utc_ms INTEGER, retired_utc_ms INTEGER, UNIQUE(name, semver)) STRICT;
CREATE TABLE predictions (
  id TEXT PRIMARY KEY, model_version_id TEXT NOT NULL REFERENCES model_versions(id),
  predicted_at_utc_ms INTEGER NOT NULL, tz_offset_min INTEGER NOT NULL, horizon_min INTEGER NOT NULL,
  risk REAL NOT NULL, threshold REAL, randomization_prob REAL,     -- [integration] MRT logging (S2.2)
  features_hash TEXT, top_features_json TEXT,
  action TEXT CHECK (action IN ('none','notify','in_app_card','suppressed_cap','randomized_none')),  -- [integration]
  notification_id TEXT REFERENCES notifications_log(id),
  outcome_label INTEGER, outcome_observed_utc_ms INTEGER) STRICT;
CREATE INDEX ix_pred_time ON predictions(predicted_at_utc_ms);

-- engagement
CREATE TABLE notifications_log (
  id TEXT PRIMARY KEY, os_request_id TEXT NOT NULL, kind TEXT NOT NULL,
  scheduled_utc_ms INTEGER NOT NULL, delivered_utc_ms INTEGER, opened_utc_ms INTEGER, dismissed_utc_ms INTEGER,
  trigger TEXT CHECK (trigger IN ('time','calendar','geofence','prediction','ema')),
  geofence_id TEXT, payload_code TEXT, status TEXT NOT NULL) STRICT;
CREATE INDEX ix_notif_sched ON notifications_log(status, scheduled_utc_ms);
CREATE TABLE achievements (id TEXT PRIMARY KEY, code TEXT UNIQUE NOT NULL, title_key TEXT NOT NULL,
  criteria_json TEXT NOT NULL CHECK (json_valid(criteria_json))) STRICT;
CREATE TABLE user_achievements (
  id TEXT PRIMARY KEY, achievement_id TEXT NOT NULL REFERENCES achievements(id),
  earned_utc_ms INTEGER NOT NULL, tz_offset_min INTEGER NOT NULL, /* audit cols */, UNIQUE(achievement_id)) STRICT;
CREATE TABLE geofences (
  id TEXT PRIMARY KEY, label TEXT NOT NULL, lat REAL NOT NULL, lon REAL NOT NULL,
  radius_m REAL NOT NULL CHECK (radius_m >= 100), priority INTEGER NOT NULL DEFAULT 0,
  active INTEGER NOT NULL DEFAULT 1, /* audit cols */) STRICT;

-- optional E2E backup & retention
CREATE TABLE sync_outbox (
  seq INTEGER PRIMARY KEY AUTOINCREMENT, table_name TEXT NOT NULL, row_id TEXT NOT NULL,
  op TEXT NOT NULL CHECK (op IN ('upsert','delete')), row_rev INTEGER NOT NULL,
  enqueued_utc_ms INTEGER NOT NULL, attempts INTEGER NOT NULL DEFAULT 0) STRICT;
CREATE TABLE retention_policy (table_name TEXT PRIMARY KEY, keep_days INTEGER NOT NULL) STRICT;
```

**Retention and erasure.** Keep `wearable_samples` 90 days then roll up into `biomarker_snapshots`; `notifications_log` and `predictions` 180 days; purge tombstones 30 days after `sync_state = 2`; keep `consent_log` for the account lifetime; run a daily BGProcessingTask/WorkManager job with `DELETE … WHERE …` then `PRAGMA incremental_vacuum` [R]. "Delete my data" runs in order: delete app-written Health Connect records with `deleteRecords` (a Health Connect duty; [sync-data](https://developer.android.com/health-and-fitness/health-connect/sync-data)) [V]; delete server-side backup blobs and the account; close and delete the DB, WAL and SHM files and **delete the Keychain/Keystore key (crypto-shredding)**; clear caches; reset to onboarding. GDPR Article 17 framing needs privacy counsel.

### 5.3 HealthKit and Health Connect pipeline for resting heart rate and HRV

**HRV is not cross-comparable between platforms: HealthKit stores SDNN** ("standard deviation of the inter-beat (RR) intervals"; auto-recorded on Apple Watch) **while Health Connect stores RMSSD** (`HeartRateVariabilityRmssdRecord.heartRateVariabilityMillis`, added in 1.1.0) ([Apple](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/heartratevariabilitysdnn); [Android](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/HeartRateVariabilityRmssdRecord)) [V]. Apple's `restingHeartRate` is estimated from sedentary samples, and **the system may delete earlier samples and replace them with better estimates** ([Apple](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/restingheartrate)) [V], so ingestion must handle deletions. Apple `vo2Max` is auto-saved on Series 3+ after outdoor walks/runs (range 14–60 ml/kg/min) [V], but Section 1.2 ships no VO2max claim.

| Platform | Registration | Delta sync | Limits and gotchas | Source [V] |
|---|---|---|---|---|
| **iOS HealthKit** | Native `AppDelegate.application(_:didFinishLaunchingWithOptions:)`: per type, `HKObserverQuery` + `enableBackgroundDelivery(.hourly)`; **iOS 15+ requires the `com.apple.developer.healthkit.background-delivery` entitlement** | `HKAnchoredObjectQuery` (returns additions **and deletions**; persist anchor); `HKStatisticsCollectionQuery` for daily buckets | **Call the completion handler: three misses stop background delivery**; store encrypted while locked, so background reads can fail; denied reads look like "no data"; `NSHealthShareUsageDescription` required; no simulator background queries | [enableBackgroundDelivery](https://developer.apple.com/documentation/healthkit/hkhealthstore/enablebackgrounddelivery(for:frequency:withcompletion:)); [privacy](https://developer.apple.com/documentation/healthkit/protecting-user-privacy) |
| **Android Health Connect** | `HealthConnectClient.getSdkStatus()`; per-type read permissions (`READ_RESTING_HEART_RATE`, `READ_HEART_RATE_VARIABILITY`, `READ_HEART_RATE`, `READ_RESPIRATORY_RATE`, `READ_OXYGEN_SATURATION`, `READ_VO2_MAX`, `READ_STEPS`, `READ_SLEEP`); `READ_HEALTH_DATA_IN_BACKGROUND` gated on `FEATURE_READ_HEALTH_DATA_IN_BACKGROUND`; `READ_HEALTH_DATA_HISTORY` for >30 days | 30-day backfill (`ReadRecordsRequest`, pageSize 1000; treat `""` page token as end); then **per-type Changes tokens, which expire within 30 days unused**; skip your own `dataOrigin`; dedupe by `Metadata.id` | Framework module from Android 14; HC app on ≤13; SDK API 26+; `connect-client` 1.1.0+ needs compileSdk 36 and AGP 8.9.1+; stricter background rate limits; manifest `<queries>` + `ViewPermissionUsageActivity` alias; **Play Console Health apps declaration**; Google Fit APIs supported until end of 2026 | [read-data](https://developer.android.com/health-and-fitness/guides/health-connect/develop/read-data); [sync-data](https://developer.android.com/health-and-fitness/health-connect/sync-data); [get-started](https://developer.android.com/health-and-fitness/guides/health-connect/develop/get-started); [publish](https://developer.android.com/health-and-fitness/health-connect/publish) |

```
Normalization (per user, per metric, per platform)                                 [R]
  store hrv_sdnn_ms (iOS) and hrv_rmssd_ms (Android) as DIFFERENT metrics — never pool
  x̃ = ln(HRV);  baseline = rolling 28-day median and MAD of x̃
  robust_z = (x̃ − median) / (1.4826 · MAD)
  RHR in bpm, also z-scored per user; a new source_device resets the baseline
  ML features require ≥7 valid days; else mask + missing-indicator (S2.2)
  Steps: HC aggregate() / HKStatisticsCollectionQuery daily buckets — never sum raw samples
Display rules (S1.2): expected 1-week abstinence ΔHR ≈ −7.3 bpm (24-h) but ≈ −3.7 bpm
  if the platform's RHR is sleep-derived; trajectories not identical across sex/subgroups
```

Which Android wearables actually write HRV and resting HR to Health Connect was not determined, so plan for missing HRV on Android. Shaffer & Ginsberg 2017 on SDNN/RMSSD non-comparability is recalled, not verified.

### 5.4 Background execution: JITAI timing must be pre-planned, not woken on demand

iOS grants opportunistic time only: **`BGAppRefreshTask` gives up to 30 seconds** at a system-chosen time, `BGProcessingTask` runs longer (typically overnight or charging), and **`BGContinuedProcessingTaskRequest` (iOS 26+) must start from a user action** ([Apple](https://developer.apple.com/documentation/backgroundtasks/choosing-background-strategies-for-your-app)) [V]. iOS keeps only the **soonest 64 pending local notifications** (archived guide; confirm on device) and Core Location monitors **at most 20 conditions per app** (`CLMonitor`, monitoring only after first unlock post-reboot) ([Apple](https://developer.apple.com/documentation/corelocation/monitoring-the-user-s-proximity-to-geographic-regions)) [V]. Android allows **100 geofences per app per user** (radius 100–150 m minimum, background location on API 29+, latency up to ~6 min when stationary, re-register after reboot), **WorkManager periodic work ≥15 minutes**, runtime `POST_NOTIFICATIONS` on API 33+, and `SCHEDULE_EXACT_ALARM` not pre-granted from API 33 ([geofencing](https://developer.android.com/develop/sensors-and-location/location/geofencing); [PeriodicWorkRequest](https://developer.android.com/reference/androidx/work/PeriodicWorkRequest); [alarms](https://developer.android.com/develop/background-work/services/alarms)) [V]. A microphone foreground service cannot start from the background ([FGS types](https://developer.android.com/develop/background-work/services/fgs/service-types)) [V].

**Design consequence:** the on-device risk model runs in every opportunistic window (foreground, BGAppRefresh, HealthKit delivery, geofence relaunch) and **pre-schedules the next N hours of risk-gated prompts** within Section 2.2's budget. Keep ≤48 pending iOS notifications; use `UNLocationNotificationTrigger` for "arrived at trigger place" nudges (fires without app code); cap user geofences at 15 on iOS and 90 on Android; prefer `GEOFENCE_TRANSITION_DWELL` to match Quit Sense's dwell gating; avoid exact alarms; run the Urge Surfer foreground-only and stop capture on background. True just-in-time wake-ups would need server push, which conflicts with offline-first privacy. Set notification content to "private" so the lock screen never shows "You smoked 3 cigarettes."

### 5.5 On-device JITAI model runtime

| Layer (Section 2.2) | Runtime | Packaging | Personalization on device | Status |
|---|---|---|---|---|
| L0 rules | Dart | Pure code; weights in `model_versions` row (`runtime='rules'`) | None | — |
| L1 logistic regression | Dart (or ORT) | <100 parameters | Closed-form/L-BFGS MAP update toward population prior, nightly in a BGProcessingTask/WorkManager job | [R] |
| L2 GBT | **ONNX Runtime Mobile** via `flutter_onnxruntime` 1.9.0 | sklearn/LightGBM/XGBoost → ONNX-ML `TreeEnsembleClassifier` via skl2onnx/onnxmltools (**TFLite has no tree-ensemble op**) | Per-user Platt calibration + bias in app code; on-device boosting non-trivial | Converter facts [PK] |
| L3 GRU/TCN (later) | **LiteRT** (`tflite_flutter` 0.12.1) or ORT Training | LiteRT: export `tf.function` signatures `train`/`infer`/`save`/`restore`; training ops need **Select TF ops (Flex delegate)**, which grows the binary. ORT: `onnxruntime.training.artifacts.generate_artifacts` → on-device `train_step` | Fine-tune final layer only | API names [PK]; **verify current LiteRT naming and whether ORT mobile training packages are still published in 2026** |

Every model artifact is downloaded signed, pinned by `artifact_sha256` in `model_versions`, and versioned with its `feature_schema_version`; every prediction is logged with model version, threshold and randomization probability for on-device evaluation. No published mobile size or latency benchmark exists for these model classes; profile in-house.

### 5.6 Microphone DSP: exhalation detection and breath pacing under 100 ms

**Smartphone microphones can estimate breathing rate: Nam, Reyes & Chon (IEEE JBHI 2016;20(6):1493–1501, DOI 10.1109/JBHI.2015.2480838) reported median errors under 1% across 6–90 breaths/min from nasal breath sounds in 10 healthy subjects, with the phone up to 30 cm away; tracheal sounds performed poorly and nasal congestion caused rate-doubling outliers at high rates** ([IEEE Xplore](https://ieeexplore.ieee.org/document/7273825); [UConn PDF](https://biosignal.uconn.edu/wp-content/uploads/sites/2503/2018/09/07_Nam_2016_JBHI.pdf)) [V, abstract level]. **Rate estimation is not real-time per-breath exhale segmentation under noise**, which is harder and unbenchmarked; that is exactly what Section 0's Gate 0b tests. The closest prior art, Breeze (Shih et al., real-time breathing-phase detection for gamified biofeedback), is believed to be **Proc ACM IMWUT 3(4) 2019, DOI 10.1145/3369835, not CHI as the brief stated** [PK]; SpiroSmart (UbiComp 2012) is recalled at about 5% error vs spirometry [PK, unverified] and is relevant only if the team ever pursues measured lung function (a device claim, Section 6).

**Platform capture facts** [V]: iOS `AVAudioSession.Mode.measurement` minimizes system signal processing and uses the primary mic ([Apple](https://developer.apple.com/documentation/avfaudio/avaudiosession/mode-swift.struct/measurement)); avoid `voiceChat` (AEC, AGC). `installTap` is **deprecated in iOS 27**, and its replacement `installAudioTap` only supports **100–400 ms buffers**, too coarse; use `AVAudioSinkNode` (iOS 13+) or RemoteIO ([installAudioTap](https://developer.apple.com/documentation/avfaudio/avaudionode/installaudiotap(onbus:buffersize:format:tapprovider:)); [AVAudioSinkNode](https://developer.apple.com/documentation/avfaudio/avaudiosinknode)). Minimum IO buffer is about 5 ms (256 frames). Android: `UNPROCESSED` (API 24) if `AudioManager.PROPERTY_SUPPORT_AUDIO_SOURCE_UNPROCESSED` is true, else `VOICE_RECOGNITION`; never `VOICE_COMMUNICATION` ([AudioSource](https://developer.android.com/reference/android/media/MediaRecorder.AudioSource)); Oboe's default InputPreset is VoiceRecognition ([Oboe](https://github.com/google/oboe/blob/main/docs/FullGuide.md)). Request permission with `AVAudioApplication.requestRecordPermission` (iOS 17+). Silero VAD processes a 30+ ms chunk in under 1 ms on one CPU thread, supports 16 kHz, is MIT-licensed and has no telemetry ([silero-vad](https://github.com/snakers4/silero-vad)). The Flutter-only fallback is `record.startStream(RecordConfig(encoder: AudioEncoder.pcm16bits, sampleRate: 16000, numChannels: 1, autoGain: false, echoCancel: false, noiseSuppress: false, androidConfig: AndroidRecordConfig(audioSource: AndroidAudioSource.unprocessed), streamBufferSize: 640))`, but `IosRecordConfig` has **no AVAudioSession mode setter**, so set `.measurement` via `audio_session` or native code and expect higher latency.

The pipeline below is an engineering design with starting parameters to be tuned in the Gate 0b calibration study [R].

| Stage | Parameter |
|---|---|
| Capture | iOS: `.playAndRecord`/`.record` + `.measurement`, IO buffer 0.01 s, 48 kHz, `AVAudioSinkNode`; Android: Oboe `LowLatency`, `Shared`, Float, mono, `Unprocessed` → `VoiceRecognition`; decimate 48→16 kHz with polyphase FIR (≥60 dB stopband, ~7 kHz cutoff) |
| Pre-processing | DC blocker (one-pole HPF ~20 Hz); **4th-order Butterworth high-pass 150 Hz** |
| Framing | **20 ms frames (320 samples), 10 ms hop (100 frames/s), Hann, 512-point FFT** |
| Features | `E_b` = band energy 150–2000 Hz (dBFS); `E_h` = 2–6 kHz; `R_bh = E_b − E_h`; **spectral flatness SF** (150–6000 Hz; breath noise-like = high, voiced speech = low); spectral centroid; ZCR; **harmonicity H** = normalized autocorrelation peak at 2.5–12.5 ms lags (80–400 Hz F0); optional Silero `p_speech` on 32 ms chunks |
| Noise floor N | 10th percentile of `E_b` over a sliding 3 s window, updated only in IDLE; rise clamped to +3 dB/s |
| Onset (IDLE → CANDIDATE) | `E_b > N + T_on` (T_on = max(10 dB, 0.5·(peak − N)), cap 20 dB) **and** SF > SF_min (start 0.25) **and** H < 0.45 **and** p_speech < 0.5 |
| Confirm (→ EXHALE) | 4 consecutive qualifying frames (40 ms debounce) |
| Sustain / offset | Stay while `E_b > N + T_off` (T_off = T_on − 4 dB), bridging ≤150 ms dropouts; end after ≥150 ms below, backdating offset to first sub-threshold frame |
| Accept | Duration 0.5–15 s; reject if >30% of frames had H ≥ 0.45 or p_speech ≥ 0.5; minimum inter-onset interval 2 s (rejects congestion double-detections) |
| Inhale | Gap between accepted exhale offset and next onset; optional weak-inhale flag on a +4 dB high-SF bump |
| Calibration (~20 s, first use and on SNR drop) | 5 s silence → N0, SF0; 3 × "breathe out slowly toward the bottom of the phone" → peak `E_b`, median SF, SC; SF_min = max(0.15, 0.5·median SF_breath); **require SNR ≥12 dB** else prompt to hold the phone 5–15 cm away or switch to touch/pacer-only; persist only thresholds, `device_model`, `audio_route` |
| Pacer | **Driven by the pacer clock, not the detector**: 4 s in / 6 s out × 18 = 180 s; live "exhale meter" = EMA₅₀ms(clamp((E_b − N)/(peak − N), 0, 1)) |
| Per-cycle metrics | `|exhale − 6 s|`; onset lag vs cue; rate = 60/median(last 3 cycles) shown with EMA α = 0.3; **adherence = % cycles with exhale 6 ± 1.5 s and onset within ±1 s** |
| Adaptive coaching | If exhales consistently <4 s, shorten target to 5 s (~6.7/min), then step back up |
| Latency budget (≤100 ms) | HW/IO 5–10 ms + FIR 2–4 ms + frame ~10 ms + debounce 40 ms + render ≤16.7 ms ≈ **75–90 ms**; meter (no debounce) ~35–50 ms |
| Robustness | Relative thresholds + per-device calibration; Bluetooth HFP mics are narrowband and processed → detect route, keep 150–2000 Hz band or switch to touch mode; wind/outdoor → low SNR → touch/pacer-only |
| Release gate | "Beta" until **exhale-duration MAE <0.5 s at SNR ≥12 dB**; report onset/offset MAE (ms), event precision/recall (±300 ms), stratified by SNR band and device |

```text
x16 = decimate(hw_block)                       # 48k → 16k
x16 = hpf150(dcblock(x16))
for frame in frames(x16, N=320, hop=160, win=hann):
    P   = |FFT512(frame)|^2
    Eb  = 10log10(sum(P[150..2000Hz]) + eps) ; Eh = 10log10(sum(P[2k..6k]) + eps)
    SF  = geomean(P[150..6k]) / mean(P[150..6k])
    H   = max_norm_autocorr(frame, lag 2.5..12.5 ms)
    ps  = vad.prob(frame32ms) if vad_enabled else 0
    if state == IDLE: noise.push(Eb); N = noise.p10(3s)
    q_on  = Eb > N+T_on and SF > SF_min and H < 0.45 and ps < 0.5
    q_off = Eb < N+T_off
    IDLE -(4×q_on)-> EXHALE -(≥150 ms q_off)-> IDLE ; bridge gaps < 150 ms
    on EXHALE end: if 0.5 s ≤ dur ≤ 15 s and speech_frac < 0.3 → emit Exhale(t_on, t_off)
    meter = ema50ms(clamp((Eb−N)/(peak−N), 0, 1)) → UI @ 60 Hz
```

Implement the DSP once as a portable C/C++ library (`breathdsp`: `init(cfg)`, `push(float* pcm, n, ts)`, `poll(events*)`) built as an XCFramework and with the NDK, bound by `dart:ffi` (or Nitro/TurboModule for RN, cinterop/JNI for KMP), emitting about 30–60 Hz feature events, never PCM, to Dart. Unit-test with synthetic pink-noise bursts of known duration, speech clips and ambient beds, asserting onset/offset error <50 ms at SNR ≥12 dB; use fixtures only from consented lab sessions. **Privacy: audio exists only in a ≤1 s in-memory ring buffer inside the native module, is never written to disk, never sent to Dart as PCM and never transmitted; only the `breath_sessions` summary is stored.** Request the mic just-in-time on first Urge Surfer launch, offer touch mode if denied, and use the purpose string: **"Urge Surfer listens for the sound of your out-breath to pace your breathing. Audio is analysed on your phone in real time and is never recorded or sent anywhere."** If Gate 0b fails, pivot P2 removes the mic entirely and the pacer runs haptic/visual only.

### 5.7 Security and privacy baseline

Map controls to OWASP MASVS v2: **STORAGE-1** "securely stores sensitive data" and **STORAGE-2** "prevents leakage… via backups or logs"; **CRYPTO-1/2** current strong cryptography and key management; **PRIVACY-1..4** minimization, unlinkability, transparency and user control, which MASVS says is not a substitute for a GDPR DPIA ([MASVS repo](https://github.com/OWASP/masvs/blob/master/Document/12-MASVS-PRIVACY.md)) [V]. Ship `PrivacyInfo.xcprivacy` for the app and SDKs ([Apple](https://developer.apple.com/documentation/bundleresources/privacy-manifest-files)) [V]; never use HealthKit data for ads, sell it or disclose it without express permission ([Apple](https://developer.apple.com/documentation/healthkit/protecting-user-privacy)) [V]; complete Play's Data safety section and Health apps declaration. Design rules [R]: all inference on-device; no third-party analytics SDK by default, with only opt-in, first-party, day-bucketed aggregate counters and a monthly-rotated install ID, and no HealthKit-derived values ever in analytics; opt-in crash reporting (`sentry_flutter` 10.1.0) with PII, screenshots and view hierarchy off, breadcrumbs scrubbed in `beforeSend`, and EU residency or self-hosting; a lint banning PHI in logs; TLS 1.2+ with pinning only for backup and model endpoints; App Attest / Play Integrity to protect the backup API; CycloneDX SBOMs for Dart, CocoaPods/SPM and Gradle plus the sqlite3 and Rive native SBOMs, `gh attestation verify` on SQLite binaries and an OSV vulnerability gate in CI; a privacy dashboard with per-source disconnect, local JSON/CSV export and crypto-shred delete; an optional biometric app lock; and best-effort root/jailbreak detection only.

## Section 6. Regulatory compliance: intended purpose, proven by every string, decides device status

Only developer.apple.com and developer.android.com could be fetched; FDA, EU, UK, Google Play help and Indian sources come from law-firm and trade-press search snippets, so every rule here needs market-specific counsel review. **The common rule across all markets is intended purpose, shown by claims, UI and marketing, and no market lets a disclaimer cure a disease-oriented claim.**

### 6.1 The January 2026 FDA General Wellness revision is real and widens room for wearable trends

**FDA issued a revised final General Wellness guidance on 6 January 2026, alongside a revised Clinical Decision Support guidance, without a comment period; it replaces the 2019 version and keeps the two-part test (intended only for general wellness, and low risk) and both claim categories** ([Covington](https://www.cov.com/en/news-and-insights/insights/2026/01/fda-issues-revised-guidance-on-general-wellness-products); [Faegre Drinker](https://www.faegredrinker.com/en/insights/publications/2026/1/key-updates-in-fdas-2026-general-wellness-and-clinical-decision-support-software-guidance); [Foley](https://www.foley.com/p/102meea/digital-health-policy-fda-relaxes-restrictions-over-wearables-and-ai-decision-ma/)) [V, snippet]. **What is new is explicit coverage of non-invasive wearables estimating physiologic parameters such as blood pressure, SpO2, glucose or HRV, if outputs are for wellness only** ([Cooley](https://www.cooley.com/news/insight/2026/2026-01-20-fda-opens-aperture-for-wearables-in-latest-general-wellness-guidance); [Loeb & Loeb](https://quicktakes.loeb.com/post/102m1yw/fda-updates-its-general-wellness-device-frameworkwhat-companies-need-to-know)) [V, snippet]. Products fall outside the policy if labeling references specific diseases, diagnostic thresholds or clinical-grade accuracy, or prompts clinical action, and qualification is "not automatic" just because a disclaimer is added ([Troutman Pepper Locke](https://www.troutman.com/insights/fdas-2026-guidance-on-general-wellness-devices-policy-for-low-risk-devices/)) [V, snippet]. At the **11 February 2026 FDA town hall**, the reported guardrails were: do not name a disease, do not call an output abnormal or diagnostic, no clinical thresholds or treatment advice, no ongoing condition-management alerts; and manufacturers should validate their measurements, ideally publishing the validation ([Hogan Lovells](https://hlc.com/en/publications/fda-town-hall-sheds-new-light-on-updated-general-wellness-policy)) [V, snippet]. Values, ranges, trends, baselines and notifications suggesting clinician follow-up are reportedly allowed ([Ropes & Gray](https://www.ropesgray.com/en/insights/alerts/2026/01/fda-adapts-with-the-times-on-digital-health-updated-guidances-on-general-wellness-products)) [V, snippet; FDA wording unverified], although the AHA asked FDA on 13 August 2026 to clarify or remove the escalation language [V]. FDA's July 2025 WHOOP warning letter said a blood-pressure feature was "inherently associated" with diagnosing hypo-/hypertension and cited "medical grade" marketing [V, snippet]; a single secondary source says it closed in June 2026 [unverified].

**Category 1** claims sustain or improve general health without naming a disease (weight, fitness, sleep, relaxation, stress, mental acuity). **Category 2** claims say a healthy lifestyle may reduce the risk or impact of chronic diseases where that link is "well understood and accepted" (heart disease, high blood pressure, type 2 diabetes) ([Fish & Richardson](https://www.fr.com/insights/thought-leadership/articles/fdas-draft-wellness-guidance-potentially-expands-the-universe-of-unregulated-products/)) [V, snippet]. Whether FDA treats smoking cessation itself as a Category 2 "healthy lifestyle choice" is not settled by any source, so keep marketing in Category 1 and use Category 2 phrasing sparingly with counsel sign-off.

**Smoking cessation sits in enforcement discretion, not outside the device definition.** FDA's examples list includes software providing "periodic educational information, reminders, or motivational guidance" to smokers trying to quit, and "software functions that keep track of medications and provide user-configured reminders" ([FDA examples page](https://www.fda.gov/medical-devices/device-software-functions-including-mobile-medical-applications/examples-software-functions-which-fda-will-exercise-enforcement-discretion)) [V, snippet]. That means FDA considers such software potentially a device but chooses not to enforce, and can change its view. Precedents mark the line: the **Pivot CO breath sensor received an expanded OTC 510(k) indication in 2021** for use in a cessation program ([MedCity News](https://medcitynews.com/2021/07/carrot-gets-fda-nod-for-over-the-counter-use-of-smoking-cessation-device/)) [V, snippet]; **CureApp was approved as Japan's first digital therapeutic** [V, snippet]; and **NichtraucherHelden is a permanently listed German DiGA, a class I device for diagnosed tobacco dependence (ICD-10 F17.2) in adults** ([Pharmazeutische Zeitung](https://www.pharmazeutische-zeitung.de/mit-dem-rauchen-aufhoeren-mit-digitaler-unterstuetzung-137255/)) [V, snippet]. Claims of treating nicotine dependence or withdrawal, quoting quit-rate efficacy, or replacing medication push the product toward drug, device or DTx territory. The DSF/MMA guidance's September 2022 date was not re-verified, and no report says the January 2026 actions revised it.

**US privacy and advertising.** The amended **FTC Health Breach Notification Rule took effect 29 July 2024**, covers direct-to-consumer health apps outside HIPAA, treats **unauthorized disclosure (for example to ad SDKs) as a breach**, and counts persistent identifiers combined with health data ([Alston & Bird](https://www.alston.com/en/insights/publications/2024/08/ftc-updated-health-breach-notification-rule)) [V, snippet]. The **FTC Health Products Compliance Guidance (20 December 2022)** requires "competent and reliable scientific evidence," generally randomized controlled human trials, and says qualifiers like "may" or "helps" do not cure an unsupported claim ([Reed Smith](https://www.reedsmith.com/articles/ftc-issues-significant-updated-guidance-for-health-related-claims/)) [V, snippet]. **Washington's My Health My Data Act** (in force 31 March 2024) requires affirmative, purpose-specific consent and has a private right of action; the first suit was filed against Amazon on 10 February 2025 ([A&O Shearman](https://www.aoshearman.com/en/insights/my-health-my-data-act-targets-entities-not-subject-to-hipaa-and-provides-a-private-right-of-action)) [V, snippet]. The consequence is no third-party ad SDKs, analytics stripped of health payloads, and separate consents for collection and for any sharing, which Section 5.7 already specifies.

### 6.2 EU MDR Rule 11: "prediction" and "prognosis" are medical purposes, so Lung Age needs the most care

Under MDR Art. 2(1), medical purposes include "diagnosis, prevention, monitoring, **prediction, prognosis**, treatment or alleviation of disease," while software for lifestyle and well-being is not a device ([Johner Institute](https://blog.johner-institute.com/regulatory-affairs/mdr-rule-11/); [NAMSA](https://namsa.com/resources/blog/eu-mdr-and-ivdr-classifying-medical-device-software-mdsw/)) [V, snippet]. If qualified, **Rule 11 makes software informing diagnostic or therapeutic decisions class IIa (IIb if a decision could cause serious deterioration, III if death or irreversible deterioration), software monitoring physiological processes class IIa (IIb for vital parameters where variation could cause immediate danger), and all other software class I** ([NAMSA](https://namsa.com/resources/blog/mdr-stricter-rules-medical-device-software/); [Penningtons Manches](https://www.penningtonslaw.com/insights/new-guidance-on-the-classification-of-software-as-medical-devices/)) [V, snippet; "danger" vs "damage" wording to check in the OJ]. **MDCG 2019-11 Rev.1 was published 17 June 2025** with clarifications rather than substantive changes, including references to software that "informs clinical prognosis or prediction" ([European Commission](https://health.ec.europa.eu/latest-updates/update-mdcg-2019-11-rev1-qualification-and-classification-software-regulation-eu-2017745-and-2025-06-17_en); [Emergo](https://www.emergobyul.com/news/european-revision-primary-software-guidance-mdcg-2019-11-revision-1-small-changes-meaningful)) [V], and MDCG 2025-4 brings app stores under device and DSA obligations ([Osborne Clarke](https://www.osborneclarke.com/insights/eu-confirms-app-stores-and-developers-are-subject-medical-device-laws)) [V, snippet]. The AI Act Digital Omnibus (reported as Regulation (EU) 2026/1744, in force 27 July 2026) moves high-risk obligations for AI in medical devices to **2 August 2028** and Annex III systems to 2 December 2027, while Article 50 transparency has applied since August 2026 [V, snippet; regulation number unverified]. **GDPR Art. 9** makes wearable and breath-derived health data special-category data requiring separate, explicit consent and, almost certainly, a DPIA [V, snippet].

**Implications.** An individual "your lungs are X years old" output reads easily as prediction or prognosis about an organ, and "accelerated lung aging" is a COPD-risk concept; if marketing links it to lung disease, the app enters Art. 2(1) and Rule 11 class IIa or higher. Craving prediction targets a behavior, but nicotine dependence is coded (F17), so "relapse prediction for nicotine addiction" can read as prognosis; use habit and pattern language. Breath *pacing* for relaxation is wellness; respiratory-rate *monitoring* or cough tracking tied to lung deterioration edges toward Rule 11 IIa/IIb, so **drop cough tracking from the EU build or keep it as an uninterpreted private log**. Whether an ML model inferring craving from HRV could fall under AI Act emotion-recognition provisions is an open legal question with no supporting source.

### 6.3 UK, India and other markets

**UK:** the MHRA test is intended purpose, under its "Medical device stand-alone software including apps" guidance, with UKCA marking under UK MDR 2002 ([MHRA PDF](https://assets.publishing.service.gov.uk/media/6abf6c8c943e890cb55e5e52/Medical_device_stand-alone_software_including_apps__including_IVDMDs.pdf)) [V, snippet]. A 2026 government-commissioned review recommended explicitly exempting wellbeing software, but that is not yet law ([RAPS](https://www.raps.org/resource/euro-roundup-mhra-commission-makes-recommendations-on-ai-regulatory-framework-in-the-uk.html)) [V, snippet], and a July 2026 AI Airlock report says qualification cannot rest on disclaimers alone [V, snippet]. Mirror the EU discipline. **India:** all devices meeting the harmonized definition are regulated (S.O. 648(E), 2020); **CDSCO issued a draft medical-device software guidance on 21 October 2025 classifying SaMD A–D**, not confirmed final ([India Briefing](https://india-briefing.com/news/cdsco-draft-guidance-medical-software-40691.html)) [V, snippet]; the **DPDP Rules 2025** were notified in mid-November 2025 with most consent, notice and child-data duties applying around **May 2027** ([India Briefing](https://www.india-briefing.com/news/dpdp-rules-2025-india-data-protection-law-compliance-40769.html)) [V, snippet]. An 18+ gate avoids verifiable parental consent. India's e-cigarette prohibition (Section 1.3) means vaping content must be market-gated.

### 6.4 Apple App Store 1.4.1 and Google Play Health apps declaration

The live App Store guidelines were fetched on 21 October 2026; the latest update notice (16 October 2026) changed nothing in 1.4.x or 5.1.x ([Apple Developer News](https://developer.apple.com/news/?id=r24k5i3)) [V, fetched]. **Guideline 1.4.1**: medical apps that could provide inaccurate data or diagnose or treat "may be reviewed with greater scrutiny"; **"Apps must clearly disclose data and methodology to support accuracy claims relating to health measurements"** and "if the level of accuracy or methodology cannot be validated, we will reject your app"; apps measuring blood pressure, temperature, glucose or blood oxygen "using only the sensors on the device are not permitted"; apps "should remind users to check with a doctor… before making medical decisions." **1.4.2** restricts drug dosage calculators to approved entities or FDA-equivalent approval. **1.4.3** bars apps that "encourage consumption of tobacco and vape products." **5.1.2(i)** requires disclosure and explicit permission before sharing personal data with third-party AI; **5.1.2(vi)/5.1.3(i)** bar HealthKit and health data for marketing or data mining; **5.1.3(ii)** bars writing false data to HealthKit and storing PHI in iCloud ([Apple guidelines](https://developer.apple.com/app-store/review/guidelines/)) [V, fetched].

**Google Play** requires every app to complete the **Health apps declaration** (deadlines from 31 May 2024), consolidated health policies into **"Health Content and Services" (effective ~28 May 2025)**, and added EU MDCG alignment and a **"Medical Device" label effective 28 January 2026**; **non-regulated health apps must disclose that the app "is not a medical device and does not diagnose, treat, cure, or prevent any medical condition"** ([Google Play policy announcements](https://support.google.com/googleplay/android-developer/table/12921780); [Health Content and Services](https://support.google.com/googleplay/android-developer/answer/16679511?hl=en)) [V, snippet; placement unverified]. Health Connect access requires per-data-type justification: **"Request the minimum data types needed and provide a valid use case for each request"**, with matching privacy policies ([Android Developers](https://developer.android.com/health-and-fitness/health-connect/declare-access)) [V, fetched]. Android 14+ microphone foreground services need type declarations in the manifest and Play Console, cannot start from the background ([FGS types](https://developer.android.com/develop/background-work/services/fgs/service-types)) [V, fetched], and Play has barred tobacco-sales facilitation since 2019 [V, snippet].

**Store-specific implications.** Declare health features honestly in the Play declaration and declare "not a medical device." Request only `HeartRate`, `RestingHeartRate` and `HeartRateVariabilityRmssd` (plus Steps or Sleep only if a feature uses them). Never write modeled Lung Age or Recovery Index values to HealthKit or Health Connect. Never present vaping as a positive substitute in store copy, and add no affiliate links or sales for nicotine products (NRT sales only through a licensed pharmacy route, counsel to confirm); where Section 1.3's evidence-based e-cigarette information is shown, it must be educational, market-gated and never promotional. Any LLM coach requires explicit third-party-AI consent. **The Scientific Methodology screen below is the main tool for clearing 1.4.1.**

### 6.5 Safe-wellness vs prohibited-SaMD claims, side by side

Rename **"Bio-Toxicity Index" to "Recovery Index"**: "toxicity" invites measurement and danger readings that the index cannot support.

| Feature | Safe general-wellness phrasing | Prohibited / device-implying phrasing | Principle |
|---|---|---|---|
| **Lung Age** | "An illustrative 'lung age' estimate based on published population averages and the details you enter. It's a motivational visual, not a test of your lungs." · "See how smoke-free time is generally associated with healthier aging in population studies." | "Your lungs are 58 years old." · "Measures your lung function." · "Detects early COPD." · "Your lung age is abnormal for your age." · "Spirometer-grade accuracy." | FDA: no disease names, thresholds or clinical-grade claims; Apple 1.4.1: no unvalidated measurement; EU Art. 2(1): no individual prediction/prognosis of disease |
| **Recovery Index (ex-Bio-Toxicity)** | "A modeled timeline of how the body generally recovers after the last cigarette (e.g., carbon monoxide typically falls within hours), based on published research and your logged smoke-free time." | "Measures carbon monoxide in your blood." · "Your toxicity level is dangerous." · "Detoxifies your body." · "COHb 4.2%." · "Clinically validated toxin score." | Apple 1.4.1; FTC substantiation; a CO **measurement** for quitting was a cleared device (Pivot) |
| **Acoustic breath / cough tracking** | "Guided breathing with real-time pacing cues from your microphone to help you relax and ride out cravings." · "Optionally keep a private log of coughs you notice, for your own reflection." | "Monitors your respiratory rate." · "Detects lung damage or infection from your cough." · "Alerts you to worsening breathing." · "Cough analysis for bronchitis or COPD." | FDA Category 1; EU Rule 11 monitoring IIa/IIb; Apple 1.4.1 sensor-only ban |
| **NRT reminders** | "Set reminders for the nicotine replacement plan you and your pharmacist or doctor chose, with general how-to tips that follow the product label." | "Calculates your NRT dose." · "Tells you which patch strength to use." · "Tapers your nicotine dose automatically." · "Treats nicotine withdrawal." | FDA discretion covers reminders, not dosing; Apple 1.4.2; withdrawal treatment is a drug/device claim |
| **Craving-risk prediction** | "Spot patterns in when cravings tend to show up for you, based on your own logs, and get a heads-up to try a coping exercise." · "Personal habit insights." | "Predicts relapse." · "Clinically proven to prevent relapse." · "Diagnoses nicotine dependence severity." · "AI detects withdrawal from your heart rate." | EU prognosis of coded disorder (F17); FTC RCT standard; possible AI Act questions |
| **HRV / resting HR** | "See trends in resting heart rate and HRV from your wearable alongside your smoke-free streak." · Category 2 style, sparingly with counsel: "Being smoke-free, as part of a healthy lifestyle, may support heart health." | "Tracks your heart's healing from smoking damage." · "Detects arrhythmia or AFib." · "Your HRV is below the clinical threshold." · "Lowers your risk of heart attack by X%." | FDA 2026 allows wellness HRV trends; no diseases or thresholds |
| **App efficacy** | Describe features, not outcomes; cite population facts (WHO) as attributed, dated education | "Triples your chances of quitting." · "Clinically proven." (without an app-specific RCT) | FTC; Section 2.0 (Chu 2026 is low certainty) |

**Cross-cutting rules.** Use "estimate," "illustration," "trend," "insight," "support," "habit," "relax"; avoid "measure," "diagnose," "detect," "predict" (disease), "treat," "cure," "clinical," "medical-grade," "abnormal" and "risk of [disease]." **Never show traffic-light normal/abnormal bands on Lung Age, Recovery Index, HRV or RHR**; this is why Section 1.1's LLN and z = −2.5 lines are internal only and why Section 1.2's modeled CO is shown as "estimated share cleared," never ppm. A one-time "If you notice symptoms that concern you, consider talking to a healthcare professional" fits the town-hall guardrails, as do Section 1.1's "ask for spirometry" and Section 4.2's "When to get checked" list; a recurring "Your recovery is abnormal, see a doctor" does not. Keep one claim set across both stores, the website, ads and social, because the FTC and MHRA review all marketing.

### 6.6 Draft disclaimers (original wording; placeholders in brackets)

**A. Store listing** (top of the long description):

> **Important:** [App Name] is a general wellness and habit-support app. It is not a medical device and does not diagnose, treat, cure, or prevent any disease or medical condition. Features such as "Lung Age" and the "Recovery Index" are educational estimates based on published population research and the information you enter. They are not measurements of your body and are not a substitute for a lung-function test or professional advice. Always talk to a doctor, pharmacist, or other qualified health professional before starting, stopping, or changing any medicine, including nicotine replacement therapy, and before making any health decision. For emergencies, call your local emergency number.

Short variant: *"Wellness app, not a medical device. Estimates are educational, not medical measurements. Consult a health professional before making health decisions."*

**B. First-launch modal** (before any data collection; checkboxes unticked by default; each consent logged with timestamp and policy version in `consent_log` and independently withdrawable):

> **Welcome. Before you begin**
>
> [App Name] helps you build and track a smoke-free routine with motivation, reminders, breathing exercises, and visual estimates of recovery. It is **not a medical device** and doesn't give medical advice, diagnosis, or treatment. The "Lung Age" and "Recovery Index" visuals are educational estimates drawn from published research, not measurements of your health.
>
> **If you feel unwell:** If you have chest pain, severe shortness of breath, fainting, coughing up blood, or thoughts of harming yourself, stop using the app and contact emergency services now ([US 911 / EU 112 / UK 999 or 112 / India 112]: verify per market). For help quitting, you can also contact a quitline ([insert verified national quitline per market]).
>
> **Age** — ☐ I confirm I am 18 years of age or older. *(Required; if unticked, the app explains it is for adults only and exits.)*
>
> **Terms** — ☐ I have read and agree to the [Terms of Use] and the [Privacy Notice], including the [Consumer Health Data Notice]. *(Required.)*
>
> **Your health information** *(each optional; change any time)*
> ☐ I explicitly consent to [App Name] processing the health-related information I enter (for example smoking history, cravings, symptoms I choose to log, and nicotine replacement reminders) to provide my personalized estimates and insights. *(Required for personalized features; without it the app runs in a limited, non-personalized mode.)*
> ☐ Connect my wearable data: allow reading resting heart rate and heart-rate variability from [Apple Health / Health Connect] to show trends alongside my smoke-free progress. We read only these data types, never use them for advertising, and never write estimated values back to Apple Health or Health Connect.
> ☐ Use my microphone for guided breathing: the microphone is used only while a breathing session is open, to time your breaths. Audio is processed on your device and is not recorded, stored, or sent to us. *(You can still use breathing exercises without the microphone.)*
> ☐ *(Optional, off by default)* Share de-identified usage statistics to help improve the app. No health information or audio is included.
> ☐ *(Only if an AI coach is offered; off by default)* Send my messages and relevant logs to [named third-party AI provider] to generate coaching replies.
>
> **Please remember:** Talk to a doctor or pharmacist before starting, stopping, or changing any medicine, including nicotine replacement therapy. The app's reminders follow the plan *you* enter and do not set or adjust doses.
>
> [Continue] *(enabled only when required boxes are ticked)* · [Read the Privacy Notice] · [Scientific methodology]

OS permission prompts appear just-in-time after the in-app explanation; "withdraw and delete" is one tap (Apple 5.1.1, GDPR, MHMDA, DPDP); emergency numbers and quitlines must be localized and verified.

**C. "Scientific Methodology & Citations" screen** (reachable from every estimate via an "i" icon and from Settings; versioned). The notes left the citations as placeholders; the bracketed content below is this report's proposed fill from Sections 1–2, using only sources tagged [V] or [V-DATA], each still to be checked against the original before release.

> **How our estimates work** — *Methodology version [x.y], last reviewed [date]. Changes are listed in the changelog below.*
>
> **What these numbers are, and aren't.** Lung Age, the Recovery Index, and craving insights are *models*. They combine published population research with the information you provide. They do not measure anything inside your body, are not validated for individual diagnosis, and can differ from what a clinical test would show. [App Name] is not a medical device.
>
> **1. Lung Age (illustrative).** *What it shows:* how the average lung-function trajectory reported in published studies compares between people with a smoking history like yours and people who never smoked, expressed as an equivalent "age." *Inputs:* age, sex, height, smoking history, smoke-free time. *No spirometer or sensor is used.* *Method:* [the race-neutral Global Lung Function Initiative "GLI Global" reference equations (Bowerman et al., Am J Respir Crit Care Med 2023) — or the Japanese Respiratory Society 2014 equations for users in Japan — with an average smoking-related difference per pack-year from population studies, converted into the age at which a never-smoker's average would match; shown as a range]. We use these equations outside their clinical purpose, as an illustration. *Limitations:* population averages do not predict any one person's lungs; healthy people of the same age and height differ by many "years"; ethnicity, occupation, air pollution, asthma and other factors are not fully captured; the value can't detect or rule out any lung condition. If you're curious about your actual lung function, ask a health professional about a breathing test.
>
> **2. Recovery Index** *(formerly "Bio-Toxicity")*. *What it shows:* a modeled timeline of typical recovery processes after stopping smoking as reported in published research. *Inputs:* time since your last logged cigarette and your logged smoking pattern. *Method:* [carbon monoxide clearance modeled with a ~4.5-hour daytime half-life (Sandberg et al., PLoS ONE 2011); heart-rate changes from a one-week abstinence study (Minami et al., Hypertension 1999); nasal mucus-clearance recovery by about day 15 in one study (Ramos et al., Respirology 2011); vascular-function recovery within about a month (2025 systematic review); smell improvement by about 45 days in one study. Each component shows an evidence badge; weights are a design choice, not a published formula]. *Limitations:* this is a generalized timeline, not a measurement of carbon monoxide or any substance in your body; several curves are interpolations between a few published time points.
>
> **3. Guided breathing (microphone).** Detects breath sounds during a session so it can time pacing cues. It does not measure lung capacity or respiratory rate for health purposes, or diagnose anything. Audio stays on your device.
>
> **4. Heart-rate and HRV trends.** Values come from your wearable through [Apple Health / Health Connect]; their accuracy depends on that device. We show trends against your own baseline. Apple and Android devices report different HRV measures, so values are not comparable across platforms. We do not interpret them for heart conditions.
>
> **5. Craving insights.** *Method:* [a transparent score based on the urge, stress, availability, alcohol, motivation and social items you answer, adapted from a published approach (Businelle et al., J Med Internet Res 2016; Hébert et al., JAMA Netw Open 2025), plus pattern-finding on your own logs that runs only on your phone]. Insights are suggestions to try a coping tool, not predictions about your health. *Evidence status:* [This app's feature has not been evaluated in a clinical trial.]
>
> **6. Nicotine replacement reminders and tips.** Reminders follow the schedule you enter. Technique tips summarize your product's US Drug Facts label [or local SmPC]. Always follow your product label and your pharmacist's or doctor's advice.
>
> **Validation and accuracy.** [e.g., "We checked our lung-age calculations against the GLI reference values." State the mean error from the NHANES-style calibration (Section 1.1) once measured. Do not claim clinical accuracy unless a validation study supports it.]
>
> **Full citations.** [Numbered list — author, title, journal, year, DOI or URL — populated only from verified sources in this blueprint.]
>
> **Questions or corrections?** Contact [email]. We review methodology at least [annually].
>
> **Always consult a qualified health professional** before making medical decisions.

## Verify-before-ship checklist

Each item below is used somewhere in the blueprint but rests on recalled, secondary or design-level evidence. Close each one with the named source or a validation result before the related feature, number or claim reaches users.

| # | Item | Where used | Why it is open | How to close |
|---|---|---|---|---|
| 1 | Morris & Temple 1985 and Morris 1971 coefficients | 1.1 legacy mode | Recalled; only internally consistent | Primary PDFs (DOIs 10.1016/0091-7435(85)90085-4; 10.1164/arrd.1971.103.1.57) |
| 2 | JRS lung-age formula (women's intercept sign) | 1.1 Japan legacy | Low confidence | JRS source document |
| 3 | GLI Global/GLI-2012 implementation and licence | 1.1 | Transcribed from GPL package; licence terms unread | Unit-test the six QA vectors against the official GLI calculator; legal review of GLI/ERS terms |
| 4 | LHS, Dockery, Vestbo, Løkke, Lange, Scanlon numbers | 1.1 trajectories, deficit model | All [PK] | Abstracts via listed DOIs |
| 5 | Step2quit details (equation, graphic, subgroup) | 0.2, 1.1 copy | [PK] | BMJ 2008 full text and figure |
| 6 | p_sus logistic coefficients and lung-age MAE | 1.1 pipeline | Design parameters | Fit on NHANES 2007–2012 or UK Biobank; publish MAE on the methodology screen |
| 7 | CPD → steady-state CO anchor; Jarvis ppm→COHb; CFK; SRNT 5–6 ppm cut-off | 1.2 CO domain | Not retrieved / secondary | PMC13536744; Jarvis 1986; Coburn 1965 (DOI 10.1172/JCI105250); Benowitz 2020 (CDC manuscript) |
| 8 | Nicotine and cotinine half-lives; sleep τ multiplier | 1.2 NIC/CO | Nicotine secondary; cotinine unverified; sleep data n=4–5 | Benowitz 2009 chapter |
| 9 | Acute FMD decay τ; Johnson 2010 FMD deltas and journal | 1.2 VASC | Not found | Amato 2013 full text; PMC2947952 full text |
| 10 | Per-timepoint STT (Ramos 2011); Verra 1995 ex-smoker cilia | 1.2 MCC | Endpoint-only | Respirology full text; AJRCCM 1995 |
| 11 | VO2max deficit and recovery | 1.2 (blocked from shipping) | No numbers | MSSE 2025 (DOI 10.1249/MSS.0000000000003602); PMC13380561 |
| 12 | Canonical timeline milestones (20 min to 15 yr) | 1.2 timeline page | Only 1–9 mo entry read | 1990 and 2020 Surgeon General reports |
| 13 | BTI weights | 1.2 | No empirical basis | Revise from in-app engagement and Gate #2 data |
| 14 | HTP CO and nicotine per stick; snus/gutka/pouch nicotine; cigar, cigarillo, kretek weights; EVALI counts; PHE "95%" provenance | 1.3 | Not retrieved; placeholders | Primary sources listed in 1.3; cdc.gov; gov.uk |
| 15 | Cochrane e-cigarette 2026 update (RR 1.61) | 1.3 | Secondary only | Cochrane Library CD010216 current version |
| 16 | Smart-T item weights and thresholds | 2.2 L0 rules | Full text blocked; "62%" summaries conflict | Businelle 2016 JMIR e275 full text; Smart-T protocol |
| 17 | Quit Sense geofence radius and clustering | 2.2 | Not obtained | NIHR KQYT5412 monograph |
| 18 | LiteRT on-device training signatures; ORT mobile training packages in 2026 | 5.5 | API names recalled | Current LiteRT and ONNX Runtime docs |
| 19 | Per-user JITAI performance | 2.2 | Published medians 0.64–0.75 | Gate #3 cohort (n≈120) with leave-one-subject-out and time-forward validation |
| 20 | Russell Standard and Hughes 2003 definitions; Kenford ">80%"; "most people take several tries" | 2.4 routing and copy | [PK] / secondary / unsourced | Addiction 2005; NTR 2003; JAMA 1994 abstract; a population source for the copy line |
| 21 | Thaler hedonic-editing principles; current λ meta-analysis; Halpern deposit-acceptor 52.3% | 2.3 | [PK] / secondary | Marketing Science 1985; J Econ Lit 2024; NEJM 2015 |
| 22 | ApBM session parameters; 4-year positive follow-up | 2.5 | Unverified | Wittekind 2026 AJP; Behav Res Ther 2026 |
| 23 | 0.1 Hz resonance mechanism; 4:6 ratio; Roxburgh nicotine-only estimate | 2.5 pacer | [PK]; design choice | Lehrer & Gevirtz 2014; Van Diest 2014; Roxburgh 2026 full text |
| 24 | NRT label warnings ("Ask a doctor", "Stop use"); patch ≤10 CPD schedule and bedtime removal; varenicline label; NICE NG209/NCSCT; pre-loading effect size | 2.6 module and red flags | Not retrieved | DailyMed; NICE; Cochrane CD013308.pub2 |
| 25 | Cytisinicline resubmission and regional licensing | 2.6 catalogue | Status after Q2 2026 unknown | Achieve Q3 2026 10-Q; MHRA, Health Canada, EMA registers |
| 26 | FTND, WISDM, MTSS, RBD, PS-ECDI licensing; legal view on original items | 3 | Unresolved | Author/publisher permission; counsel |
| 27 | Onboarding median time ≤90 s; item reliability; agreement with Brief WISDM and RBD | 3 | No timing norm; unvalidated | Paradata in soft launch; permissioned validation sub-sample |
| 28 | Rive performance budget on 2–3 GB Android; reduce-motion handling | 4.3 | Not retrieved | Device profiling (Gate B5) |
| 29 | Core Haptics background behavior; max continuous duration; AHAP `Duration` vs `EventDuration`; Android `USAGE_MEDIA` attenuation | 4.5 | Not verified | On-device tests |
| 30 | OLED black smear; color-emotion claims; Compose `tnum` | 4.4 | Unsourced | Panel testing; CVD simulation |
| 31 | `STRICT` support and cipher pragmas in the chosen SQLite build | 5.2 | Version/pragma names recalled | Runtime `sqlite_version()`, `PRAGMA cipher_version` / `PRAGMA cipher` checks in CI |
| 32 | iOS 64-pending-notification limit; `native_geofence` CLMonitor use | 5.4 | Archived doc; README unread | Device test; package source |
| 33 | Which Android wearables write HRV/RHR to Health Connect | 5.3 | Unknown | Device matrix test |
| 34 | Mic exhale detection accuracy in noise | 5.6 | No benchmark; Breeze metrics unread | **Gate 0b** bench (30 people × 4 noise levels × ≥6 phones); release only if duration MAE <0.5 s at SNR ≥12 dB |
| 35 | FDA 2026 General Wellness primary text; DSF/MMA guidance date | 6.1 | Law-firm snippets only | fda.gov guidance PDFs |
| 36 | Google Play disclaimer placement and tobacco/NRT policy wording | 6.4 | Snippet only | Play Console policy pages |
| 37 | MHMDA details (geofencing ban, sale authorization); HBNR deadlines and penalty | 6.1 | Not confirmed | RCW 19.373; 16 CFR 318 |
| 38 | EU AI Act Omnibus regulation number; MDCG 2019-11 Rev.1 examples; possible emotion-recognition scope of craving inference | 6.2 | Snippet / inference | EUR-Lex; Commission page; counsel |
| 39 | Emergency numbers and quitlines per market | 6.6 | Placeholders | National health authorities |
| 40 | Written regulatory opinions (US, EU, UK, India) and test store submissions | 6 | Required by Gate 0a | Counsel in each launch market |

## Conclusion

The research points to an asymmetry the brief did not anticipate. **The most visual components (avatar, Lung Age, toxicity dashboard, swipe training, microphone sensing) have the weakest evidence, and the least visual ones (acceptance of bodily urges, a six-item rules score, label-quoted medication reminders, non-resetting progress) have the strongest.** A team that builds in the order of visual appeal will spend its first year on features that may not move abstinence, and its pivotal readout comes 18–30 months later. The decision tree is therefore the product strategy. The five month-0–6 gates (claims, microphone bench, retention, visualization factorial and the JITAI cohort) cost far less than the avatar. Each also yields a publishable asset (a cessation-app retention benchmark, the first head-to-head test of estimated lung age against reversible-harm framing, and an EMA-plus-sensing lapse dataset). These assets are themselves a defensible advantage in a market where the tracker layer is commoditized.

The sections also converge in a way that makes the design coherent. The physiology that solves the Young Smoker Paradox operates on short time constants: CO clears in hours, the heart-rate spike passes in about 30 minutes, resting heart rate falls about 7 bpm in a week, and nasal clearance recovers by about day 15. Smokers' steep hyperbolic discounting says these near-term, certain signals carry the most motivational weight. The 2026 FDA wellness revision and Apple 1.4.1 permit exactly this kind of display (trends, estimates, ranges, wearable-derived values) while forbidding thresholds, disease names and implied measurement. The EPPM and pictorial-warning evidence, in turn, favors showing harm once and recovery thereafter. **Physiology, behavioral economics and regulation thus point to the same interface: a gain-framed, near-term, range-bounded recovery display that the user's own wearable can partly confirm.** The open question is no longer whether such an interface is defensible but whether it adds anything over ACT and medication support. Gate #2 answers that in about four months for roughly the cost of one design sprint.

