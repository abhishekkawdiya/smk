# Section 0: Problem Selection & Risk Assessment: Competitive Landscape, Evidence Ceiling, Engagement Risk, and Fischbach & Walsh Framework Application

> **Read this first: sourcing limits for these notes (2026-10-21).**
> - WebFetch failed with a DNS error (`ENOTFOUND`) on every domain tried: pubmed, PMC, Cochrane, JMIR, BMJ, medRxiv, who.int and fredhutch. The agent proxy also blocked NCBI.
> - The shared WebSearch budget (200 calls per turn, across all agents) ran out after about 16 searches by this researcher.
> - **[V]** marks facts confirmed this session through search-result text from the source or close summaries of it. I could not open any full text.
> - **[PK]** marks facts taken from the researcher's prior knowledge (training cut-off June 2026). Each one has a full citation and a DOI. The DOIs were not re-verified this session. A [PK] item tells the writer where to look; it is not confirmed. Check every [PK] number against the original before publication.
> - Company and app statuses as of October 2026 could only be checked for Quit Genius/Pelago, Pivot and Smoke Free, and only partly. The other statuses are listed under Gaps.

---

## 1. Competitive landscape: leading cessation apps and their evidence (status as of Oct 2026)

### Takeaway
Only a few cessation apps have RCT evidence. The strongest consumer-app result is iCanQuit (ACT; OR 1.49 versus NCI QuitGuide at 12 months, self-reported). Results that combine an app with human support or NRT (Pivot, Quit Genius, CureApp SC in Japan) are larger but not app-only. The most-downloaded standalone app, Smoke Free, had a null intention-to-treat result in its pragmatic RCT. Its effect showed up only among the roughly 25% who downloaded it. The market leaders (Pelago, formerly Quit Genius; Pivot) have moved to B2B "digital clinic" models with coaching and NRT. I found no FDA-cleared smoking-cessation app for the US. The one regulator-approved prescription cessation app I know of is Japan's CureApp SC [PK].

### Cited Findings

**iCanQuit (ACT; Fred Hutch; now licensed to 2Morrow Inc.)**
- RCT design: Bricker JB, Watson NL, Mull KE, Sullivan BM, Heffner JL. *Efficacy of Smartphone Applications for Smoking Cessation: A Randomized Clinical Trial.* JAMA Intern Med 2020;180(11):1472–1480. DOI 10.1001/jamainternmed.2020.4055 [DOI: PK]. Participants: N=2,415 adults from all 50 US states, 70.4% women. Arms: iCanQuit (n=1,214) vs NCI QuitGuide (n=1,201). Follow-up at 3, 6 and 12 months. — [Fred Hutch press release (via search)](https://www.fredhutch.org/en/news/releases/2020/09/fred-hutch-led-clinical-trial-shows-new-smartphone-app-helps-smokers-quit.html) [V]
- Primary outcome: self-reported 30-day point-prevalence abstinence (PPA) at 12 months, OR 1.49. Prolonged abstinence, 7-day PPA and all-tobacco abstinence gave similar significant effects. — [NAQC summary](https://www.naquitline.org/news/531843/Efficacy-of-Smartphone-Applications-for-Smoking-Cessation-A-Randomized-Clinical-Trial.-.htm) [V]
- 28.2% of iCanQuit users were abstinent at 12 months [V: [Psychiatric News](https://psychnews.psychiatryonline.org/doi/10.1176/appi.pn.2020.11a6)]. QuitGuide arm about 21.1%; OR 1.49, 95% CI 1.22–1.83 [PK; not re-verified].
- Mechanism contrast: iCanQuit teaches acceptance of urges and letting them pass (urge surfing). QuitGuide teaches avoidance of high-risk situations. — [Fred Hutch](https://www.fredhutch.org/en/news/releases/2020/09/fred-hutch-led-clinical-trial-shows-new-smartphone-app-helps-smokers-quit.html) [V]
- Engagement: participants opened iCanQuit about 37 times on average over 12 months, vs about 10 openings for QuitGuide. Logins, minutes of use and unique days of use all serially mediated the cessation effect. — Bricker JB et al. JMIR mHealth uHealth 2021, [DOI 10.2196/32847](https://mhealth.jmir.org/2021/11/e32847/PDF) [V]
- Funding was an NCI grant. The app was licensed to 2Morrow Inc. after the study. — [Fred Hutch](https://www.fredhutch.org/en/news/releases/2020/09/fred-hutch-led-clinical-trial-shows-new-smartphone-app-helps-smokers-quit.html) [V]

**QuitGuide / quitSTART (NCI, smokefree.gov)**
- QuitGuide is the standard active comparator in the two most cited US app RCTs (iCanQuit; Pivot). It is based on US clinical practice guidelines. — [Fred Hutch](https://www.fredhutch.org/en/news/releases/2020/09/fred-hutch-led-clinical-trial-shows-new-smartphone-app-helps-smokers-quit.html); [Marler 2022](https://mhealth.jmir.org/2022/11/e41658/PDF) [V]
- Its October 2026 availability could not be verified (see Gaps).

**Smoke Free (David Crane / 23 Limited; UCL collaborators)**
- Exploratory RCT: Crane D, Ubhi HK, Brown J, West R. F1000Research 2018;7:1524. N=28,112. The full version was associated with higher 3-month abstinence than a reduced version. — [UCL Discovery](https://discovery-pp.ucl.ac.uk/id/eprint/10108155); [F1000Research](https://f1000research.com/articles/7-1524/v1/xml) [V]
- Pragmatic RCT: Jackson SE, Kale D, Beard E, Perski O, West R, Brown J. *Effectiveness of the Offer of the Smoke Free Smartphone App Compared With No Intervention for Smoking Cessation: Pragmatic RCT.* J Med Internet Res 2024;26:e50963. [DOI 10.2196/50963](https://jmir.org/2024/1/e50963). Participants: N=3,143 motivated adults recruited online, Aug 2020 to Apr 2021. Primary outcome: self-reported (not biochemically verified) 6-month continuous abstinence at 7 months. [V]
- ITT result: **6.8% vs 7.0%, RR 0.97 (95% CI 0.75–1.26)**. Effective follow-up was **41.9%**. No secondary outcome benefited. — [medRxiv preprint](https://medrxiv.org/content/10.1101/2023.01.12.23284463.full.pdf); [UCL Discovery](https://discovery.ucl.ac.uk/id/eprint/10197820) [V]
- Only **25.3% (n=395)** of those offered the app downloaded it. Among downloaders, abstinence was 12.7% vs 7.0%, RR 1.80 (1.30–2.45). This comparison selects on uptake and is not randomized. — [medRxiv](https://medrxiv.org/content/10.1101/2023.01.12.23284463.full.pdf) [V]
- Chatbot trial: the company site cites a trial of 57,214 participants in which chatbot users were "more than twice as likely to stay smoke free" as users given "missions". This is a company-hosted claim. — [smokefreeapp.com](https://smokefreeapp.com/practices-and-procedures/) [V as claim]
- Engagement experiment: Perski O, Crane D, Beard E, Brown J. *Does the addition of a supportive chatbot promote user engagement with a smoking cessation app?* Digit Health 2019;5. DOI 10.1177/2055207619880676 [PK]. It reported more engagement with the chatbot [PK]; exact effect sizes not re-verified.

**Quit Genius, now Pelago (UK/US; digital CBT plus coaching plus medication)**
- 4-week RCT: Webb J et al. JMIR Ment Health 2020;7(10):e22833 ([DOI 10.2196/22833](https://mental.jmir.org/2020/10/e22833)). 556 UK smokers randomized (530 analyzed). Comparator: Very Brief Advice (VBA). 7-day PPA at 4 weeks after quit date: **44.5% vs 28.7%**. [V]
- 52-week follow-up: Webb J et al. *Long-Term Effectiveness of a Clinician-Assisted Digital CBT Intervention for Smoking Cessation.* Nicotine Tob Res 2022;24(11):1763–1772, [DOI 10.1093/ntr/ntac113](https://pmc.ncbi.nlm.nih.gov/articles/PMC9597001). Self-reported 7-day PPA was 27.2% vs 16.6% at 26 weeks and **22.6% vs 13.2% at 52 weeks (RR 1.71, 95% CI 1.17–2.50)**. [V]
- CO verification covered a random subset of 280. The difference was significant at 26 weeks (p=.03) but **not at 52 weeks (p=.16)**. The trial was funded by the company. [V]
- Company: renamed **Pelago**, a virtual substance-use clinic covering tobacco, alcohol, opioids and cannabis. Sold to employers and health plans. Sources disagree on whether the rebrand was in 2022 or 2023. Raised a $58M Series C led by Atomico (March 2024). — [Dealroom](https://app.dealroom.co/companies/pelago_formerly_quit_genius_); [MobiHealthNews](https://www.mobihealthnews.com/news/digital-addiction-treatment-company-quit-genius-scores-64m) [V]
- **No FDA clearance for Quit Genius/Pelago appeared in any search result** [V: absence in search results only].
- The brief's premise that Quit Genius is "now part of Bicycle" **was not confirmed**. Sources show a rebrand to Pelago, not an acquisition.

**Pivot (Pivot Health Technologies Inc., formerly Carrot Inc.; personal CO breath sensor, app, text coaching, NRT, community)**
- Pilot RCT at 26 weeks: Marler JD et al. JMIR mHealth uHealth 2022;10(11):e41658 ([PDF](https://mhealth.jmir.org/2022/11/e41658/PDF)). Pivot vs QuitGuide, both with 12 weeks of free NRT, N=188. Biovalidated continuous abstinence (witnessed remote breath-CO): **21% (20/94) vs 10% (9/94)**. [V]
- 52-week results: Marler JD et al. JMIR mHealth uHealth 2023;11:e48157 ([PDF](https://mhealth.jmir.org/2023/1/e48157/PDF)). Biochemically confirmed PPA 31% vs 18%. Biochemically confirmed continuous abstinence **19% (18/94) vs 9% (8/94), P=.046**. Self-reported continuous abstinence 20% vs 9%. Registered as NCT04955639. [V]
- Caveats: the lead author is company staff and parts of the analysis are exploratory. No analysis isolates the CO sensor's contribution. — [NAQC](https://www.naquitline.org/news/652693/Long-term-Outcomes-of-a-Comprehensive-Mobile-Smoking-Cessation-Program-with-Nicotine-Replacement-The.htm) [V]
- Company history: Carrot Inc. was renamed Pivot Health Technologies Inc. [V: [ClinicalTrials.gov protocol](https://classic.clinicaltrials.gov/ProvidedDocs/39/NCT04955639/Prot_SAP_001.pdf)]. It partnered with Virgin Pulse in 2021 [V: [BusinessWire](https://www.businesswire.com/news/home/20211108005461/en/Carrot-Joins-Virgin-Pulse-Partner-Network-to-Help-Members-Quit-Tobacco)] and launched a vaping program [V: [Managed Healthcare Executive](https://managedhealthcareexecutive.com/view/pivot-launches-solution-help-end-vaping-epidemic)]. **No 2024–2026 acquisition or shutdown news was found.** Status is unverified.
- Earlier single-arm cohort: Marler JD et al. JMIR mHealth uHealth 2019;7(2):e12609 [PK; numbers not re-verified].

**CureApp SC (Japan; prescription app plus portable CO checker; added to clinic-based varenicline/NRT care) [PK]**
- Masaki K et al. *A randomized controlled trial of a smoking cessation smartphone application with a carbon monoxide checker.* npj Digit Med 2020;3:35. DOI 10.1038/s41746-020-0243-5 [PK].
- Continuous abstinence, weeks 9–24: about 63.9% vs 50.5% (OR about 1.73) [PK; verify].
- Approved by Japanese regulators in 2020 and reimbursed under national health insurance [PK; verify date].
- This is the clearest example of a cessation app regulated *as a medical device*. That matters for the wellness-positioning risk (B4 below).

**Clickotine (Click Therapeutics)**
- Iacoviello BM et al. *Clickotine, a personalized smartphone app for smoking cessation: initial evaluation.* JMIR mHealth uHealth 2017;5(4):e56. DOI 10.2196/mhealth.7226 [PK]. Single-arm, uncontrolled, n≈416 [PK]. Abstinence numbers not re-verified.
- Click Therapeutics has since focused on prescription digital therapeutics in other indications [PK]. **Clickotine's current status is unverified.**

**"This is Quitting" (Truth Initiative; text messaging for vaping) [PK]**
- Graham AL, Amato MS, Cha S, Jacobs MA, Bottcher MM, Papandonatos GD. *Effectiveness of a Vaping Cessation Text Message Program Among Young Adult e-Cigarette Users: A Randomized Clinical Trial.* JAMA Intern Med 2021;181(7):923–930. DOI 10.1001/jamainternmed.2021.1793.
- Young adults aged 18–24, n≈2,588. 30-day PPA at 7 months about 24.1% vs 18.6% (OR about 1.39) [PK; verify].
- Graham AL et al. *A vaping cessation text message program for adolescent e-cigarette users: RCT.* JAMA 2024 (DOI not re-verified). Positive at 7 months [PK]; exact figures not re-verified.

**Text messaging generally (benchmark modality)**
- Cochrane 2019 (Whittaker et al.): **text messaging vs minimal support RR 1.54 (95% CI 1.19–2.00), 13 studies, moderate certainty**. Text messaging added to other support: RR 1.59 (1.09–2.33), 4 studies. — [Community Guide summary](https://www.thecommunityguide.org/content/tffrs-tobacco-use-mobile-phone-based-cessation-interventions); [Cochrane record](https://cochranelibrary.com/cdsr/doi/10.1002/14651858.CD006611.pub5/information) [V]

**WHO "Florence" / S.A.R.A.H. [PK]**
- WHO launched "Florence", an AI-driven digital health worker built with Soul Machines, in its 2020–2021 "Commit to Quit" campaign to give quit-tobacco advice. In 2024 WHO launched S.A.R.A.H., a generative-AI successor covering several health topics, tobacco among them [PK; verify].
- I am not aware of any efficacy trial of either.

**Kwit, Flamingo, QuitNow!, NHS Quit Smoking app, Quit Coach**
- No outcome trials or current-status data could be retrieved this session (see Gaps).
- QuitNow! (Fewlaps) and Kwit (France) are popular freemium gamified trackers. They show "health recovery" milestone lists, which are the closest commercial analog to a reversible-harm display. I know of no published RCTs for either [PK].

**Content and quality reviews of cessation apps**
- Abroms LC, Padmanabhan N, Thaweethai L, Phillips T. *iPhone apps for smoking cessation: a content analysis.* Am J Prev Med 2011;40(3):279–285. DOI 10.1016/j.amepre.2010.10.032 [PK]. Most of 47 apps adhered poorly to US Clinical Practice Guidelines, and few recommended quitlines or pharmacotherapy [PK].
- Abroms LC et al. *A content analysis of popular smartphone apps for smoking cessation.* Am J Prev Med 2013;45(6):732–736. DOI 10.1016/j.amepre.2013.07.008 [PK]. Guideline adherence remained low [PK].
- Hoeppner BB et al. *How smart are smartphone apps for smoking cessation? A content analysis.* Nicotine Tob Res 2016;18(5):1025–1031. DOI 10.1093/ntr/ntv117 [PK].
- Haskins BL, Lesperance D, Gibbons P, Boudreaux ED. *A systematic review of smartphone applications for smoking cessation.* Transl Behav Med 2017;7(2):292–299. DOI 10.1007/s13142-017-0492-2 [PK]. Evidence-based content and popularity were poorly aligned [PK].
- Rajani NB, Weth D, Mastellos N, Filippidis FT. *Adherence of popular smoking cessation mobile applications to evidence-based guidelines.* BMC Public Health 2019;19:743 [PK].
- Rajani NB et al. 2021 (JMIR Serious Games): gamification, self-efficacy and motivation in cessation apps [PK]. The exact 2021 paper the brief refers to was not confirmed.

### Inferences
- **The space is crowded and commoditized at the "tracker plus milestones" layer**: money saved, days smoke-free, health-recovery timelines. That layer alone does not move pragmatic ITT outcomes (Smoke Free RR 0.97). Differentiation has to come from (a) evidence-backed mechanisms such as ACT urge surfing (iCanQuit) and combining the app with pharmacotherapy (Pivot, CureApp), and/or (b) distribution that solves uptake. Lung-avatar visualization by itself is not a moat.
- **Market leaders moved to B2B with humans and NRT.** Pelago (employer/health plan, coaching, medication) and Pivot (employer/health plan, NRT, coaching) do this. CureApp is a prescription device. A global direct-to-consumer wellness app competes with free government apps (NCI, NHS) and freemium trackers (QuitNow!, Kwit, Smoke Free) on price and with the B2B clinics on efficacy.
- **The "downloaded the app" effect in Smoke Free (RR 1.80 among uptakers)** shows that uptake and engagement, not content, are the binding constraint in self-directed populations. This drives the parameter strategy below.
- **The app most similar to this blueprint is iCanQuit plus Pivot features.** It combines ACT urge surfing, biological feedback (Pivot's CO sensor, which this team replaces with a modeled toxicity index) and NRT. The team should treat iCanQuit (about 28% 30-day PPA at 12 months, self-reported) and Pivot (about 19% CO-verified continuous at 52 weeks with NRT) as ceiling benchmarks, not floors.

### Gaps
- Status as of Oct 2026 could not be verified (WebFetch blocked; search budget exhausted) for: QuitGuide/quitSTART, the NHS Quit Smoking app, Kwit, Flamingo, QuitNow!, Clickotine, Quit Coach, the WHO Florence/S.A.R.A.H. lifecycle, and Pivot ownership.
- Whether any FDA De Novo or 510(k) for a smoking-cessation app exists as of 2026. None appeared in search results; a direct check of the FDA database is needed.
- Whether Smoke Free or NichtraucherHelden hold German DiGA listings [PK suspicion only].
- "Flamingo" could not be identified as a cessation app. The name may be ambiguous; confirm with the team.
- No head-to-head data comparing breath-CO feedback with modeled (non-measured) toxicity feedback.

---

## 2. Lung-age / lung-health visualization and biomedical-risk feedback: what is the evidence?

### Takeaway
Telling smokers their **spirometry-measured** "lung age" roughly doubled verified 12-month quit rates in one good-quality UK RCT (Step2quit, BMJ 2008). Cochrane classes the wider biomedical-risk-feedback literature as low certainty, with essentially one supportive trial [PK]. I found **no RCT of a questionnaire-estimated (non-spirometric) lung age, a 3D lung avatar, or a "reversible toxicity" dashboard** in a cessation app. The core motivational hook of this blueprint is therefore untested.

### Cited Findings
- Parkes G, Greenhalgh T, Griffin M, Dent R. *Effect on smoking quit rate of telling patients their lung age: the Step2quit randomised controlled trial.* BMJ 2008;336:598–600. DOI 10.1136/bmj.39503.582396.25 [PK].
  - N=561 primary-care smokers aged ≥35.
  - Verified (salivary cotinine) quit at 12 months: **13.6% vs 6.4%** (difference 7.2 percentage points, 95% CI 2.2–12.1; NNT≈14) [PK].
  - Quit rates were reported as similar whether the patient's lung age was normal or abnormal [PK; verify]. This suggests the effect may come from personalized engagement and attention rather than threat alone.
- Clair C, Mueller Y, Livingstone-Banks J et al. *Biomedical risk assessment as an aid for smoking cessation.* Cochrane Database Syst Rev 2019;3:CD004705. DOI 10.1002/14651858.CD004705.pub5 [PK]. Conclusion (paraphrase, PK): there is insufficient evidence that most biomedical risk feedback (CO, spirometry, genetic susceptibility, imaging) increases cessation. Spirometry with "lung age" had a positive effect in a single trial.
- Gallagher KM, Updegraff JA. *Health message framing effects on attitudes, intentions, and behavior: a meta-analytic review.* Ann Behav Med 2012;43(1):101–116. DOI 10.1007/s12160-011-9308-7 [PK]. Gain-framed messages modestly outperformed loss-framed ones for prevention behaviors, including smoking cessation (small effect, r≈0.08). This bears on "reversible gains" versus "damage" framing.
- Physiological basis for a "reversible" index:
  - COHb clears with a half-life of hours on room air [PK, standard toxicology].
  - Johnson HM et al. JACC 2010;55(18):1988–1995 (DOI 10.1016/j.jacc.2010.03.002) [PK]: brachial flow-mediated dilation improved by about 1 percentage point at 1 year in quitters versus continuing smokers.
  - Precise individual-level timelines for cilia and heart rate are weakly evidenced [PK]. The popular "20 minutes / 8 hours / 48 hours" recovery timelines come mostly from public-health leaflets, not individual-level data.

### Inferences
- The visualization's effect size is **unknown and probably smaller than Step2quit**, for three reasons:
  1. An estimated lung age is not personal measurement. Users may discount it, especially if two inputs produce the same "age".
  2. Step2quit included a clinician encounter.
  3. App self-selection populations are already motivated, so there is less headroom.
- "Reversible acute harm" is theoretically attractive. It is gain-framed, gives fast feedback within hours to days, and matches present bias in young smokers. But it is **untested head-to-head against lung age**, so it should be a factorial factor (Go/No-Go #2 below), not an assumption.
- The visualization should probably be justified as an **engagement and feedback loop**, a reason to open the app daily, rather than as a primary efficacy mechanism, until data say otherwise.

### Gaps
- No search budget remained to look for commercial apps with lung avatars (for example "lung health" visualizers) or face-aging analogs (Smokerface/Brinker et al. school-prevention studies, PK). Their evidence is unretrieved.
- No data on whether modeled, non-measured toxicity indices are perceived as credible, or whether they cause reactance or defensive avoidance in smokers.

---

## 3. Evidence ceiling: realistic effect sizes, verification standards, evaluation path, and what a credible pivotal RCT needs

### Takeaway
Pooled app evidence is **conflicting and low certainty**:
- Cochrane 2019: apps vs lower-intensity support **RR 1.00 (0.66–1.52)**.
- JMIR 2023 meta-analysis: OR 1.25 (0.99–1.56) for apps overall; **OR 1.79** for app plus pharmacotherapy vs pharmacotherapy.
- BMJ EBM (Chu et al., online Jan 2026): RR 2.85 vs no/minimal support (4 small studies) and RR 1.98 as an add-on (I²=85.7%), both low certainty.
- The largest pragmatic trial (Smoke Free, ITT) was null.

**The planning assumption should be a pragmatic ITT RR of about 1.2–1.5 against minimal support, and lower against an active comparator.** A credible pivotal RCT needs roughly **2,000–7,000 participants** with CO-verified, Russell Standard 6-month sustained abstinence.

### Cited Findings
**Pooled efficacy**
- Whittaker R, McRobbie H, Bullen C, Rodgers A, Gu Y, Dobson R. *Mobile phone text messaging and app-based interventions for smoking cessation.* Cochrane Database Syst Rev 2019;(10):CD006611. [DOI 10.1002/14651858.CD006611.pub5](https://cochranelibrary.com/cdsr/doi/10.1002/14651858.CD006611.pub5/information). 26 studies, searched to Oct 2018. Smartphone app vs lower-intensity support: **RR 1.00 (95% CI 0.66–1.52), 5 studies, N=3,079, very low certainty**. Text messaging: RR 1.54 (1.19–2.00), moderate certainty. — [Cochrane abstract PDF](https://cochranelibrary.com/cdsr/doi/10.1002/14651858.CD006611.pub5/pdf/CDSR/CD006611/CD006611_abstract.pdf); [AAFP summary](https://www.aafp.org/afp/2020/0801/p148) [V]
- JMIR 2023 systematic review and meta-analysis ([J Med Internet Res 2023;25:e43242](https://www.jmir.org/2023/1/e43242); first author believed to be Guo YQ [PK]). 9 RCTs, N=12,967. Apps vs comparators **OR 1.25 (0.99–1.56), not significant**. App plus pharmacotherapy vs pharmacotherapy alone (3 trials): **OR 1.79 (1.38–2.33)**. [V]
- Chu et al. BMJ Evidence-Based Medicine, online 13 Jan 2026 ([ebm.bmj.com 31(4):242](https://ebm.bmj.com/content/31/4/242); DOI 10.1136/bmjebm-2025-113971). 31 RCTs, N=12,802, searched to 15 Aug 2025. [V]
  - Apps alone vs no/minimal support: **RR 2.85** for 6-month continuous abstinence (4 studies, n=1,402, low certainty).
  - Apps added to traditional interventions: **RR 1.98** (4 studies, n=2,163, I²=85.7%, low certainty).
  - The authors call the findings hypothesis-generating. — [BMJ press release](https://bmjgroup.com/phone-apps-nearly-3-times-as-good-as-no-basic-support-for-quitting-smoking-long-term/); [Scimex](https://www.scimex.org/newsfeed/smartphone-apps-are-a-smart-way-to-quit-smoking)
- Smoke Free pragmatic RCT (largest app-alone ITT trial): RR 0.97 (0.75–1.26) — [Jackson 2024](https://jmir.org/2024/1/e50963) [V]

**Baselines**
- Hughes JR, Keely J, Naud S. *Shape of the relapse curve and long-term abstinence among untreated smokers.* Addiction 2004;99(1):29–38. DOI 10.1111/j.1360-0443.2004.00540.x [PK]. About **3–5%** of unaided quit attempts reach 6–12 months of abstinence; most relapse within the first 8 days [PK].
- NRT: Hartmann-Boyce J et al. Cochrane 2018, CD000146.pub5, DOI 10.1002/14651858.CD000146.pub5 [PK]. Any NRT vs placebo or no NRT: RR about 1.55 (1.49–1.61), high certainty [PK]. Combination NRT outperforms single-form NRT (Lindson N et al. Cochrane 2019, CD013308; RR about 1.25) [PK].

**Verification and outcome standards**
- Russell Standard: West R, Hajek P, Stead L, Stapleton J. *Outcome criteria in smoking cessation trials: proposal for a common standard.* Addiction 2005;100(3):299–303. DOI 10.1111/j.1360-0443.2004.00995.x [PK]. Its rules:
  - Sustained abstinence over 6 or 12 months from the target quit date.
  - A 2-week grace period.
  - No more than 5 cigarettes in total allowed.
  - Biochemical verification at least at the final follow-up.
  - ITT, with people lost to follow-up counted as smokers.
  - Follow-up blind to allocation where possible.
- SRNT verification standard: Benowitz NL, Bernert JT, Foulds J, Hecht SS, Jacob P, Jarvis MJ, Joseph A, Oncken C, Piper ME. *Biochemical Verification of Tobacco Use and Abstinence: 2019 Update.* Nicotine Tob Res 2020;22(7):1086–1097. DOI 10.1093/ntr/ntz132 [PK]. It recommends:
  - Lower exhaled-CO cut-offs than older 8–10 ppm conventions, about 5–6 ppm [PK; verify exact].
  - Cotinine cut-offs that depend on the matrix.
  - Minor tobacco alkaloids (anabasine/anatabine) to verify abstinence in people using NRT or e-cigarettes.
  - Acknowledgement that CO detects only about the last 24 hours of smoking.
- Remote verification is feasible:
  - Pivot used witnessed remote breath-CO. — [Marler 2022](https://mhealth.jmir.org/2022/11/e41658/PDF) [V]
  - Quit Genius CO-verified a random subset (n=280). Its verified effect lost significance at 52 weeks (p=.16), illustrating attenuation between self-report and verification. — [Webb 2022](https://pmc.ncbi.nlm.nih.gov/articles/PMC9597001) [V]
  - Smoke Free's 41.9% follow-up shows the attrition risk of online-only trials. — [Jackson 2024](https://medrxiv.org/content/10.1101/2023.01.12.23284463.full.pdf) [V]

**Evaluation-path methodology [PK]**
- MOST:
  - Collins LM, Murphy SA, Strecher V. Am J Prev Med 2007;32(5 Suppl):S112–S118, DOI 10.1016/j.amepre.2007.01.022.
  - Collins LM. *Optimization of Behavioral, Biobehavioral, and Biomedical Interventions: The Multiphase Optimization Strategy (MOST).* Springer 2018, DOI 10.1007/978-3-319-72206-1.
  - Phases are preparation, optimization and evaluation. Factorial screening experiments estimate each component's main effect using the whole sample.
- Micro-randomized trials: Klasnja P, Hekler EB, Shiffman S, Boruvka A, Almirall D, Tewari A, Murphy SA. Health Psychol 2015;34S:1220–1228. DOI 10.1037/hea0000305.
- JITAI design: Nahum-Shani I, Smith SN, Spring BJ, Collins LM, Witkiewitz K, Tewari A, Murphy SA. Ann Behav Med 2018;52(6):446–462. DOI 10.1007/s12160-016-9830-8. Components are decision points, tailoring variables, intervention options and decision rules.
- SMART: Murphy SA. Stat Med 2005;24(10):1455–1481, DOI 10.1002/sim.2022. Also Lei H et al. Annu Rev Clin Psychol 2012;8:21–48.

**Sample size calculations (this researcher's computation)**
Two-arm trial, two-sided α=0.05, standard two-proportion formula. Per-arm n, ITT, with missing counted as smoking:

| Control CO-verified 6-mo sustained abstinence (ITT) | Target RR | n/arm, 80% power | n/arm, 90% power |
|---|---|---|---|
| 5% | 1.3 | 3,780 | 5,060 |
| 5% | 1.5 | 1,471 | 1,969 |
| 7% | 1.3 | 2,634 | 3,526 |
| 7% | 1.5 | 1,022 | 1,368 |
| 10% | 1.3 | 1,774 | 2,375 |
| 10% | 1.5 | 686 | 918 |
| 10% | 1.8 | 295 | 394 |

The control-rate anchors come from three sources: Smoke Free's comparator (7.0% self-reported continuous), the QuitGuide plus NRT arm in Pivot (9–10% CO-verified continuous), and the unaided baseline of 3–5% (Hughes 2004 [PK]).

### Inferences
- **Realistic targets to give the team:**
  - App alone, pragmatic, ITT, CO-verified 6-month sustained abstinence: **~6–10% in the intervention arm vs ~4–7% in control (absolute gain of 1–3 points, RR ≈1.2–1.5)**.
  - With NRT bundled: **~12–20%** (anchored to Pivot's 19% at 52 weeks).
  - Self-reported 30-day PPA at 12 months in a motivated trial sample: **~20–28%** (iCanQuit).
  - Claims like "2–3× quit rates" from the low-certainty Chu 2026 pooled RR 2.85 should not be used in marketing or planning. Those trials were small, used minimal-support comparators and were heterogeneous.
- **A credible pivotal RCT** should have:
  - An active comparator: QuitGuide, the NHS app, or brief advice plus NRT signposting.
  - Russell Standard 6-month sustained abstinence (12 months preferred), with remote CO verification (BLE or mailed CO monitor, witnessed by video) at 6 months, plus anabasine or saliva cotinine where NRT/e-cigarette use confounds.
  - ITT with missing counted as smoking, a target follow-up of at least 70–80%, and preregistration.
  - **N≈2,000–3,000 for RR 1.5, or ≥5,000–7,000 for RR 1.3**, with enrollment of 6–12 months.
  - **Total time to readout of about 18–30 months** from first patient in. This makes the efficacy assumption a *late, high-risk* readout (red flag; see section 5).
- **Recommended staged path (MOST):**
  1. Preparation, months 0–6: conceptual model, go/no-go gates 1–3.
  2. Optimization, months 6–18: a 2^k factorial screening experiment, for example k=5 components (lung-age vs reversible-toxicity framing; ApBM; cigarette logging intensity; BE commitment; lapse-handling module). Proximal outcomes are CO-verified 4-week abstinence and quit attempts. Run a parallel MRT on JITAI prompts and breathing-pacer prompts, with craving 30–60 minutes later and lapse 2–4 hours later as proximal outcomes.
  3. Optional SMART for non-responders: for example, augment with human coaching or NRT escalation at week 2 if the user has lapsed. Early lapses strongly predict failure (Kenford 1994 [PK]).
  4. Evaluation, months 18–36: the pivotal RCT.

### Gaps
- Whether a 2024–2026 Cochrane update of CD006611 exists. Not retrieved; the Chu 2026 BMJ EBM review is the most recent pooled estimate found.
- The exact SRNT 2020 CO and cotinine cut-offs and the exact Russell Standard wording are [PK]; verify against the originals.
- The individual RCTs inside Chu 2026's "apps alone RR 2.85" stratum are not identified.

---

## 4. Engagement risks: retention, notification fatigue, dropout after lapse

### Takeaway
Retention is the dominant practical risk. In real-world panel data, the median mental-health app keeps **3.9% of users at day 15 and 3.3% at day 30**. **Breathing-exercise apps had the worst day-30 retention (median 0.0%)**, which is directly relevant to the 0.1 Hz breathing feature. Only 25.3% of trial participants offered Smoke Free even downloaded it. Engagement statistically mediates efficacy (iCanQuit). Lapses are the highest-risk moment for both relapse and dropout.

### Cited Findings
- Baumel A, Muench F, Edan S, Kane JM. *Objective User Engagement With Mental Health Apps: Systematic Search and Panel-Based Usage Analysis.* J Med Internet Res 2019;21(9):e14567. [DOI 10.2196/14567](https://www.jmir.org/2019/9/e14567). [V]
  - 93 apps, median 100,000 installs.
  - **Median 15-day retention 3.9% (IQR 10.3%); 30-day retention 3.3% (IQR 6.2%)**. Median daily active users 4.0%.
  - **Breathing-exercise apps: DAU 1.6%, day-30 retention 0.0% (IQR 0.0%)**.
  - Peer-support apps had about 8.9% day-30 retention, mindfulness/meditation 4.7%, trackers 6.1%.
- A secondary source summarizes this as "more than 80% lost within 10 days". That figure was not verified in the primary source. — [textbookofdigitalhealth.com](https://www.textbookofdigitalhealth.com/references/baumel2019engagement.html) [V as secondary claim only]
- Smoke Free offer: 25.3% uptake among randomized, motivated smokers. — [Jackson 2024](https://medrxiv.org/content/10.1101/2023.01.12.23284463.full.pdf) [V]
- iCanQuit: about 37 vs 10 mean openings over 12 months. Engagement indicators mediated the effect on cessation. — [Bricker 2021 JMIR mHealth](https://mhealth.jmir.org/2021/11/e32847/PDF) [V]
- Notification response decays [PK]:
  - Klasnja P et al. *Efficacy of Contextually Tailored Suggestions for Physical Activity: A Micro-randomized Optimization Trial of HeartSteps.* Ann Behav Med 2019;53(6):573–582. DOI 10.1093/abm/kay067. The proximal effect of suggestions on step count diminished over study days, consistent with habituation.
  - Bidargaddi N et al. *To Prompt or Not to Prompt? A Microrandomized Trial of Time-Varying Push Notifications.* JMIR mHealth uHealth 2018;6(11):e10123. DOI 10.2196/10123. Notifications produced small, time-dependent increases in proximal engagement.
- Lapse dynamics [PK]:
  - Kirchner TR, Shiffman S, Wileyto EP. *Relapse dynamics during smoking cessation: recurrent abstinence violation effects and lapse-relapse progression.* J Abnorm Psychol 2012;121(1):187–197. DOI 10.1037/a0024451.
  - Kenford SL et al. *Predicting smoking cessation: who will quit with and without the nicotine patch.* JAMA 1994;271(8):589–594. Smoking in the first 2 weeks strongly predicts failure.
- Engagement concepts: Perski O, Blandford A, West R, Michie S. *Conceptualising engagement with digital behaviour change interventions.* Transl Behav Med 2017;7(2):254–267. DOI 10.1007/s13142-016-0453-1 [PK].

### Inferences
- **"Streak" mechanics are a double-edged sword.** A days-smoke-free counter that resets on a lapse can trigger an abstinence-violation effect and lead to uninstalling. Lapse handling ("lapse ≠ relapse", keep cumulative smoke-free days, a "recovery" state on the avatar) is a retention feature, not only a clinical one.
- **The breathing feature should not be a standalone destination.** Given 0.0% median day-30 retention for breathing apps, embed it inside urge-surfing and craving SOS flows.
- **Notification budget:** HeartSteps habituation plus JITAI prompts plus EMA prompts create a combined interruption load. Set a hard cap, for example ≤3 proactive prompts per day including EMA, and let an MRT tune it.
- **The engagement multiplier dominates expected impact.** If only about 25% install and about 3–15% are active at day 30, then even a large per-user effect yields a small population effect (see section 5, optimization function).

### Gaps
- I found no cessation-specific, real-world D1/D7/D30 retention benchmark (for example from Smoke Free or QuitNow! telemetry). Baumel covers mental-health apps generally; cessation apps may retain better around the quit date.
- I found no published data quantifying app dropout *immediately after a logged lapse*. This is a key unknown worth instrumenting from day 1.
- Notification-fatigue thresholds specific to smokers were not found.

---

## 5. Fischbach & Walsh framework applied: assumptions, red flags, go/no-go tests, optimization function, parameter strategy, pivots

### Takeaway
**As currently scoped, with about 12 features fixed together, the project is a RED light under the framework.** It has ≥7 assumptions at risk 4, it depends on "multiple miracles" (estimated lung age motivates, ApBM works on a phone, JITAI from 5–7 days, D30 retention, bundle additivity), and its main efficacy readout is late (18–30 months). It becomes **YELLOW-to-GREEN** if the team:
1. Fixes **one parameter**: the core user segment plus outcome (adult daily smokers ready to quit within 30 days → CO-verifiable sustained abstinence), and lets mechanisms float through MOST.
2. Runs three go/no-go tests in months 0–6: retention, visualization mechanism, and JITAI predictability with a mic-detection sub-gate. A regulatory claims gate runs alongside them.
3. Keeps evidence-anchored components (ACT urge surfing, NRT support, lapse handling) as the default core.

### Cited Findings (calibration evidence used in the scoring below)
- Global burden (WHO, 6 Oct 2025): **1.2 billion tobacco users in 2024**, down from 1.38 billion in 2000. One in five adults uses tobacco. Men are more than four in five users. More than 100 million people vape, including at least 86 million adults and at least 15 million children aged 13–15. Female prevalence was 11% in 2010 and 6.6% in 2024. — [WHO news release](https://www.who.int/news/item/06-10-2025-who-tobacco-trends-report-1-in-5-adults-still-addicted-to-tobacco); [PAHO](https://www.paho.org/en/news/6-10-2025-who-tobacco-trends-report-1-5-adults-still-addicted-tobacco) [V]
- WHO 2024 trends report (16 Jan 2024; ISBN 978-92-4-008828-3) has 2022 estimates and projections to 2030 ([WHO](https://www.who.int/publications-detail-redirect/9789240088283)) [V]. A secondary summary gives smoking prevalence among people ≥15 as 32.7% (2000), 21.7% (2020) and a projected 18.1% (2030) — [Generations Sans Tabac](https://www.generationsanstabac.org/en/?p=18917) [V secondary].
- Deaths: tobacco "still claims over seven million lives a year" (2025 WHO global tobacco epidemic report summary, via search) [V secondary]. WHO's fact-sheet figure is "more than 8 million per year, including about 1.3 million non-smokers exposed to second-hand smoke" [PK]. The two numbers differ by whether second-hand-smoke deaths are included.
- Unaided success is about 3–5% (Hughes 2004 [PK]).
- Value of quitting [PK]:
  - Jha P et al. *21st-century hazards of smoking and benefits of cessation in the United States.* N Engl J Med 2013;368(4):341–350. DOI 10.1056/NEJMsa1211128. Smokers lose ≥10 years of life expectancy. Quitting at 25–34 gains about 10 years, at 35–44 about 9, at 45–54 about 6.
  - Doll R et al. BMJ 2004;328:1519, DOI 10.1136/bmj.38142.554479.AE. Stopping at 60, 50, 40 or 30 gains about 3, 6, 9 or 10 years.
- Calibration for specific components [PK unless marked]:
  - **ApBM / cognitive bias modification:** Boffo M et al. *Cognitive Bias Modification for Behavior Change in Alcohol and Smoking Addiction: Bayesian Meta-Analysis of Individual Participant Data.* Neuropsychol Rev 2019;29(1):52–78, DOI 10.1007/s11065-018-9386-4. No robust effect on behavior. Smoking ApBM trials (Wittekind CE et al. J Behav Ther Exp Psychiatry 2015;46:115–120; Wittekind CE et al. Behav Res Ther 2019;114:35–43; Machulska A et al. J Psychiatr Res 2016;76:44–51) show mixed reductions in consumption, mostly without abstinence effects.
  - **Slow/paced breathing:**
    - McClernon FJ, Westman EC, Rose JE. *The effects of controlled deep breathing on smoking withdrawal symptoms in dependent smokers.* Addict Behav 2004;29(4):765–772. Small acute reductions in some withdrawal and craving measures.
    - Lehrer PM, Gevirtz R. *Heart rate variability biofeedback: how and why does it work?* Front Psychol 2014;5:756, DOI 10.3389/fpsyg.2014.00756. Resonance breathing at about 0.1 Hz.
  - **Mic-based respiration:** Nam Y, Reyes BA, Chon KH. *Estimation of respiratory rates using the built-in microphone of a smartphone or headset.* IEEE J Biomed Health Inform 2016;20(6):1493–1501. Feasible in controlled conditions. No noisy-environment exhalation-phase benchmark was found.
  - **JITAI lapse prediction:**
    - Businelle MS et al. J Med Internet Res 2016;18(10):e275 (DOI 10.2196/jmir.6307): EMA-based imminent-lapse prediction.
    - Hébert ET et al. Drug Alcohol Depend 2021;218:108340 (DOI 10.1016/j.drugalcdep.2020.108340): machine-learning prediction of first lapse.
    - Hébert ET et al. J Med Internet Res 2020;22(3):e16907 (DOI 10.2196/16907): Smart-T2 JITAI pilot.
    - Perski O et al. Nicotine Tob Res 2023 (DOI 10.1093/ntr/ntad051): supervised ML classification of lapses using Smoke Free app data. Group-level models generalized poorly; individual-level models needed substantial per-person data [PK; verify exact AUCs].
  - **Self-monitoring reactivity:** McFall RM. J Consult Clin Psychol 1970;35(2):135–142. Monitoring cigarettes *smoked* tended to increase smoking, while monitoring urges *resisted* decreased it [PK; classic small study]. What gets logged matters.
  - **Behavioral economics:** Halpern SD et al. *Randomized trial of four financial-incentive programs for smoking cessation.* N Engl J Med 2015;372(22):2108–2117, DOI 10.1056/NEJMoa1414293. Deposit-contract programs were accepted by about 13.7% vs about 90% for reward programs. Real financial incentives increased abstinence. The effect of framing alone, without money, is not established.
  - **App plus pharmacotherapy:** OR 1.79 (1.38–2.33) — [JMIR 2023](https://www.jmir.org/2023/1/e43242) [V]. Pivot with NRT: 19% vs 9% continuous at 52 weeks — [Marler 2023](https://mhealth.jmir.org/2023/1/e48157/PDF) [V].
  - **ACT urge surfing:** OR 1.49 vs QuitGuide — [Bricker 2020](https://www.naquitline.org/news/531843/Efficacy-of-Smartphone-Applications-for-Smoking-Cessation-A-Randomized-Clinical-Trial.-.htm) [V].
  - **Regulatory analogs [PK]:**
    - Japan regulated CureApp SC as a medical device.
    - Under EU MDR 2017/745 Annex VIII Rule 11, software that provides information used for diagnostic or therapeutic decisions is at least class IIa.
    - Apple App Store Review Guideline 1.4.1 applies extra scrutiny to medical apps that could give inaccurate data, and requires accuracy claims to be backed by disclosed methodology.
    - The FDA *General Wellness* guidance (2016, revised 2019) and the *Policy for Device Software Functions and Mobile Medical Applications* (2019/2022) place many lifestyle/behavioral self-management apps under enforcement discretion. Whether "smoking cessation" claims count as disease claims (tobacco use disorder) is a key legal question [PK; verify current guidance, including any 2026 revision].

### Inferences

#### 5.1 Assumption analysis table
**Risk scale:** 1 = >90% likely true; 2 = 70–90%; 3 = 40–70%; 4 = 10–40%; 5 = <10%.
**Time** = months until the team can know, if a test is started now.

**Type A: assumptions about behavioral and biological reality** (will not change during the project)

| # | Assumption | Risk | Time (mo) | Calibrating evidence / rationale |
|---|---|---|---|---|
| A1 | Visualizing **reversible acute harm** (COHb, HR, endothelial, cilia recovery) motivates quit attempts in young smokers **more than Lung Age** does | **4** (for "more than"); 3 for "motivates at all" | 3–4 | No head-to-head trial found. Gain frames are only slightly better for prevention behaviors (Gallagher & Updegraff 2012 [PK], r≈0.08). Lung age had a positive effect in one RCT (Parkes 2008 [PK]). |
| A2 | A **questionnaire-estimated** Lung Age (no spirometry) reproduces Step2quit's motivational effect | **4** | 3–4 | Step2quit used measured FEV1 and a clinician encounter [PK]. Cochrane rates biomedical-feedback evidence low certainty (Clair 2019 [PK]). Estimated values may be discounted. |
| A3 | Displayed recovery timelines are physiologically defensible per user | 2 (COHb) / 3 (endothelial) / **4** (per-user cilia/HR timings) | 1–2 | CO half-life is hours [PK]. FMD improvement at 1 year (Johnson 2010 [PK]). Per-user cilia/HR timelines rest on leaflet-level evidence. |
| A4 | **Logging every cigarette** reduces automaticity and consumption | 3–4 | 2–3 | McFall 1970 [PK]: monitoring cigarettes smoked can *increase* smoking, monitoring resisted urges decreases it. Logging burden erodes adherence (Baumel 2019 [V]). |
| A5 | ACT urge surfing, as we implement it, improves cessation | **2** | 1–2 (proximal craving); 9–12 (distal) | iCanQuit OR 1.49 at 12 months vs active comparator, N=2,415 [V]. Engagement mediates [V]. |
| A6 | 0.1 Hz breathing reduces acute craving enough to bridge an urge | 3 | 1–2 | McClernon 2004 [PK]: small acute effects. HRV resonance mechanism (Lehrer & Gevirtz 2014 [PK]). Breathing apps have the worst retention (D30 median 0.0%) [V]. |
| A7 | **Smartphone ApBM swipe training** reduces smoking | **4** | 3–6 | IPD meta-analysis shows no robust CBM effect on behavior (Boffo 2019 [PK]). Smoking ApBM trials mixed [PK]. A swipe adaptation of the joystick paradigm is unvalidated. |
| A8 | BE framing (loss aversion, money saved, commitment) **without real money** increases abstinence | 3–4 | 3–6 | Real incentives work, but deposit contracts have about 14% uptake (Halpern 2015 [PK]). Framing alone is unproven. |
| A9 | Lapse handling prevents lapse → relapse and lapse → dropout | 3 | 3–6 | Lapses cascade (Kirchner 2012 [PK]). Early smoking predicts failure (Kenford 1994 [PK]). No app data on post-lapse dropout found. |
| A10 | In-app NRT adherence support increases correct NRT use and abstinence | 2–3 | 3–6 | App plus pharmacotherapy OR 1.79 [V]. Pivot plus NRT 19% vs 9% [V]. NRT RR about 1.55 (Cochrane [PK]). NRT access is heterogeneous worldwide. |
| A11 | Phenotype-based onboarding (tailoring) improves outcomes over a common path | 3–4 | 6 | No app-specific evidence retrieved. Tailoring evidence in other media is modest [PK, unspecific]. |
| A12 | Enough users stay engaged ≥30 days to receive an effective dose | **4** | 2–4 | Median D30 retention 3.3% [V]. Smoke Free uptake 25.3% when offered free [V]. iCanQuit about 37 openings per year in a paid trial cohort [V]. |
| A13 | **Personalized JITAI from 5–7 days of EMA** predicts high-craving or lapse moments well enough to act on (AUC ≥0.75, PPV ≥0.3) | **4** | 4–6 | Group models generalize poorly and individual models need more data (Perski 2023 [PK]). Pre-quit behavior differs from post-quit behavior (distribution shift; inference). Hébert 2021 and Businelle 2016 [PK]. |
| A14 | Users sustain EMA (≥3 per day) and tolerate prompts for ≥4 weeks without fatigue | 3–4 | 2–3 | HeartSteps habituation and Bidargaddi 2018 small proximal effects [PK]. Low DAU across apps [V]. |
| A15 | The ~10 components are **additive**, not burden-diluting | **4** | 9–12 | Full vs reduced Smoke Free favors more BCTs at 3 months [V]. No evidence for a 10-component stack. MOST screening is required. |
| A16 | **Distal efficacy:** the app produces CO-verified 6-month sustained abstinence RR ≥1.3 vs an active comparator | **4** | **18–30** | Cochrane apps RR 1.00 [V]. Smoke Free ITT RR 0.97 [V]. Chu 2026 RR 2.85 is low certainty [V]. iCanQuit is positive but self-reported [V]. |

**Type B: assumptions about technical capability** (may improve over time)

| # | Assumption | Risk | Time (mo) | Calibrating evidence / rationale |
|---|---|---|---|---|
| B1 | **Phone mic detects exhalation phase reliably**: ≥90% agreement in quiet, ≥80% at 60–70 dBA ambient noise (café, street, wind) | 2 (quiet) / **4** (noisy) | 1–2 | Respiratory-rate estimation from the built-in mic works in controlled settings (Nam 2016 [PK]). No noisy-field benchmark found. Device mic/AGC variability across Android OEMs (inference). |
| B2 | On-device model personalization (Core ML / TFLite on-device updates) is feasible within battery and privacy budgets | 2 | 2–3 | Engineering-feasible. The binding constraint is data quantity (A13), not compute (inference). |
| B3 | Passive context sensing (location, screen state, motion) works in the background on iOS and Android with acceptable consent rates | 3 | 1–2 | OS background limits and permission prompts (inference; no source retrieved). |
| B4 | Store approval and **legal positioning as general wellness** in all launch markets despite "Lung Age", "toxicity index", "craving prediction" and "NRT support" claims | 3 (US) / **4** (EU/UK) | 1–3 | Japan regulated CureApp SC as a device [PK]. EU MDR Rule 11 [PK]. Apple 1.4.1 [PK]. "Treats nicotine addiction" is a disease claim [PK]. |
| B5 | 3D lung avatar renders at ≥30 fps on low-end Android (2–3 GB RAM) | 2 | 1 | Standard mobile graphics engineering (inference). |
| B6 | A personal toxicity index can be computed from self-reported cigarettes with defensible uncertainty bands | 3 | 1–2 | Self-report under-reporting; CO boost varies with puff topography [PK]. Should be shown as a range, not a point. |
| B7 | Remote biochemical verification is feasible in target countries (BLE or mailed CO monitors; saliva cotinine; anabasine for NRT users) | 2–3 | 3–6 | Remote witnessed CO worked (Pivot [V]). CO subset sampling (Quit Genius [V]). Online follow-up only 41.9% (Smoke Free [V]). SRNT 2020 [PK]. |
| B8 | Global localization covers languages, local products (kretek, bidi, smokeless, e-cigarettes, dual use) and local NRT availability | 3 | 3–6 | Men are >80% of users. >100M vapers (WHO 2025 [V]). |
| B9 | Privacy compliance (GDPR special-category health data) is achievable through on-device processing | 2 | 1–2 | Inference. On-device design reduces exposure. |

**Risk profile summary**
- Total assumptions: 25.
- **Risk-4 count: 7 at a clean 4** (A1, A2, A7, A12, A13, A15, A16). Another 5–6 sit at 3–4 (A3-cilia/HR, A4, A8, A11, A14, B1-noisy, B4-EU).
- **Late high-risk: A16 at 18–30 months.**
- Critical dependency chain: **A13 (JITAI) ← A14 (EMA compliance) ← A12 (retention) → A16 (efficacy)**. A second chain is **B4 (regulatory) → A2 (personal Lung Age is allowed at all)**.
- Overall: **RED as scoped; YELLOW after de-scoping and gating.**

#### 5.2 Red flags (framework definitions)
1. **Multiple miracles (more than 2–3 assumptions at risk 4–5): yes, 7.** The product works only if estimated Lung Age motivates (A2) *and* phone ApBM works (A7) *and* JITAI predicts from about a week of data (A13) *and* users stay (A12) *and* the stack is additive (A15).
2. **Late high-risk test: yes.** Distal efficacy (A16) cannot be known before about 18–30 months. Recruiting takes 6–12 months, follow-up 6–12 months, and N needs to be about 2,000–7,000 (section 3 table).
3. **Dependency chain: yes.** JITAI value depends on EMA compliance, which depends on retention. The breathing feature's value depends on users opening it during cravings, which depends on retention plus JITAI or SOS prompting.
4. **Ostrich-pattern risk: high.** The most enjoyable and lowest-risk work (3D lung avatar B5, risk 2; rendering; UI) tempts the team to build first. Meanwhile retention (A12), mechanism (A1/A2) and prediction (A13) stay untested.
5. **Technique-application forcing:** "Use a lung avatar + JITAI + ApBM + mic breathing to make smokers quit, globally, as a wellness app" fixes system, tool, application and regulatory route all at once. This matches the framework's "Use X to do Y in Z" warning sign.

**Green-light features already present**
- The highest-evidence components (ACT urge surfing A5, NRT support A10) are low risk.
- Several high-risk assumptions (A1, A2, A12, A13, B1, B4) can be tested in **under 6 months** with cheap, crude experiments.
- Several features are droppable without killing the product: ApBM, BE framing, JITAI.

#### 5.3 Top-3 go/no-go experiments (plus two fast "gate-zero" checks)

**Gate 0a: regulatory claims gate (B4). Months 0–2.**
- Experiment: build a claims matrix covering every on-screen string and store-listing phrase, for example "Lung Age", "toxicity", "predicts cravings", "NRT dose reminders", "quit smoking". Get written regulatory opinions for the US (FDA wellness/enforcement discretion), EU (MDR Rule 11 / MDCG 2019-11) and UK (MHRA). Do a test submission to App Store and Google Play with medical-disclaimer copy.
- Go: all launch claims are classifiable as non-device or wellness in the launch markets.
- No-go → pivot P1: replace personal Lung Age with illustrative education (section 5.6).

**Gate 0b: mic exhalation-detection bench test (B1). Months 1–2.**
- Experiment: 30 participants × 4 noise conditions (quiet <40 dBA; home about 50 dBA; café about 65 dBA; street or wind ≥70 dBA) × ≥6 phone models, iOS plus low/mid-range Android. Reference: chest respiratory belt or nasal thermistor.
- Go: ≥90% inhale/exhale phase agreement in quiet and ≥80% at about 65 dBA, with a false "exhale detected" rate below 10%.
- No-go → pivot P2: haptic/visual-only pacer.

**Go/No-Go #1: retention and engagement dose (A12, A14). Months 1–4.**
- Experiment: soft-launch a *minimal* MVP (light cigarette/urge logging, ACT urge surfing, craving SOS with breathing embedded, lapse handling, one visualization) in 2–3 markets with paid acquisition, for ≥2,000 installs. Analyze the cohort who set a quit date within 14 days.
- Measures: D7 and D30 retention (≥1 meaningful session); the share reaching a pre-registered "minimum effective dose" (for example ≥3 urge-tool uses plus ≥5 active days in the first 2 weeks after the quit date); EMA completion; self-reported 4-week abstinence; post-lapse dropout.
- **Go:** D30 ≥15% of quit-date setters *and* ≥40% reach the minimum effective dose *and* EMA completion ≥60% at week 4.
- **Pivot:** D30 of 8–15% → strip components and add a human or SMS channel (P4).
- **Stop/rethink:** D30 <8%.
- Basis for thresholds: they are this researcher's heuristics, set at about 4–5× the Baumel median of 3.3% because quit-date setters are a motivated cohort. **No cessation-specific benchmark was found (Gap).**
- Power: detecting a 10% → 15% D30 difference between two onboarding variants needs about 690 per arm (computed).

**Go/No-Go #2: visualization mechanism (A1, A2, A3). Months 1–4.**
- Experiment: online randomized 2×2 factorial, n≈1,200 adult daily smokers through a research panel, about 50% aged 18–29. Factor 1: estimated Lung Age on/off. Factor 2: reversible-toxicity recovery dashboard on/off. Both arms get the same core app.
- Outcomes: self-reported quit attempt by 4 weeks (primary); CO-verified 4-week abstinence in a subsample; Motivation To Stop Scale; days of app use; reactance and defensive-avoidance scales.
- Factorial efficiency means each main effect compares about 600 vs 600. That detects a 20% → 27.5% difference in quit attempts with 80% power (computed n=505 per group).
- **Go:** a factor increases quit attempts by ≥5 percentage points (RR ≥1.25) with no increase in reactance. The winner becomes the "hero" feature. Test the interaction for young vs older smokers.
- **No-go:** neither factor beats control → demote visualization to an engagement and feedback layer, make no motivational claims, and move effort to NRT or human support.

**Go/No-Go #3: JITAI predictability (A13, with B2/B3). Months 2–6.**
- Experiment: 8-week observational EMA plus passive-sensing study, n≈120 quit-date setters. About 6 EMA prompts per day (craving 0–10, affect, context, smoking) plus passive signals. Train per-user models on days 1–7, including pre-quit days. Test prospectively on post-quit days 8–42.
- **Go:** median within-person AUC ≥0.75 for a high-craving episode (≥7/10) or lapse in the next 60–120 minutes. At ≤3 prompts per day: PPV ≥0.30 and sensitivity ≥0.50. EMA compliance ≥65% at week 4.
- **No-go:** ship rule-based or user-scheduled "high-risk windows" learned from the user's own logs, plus a one-tap SOS. Move JITAI to a v2 MRT once more data per person exists (P3).
- The dataset itself is a publishable asset (inversion strategy 3).

**Revised timeline**
- Months 0–6: Gates 0a/0b, #1, #2 and #3 run in parallel. No 3D-avatar polish until #2 reads out.
- Months 6–18: MOST optimization. A 2^5 factorial screening of surviving components on CO-verified 4-week abstinence and quit attempts. A parallel MRT on prompt timing and breathing prompts. Optional SMART for early lapsers (escalate to NRT or human coaching).
- Months 18–36: pivotal RCT (section 3 design), with interim engagement monitoring.

#### 5.4 Optimization function (framework 3: invention/application = "how much good × for how many people")
- **Framework:** invention/application. Proposed custom metric: **incremental CO-verified 6-month quitters per 1,000 installs, and cost per incremental quitter**, multiplied by the age-weighted life-years gained per quitter.
- **How many people (reach axis): HIGH potential, LOW realized by default.**
  - 1.2 billion tobacco users (WHO 2025 [V]), more than 100 million vapers [V], and very low marginal cost per user.
  - But realized reach equals installs × quit-date setting × D30 engagement. With about 25% uptake (Smoke Free [V]) and single-digit D30 retention (Baumel [V]), the default is non-use. The framework's own warning applies: "the default state of every new technology is non-use."
- **How much good (depth axis): VERY HIGH per quitter, LOW-MEDIUM per user.**
  - Per quitter, quitting at 35–44 gains about 9 years of life expectancy and at 25–34 about 10 years (Jha 2013 [PK]).
  - Per user, the incremental absolute quit probability is about 1–3 percentage points for an app alone, or about 5–10 with NRT bundled (sections 1 and 3).
- **Worked illustration (assumptions explicit; not a forecast):**
  - Per 1,000,000 users who start a quit attempt, unaided long-term success of 3–5% (Hughes [PK]) gives about 30,000–50,000 quitters.
  - An app adding +1 to +3 points gives **about 10,000–30,000 additional long-term quitters**.
  - At about 6–9 life-years each (age mix; Jha/Doll [PK]), and before discounting for later relapse (unknown, see Gaps), that is **about 60,000–270,000 life-years per million attempters**.
  - The engagement multiplier dominates. Doubling the D30 dose-reaching fraction is worth more than any single content feature.
- **Threshold check:** the project scores at least medium-high on one axis (reach) *only if* the engagement problem is solved. Otherwise both axes are low-medium, which by the framework is "a problem". Hence Go/No-Go #1 is the first gate.
- **Equity sub-axis:**
  - Men are more than four in five users and most users live in low- and middle-income countries (WHO 2025 [V]). An English-first iOS-first launch optimizes the wrong population.
  - Low-end Android performance (B5) and SMS/WhatsApp fallbacks matter for the global claim.
  - Text messaging has the strongest pooled evidence of any mobile modality: RR 1.54, moderate certainty [V].

#### 5.5 Parameter strategy ("fix one parameter, let the others float")
**Current inventory: over-constrained.**

| Parameter | Current | Should be | Can float if a problem arises? |
|---|---|---|---|
| User segment + outcome (who and what success means) | Floating/implicit ("global smokers") | **FIXED**: adults (≥18) who smoke daily and intend to quit within 30 days. Outcome = CO-verifiable sustained abstinence. Proximal: 4-week abstinence, quit attempts | Narrow only (for example young adults, or dual users) |
| Core mechanism(s) (lung avatar, toxicity index, JITAI, ApBM, mic breathing, BE, phenotype onboarding) | Fixed as a bundle | **FLOAT**, with MOST screening deciding | Yes |
| Hero visualization (Lung Age vs reversible toxicity vs neither) | Fixed (both) | **FLOAT**, decided by Go/No-Go #2 | Yes |
| Prediction engine (on-device personalized JITAI) | Fixed | **FLOAT**: rule-based → JITAI after the MRT | Yes |
| Sensor modality (mic breath detection) | Fixed | **FLOAT**: mic, haptic-only or wearable HR | Yes |
| Channel (iOS/Android DTC app) | Fixed | Semi-fixed. Float to B2B (quitlines, employers, pharmacies, lung-cancer screening) or SMS/WhatsApp companion | Yes |
| Regulatory route (general wellness) | Fixed | Fix for v1, with claims engineered to fit. Keep an "evidence-ready" path to a device or DiGA-style route if efficacy is proven | Maybe |
| Geography ("global") | Fixed | **FLOAT**: start in 2–3 markets with high smartphone use and an available verification infrastructure; expand after gates | Yes |

**Recommendation:** fix the **segment-plus-outcome** parameter (the framework's "fix the application" option). This team is a product team with no unique proprietary mechanism. Its competitive advantage is speed of iteration and consumer UX, which suits "fix the problem, float the solution". The GLP-1 example says the same: fixing the delivery goal opens better solution options.

**Alternative ensemble, if the team's real edge is the visualization technology** (fix the tool, float the application). Lung-health visualization could serve:
- Lung-cancer-screening programs, where smokers with real CT or spirometry data are at a teachable moment.
- Primary-care spirometry, which mirrors the Step2quit protocol.
- Adolescent prevention.
- Vaping cessation.

The two choices are different projects. The team should choose explicitly.

**Project ensemble (core fixed = segment plus outcome):**
1. ACT urge surfing + NRT support + lapse handling + winning visualization → DTC app (base case).
2. The same core + a human coach or quitline → B2B employer or health system (if retention is low).
3. The same core + SMS/WhatsApp delivery → LMIC public-health partners (if smartphone engagement is low or the equity goal dominates).
4. The same core + real measurement (BLE CO monitor or clinic spirometry) → evidence-grade or device route (if the regulator or payer demands measurement).

#### 5.6 Decision tree, adversity playbook and problem-inversion pivots

| Trigger (when) | Likelihood / impact | Pivot (framework strategy) | Upgrade opportunity |
|---|---|---|---|
| **P1. Lung Age or toxicity claims are deemed device or diagnostic functions** in the EU/UK/US, or the store rejects them (Gate 0a, months 0–2) | Medium / High | *Unfix the claim:* replace personal Lung Age with **illustrative education** ("what typically happens in a smoker's lungs" at population level), plus personal *exposure* metrics (pack-years, cigarettes avoided, CO-cleared timer as an estimate with ranges) without diagnostic language. *Comparable goal B:* partner with clinics or screening programs that measure real spirometry/CO (Step2quit model) | Removes regulatory exposure and also the credibility risk of estimated numbers. Creates a B2B channel |
| **P2. Mic DSP is unreliable** in noise (Gate 0b, months 1–2) | Medium-High / Low-Medium | *Unfix the sensor:* **haptic plus visual 0.1 Hz pacer** with no detection. Optional wearable HR/HRV (Watch/BLE) for biofeedback where available. Self-confirmation taps | Simpler, accessible, works for deaf/hard-of-hearing users and in public. Removes the microphone permission and its privacy friction |
| **P3. JITAI accuracy is insufficient** (Go/No-Go #3, months 2–6) | Medium-High / Medium | *Comparable goal:* user-scheduled and rule-based risk windows plus a one-tap SOS (user-initiated support is always available). *Answer → question (strategy 3):* publish the EMA/sensing dataset ("what predicts first-week lapses?") and run an MRT on prompt timing | Lower notification fatigue. A data asset that enables v2 JITAI once enough per-user data has accumulated |
| **P4. D30 retention below 8–15%** (Go/No-Go #1, months 1–4) | High / High | *Unfix the channel:* add human support (coach, quitline handoff). Pelago and Pivot both use coaching. Or move delivery to text messaging, the strongest pooled mobile modality (Cochrane RR 1.54 [V]). Strip the feature count | Simplification typically improves engagement. B2B gives distribution, which solves the Smoke Free uptake problem |
| **P5. Neither visualization beats control** (Go/No-Go #2, months 1–4) | Medium / Medium | Visualization stays as an engagement and feedback layer only. The hero mechanism becomes ACT urge surfing plus NRT support (evidence-anchored) | Frees the roadmap. Prevents misleading claims |
| **P6. ApBM or BE framing shows no main effect in MOST screening** (months 6–18) | High (ApBM) / Low | Drop the component. The factorial result itself is informative | Reduces user burden and build cost |
| **P7. Distal RCT is null at ITT** (Smoke Free pattern; months 18–30) | Medium / High | *Comparable goal:* reposition as **"app + pharmacotherapy adherence"** (app plus pharmacotherapy OR 1.79 [V]; Pivot [V]). Partner with NRT distributors or pharmacies. *Answer → question:* analyze dose-response and uptake mediators to design an uptake-optimized v2 | Converts a null into a pharmacotherapy-adherence product with a clearer value story for payers |
| **P8. Global launch spreads the team too thin** (localization, B8) | High / Medium | *Unfix geography:* 2–3 launch markets, then expand. Prioritize markets with high prevalence and limited cessation services once gates pass | Allows proper cultural adaptation (local products, dual use, male-majority users) |

**Altitude rhythm** (decision-tree skill): hold a weekly Level-2 review of gate metrics, a monthly field scan of new trials (for example a Cochrane CD006611 update or new JITAI MRT results), and a quarterly Level-4 portfolio decision (go/pivot/stop).

### Gaps
- Regulatory classification of "estimated Lung Age" and a "toxicity index" under the current FDA General Wellness guidance (possibly revised in 2026), EU MDR/MDCG and UK MHRA could not be verified this session. Specialist counsel is required (Gate 0a).
- Cessation-specific engagement benchmarks (D7/D30) and post-lapse dropout rates were not found. The thresholds in Go/No-Go #1 are heuristics.
- Exact AUC and PPV values from published smoking-lapse prediction studies (Perski 2023, Hébert 2021, Businelle 2016) were not re-verified, so the A13 risk score rests on qualitative recall.
- Relapse after 12 months among app-assisted quitters (needed to discount life-year estimates) was not retrieved.
- Global smartphone ownership among smokers, and NRT availability and affordability by country, were not retrieved. Both are needed to size realistic reach for the optimization function.
- No search budget remained to verify Graham 2024 (adolescent vaping RCT) figures, WHO Florence/S.A.R.A.H. details, CureApp SC figures, or the current status of Clickotine, Kwit, QuitNow!, Flamingo, the NHS app and Quit Coach.
