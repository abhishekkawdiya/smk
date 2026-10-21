# Section 2.2 + ML half of Section 5.2: JITAIs, EMA, and on-device craving/lapse prediction for smoking cessation

**Verification note for the report writer (read first).** Research conditions for this section were constrained: every full-text fetch (PMC, PubMed, JMIR, PLOS, OUP, ClinicalTrials.gov, TensorFlow/LiteRT and ONNX Runtime docs) failed (DNS error or a 403 from the egress proxy), and the shared web-search budget ran out after about 25 searches. Items tagged **[V]** were confirmed this session from search-engine summaries of the primary source (abstracts, registries or publisher pages). Items tagged **[M]** come from the researcher's prior knowledge of a well-known primary paper. They are cited to the canonical DOI but were **not re-verified this session**, and any number marked [M] must be checked against the full text before publication. Numbers I could not recall with confidence are in the Gaps sections, not the findings. Nothing has been invented. Wherever summaries of the same paper disagreed, both readings are given.

---

## Q1. JITAI framework (Nahum-Shani et al. 2018) and micro-randomized trials (Klasnja et al. 2015)

### Takeaway
A JITAI is a set of decision rules. At each **decision point**, the rules map **tailoring variables** (the person's state and context) onto one of several **intervention options**, which always include delivering nothing, in order to change a **proximal outcome** that leads toward a **distal outcome**. Micro-randomized trials (MRTs) give each person random assignment at every decision point, which is the standard way to tune those rules empirically. Smoking cessation already has one MRT, Sense2Stop.

### Cited Findings
- **[V] Citation:** Nahum-Shani I, Smith SN, Spring BJ, Collins LM, Witkiewitz K, Tewari A, Murphy SA. "Just-in-Time Adaptive Interventions (JITAIs) in Mobile Health: Key Components and Design Principles for Ongoing Health Behavior Support." *Ann Behav Med* 2018;52(6):446–462. DOI 10.1007/s12160-016-9830-8. — [Google Scholar record](https://scholar.google.com/scholar_lookup?doi=10.1007/s12160-016-9830-8)
- **[V]** In this framework a JITAI targets conditions that represent *vulnerability* to an adverse proximal outcome and/or an *opportunity* to promote a desired proximal outcome. It also explicitly avoids intervening when support is unnecessary or potentially harmful. — [U-M d3c mobile health page](https://d3c.isr.umich.edu/mobilehealth/)
- **[V]** An adaptive intervention is "a sequence of decision rules that specify how the intensity or type of treatment should change depending on the patient's needs". Decision points and tailoring variables are the inputs to those rules. — [Harvard (S. Murphy) JITAI/MRT page](http://people.seas.harvard.edu/~samurphy/JITAI_MRT/jitai.html)
- **[M] The six components defined in the 2018 paper:**
  - **distal outcome:** the ultimate goal, e.g., sustained abstinence;
  - **proximal outcomes:** short-term mediators that the intervention targets directly;
  - **decision points:** times at which a decision about intervening is made;
  - **intervention options:** the types, sources, amounts and delivery modes of support, including "provide nothing";
  - **tailoring variables:** information about the person used to decide when and how to intervene;
  - **decision rules:** the rules linking tailoring variables to options at each decision point.

  The paper also adds **receptivity** (being able and willing to receive, process and use support) to vulnerability and opportunity as conditions a JITAI should detect. — [DOI 10.1007/s12160-016-9830-8](https://doi.org/10.1007/s12160-016-9830-8)
- **[M]** Klasnja P, Hekler EB, Shiffman S, Boruvka A, Almirall D, Tewari A, Murphy SA. "Microrandomized trials: An experimental design for developing just-in-time adaptive interventions." *Health Psychol* 2015;34(Suppl):1220–1228. DOI 10.1037/hea0000305. In an MRT each participant is randomized many times, at every decision point. The design estimates the *proximal (causal excursion) effect* of an option versus no option, and how that effect is moderated by time-in-study and context. It is the design behind HeartSteps. — [DOI](https://doi.org/10.1037/hea0000305)
- **[M]** HeartSteps MRT: Klasnja P, Smith S, Seewald NJ, et al. *Ann Behav Med* 2019;53(6):573–582. DOI 10.1093/abm/kay067. Contextually tailored activity suggestions were randomized at 5 decision points/day over about 6 weeks (N≈37). The proximal effect on 30-minute step count was positive early and **diminished with days in the study**, the textbook habituation signal for JITAIs. Exact effect sizes are not reproduced here; see Gaps. — [DOI](https://doi.org/10.1093/abm/kay067)
- **[V] Smoking MRT (Sense2Stop):** stressed and non-stressed minutes, as classified by on-phone wearable data, were randomized to a stress-management prompt or no prompt, with proximal outcomes measured over the next 2 hours. Details are under Q4. — [Battalio et al. 2021, PubMed](https://pubmed.ncbi.nlm.nih.gov/34375749/)
- **[V] Current state of the field:** Nahum-Shani I and Murphy SA, "Just-in-Time Adaptive Interventions: Where Are We Now and What Is Next?" (*Annual Review of Psychology*, listed as 2026), identify three problems:
  - people may be unable to engage with an intervention at the moment they need it most;
  - engagement with digital interventions as currently implemented is generally suboptimal;
  - "deterministic and fixed decision rules" limit a JITAI's capacity to accommodate unknown factors such as habituation or changing conditions.

  The review also notes that research on using social relationships in JITAIs is scarce. — [Annual Reviews](https://www.annualreviews.org/content/journals/10.1146/annurev-psych-121024-044244); [PubMed 40939059](https://pubmed.ncbi.nlm.nih.gov/40939059/)
- **[V] Effect size benchmark:** a meta-analysis of JITAIs and ecological momentary interventions (EMIs) for mental health found a small between-group effect, g = 0.15 (95% CI 0.05–0.26, p = 0.003). — [PubMed 41027677](https://pubmed.ncbi.nlm.nih.gov/41027677/)

### Inferences
- **Mapping the blueprint onto the six components:**
  - **Distal outcome:** biochemically verified sustained abstinence at 6 months, the outcome used by Quit Sense and Smart-T.
  - **Proximal outcomes:**
    - no lapse in the next 2–4 hours, matching Smart-T's 4-hour window and Sense2Stop's 2-hour window;
    - a drop in self-reported craving 15–60 minutes after a prompt;
    - engagement with the coping tool within 10 minutes.
  - **Decision points:**
    1. every 15–30 minutes during waking hours (a model check of passive context);
    2. each EMA or cigarette/craving log;
    3. each geofence dwell event;
    4. each user-initiated "craving now" tap.
  - **Tailoring variables:**
    - calibrated predicted risk from the model;
    - receptivity proxies (screen on, not driving, not asleep, not in a meeting per calendar);
    - prompts already sent today;
    - minutes since the last prompt;
    - the user's self-reported trigger profile.
  - **Intervention options:**
    - nothing;
    - a brief coping prompt (urge-surfing or breathing);
    - a context-specific plan reminder, e.g., an "if-then" plan for that geofence;
    - a social or support message;
    - a pharmacotherapy (NRT) use reminder.
  - **Decision rules:** a risk threshold, gated by a notification budget and a receptivity check (see Q8/Q9).
- To optimise the rules after launch, the app should keep a micro-randomized arm, for example randomization probability 0.3–0.6 for high-risk moments as in HeartSteps and Sense2Stop. Logging the randomization probability alongside each decision allows causal excursion effects to be estimated, which addresses the habituation problem the 2026 Annual Review raises.

### Gaps
- The full text of Nahum-Shani 2018 could not be fetched, so its exact wording, its worked smoking examples and its "design principles" list are recalled, not quoted.
- The exact HeartSteps effect sizes (steps per 30 minutes, per-day decay) are not verified, so none are reported.

---

## Q2. Quit Sense and Q Sense (Naughton et al.; Univ. of East Anglia / Cambridge)

### Takeaway
Quit Sense is the closest precedent for the blueprint's "pre-quit mindful baseline". Before the quit date, users train the app by logging each cigarette with its context. The app builds per-user GPS geofences around repeated smoking locations, then sends location- and cue-tailored support when the user dwells in one of those places after quitting. In the feasibility RCT (N = 209), verified 6-month sustained abstinence was 11.5% versus 2.9% (aOR 4.57, 95% CI 1.23–16.94). The estimate is imprecise and is undermined by a 39% saliva-sample return rate. **No full efficacy RCT was found in registries or literature as of this session.**

### Cited Findings
- **[V] Citations:**
  - The feasibility RCT: Naughton F et al. "An Automated, Online Feasibility Randomized Controlled Trial of a Just-In-Time Adaptive Intervention for Smoking Cessation (Quit Sense)." *Nicotine Tob Res* 2023;25(7):1319–1329. — [OUP](https://academic.oup.com/ntr/article/25/7/1319/7116281); [PMC10256891](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC10256891/)
  - The NIHR monograph: "A smoking cessation smartphone app that delivers real-time 'context aware' behavioural support: the Quit Sense feasibility RCT." *NIHR Public Health Research*, DOI 10.3310/KQYT5412. — [NIHR Journals Library](https://www.journalslibrary.nihr.ac.uk/phr/KQYT5412)
  - The trial registration is **ISRCTN12326962**, for the feasibility trial. — [ISRCTN PDF](https://www.isrctn.com/pdf/12326962)
  - The protocol was published in 2021. — [PMC8076923](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8076923/)
  - (The NTR DOI is believed to be 10.1093/ntr/ntad032. **[M] Verify this.**)
- **[V] Design:** smokers willing to quit were recruited through online paid adverts. They were randomized to usual care (a text-message referral to the NHS SmokeFree website) or usual care plus a text invitation to install Quit Sense. Most procedures were automated. Abstinence was verified by cotinine in posted saliva samples. — [PMC10256891](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC10256891/)
- **[V] Uptake and engagement:** 75% of the app arm installed the app and set a quit date. About half of app users engaged for more than 1 week (reported as 51% of installers). — [PMC10256891](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC10256891/)
- **[V] Outcomes:**
  - Biochemically verified 6-month sustained abstinence was **11.5% (12/104)** for Quit Sense versus **2.9% (3/105)** for usual care, adjusted OR **4.57 (95% CI 1.23–16.94)**.
  - Saliva return was **39%**, and the authors flag possible bias in verified rates.
  - Six-month self-reported outcome completion was **77% (160/209; 95% CI 71–82%)**.
  - There was **no evidence of between-group differences in the hypothesised mechanisms of action**.

  — [PMC10256891](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC10256891/); [NTR/OUP](https://academic.oup.com/ntr/article/25/7/1319/7116281?login=true)
- **[V] Learning phase:** before the quit attempt, users "train the app" by reporting each smoking incident in context, including which smoking cues were present, while the app records GPS coordinates. — [NIHR KQYT5412](https://www.journalslibrary.nihr.ac.uk/phr/KQYT5412); [protocol PMC8076923](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8076923/)
- **[V] Geofence creation rule:** in Quit Sense, a geofence forms when the user reports smoking **more than once in the same place**. The earlier Q Sense pilot required **more than four reports** in the same area. Version 2 lowered the frequency threshold and also creates new geofences around places where users report **lapses** after quitting. Users typically end up with several geofences. Search summaries did not give the geofence radius or the clustering algorithm. — [NIHR KQYT5412](https://www.journalslibrary.nihr.ac.uk/phr/KQYT5412); [Q Sense JMIR mHealth 2016](https://doi.org/10.2196/mhealth.5787)
- **[V] Trigger rule after the quit date.** The two sources describe it differently:
  - The protocol summary says support fires when the user enters a geofence **and remains for at least 5 minutes**, after which the app decides whether to trigger a message.
  - The 2025 process evaluation says support fires on entering and staying **between 1 and 15 minutes**, or again **after 3 hours** in the same place.

  Messages are tailored to that location and to the individual's location-specific smoking cues. The two descriptions may reflect a randomized or variable dwell time, or a change between versions. — [protocol PMC8076923](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8076923/); [Hope et al. 2025 BJHP, PMC12290499](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC12290499/)
- **[V] Privacy architecture:** Quit Sense is a native app that does not need an internet connection, or any sharing of location or other data, to operate outside research. This matters for the blueprint's on-device design. — [NIHR KQYT5412](https://www.journalslibrary.nihr.ac.uk/phr/KQYT5412)
- **[V] Q Sense pilot:** Naughton F et al. "A Context-Sensing Mobile Phone App (Q Sense) for Smoking Cessation: A Mixed-Methods Study." *JMIR mHealth uHealth* 2016, DOI 10.2196/mhealth.5787. Geofencing was a reliable and accurate way to identify smoking locations, and participants viewed geofence-triggered support positively. — [DOI](https://doi.org/10.2196/mhealth.5787); [PMC5045522](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5045522/)
- **[V] Process evaluation:** Hope A et al. "Smoking cessation supported by a smartphone app: A qualitative process evaluation of the Quit Sense feasibility RCT." *Br J Health Psychol* 2025, DOI 10.1111/bjhp.70010. Experiences were broadly positive, and the authors identify factors that led to disengagement. — [Wiley](https://bpspsychub.onlinelibrary.wiley.com/doi/full/10.1111/bjhp.70010)
- **[V] Full trial status:** searches for a 2024–2026 full Quit Sense efficacy RCT (ISRCTN or publications) returned only the feasibility trial and its outputs. — [search result set incl. ISRCTN12326962](https://www.isrctn.com/pdf/12326962)

### Inferences
- **Directly reusable patterns:**
  1. pre-quit per-cigarette logging that captures location plus cues;
  2. geofences that need at least 2 reports at a place, refreshed with post-quit lapse locations;
  3. dwell-time gating (≥1–5 minutes) so the app does not fire on pass-through;
  4. a re-trigger after a long dwell (3 hours);
  5. fully on-device processing.
- Quit Sense's personalisation is rule-based: location clusters plus the cues the user reported. That works with only about a week of data. The blueprint's ML model should be a layer on top of these rules, not a replacement for them; the 2026 Leppin/Perski finding under Q5 says the same.
- With roughly half of users engaging for more than a week, the baseline phase itself is a disengagement risk. Burden must be minimised, and the model must still work from a partial baseline (see Q7).

### Gaps
- Not obtained: the exact geofence radius, the clustering method, the number of trigger messages, daily caps, any message-content library, and the minimum length of the learning phase. Full text was blocked.
- I could not confirm whether a definitive Quit Sense RCT has been funded or registered, e.g., by NIHR. No evidence was found as of 2026-10-21.

---

## Q3. Smart-T, Smart-T2 and Smart-T3 (Businelle, Hébert, Kendzor et al.; Univ. of Oklahoma TSET Health Promotion Research Center)

### Takeaway
Smart-T estimates lapse risk from a **weighted 6-item EMA score**: urge, stress, cigarette availability, alcohol use, motivation to quit, and being near others who are smoking. It computes the score at every prompted EMA (5/day) and immediately delivers messages tailored to whichever risk factors are elevated. The original estimator flagged about **80% of lapses within the 4 hours before the lapse, at a false-positive rate of about 17%**. The **full RCT (JAMA Netw Open, Aug 2025; N = 454 low-income adults) showed 7-day point-prevalence abstinence (PPA) at 26 weeks of 16.4% versus 10.0% for NCI QuitGuide (intention-to-treat)**. This is the strongest efficacy evidence to date for a smoking-cessation JITAI.

### Cited Findings
- **[V] Lapse-risk estimator paper:** Businelle MS, Ma P, Kendzor DE, Frank SG, Vidrine DJ, Wetter DW. "Using Intensive Longitudinal Data Collected via Mobile Phone to Detect Imminent Lapse in Smokers Undergoing a Scheduled Quit Attempt." *J Med Internet Res* 2016;18(10):e275. DOI 10.2196/jmir.6307. Participants were socioeconomically disadvantaged smokers starting cessation treatment. Unweighted and weighted estimators were built and compared using ROC curves (Fig. 2), and both distinguished most lapsers within 4 hours of the first lapse. — [DOI](https://doi.org/10.2196/jmir.6307); [JMIR](https://www.jmir.org/2016/10/e275/)
- **[V] The six risk factors** in the Smart-T estimator: **urge, stress, cigarette availability, alcohol use, motivation to quit, and proximity to others smoking**. Each is weighted. — [JMIR 2016 e275](https://www.jmir.org/2016/10/e275/); [Hébert 2020 pilot RCT](https://doi.org/10.2196/16907)
- **[V] Performance:**
  - The NCT03740490 protocol summarises the estimator as identifying **80% of all smoking lapses within 4 hours of the lapse (false-positive rate = 17%)**. — [NCT03740490 protocol PDF](https://cdn.clinicaltrials.gov/large-docs/90/NCT03740490/Prot_SAP_000.pdf)
  - Two search summaries of the 2016 paper gave further figures that may be inconsistent:
    - (a) "having **≥3 lapse risk factors** flagged imminent lapse (within 4 hours) in **62%** of lapsers during the first week";
    - (b) "a cut-off of **1.0 on the weighted score** identified **62.0% (67/108)** of all EMAs collected within 4 hours of a lapse."
  - A fragment about the weighting of cigarette availability (subtracting 3 for "with difficulty", multiplying by 0.7) could not be checked and should **not** be implemented without the full text.

  — [ResearchGate PDF record](https://www.researchgate.net/publication/309202411_Using_Intensive_Longitudinal_Data_Collected_via_Mobile_Phone_to_Detect_Imminent_Lapse_in_Smokers_Undergoing_a_Scheduled_Quit_Attempt)
- **[V] Feasibility study:** Businelle MS, Ma P, Kendzor DE, Frank SG, Vidrine DJ, Wetter DW. "An Ecological Momentary Intervention for Smoking Cessation: Evaluation of Feasibility and Effectiveness." *J Med Internet Res* 2016;18(12):e321 (DOI believed to be 10.2196/jmir.6058, **[M] verify**). — [JMIR](https://www.jmir.org/2016/12/e321/); [PMC5187451](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5187451/)
  - **EMA schedule:** 5 prompted EMAs/day for 3 consecutive weeks (1 week pre-quit, 2 weeks post-quit).
  - Participants completed **87%** of prompted EMAs.
  - Participants received **about 102 treatment messages** over the 3 weeks.
  - **15% (9/59)** said 5 assessments/day was "too high".
  - **83% (49/59)** used or implemented the messages.
  - **97% (57/59)** rated the messages helpful.
- **[V] Message tailoring mechanism:** Hébert ET, Stevens EM, Frank SG, Kendzor DE, Wetter DW, Zvolensky MJ, Buckner JD, Businelle MS. *Addict Behav* 2018;78:30–35 (PubMed 29121530). Messages tailored to urge, cigarette availability or stress were followed by greater reductions in those same factors than untailored messages. The stress effect was non-significant within high-stress moments (p = 0.892). — [PubMed 29121530](https://pubmed.ncbi.nlm.nih.gov/29121530); [ScienceDirect](https://www.sciencedirect.com/science/article/abs/pii/S0306460317303970)
- **[V] Smart-T2 pilot RCT:** Hébert ET, Ra CK, Alexander AC, et al., Businelle MS. "A Mobile Just-in-Time Adaptive Intervention for Smoking Cessation: Pilot Randomized Controlled Trial." *J Med Internet Res* 2020;22(3):e16907. DOI 10.2196/16907. — [JMIR](https://www.jmir.org/2020/3/e16907/); [PMC7091024](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7091024/)
  - **Design:** three arms (Smart-T2, NCI QuitGuide, in-person clinic usual care), n = 27 per arm, N = 81, followed for 13 weeks (1 week pre-quit to 12 weeks post-quit).
  - **EMA:** 5 per day for 5 weeks on study phones, with **tailored messages delivered after each completed EMA**.
  - **Outcome:** CO-verified 7-day PPA at 12 weeks was 22% (6/27) for Smart-T2, 15% (4/27) for QuitGuide and 15% (4/27) for usual care. This was not powered for significance.
- **[V] Full RCT:** Hébert ET, Kendzor DE, Vidrine DJ, Langford JS, Kezbers KM, Montgomery A, Chen M, Frank-Pearce SG, Vesely SK, Chen S, Barrett ZCW, Businelle MS. "Just-in-Time Adaptive Intervention for Smoking Cessation in Low-Income Adults: A Randomized Clinical Trial." *JAMA Netw Open*, published 14 Aug 2025. DOI 10.1001/jamanetworkopen.2025.26691. Registration NCT03740490. — [JAMA Netw Open](https://jamanetwork.com/journals/jamanetworkopen/fullarticle/2837640); [PMC12355279](https://pmc.ncbi.nlm.nih.gov/articles/PMC12355279/); [DOI](https://doi.org/10.1001/jamanetworkopen.2025.26691)
  - **Population and conduct:** US adults with household income below 200% of the federal poverty line, enrolled Aug 2019 to Nov 2023.
  - **Randomization:** N = 454 (225 Smart-T, 229 QuitGuide). Mean age 52.0; 73.3% female.
  - **Treatment and follow-up:** both arms received NRT; follow-up lasted 27 weeks; the quit date was set 7 days after enrollment.
  - **Primary outcome:** biochemically verified 7-day PPA at 26 weeks post-quit was **16.4% (37/225) vs 10.0% (23/229)** (ITT), and **23.1% vs 14.3%** among complete cases.
  - Smart-T users used the app more and rated it more helpful.
  - **Limitations noted:** the fixed 7-day quit date limits generalisability, and QuitGuide participants had to use 2 separate apps.
  - **Naming caveat:** the JAMA paper calls the intervention "Smart-T", whereas a 2022 Frontiers secondary analysis of what appears to be the same program calls it "Smart-T2".
- **[V] Secondary mechanism analysis:** the Smart-T2 arm showed a weaker link between negative affect and smoking urges than the QuitGuide arm. — [Frontiers in Digital Health 2022, 10.3389/fdgth.2022.864003](https://www.frontiersin.org/journals/digital-health/articles/10.3389/fdgth.2022.864003/full)
- **[V] ML follow-up (time-to-first-lapse):** Hébert ET, Suchting R, Ra CK, et al., Businelle MS. "Predicting the first smoking lapse during a quit attempt: A machine learning approach." *Drug Alcohol Depend* 2021;218:108340. DOI 10.1016/j.drugalcdep.2020.108340. Participants were n = 74 clinic patients who completed EMAs 5×/day for 4 weeks after quitting. Time to lapse was modelled with Cox proportional hazards in three stages, using elastic net to select from **31 candidate predictors**; **7 predictors** were significant in univariate models. The paper models hazard and does not appear to report AUC. — [PMC8496911](https://pmc.ncbi.nlm.nih.gov/articles/PMC8496911/); [ScienceDirect](https://www.sciencedirect.com/science/article/abs/pii/S0376871620305056)
- **[V] Elastic-net Cox paper:** Suchting R, Hébert ET, Ma P, Kendzor DE, Businelle MS. "Using Elastic Net Penalized Cox Proportional Hazards Regression to Identify Predictors of Imminent Smoking Lapse." *Nicotine Tob Res* 2019. The list of selected predictors was not retrieved. — [PMC7962780](https://pmc.ncbi.nlm.nih.gov/articles/PMC7962780/)

### Inferences
- **Engineering takeaway:** a transparent, weighted, rules-based score over about 6 EMA items, computed at each EMA with immediate tailored messages, *has trial-proven efficacy*. That evidence comes from a 6.4-percentage-point absolute difference in 7-day PPA at 26 weeks against an active app comparator plus NRT. No ML lapse model has comparable trial evidence yet. The blueprint should therefore ship a **Smart-T-style rules score as the cold-start and fallback policy**, with the ML model added on top.
- **Message logic Smart-T implies:** after each EMA, find which of the 6 factors exceed their thresholds and select messages that target those factors, e.g., urge → urge-coping, availability → stimulus control, stress → stress-coping. Tailoring to the specific trigger is what Hébert 2018 linked to reductions in those triggers.
- **Evaluation metric:** the 4-hour look-ahead window, reporting the share of lapses preceded by a flag and the false-positive rate, gives the blueprint an event-level metric to report alongside AUC.

### Gaps
- The exact item weights, scoring formula, and risk tiers or thresholds of the Smart-T estimator are not obtained; the 2016 JMIR full text was blocked. The two "62%" summaries could not be reconciled.
- The message library and the per-tier message rules are not obtained.
- The JAMA 2025 secondary outcomes (30-day PPA, continuous abstinence), EMA compliance in the full trial, and message counts are not obtained.
- **Smart-T3:** no publication or registry record was found this session.
- A search-engine summary mentioned Langford JS, Hébert ET, Kendzor DE, Chen M, Vidrine DJ, Businelle MS, *Drug Alcohol Depend* 2025;276:112873, which compares the prospective Smart-T lapse-risk algorithm with participants' retrospective self-reports. No URL or abstract was retrieved, so the citation and its findings are unverified.
- The predictor list from Suchting 2019 is not obtained.

---

## Q4. Sense2Stop, puffMarker and wearable sensing

### Takeaway
Sense2Stop is the reference MRT for wearable-triggered support. It used chest-band ECG and respiration processed by **cStress on the phone**, classifying each minute as stressed or not and randomizing **2.5–3 stress-management prompts per day**. Proximal outcomes were stress and smoking over the next 2 hours. Its primary results were not located in peer-reviewed form; only a 2023 conference abstract is cited. puffMarker (chest respiration plus wrist IMU) is the canonical lapse *detector*, not a predictor. Among consumer wearables, the best smoking-lapse evidence is Fitbit heart rate plus steps, which raised group AUC from 0.899 to 0.952 in Perski 2024. **I found no 2023–2025 study predicting smoking craving or lapse from consumer-smartwatch HRV/EDA with an AUC reported.**

### Cited Findings
- **[V] Sense2Stop protocol:** Battalio SL, Conroy DE, Dempsey W, Liao P, Menictas M, Murphy S, Nahum-Shani I, Qian T, Kumar S, Spring B. "Sense2Stop: A micro-randomized trial using wearable sensors to optimize a just-in-time-adaptive stress management intervention for smoking relapse prevention." *Contemp Clin Trials* 2021;109:106534. — [PubMed 34375749](https://pubmed.ncbi.nlm.nih.gov/34375749/?dopt=Abstract); [ScienceDirect](https://www.sciencedirect.com/science/article/abs/pii/S1551714421002706)
  - **Sample and wear period:** 75 adult smokers wore chest and wrist sensors and used a smartphone app suite for **4 days pre-quit plus 10 days post-quit**.
  - **Real-time classification:** cStress ran on the smartphone to label each minute as probably stressed or not.
  - **Randomization:** stressed and non-stressed minutes were randomized to a prompt or no prompt, delivering **2.5–3 stress-management prompts/day**.
  - **Aims:** whether a prompt, compared with none, reduces the likelihood of (a) being stressed and (b) smoking in the **subsequent 2 hours**, and (c) whether current stress moderates these effects. The secondary hypothesis was a stronger effect when prompts arrive during stress.
- **[V] Results:** a 2023 conference abstract exists: Spring B, Nahum-Shani I, Battalio S, et al. "When should we prompt stress management for smokers attempting to quit? Results of the Sense2Stop microrandomized trial." *Ann Behav Med* 57(Suppl 1):S394. Its content could not be accessed. — [Annual Review of Clinical Psychology ref list](https://www.annualreviews.org/content/journals/10.1146/annurev-clinpsy-080822-042337)
- **[M] cStress:** Hovsepian K, al'Absi M, Ertin E, Kamarck T, Nakajima M, Kumar S. "cStress: towards a gold standard for continuous stress assessment in the mobile environment." *UbiComp* 2015:493–504. DOI 10.1145/2750858.2807526. The model uses ECG and respiration features from a chest band. Accuracy figures are not reproduced here. — [DOI](https://doi.org/10.1145/2750858.2807526)
- **[V] puffMarker:** Saleheen N, Ali AA, Hossain SM, Sarker H, Chatterjee S, Marlin B, Ertin E, al'Absi M, Kumar S. "puffMarker: a multi-sensor approach for pinpointing the timing of first lapse in smoking cessation." *UbiComp* 2015:999–1010. DOI 10.1145/2750858.2805832. Evaluated in **61 newly abstinent smokers**, using respiration plus 6-axis wrist inertial sensors. A citing paper reports **96.9% accuracy with 1.1% false positives** for distinguishing smoking from walking or eating; this is secondary reporting and not confirmed against the original. — [PubMed 26543927](https://pubmed.ncbi.nlm.nih.gov/26543927/); [Semantic Scholar](https://www.semanticscholar.org/paper/puffMarker:-a-multi-sensor-approach-for-pinpointing-Saleheen-Ali/0be8b0df675f97d21de95e766aef0b17a0be9c2b)
- **[V] Sensing platform:** the platform behind puffMarker and cStress is AutoSense (chest band, wristbands, ECG electrodes). — [JMIR mHealth 2024 scoping review "Sensors for Smoking Detection in Epidemiological Research"](https://mhealth.jmir.org/2024/1/e52383)
- **[V] Wrist-only detection:**
  - Tang Q, Vidrine DJ, Crowder E, Intille SS. "Automated detection of puffing and smoking with wrist accelerometers" (2014). — [Semantic Scholar](https://www.semanticscholar.org/paper/Automated-detection-of-puffing-and-smoking-with-Tang-Vidrine/a35403d91effbce27a495419349b2efb0fd4dc76)
  - Smartwatch accelerometer validation study, *JMIR mHealth uHealth* 2017. — [DOI 10.2196/mhealth.9035](https://doi.org/10.2196/mhealth.9035)
  - CNN-LSTM puff recognition, *Biomed Eng Lett* 2020. — [Springer](https://link.springer.com/article/10.1007/s13534-020-00147-8)
  - Performance numbers for these were not retrieved.
- **[V] StopWatch (smartwatch relapse intervention):** the feasibility and acceptability paper (*JMIR Formative Research* 2024) cites prior work showing smartwatch smoking detection with **78% sensitivity and 88% specificity**. Participants said the watch increased their *awareness* of smoking and motivated quitting. — [ScienceDirect/JMIR Form Res](https://www.sciencedirect.com/org/science/article/pii/S2561326X24006553)
- **[V] Consumer wearable plus EMA for lapse prediction:** Perski et al. 2024 (*PLOS Digit Health*) used a Fitbit Charge 4 worn during waking hours, providing heart rate and step count, not HRV or EDA. — [PMC11343380](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC11343380/); [PubMed 39178183](https://pubmed.ncbi.nlm.nih.gov/39178183/)

  | Model evaluation | EMA only | EMA + Fitbit |
  |---|---|---|
  | Best group-level AUC | **0.899** (95% CI 0.871–0.928) | **0.952** (0.933–0.970) |
  | Out-of-sample individuals, median AUC | **0.639** (range 0.524–0.994) | **0.745** |
- **[V] Related stress-detection evidence (stress, not smoking):**
  - A smartwatch review reports an SVM on heart-rate patterns reaching **AUROC 0.79** for detecting stress episodes. — [Algorithms 2025, 10.3390/a18070419](https://doi.org/10.3390/a18070419)
  - A 2025 systematic review found EDA sensors in **70%** of stress-detection ML studies. — [Comput Biol Med 2025 review](https://www.sciencedirect.com/science/article/pii/S0010482525015197)
- **[V] Stress-sensor lapse study:** "Using novel mobile sensors to assess stress and smoking lapse" (*Int J Psychophysiol* 2020) exists; its findings were not retrieved. — [ScienceDirect](https://www.sciencedirect.com/science/article/abs/pii/S0167876020302610)

### Inferences
- For a *global consumer* app, chest-band-grade signals such as cStress ECG and respiration are not available. The realistic passive features are phone context plus optional smartwatch data (heart rate, steps, activity state, sleep), read through Health Connect or HealthKit. HRV from consumer watches is sparse and noisy in the background. Treat wearable features as **optional model inputs that degrade gracefully**, and keep the core model EMA-plus-phone-context only.
- Smartwatch puff and hand-to-mouth detection, at roughly 78/88 sensitivity/specificity per StopWatch's citation, could **auto-suggest a log entry** ("Did you just smoke?") during the baseline. That would cut logging burden and recover missed cigarettes. It should not be used as ground truth.
- Sense2Stop's dose of about 2.5–3 randomized prompts/day is a published, ethically approved prompt budget for a stress-triggered smoking JITAI, and a reasonable starting cap.

### Gaps
- Sense2Stop's primary and secondary results were not retrieved, so it cannot be said whether stress-triggered prompts reduced 2-hour lapse risk.
- No consumer-wearable HRV/EDA smoking-craving or lapse prediction study from 2023–2026 with AUC was found; this may reflect the exhausted search budget rather than absence of evidence.
- The original puffMarker metrics (first-lapse timing accuracy) and the cStress accuracy figures were not verified.

---

## Q5. Other ML lapse and craving prediction work (performance, class imbalance, personalisation, cold start)

### Takeaway
Group-level models trained on EMA data report very high within-sample AUCs (**0.90–0.97**). Performance on **new individuals is much lower and highly variable** (median AUC about **0.64–0.75**, range 0.48–1.00). The most recent study (Leppin, Perski et al., *PLOS ONE* 2026) concludes that ML prediction **alone is unlikely to be sufficient for a real-world JITAI** and recommends combining it with rules. In this literature lapses are rare events (about 7.6% of entries in the largest dataset).

### Cited Findings
- **[V] Largest app dataset:** Perski O, Li K, Pontikos N, Simons D, Goldstein SP, Naughton F, Brown J. "Classification of Lapses in Smokers Attempting to Stop: A Supervised Machine Learning Approach Using Data From a Popular Smoking Cessation Smartphone App." *Nicotine Tob Res* 2023;25(7):1330–1339 (2022 preprint). — [OUP](https://academic.oup.com/ntr/article/25/7/1330/7086681?login=false); [PubMed 36971111](https://pubmed.ncbi.nlm.nih.gov/36971111/); [PMC10256890](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC10256890/)
  - **Data:** Smoke Free app "pro" users with **≥20 unprompted craving entries within 3 months** of registration; **N = 791**, **37,002 entries**, **7.6% lapses**.
  - **Features:** craving severity, mood, activity, social context, lapse incidence.
  - **Models:** group-level algorithms (Random Forest, XGBoost, others), then individual-level and hybrid algorithms.
  - **Results:** best group-level **AUC 0.969 (95% CI 0.961–0.978)**. Out-of-sample individuals ranged from **AUC 0.482 to 1.000** ("poor to excellent").
- **[V] EMA plus sensors:** Perski et al. *PLOS Digit Health* 2024 (DOI 10.1371/journal.pdig.0000594). — [PLOS DH](https://journals.plos.org/digitalhealth/article?id=10.1371%2Fjournal.pdig.0000594); [UCL Discovery](https://discovery.ucl.ac.uk/id/eprint/10196205/)
  - **Data:** **38 participants**; **16 hourly EMAs/day for 10 days** covering craving, mood, activity, social context, physical context and lapses; Fitbit Charge 4.
  - **Results:** best group model (Random Forest) AUC 0.899 → 0.952 with sensors. Out-of-sample individuals: median 0.639 → 0.745; without sensors the per-person range was 0.524–0.994.
- **[V] Burden versus accuracy:** Leppin C, Brown J, Garnett C, Kale D, Okpako T, Simons D, Perski O. "Optimising supervised machine learning algorithms predicting cigarette cravings and lapses for a smoking cessation just-in-time adaptive intervention (JITAI)." *PLOS ONE* 2026;21(5):e0349028. DOI 10.1371/journal.pone.0349028 (medRxiv preprint Aug 2025, 10.1101/2025.08.07.25333190). — [PLOS ONE](https://journals.plos.org/plosone/article?id=10.1371%2Fjournal.pone.0349028); [PMC13175349](https://pmc.ncbi.nlm.nih.gov/articles/PMC13175349/); [medRxiv](https://www.medrxiv.org/content/10.1101/2025.08.07.25333190v1.full)
  - **Data:** 37 participants, 16 EMAs/day for the first 10 days of a quit attempt.
  - Lapse prediction outperformed craving prediction; median ROC-AUC for lapses was **0.659**.
  - Out-of-sample performance was "on average, modest".
  - **Reducing the feature set had negligible impact on lapse prediction** but slightly lowered craving performance. That is direct evidence that a shorter, lower-burden EMA can be used.
  - **Conclusion:** ML "alone is unlikely to be sufficient… may be best combined with complementary rules-based approaches."
- **[V] Smart-T lineage:** this work uses Cox and elastic-net hazard models, not classifiers.
  - Hébert 2021: 31 predictors, 7 significant univariately, n = 74.
  - Suchting 2019: elastic-net Cox.
  - The Smart-T weighted rule score: 80% of lapses flagged within 4 hours, 17% FPR.

  See Q3. — [PMC8496911](https://pmc.ncbi.nlm.nih.gov/articles/PMC8496911/); [PMC7962780](https://pmc.ncbi.nlm.nih.gov/articles/PMC7962780/)
- **[V] Reviews (content not retrieved):**
  - "Harnessing machine learning in contemporary tobacco research" (2024). — [PMC11750557](https://pmc.ncbi.nlm.nih.gov/articles/PMC11750557/)
  - "Are Machine Learning Methods the Future for Smoking Cessation Apps?" *Sensors* 2021;21(13):4254. — [DOI 10.3390/s21134254](https://doi.org/10.3390/s21134254)
- **[M] Classic EMA lapse antecedents (Shiffman):**
  - Shiffman S, Paty JA, Gnys M, Kassel JA, Hickcox M. "First lapses to smoking: within-subjects analysis of real-time reports." *J Consult Clin Psychol* 1996;64(2):366–379. Lapses were compared with temptation episodes the person resisted. Negative affect, the presence of smoking cues and others smoking, and eating or drinking were salient antecedents. — [DOI 10.1037/0022-006X.64.2.366](https://doi.org/10.1037/0022-006X.64.2.366)
  - Shiffman S, Waters AJ. "Negative affect and smoking lapses: a prospective analysis." *J Consult Clin Psychol* 2004;72(2):192–201. Lapses were preceded by rising negative affect over the preceding hours, not by slowly changing daily mood. — [DOI 10.1037/0022-006X.72.2.192](https://doi.org/10.1037/0022-006X.72.2.192)
- **[M] Ad-lib smoking antecedents (relevant to the pre-quit baseline):** Shiffman S, Gwaltney CJ, Balabanis MH, et al. "Immediate antecedents of cigarette smoking: an analysis from ecological momentary assessment." *J Abnorm Psychol* 2002;111(4):531–545. Smoking occasions were compared with random non-smoking moments within subjects. Smoking was associated with urge, with being where smoking was allowed or others were smoking, and with eating or drinking (coffee, alcohol). It was only weakly related to affect during ad-lib smoking. — [DOI 10.1037/0021-843X.111.4.531](https://doi.org/10.1037/0021-843X.111.4.531)
- **[M] Imbalanced-data evaluation:** Saito T, Rehmsmeier M. "The precision-recall plot is more informative than the ROC plot when evaluating binary classifiers on imbalanced datasets." *PLOS ONE* 2015;10(3):e0118432. — [DOI](https://doi.org/10.1371/journal.pone.0118432)
- **[M] Oversampling:** Chawla NV, Bowyer KW, Hall LO, Kegelmeyer WP. "SMOTE: Synthetic Minority Over-sampling Technique." *J Artif Intell Res* 2002;16:321–357. — [DOI 10.1613/jair.953](https://doi.org/10.1613/jair.953)

### Inferences
- **What the AUC gap means:** the gap between group-level within-sample AUC (0.90–0.97) and out-of-sample individual AUC (median 0.64–0.75) is the key engineering fact. Pooled random train/test splits leak each person's patterns into both sets and inflate AUC. The blueprint should **validate with leave-one-subject-out or time-forward splits** and report per-user AUC distributions.
- **Cold start:** begin with (1) a Smart-T-style rule score and (2) a population prior model. Then (3) personalise during and after the baseline with a hybrid approach: population features plus per-user intercepts and slopes, or fine-tuning only the last layer. Perski 2023 tested individual and hybrid models, but their comparative results were not retrieved.
- **Class imbalance:** in the baseline, every logged cigarette is a positive, so positives are not rare (perhaps 10–20/day against 4–6 random negative prompts). After quitting, lapses are rare, at about 7.6% of entries in Perski 2023. Handle this with class weights or focal loss rather than SMOTE on time series. Choose thresholds on PR curves and a notification budget, not at 0.5. Report PR-AUC, Brier score and event-level recall.
- **Fewer EMA items:** Leppin 2026 found that reducing features barely changed lapse prediction. That supports a short EMA of about 4–6 items, the same order as Smart-T's 6-item score.

### Gaps
- Per-paper sensitivity, specificity and PR-AUC at chosen thresholds were not retrieved for Perski 2023, Perski 2024 or Leppin 2026, nor the individual-versus-hybrid results.
- "Bae et al. 2018 (passive sensing)" could not be verified as a smoking study. The Bae et al. 2018 paper I know of is phone-sensor detection of *alcohol* use in young adults (*Addict Behav*), and it was not retrieved.
- No 2023–2026 deep-learning (GRU/TCN/Transformer) smoking-lapse EMA study with AUC was retrieved. Searches ran out before this could be checked.
- No published smoking-specific transfer-learning or federated-learning study was retrieved.

---

## Q6. Habit and automaticity: does logging every cigarette reduce smoking or disrupt automaticity?

### Takeaway
There is **no direct evidence that logging cigarettes changes striatal habit circuitry**. The dorsal-striatum "action to habit to compulsion" account (Everitt & Robbins) is neuroscience *theory*, mostly from animal studies. Behaviourally, self-monitoring is a standard behaviour-change technique, and early studies show small or **direction-dependent** reactivity. EMA reactivity in smoking studies is generally small. The blueprint should present the baseline as **awareness and training data collection**, not as a proven automaticity-disrupting treatment. It must not schedule logging as a reduction-to-quit method, because abrupt quitting outperformed gradual reduction in the largest RCT.

### Cited Findings
- **[M] Early reactivity evidence:** McFall RM. "Effects of self-monitoring on normal smoking behavior." *J Consult Clin Psychol* 1970;35(2):135–142. Reactivity depended on *what* was monitored: recording cigarettes smoked tended to increase smoking, while recording urges resisted tended to decrease it. Samples were small. — [DOI 10.1037/h0030087](https://doi.org/10.1037/h0030087)
- **[M] Small reactivity in EMA:**
  - Shiffman S. "Ecological momentary assessment (EMA) in studies of substance use." *Psychol Assess* 2009;21(4):486–497. EMA reactivity in substance-use studies is generally small or not detected. — [DOI 10.1037/a0017074](https://doi.org/10.1037/a0017074)
  - Rowan PJ, Cofta-Woerpel L, Mazas CA, et al. "Evaluating reactivity to ecological momentary assessment during smoking cessation." *Exp Clin Psychopharmacol* 2007;15(4):382–389. Found little evidence of reactivity. — [DOI 10.1037/1064-1297.15.4.382](https://doi.org/10.1037/1064-1297.15.4.382)
- **[V] Mechanism evidence from a JITAI trial:** Quit Sense found **no between-group differences in hypothesised mechanisms of action** despite its pre-quit logging phase. — [PMC10256891](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC10256891/)
- **[V] Awareness:** StopWatch participants said smartwatch detection increased their *awareness* of smoking. This is qualitative, not an effect on smoking. — [JMIR Form Res 2024](https://www.sciencedirect.com/org/science/article/pii/S2561326X24006553)
- **[M] BCT taxonomy:**
  - Michie S, Hyder N, Walia A, West R. "Development of a taxonomy of behaviour change techniques used in individual behavioural support for smoking cessation." *Addict Behav* 2011;36(4):315–319. Self-monitoring of behaviour is a coded technique. — [DOI 10.1016/j.addbeh.2010.11.016](https://doi.org/10.1016/j.addbeh.2010.11.016)
  - Michie S, et al. BCT Taxonomy v1. *Ann Behav Med* 2013;46(1):81–95. Self-monitoring of behaviour is BCT 2.3. — [DOI 10.1007/s12160-013-9486-6](https://doi.org/10.1007/s12160-013-9486-6)
- **[M] Pre-quit reduction versus abrupt quitting:** Lindson-Hawley N, Banting M, West R, Michie S, Shinkins B, Aveyard P. "Gradual Versus Abrupt Smoking Cessation: A Randomized, Controlled Noninferiority Trial." *Ann Intern Med* 2016;164(9):585–592. DOI 10.7326/M14-2805. N = 697. Results as recalled, **verify before publication**:
  - 4-week abstinence: **39.2%** gradual vs **49.0%** abrupt (RR 0.80, 95% CI 0.71–0.90);
  - 6-month abstinence: **15.5% vs 22.0%** (RR about 0.71).

  Gradual reduction was not non-inferior. — [DOI](https://doi.org/10.7326/M14-2805)
- **[M] Mindfulness and "curious smoking":**
  - Brewer JA, Mallik S, Babuscio TA, et al. "Mindfulness training for smoking cessation: results from a randomized controlled trial." *Drug Alcohol Depend* 2011;119(1–2):72–80. N = 88; mindfulness training vs Freedom From Smoking. Recalled result: **31% vs 6%** point-prevalence abstinence at 17 weeks (**verify**). — [DOI 10.1016/j.drugalcdep.2011.05.027](https://doi.org/10.1016/j.drugalcdep.2011.05.027)
  - Elwafi HM, Witkiewitz K, Mallik S, Thornhill TA, Brewer JA. *Drug Alcohol Depend* 2013;130(1–3):222–229. Mindfulness training weakened the craving-to-smoking link. — [DOI 10.1016/j.drugalcdep.2012.11.015](https://doi.org/10.1016/j.drugalcdep.2012.11.015)
  - The "pay attention / be curious while smoking" exercise (noticing the taste and smell of a cigarette) is a component of Brewer's Craving to Quit program. Its unique effect has not been isolated in RCTs.
  - App RCT: Garrison KA, et al. "Craving to Quit: A Randomized Controlled Trial of Smartphone App-Based Mindfulness Training for Smoking Cessation." *Nicotine Tob Res* 2020;22(3):324–331. **No significant difference in abstinence** compared with NCI QuitGuide. — [DOI 10.1093/ntr/nty126](https://doi.org/10.1093/ntr/nty126)
- **[M] Habit formation timeline:** Lally P, van Jaarsveld CHM, Potts HWW, Wardle J. "How are habits formed: Modelling habit formation in the real world." *Eur J Soc Psychol* 2010;40(6):998–1009. For *new* health behaviours, automaticity reached 95% of asymptote at a **median of 66 days (range 18–254)**. This is about forming habits, not breaking them. — [DOI 10.1002/ejsp.674](https://doi.org/10.1002/ejsp.674)
- **[M] Measuring automaticity:** Gardner B, Abraham C, Lally P, de Bruijn GJ. "Towards parsimony in habit measurement: testing the convergent and predictive validity of an automaticity subscale of the Self-Report Habit Index." *Int J Behav Nutr Phys Act* 2012;9:102. This is the 4-item Self-Report Behavioural Automaticity Index (SRBAI). — [DOI 10.1186/1479-5868-9-102](https://doi.org/10.1186/1479-5868-9-102)
- **[M] Neuroscience theory, not evidence about logging:**
  - Everitt BJ, Robbins TW. "Neural systems of reinforcement for drug addiction: from actions to habits to compulsion." *Nat Neurosci* 2005;8(11):1481–1489. — [DOI 10.1038/nn1579](https://doi.org/10.1038/nn1579)
  - Everitt BJ, Robbins TW. "Drug Addiction: Updating Actions to Habits to Compulsions Ten Years On." *Annu Rev Psychol* 2016;67:23–50. — [DOI 10.1146/annurev-psych-122414-033457](https://doi.org/10.1146/annurev-psych-122414-033457)
  - Both describe a ventral-to-dorsal striatal shift in control, drawn largely from animal work. The habit account is contested; Hogarth argues human drug choice is largely goal-directed. — [Hogarth L. *Neuropsychopharmacology* 2020, DOI 10.1038/s41386-020-0600-8](https://doi.org/10.1038/s41386-020-0600-8)

### Inferences
- **Messaging rule:** say "Logging helps you notice your patterns and teaches the app when you're most at risk." Do **not** say "logging rewires your brain's habit centre (dorsal striatum)". No study shows that self-monitoring cigarettes changes striatal function.
- McFall's direction effect suggests framing *craving and urge* logs, especially "urges resisted", as a positive mastery record after the quit date. During the baseline, cigarette logs are measurement.
- The baseline should keep normal smoking (no forced reduction) and lead into an **abrupt quit date**, consistent with Lindson-Hawley 2016. A "mindful/curious cigarette" exercise can be offered for 1–2 cigarettes/day as an optional awareness practice, labelled as a Craving to Quit-derived technique whose isolated efficacy is unproven.
- An adapted SRBAI item ("I smoked this one without thinking", 1–5) gives a per-cigarette automaticity score. Tracking it across baseline days would let the product *measure* whether awareness logging reduces self-rated automaticity. This is a testable claim, not an assumed one.

### Gaps
- No RCT was found isolating per-cigarette logging, or the historical "wrap-a-pack" technique, as a cessation intervention with modern outcomes.
- No study was found measuring change in self-reported automaticity (SRBAI) from cigarette logging.
- The exact effect sizes from McFall 1970, Rowan 2007 and Garrison 2020 were not re-verified, so none are quoted.

---

## Q7. Designing the 5–7-day Pre-Quit Mindful Baseline (logging schedule, burden, compliance, dataset size)

### Takeaway
Validated precedents ran pre-quit monitoring for **4–7 days**:

| Program | Pre-quit monitoring | EMA load | Compliance / burden reported |
|---|---|---|---|
| Sense2Stop | 4 days pre-quit | sensor-driven | — |
| Smart-T | 7 days pre-quit | 5 random EMAs/day | 87% compliance; 15% said "too many" |
| Quit Sense | learning phase before quit date | event logging of each cigarette | — |
| Perski studies (post-quit) | — | 16 hourly EMAs/day for 10 days | feasible in small research samples |

Substance-use EMA compliance averages **about 75%**. A 7-day baseline with event-contingent cigarette logs plus **4–5 random EMAs/day** matches what trials have shown feasible.

### Cited Findings
- **[V] Precedents:**
  - Smart-T feasibility: 5 random EMAs/day for 1 week pre-quit and 2 weeks post-quit; 87% compliance; 15% said 5/day was too many. — [PMC5187451](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5187451/)
  - Smart-T pilot RCT: 5/day for 5 weeks. — [PMC7091024](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7091024/)
  - JAMA 2025 trial: the quit date was 7 days after enrollment. — [JAMA Netw Open](https://jamanetwork.com/journals/jamanetworkopen/fullarticle/2837640)
  - Sense2Stop: 4 days pre-quit. — [PubMed 34375749](https://pubmed.ncbi.nlm.nih.gov/34375749/?dopt=Abstract)
  - Perski 2024 and Leppin 2026: 16 EMAs/day for 10 days. — [PMC11343380](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC11343380/); [PLOS ONE 2026](https://journals.plos.org/plosone/article?id=10.1371%2Fjournal.pone.0349028)
- **[V] Learning-phase precedent:** Quit Sense users log each cigarette with its context and the cues present, and the app creates a geofence when a place is reported more than once. — [NIHR KQYT5412](https://www.journalslibrary.nihr.ac.uk/phr/KQYT5412)
- **[V] Compliance benchmark:** Jones A, Remmerswaal D, Verveer I, Robinson E, Franken IHA, Wen CKF, Field M. "Compliance with ecological momentary assessment protocols in substance users: a meta-analysis." *Addiction* 2019;114(4):609–619 (DOI believed to be 10.1111/add.14503, **[M] verify**). — [OSF project page](https://osf.io/thmgy/overview)
  - Pooled compliance was **about 75%** across about 125–126 studies from 1998–2017. Sources differ on the exact study count.
  - This is below the commonly recommended **80%**.
  - The paper's abstract (per OSF) says compliance was **not associated with procedural variables**, such as prompts per day. One secondary source instead claims compliance falls with more prompts per day, longer studies and morning prompts. **The two descriptions conflict; check the paper itself.**
- **[V] Broader EMA compliance meta-analysis:** "Compliance With Mobile Ecological Momentary Assessment of Self-Reported Health-Related Behaviors and Psychological Constructs in Adults: Systematic Review and Meta-analysis," *J Med Internet Res* 2021;23(3):e17023. The pooled figure was not retrieved. — [JMIR](https://www.jmir.org/2021/3/e17023)
- **[V] Minimum per-user data precedent:** Perski 2023 required **≥20 unprompted craving entries** per user (within 3 months) for inclusion in ML modelling. — [Perski 2023 NTR, PubMed 36971111](https://pubmed.ncbi.nlm.nih.gov/36971111/)
- **[V] Feature reduction:** reducing the EMA feature set had negligible impact on lapse prediction. — [Leppin 2026 PLOS ONE](https://journals.plos.org/plosone/article?id=10.1371%2Fjournal.pone.0349028)
- **[M] Case-crossover design:** Shiffman 2002 compared each cigarette with random non-smoking moments in the same person. This is the analytic template for training a per-user "smoking-likely moment" classifier from baseline data. — [DOI 10.1037/0021-843X.111.4.531](https://doi.org/10.1037/0021-843X.111.4.531)

### Inferences
These are proposed protocol details, derived from the precedents above. They are design recommendations, not validated specifications.

- **Length:** 7 days by default, with a minimum of 5 when the data quota is met. Seven days captures one full weekday/weekend cycle, which is needed for day-of-week features, and matches Smart-T's pre-quit week.
- **Per-cigarette log (event-contingent, ≤20 seconds, one screen).** Fields marked † are passively captured.
  - Timestamp† and geofence cluster ID†.
  - Location type (home / work / car / outside-home / bar-restaurant / other).
  - Activity (work break, after meal, with coffee, with alcohol, driving, socialising, on phone/screens, waking up, before bed).
  - Others smoking present (Y/N) and alone or with others.
  - Craving before lighting up (0–10).
  - Affect valence (−2 to +2) and arousal (low/high), as a 2-tap circumplex.
  - "How automatic was this?" (1–5, adapted from SRBAI: "I did it without thinking").
  - "How much did you enjoy it?" (0–10).
  - Optional "mindful cigarette" check-in: "what did you notice: taste, smell, throat, mood after?", offered at most 1–2 times/day.
  - **Back-fill:** "Missed a log? Tap +1 with an approximate time." The approximate flag is stored so the model can weight that entry down.
- **Random EMAs:** 4/day (Smart-T used 5/day, and 15% found that burdensome), stratified across waking blocks, with a ≥90-minute gap between prompts and a 20-minute expiry. Items: current craving 0–10, stress 0–10, valence and arousal, cigarettes available (Y/N/with difficulty), others smoking nearby, alcohol in the last 2 hours, and motivation to quit 0–10. Those last items are the Smart-T six, so the rules score can run from day 1. Also ask: smoked since the last prompt (Y/N, to catch missed logs) and receptivity ("Is now a good time for a tip?").
- **Expected compliance:** about 75–87%, per Jones 2019 and Smart-T.
- **Dataset size per user** (illustrative arithmetic, not a validated requirement): at 15 cigarettes/day × 7 days, roughly 105 positive events. Random EMAs at 4/day × 7 × 0.8 compliance give about 22 prompt moments. Passive context samples, e.g., one every 15 minutes during waking hours (about 64/day), add about 448 unlabelled windows; label the ones without a nearby log as "no cigarette within ±30 minutes" negatives. A light smoker (5 cigarettes/day) yields only about 35 positives. In that case lean more on the population prior and hierarchical shrinkage, and gate personalisation on a quota, e.g., ≥30 logged cigarettes plus ≥15 answered EMAs. The ≥20-entry precedent from Perski 2023 sits in the same range.
- **Caveat:** pre-quit cigarettes are *ad-lib smoking*, which Shiffman 2002 linked mainly to stimulus and context. Post-quit lapses are more tied to negative affect and urges (Shiffman 1996/2004). Baseline-trained models therefore predict **cue-exposure and craving-likely windows**, a proxy that must be **re-anchored post-quit** with craving and lapse labels. Weight post-quit data more heavily as it arrives.

### Gaps
- No trial was found that directly compares baseline lengths (e.g., 3 vs 7 vs 14 days) on model accuracy or abstinence.
- No published per-user sample-size requirement for smoking-lapse models was found beyond Perski's ≥20-entry inclusion rule.
- The pooled compliance in the JMIR 2021 meta-analysis, and the Jones 2019 moderator results, were not retrieved; see the conflict noted above.

---

## Q8. On-device ML: model candidates, features, cold start, on-device training, calibration, thresholds and evaluation

### Takeaway
Use a **three-layer policy**:

1. a Smart-T-style rules score, available from day 1;
2. a population-pretrained model with **per-user hierarchical/Bayesian personalisation**, either logistic regression with a Gaussian prior centred on population weights or a GBT plus per-user calibration;
3. an optional small temporal model.

Deploy GBTs through ONNX Runtime Mobile, which supports tree ensembles natively, and use LiteRT for neural models. Both runtimes offer on-device training paths. Choose thresholds against a **notification budget** (e.g., ≤3 proactive prompts/day) rather than a fixed probability cutoff. Validate leave-one-subject-out and time-forward, because group AUCs overstate per-person performance (Q5).

### Cited Findings
- **[V] Evidence base for model choice:**
  - Tree ensembles (Random Forest, XGBoost) were the best group-level lapse classifiers in Perski 2023 and 2024. — [PubMed 36971111](https://pubmed.ncbi.nlm.nih.gov/36971111/); [PMC11343380](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC11343380/)
  - Leppin 2026 recommends ML plus rules hybrids. — [PLOS ONE 2026](https://journals.plos.org/plosone/article?id=10.1371%2Fjournal.pone.0349028)
  - The weighted-sum rule (Smart-T) has RCT efficacy. — [JAMA Netw Open 2025](https://doi.org/10.1001/jamanetworkopen.2025.26691)
- **[V] Personalisation need:** out-of-sample individual AUC medians are 0.639–0.745, with wide ranges (0.48–1.00). — [PMC11343380](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC11343380/); [PubMed 36971111](https://pubmed.ncbi.nlm.nih.gov/36971111/)
- **[V] Privacy precedent:** Quit Sense ran all JITAI logic on-device without internet. — [NIHR KQYT5412](https://www.journalslibrary.nihr.ac.uk/phr/KQYT5412)
- **[M] LiteRT / TensorFlow Lite on-device training:** a model exported with multiple `tf.function` **signatures**, typically `train`, `infer`, `save` and `restore`, can be invoked from the Android/iOS interpreter to run gradient steps on device and checkpoint the weights. Training ops require the **Select TF ops (Flex delegate)**, which increases binary size. **Verify the current LiteRT API naming before implementation.** — [TensorFlow Lite on-device training guide](https://www.tensorflow.org/lite/examples/on_device_training/overview); [LiteRT docs](https://ai.google.dev/edge/litert)
- **[M] ONNX Runtime on-device training:** the offline step `onnxruntime.training.artifacts.generate_artifacts` produces training, eval and optimizer graphs plus a checkpoint. The on-device Training API (C/C++, Java/Kotlin, Swift/Obj-C, C#) then runs `train_step` and exports an inference model. Mobile training packages were published separately from inference-only packages. **Check that these are still maintained in current ORT releases.** — [ONNX Runtime "On-Device Training" docs](https://onnxruntime.ai/docs/get-started/training-on-device.html)
- **[M] Converting tree ensembles:** sklearn, LightGBM and XGBoost tree ensembles convert to the ONNX-ML `TreeEnsembleClassifier`/`TreeEnsembleRegressor` operators through skl2onnx/onnxmltools, and ORT Mobile can execute them. TFLite has no native tree-ensemble op. — [skl2onnx docs](https://onnx.ai/sklearn-onnx/); [onnxmltools](https://github.com/onnx/onnxmltools)
- **[M] Calibration:**
  - Platt scaling: Platt J. 1999, "Probabilistic outputs for support vector machines…".
  - Isotonic regression: Zadrozny B, Elkan C. *KDD* 2002.
  - Empirical comparison: Niculescu-Mizil A, Caruana R. "Predicting good probabilities with supervised learning." *ICML* 2005, showing boosted trees and SVMs are poorly calibrated without correction, and that isotonic regression needs more data than Platt. — [DOI 10.1145/1102351.1102430](https://doi.org/10.1145/1102351.1102430)
- **[M] Imbalanced evaluation:** prefer PR curves over ROC under imbalance. — [Saito & Rehmsmeier 2015, DOI 10.1371/journal.pone.0118432](https://doi.org/10.1371/journal.pone.0118432)
- **[V] Event-level metric precedent:** Smart-T reported the share of lapses flagged in the 4 hours before the lapse (80%) together with the false-positive rate (17%). — [NCT03740490 protocol](https://cdn.clinicaltrials.gov/large-docs/90/NCT03740490/Prot_SAP_000.pdf)

### Inferences
These are engineering recommendations derived from the findings above, not validated specifications.

- **Prediction target.** Define a per-window label: "craving ≥7/10, cigarette logged, or lapse logged within the next 60 minutes", evaluated every 15–30 minutes. Pre-quit, positives are cigarettes. Post-quit, they are high craving or lapses; for these, use a separate output head or re-weighting.
- **Features**, about 30–60 total, computed on-device:
  - **Time:** hour-of-day encoded as sin/cos(2π·h/24); day-of-week as sin/cos(2π·d/7) plus a weekend flag; minutes since waking, from the first screen unlock.
  - **Recency and counts:** minutes since the last cigarette or lapse, and since the last craving ≥7; cigarettes logged in the last 1, 3 and 24 hours; the user's baseline-hour smoking rate, i.e., this hour's historical mean across baseline days (a strong personal prior); EMA craving, stress and valence (last value, an exponentially decayed mean, and the change since the previous value).
  - **Smart-T six:** the last values of urge, stress, availability, alcohol, motivation and others-smoking, plus the computed rules score itself as a feature.
  - **Place:** geofence cluster ID one-hot (top-k clusters plus "other"); dwell minutes in the current cluster; a "smoking-associated cluster" flag (≥2 logs, per Quit Sense); place type.
  - **Phone context:** screen on/off, unlock count over the last 30 minutes, charging, headphones, activity-recognition state (still, walking, vehicle), calendar busy flag, ambient-noise bucket where permitted.
  - **Wearable (optional, nullable):** heart rate minus the user's resting baseline for this hour, steps in the last 15 minutes, a sleep flag. HRV only where the platform exposes it, with a missingness indicator.
- **Model ladder:**
  - **(L0) Rules:** a Smart-T-style weighted score, with weights to be taken from Businelle 2016 once verified.
  - **(L1) Logistic regression:** population-pretrained, with a per-user MAP/Laplace update toward a Gaussian prior on the population weights (the prior acts as shrinkage). Updates run nightly on device in closed form or with a few L-BFGS/SGD steps. Under 100 parameters; inference is effectively instantaneous.
  - **(L2) GBT:** for example 100–300 trees of depth 3–5, exported to ONNX. Personalise with per-user Platt calibration plus a per-user bias term, or by appending a few boosting rounds on device (non-trivial; the ORT training API targets differentiable graphs, so GBT retraining on device is better done in app code).
  - **(L3, later) Small GRU or temporal CNN:** over the last 24–48 hours of event sequences, a few thousand to tens of thousands of parameters. Fine-tune only the final layer on device via LiteRT signatures or the ORT Training API.

  These model sizes and latencies are order-of-magnitude engineering estimates, not benchmarks (see Gaps).
- **Cold start:** day 0 uses the population model plus rules. During the baseline, update after each day. At quit, switch the target from "smoke" to "craving/lapse risk" and keep the per-user offsets.
- **Thresholding:** calibrate (Platt for small per-user data, isotonic only for population calibration with more data). Then choose a per-user threshold so that the expected proactive prompts per day stay at or below the budget (e.g., 3/day, informed by Sense2Stop's 2.5–3/day). Add a refractory period of ≥60–90 minutes between proactive prompts. Below the threshold, only passive UI cues appear (e.g., a home-screen widget showing "higher-risk hour").
- **Metrics to report:**
  - per-user ROC-AUC and PR-AUC distributions (leave-one-subject-out and time-forward);
  - Brier score and reliability curves;
  - event recall: the percentage of lapses or high cravings preceded by a prompt within the past 60–240 minutes, comparable with Smart-T's 4-hour window;
  - false prompts per day;
  - proximal outcomes from in-app micro-randomization.

### Gaps
- The current LiteRT and ORT on-device training documentation could not be fetched (blocked). API names, package availability and whether ORT mobile training packages are still published in 2026 must be verified.
- No published mobile benchmark of on-device model size or latency was retrieved for these specific model classes. Any MB or ms figures in the blueprint should come from in-house profiling.
- No smoking-specific study evaluating calibration (Brier, reliability) was retrieved.

---

## Q9. Notification fatigue, receptivity and JITAI timing

### Takeaway
Engagement decays and prompt effects habituate over time (HeartSteps; the 2026 Annual Review). Smoking JITAIs have run at about 2.5–3 randomized prompts/day (Sense2Stop) and 5 EMAs/day with immediate tailored messages (Smart-T: about 102 messages in 3 weeks, roughly 5/day, with 15% finding 5 EMAs/day too many). Receptivity is predictable from phone context (Künzler 2019; Mishra 2021). Budgeted, receptivity-gated, partly randomized prompting is the evidence-aligned design.

### Cited Findings
- **[V] Smoking JITAI prompt doses:**
  - Sense2Stop: 2.5–3 prompts/day. — [PubMed 34375749](https://pubmed.ncbi.nlm.nih.gov/34375749/?dopt=Abstract)
  - Smart-T: 5 EMAs/day with a message after each; about 102 messages over 3 weeks; 15% (9/59) rated 5 assessments/day as too high. — [PMC5187451](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5187451/)
  - Quit Sense: event-triggered by geofence dwell, with a re-trigger after 3 hours. — [PMC12290499](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC12290499/)
- **[V] Engagement decay in Quit Sense:** about half of users engaged for more than 1 week; the 2025 qualitative work identified disengagement factors. — [PMC10256891](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC10256891/); [BJHP 2025](https://bpspsychub.onlinelibrary.wiley.com/doi/full/10.1111/bjhp.70010)
- **[V] Field-level problems:** suboptimal engagement, inability to engage when needed most, and fixed rules that cannot adapt to habituation. — [Nahum-Shani & Murphy, Annu Rev Psychol](https://www.annualreviews.org/content/journals/10.1146/annurev-psych-121024-044244)
- **[M] Receptivity:** Künzler F, Mishra V, Kramer JN, Kotz D, Fleisch E, Kowatsch T. "Exploring the State-of-Receptivity for mHealth Interventions." *Proc ACM IMWUT* 2019;3(4):140. In a physical-activity chatbot study, receptivity to prompts varied with time of day, day of week, phone interaction or battery state, and physical activity or location context. — [DOI 10.1145/3369805](https://doi.org/10.1145/3369805)
- **[M] Predicting receptivity:** Mishra V, Künzler F, Kramer JN, Fleisch E, Kowatsch T, Kotz D. "Detecting Receptivity for mHealth Interventions in the Natural Environment." *Proc ACM IMWUT* 2021;5(2):74. Sending interventions at ML-predicted receptive moments improved receptivity over random timing. The exact uplift percentage is not quoted; verify. — [DOI 10.1145/3463492](https://doi.org/10.1145/3463492)
- **[M] Notification receptivity in general:** Mehrotra A, Pejovic V, Vermeulen J, Hendley R, Musolesi M. "My Phone and Me: Understanding People's Receptivity to Mobile Notifications." *CHI* 2016. Content, sender and the cognitive context at the time shape acceptance of notifications. — [DOI 10.1145/2858036.2858566](https://doi.org/10.1145/2858036.2858566)
- **[M] Habituation in an MRT:** in HeartSteps, the proximal effect of suggestions declined over days in the study. — [DOI 10.1093/abm/kay067](https://doi.org/10.1093/abm/kay067)
- **[V] 2025 receptivity work in mental-health JITAIs:** "Real-World Receptivity to Adaptive Mental Health Interventions: Findings from an In-the-Wild Study" (arXiv 2508.02817). Content was not retrieved. — [arXiv](https://arxiv.org/pdf/2508.02817)

### Inferences
- **Prompt budget:**
  - Proactive risk prompts: ≤3/day by default (Sense2Stop dose), user-adjustable from 0 to 5.
  - Refractory period: ≥90 minutes.
  - Quiet hours: sleep window plus driving (activity-recognition "in vehicle").
  - Random EMAs during the baseline: ≤4/day.
  - Post-quit EMAs: taper from 3/day in weeks 1–2 to 1–2/day, because the highest lapse risk is early after quitting.
  - Always available: an unlimited **user-initiated "craving SOS"** button. This is the zero-cost decision point.
- **Receptivity gating:** deliver only when the phone was unlocked in the last 5 minutes or the screen is on, and not during calendar-busy or vehicle states. If the risk window persists, defer up to 15 minutes rather than drop the prompt.
- **Countering habituation:**
  - rotate message types (the Smart-T factor-matched library);
  - lower the per-type frequency after 3 ignores;
  - keep a micro-randomized "no-prompt" probability of 0.3–0.5 at high-risk moments during optimisation, to measure true proximal effects and detect decay;
  - log every decision, its probability, the context, and the response.
- Track response rate per message type as the online feedback signal. Consider a contextual bandit (e.g., Thompson sampling, as used in later HeartSteps versions) once enough per-user data exists. This is a design suggestion; this session did not verify any published smoking application of a bandit.

### Gaps
- No smoking-specific study was found that relates prompt frequency to disengagement or dropout as a dose-response.
- The exact receptivity-uplift numbers (Mishra 2021) and the HeartSteps decay rates were not verified.
- No 2024–2026 smoking JITAI receptivity study was retrieved; the search budget ran out.
