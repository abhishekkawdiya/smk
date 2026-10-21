# Sections 2.3 and 2.5: Behavioral-economics framing, Approach Bias Modification (ApBM), and slow-paced / resonance-frequency breathing for smoking cessation

Method caveat for the report writer: full-text fetching (WebFetch/curl) was blocked in this session (DNS/proxy refusals for PubMed, Cochrane, UEA, publisher sites), and the shared web-search budget ran out partway through. Every "Cited Finding" below comes from search-result abstracts, registry entries, institutional repository records or press summaries of the primary papers, and is linked to the page it came from. Items I know from prior knowledge but could NOT re-verify this session are listed only under "Gaps" and tagged **[UNVERIFIED]**. Do not quote them as fact without checking. Worked calculations (marked "computed") were done locally from the cited parameters. They show what the models predict and are not empirical results.

---

## Q1. Prospect theory, mental accounting and reference points: equations and how to apply them

### Takeaway
Cumulative prospect theory (CPT) gives a ready-made, parameterised "felt value" model: v(x)=x^0.88 for gains and v(x)=−2.25(−x)^0.88 for losses, plus inverse-S probability weighting (γ=0.61 for gains, δ=0.69 for losses). These parameters are **median lab estimates for money gambles**, not constants and not smoking-specific. In this model a cigarette counted as a loss against a new "smoke-free" reference point weighs about 2.25× as much as the same amount counted as a forgone gain. Splitting a loss into several concrete parts makes it feel larger (n^0.12×), and splitting gains into many separate events does the same for gains.

### Cited Findings
- **Kahneman & Tversky (1979)** "Prospect theory: an analysis of decision under risk," *Econometrica* 47(2):263–291, DOI 10.2307/1914185. This is the original statement of a reference-dependent value function: concave for gains, convex and steeper for losses. (Citation details were supplied in the brief. The model content is confirmed via the 1992 parameter sources below.) — [Wakker CPT calculator notes](https://personal.eur.nl/wakker/miscella/calculate.cpt.kobb/index.htm)
- **Tversky & Kahneman (1992)** "Advances in prospect theory: cumulative representation of uncertainty," *J Risk Uncertain* 5:297–323, DOI 10.1007/BF00122574. Parameters: α=0.88 (gain curvature), β=0.88 (loss curvature), λ=2.25 (loss aversion), γ=0.61 (probability weighting, gains), δ=0.69 (probability weighting, losses). — [Wakker CPT calculator (J Risk Uncertain program notes)](https://personal.eur.nl/wakker/miscella/calculate.cpt.kobb/index.htm); [Birnbaum CPT calculator](https://psych.fullerton.edu/mbirnbaum/calculators/cpt_calculator.htm)
- α=β=0.88 and λ=2.25 are **median estimates across the experimental subjects**, and individual preferences vary considerably. — [cognitivemodels `cpt` documentation](https://rdrr.io/github/JanaJarecki/cognitivemodels/man/cpt.html); [MetricGate CPT docs](https://metricgate.com/docs/cumulative-prospect-theory/)
- Weighting function: w(p) = p^γ / (p^γ + (1−p)^γ)^(1/γ), an inverse-S shape with separate parameters for gains (γ) and losses (δ). Alternative weighting functions fit some datasets better. — [MetricGate CPT docs](https://metricgate.com/docs/cumulative-prospect-theory/); [cognitivemodels `cpt`](https://rdrr.io/github/JanaJarecki/cognitivemodels/man/cpt.html)
- Computed from the TK-1992 parameters (my calculation, not an empirical result):
  - **Loss aversion:** a loss of x weighs λ=2.25 times a gain of x.
  - **Segregating a loss into n equal parts** multiplies its felt size by n^(1−β) = n^0.12: 1.087× for 2 parts, 1.141× for 3, 1.181× for 4. Example: −2.25(1+1) = −4.50 versus −2.25·2^0.88 = −4.14.
  - **Segregating a gain into N equal events** multiplies its felt size by N^0.12: 1.26× for N=7, 1.50× for N=30, 2.03× for N=365.
  - **Probability weighting (losses, δ=0.69):** w(0.001)=0.008, w(0.01)=0.040, w(0.05)=0.111, w(0.10)=0.170, w(0.5)=0.454, w(0.9)=0.775. Small described probabilities are over-weighted and large ones under-weighted.

### Inferences
- **Reference-point reset (design rule R1):** On the quit date, make "smoke-free status" the reference point by giving the user an endowed balance: a live counter of money kept, minutes of life expectancy kept and smoke-free hours. A cigarette is then shown as a *decrement* of that balance, which CPT prices at λ≈2.25× a forgone gain, rather than as "a little less saved". Copy example: "This cigarette takes about £X and about 20 min of life expectancy from your balance." (See Q4 for the formulas.)
- **Hedonic editing has opposite rules before and after a lapse (R2):**
  - *Before a choice, during a craving:* segregate the prospective loss into 3–4 concrete, separately displayed components (money, minutes of life expectancy, streak, acute body signal). Under CPT this raises the felt loss by about 14–18% for the same total, versus a single integrated figure.
  - *After a lapse:* do the reverse, following Thaler-style hedonic editing to protect motivation. Integrate the loss into one compact line and segregate the gains ("you still kept 41 of 42 days, £N, M hours"). This is a design inference from CPT curvature. Thaler's 1985 principles could not be re-verified this session (see Gaps).
- **Segregate gains over time (R3):** show each smoke-free day, and each craving resisted, as a separate "deposit" event with its own micro-celebration, alongside the cumulative total. Under CPT, 30 separate daily gains feel about 1.5× one lump sum of the same size.
- **Avoid probabilistic risk statements as the main lever (R4):** smoking harms reach the user as small, delayed probabilities. CPT over-weights small *described* probabilities (w(0.01)≈0.04 for losses), but delay discounting (Q2) and optimism bias dominate in practice. Convert risk into certain, immediate units instead (money now; expected minutes of life expectancy, clearly labelled as an average; acute physiological signals).
- These parameters come from monetary lotteries in student samples. Their transfer to health and time outcomes, and to smokers, is an assumption. Treat the 2.25 and 0.88 values as *design heuristics for A/B hypotheses*, not as predicted effect sizes.

### Gaps
- **[UNVERIFIED] Thaler (1985)** "Mental accounting and consumer choice," *Marketing Science* 4(3):199–214, DOI [10.1287/mksc.4.3.199](https://doi.org/10.1287/mksc.4.3.199). From memory, the four hedonic-editing principles are: segregate gains; integrate losses; integrate a small loss with a larger gain; segregate a small gain from a large loss ("silver lining"). I could not fetch the paper. The principles do follow mathematically from the CPT curvature computed above.
- **[UNVERIFIED] Endowment effect:** Kahneman, Knetsch & Thaler (1990) *J Polit Econ* 98(6):1325–1348, DOI [10.1086/261737](https://doi.org/10.1086/261737). No WTA/WTP figures were retrieved, so none are reported here.
- **[UNVERIFIED] Robustness of loss aversion:** there are critiques arguing loss aversion is weak or absent for small stakes (e.g., Gal & Rucker 2018 *J Consum Psychol*), and a large 2024 meta-analysis of λ estimates (Brown, Imai, Vieider & Camerer, *J Econ Lit*) is recalled as giving a mean λ somewhat below 2.25. Neither was retrieved this session, and no alternative λ should be quoted until checked.
- No study was found that tests a CPT-optimised metric display (segregated versus integrated losses) inside a smoking-cessation app. The R1–R4 rules are theory-derived and need A/B testing.

---

## Q2. Delay discounting in smokers: model, evidence and design implications

### Takeaway
Smokers discount delayed rewards more steeply than never- and ex-smokers. The hyperbolic model V=A/(1+kD) fits better than the exponential one in most comparisons. Across addictive behaviours, steeper discounting is reliably associated with addiction (d=0.15 overall, d=0.58 in methodologically homogeneous studies). Episodic future thinking (EFT) acutely reduces discounting (d=0.65) and laboratory cigarette self-administration (d=0.58). The design implication is to make consequences immediate, concrete and certain, and to make future rewards vivid.

### Cited Findings
- **Bickel, Odum & Madden (1999)** "Impulsivity and cigarette smoking: delay discounting in current, never, and ex-smokers," *Psychopharmacology* 146:447–454. Samples: n=23 current, 22 never and 21 ex-smokers, using a titration procedure for money indifference points. Current smokers discounted delayed money more steeply. Never- and ex-smokers did not differ. The **hyperbolic equation fit better than the exponential in 74 of 89 comparisons**. — [USU DigitalCommons record](https://digitalcommons.usu.edu/psych_facpub/54); [Springer DOI page 10.1007/PL00005490](https://link.springer.com/doi/10.1007/PL00005490)
  - DOI discrepancy: the Springer record found in search uses **10.1007/PL00005490**, not 10.1007/s002130051097 as given in the brief. The writer should cite the DOI that resolves.
- **MacKillop et al. (2011)** "Delayed reward discounting and addictive behavior: a meta-analysis," *Psychopharmacology* 216:305–321, DOI 10.1007/s00213-010-2048-6:
  - 64 comparisons: d=0.15 (p<0.00001), with very high heterogeneity.
  - 57 methodologically equivalent comparisons (n=3,329): **d=0.58**.
  - Clinical samples d=0.61 versus non-clinical d=0.45.
  — [Bath research portal](https://researchportal.bath.ac.uk/en/publications/delayed-reward-discounting-and-addictive-behavior-a-meta-analysis/); [UCLA PDF](https://addictions.psych.ucla.edu/wp-content/uploads/sites/160/2018/01/PsychoPharm-Delayed-Reward-Discounting-and-Addictive-Behavior-a-Meta-Analysis.pdf)
  - No nicotine-specific d was retrievable from the abstract.
- **Stein et al. (2016)** "Unstuck in time: episodic future thinking reduces delay discounting and cigarette smoking," *Psychopharmacology* 233(21–22):3771–3778, DOI 10.1007/s00213-016-4410-y (authors Stein, Wilson, Koffarnus, Daniel, Epstein, Bickel). EFT reduced delay discounting (**d=0.65**) and puffs earned in a lab self-administration task (**d=0.58**). — [Springer](https://link.springer.com/10.1007/s00213-016-4410-y); [Buffalo research record](https://researchconnect.buffalo.edu/en/publications/unstuck-in-time-episodic-future-thinking-reduces-delay-discountin/)
- A later web-based study in smokers found EFT reduced delay discounting and cigarette demand *intensity* but had **no effect on demand elasticity or craving**. EFT participants were also better at guessing the study hypothesis, which raises a demand-characteristic concern. — [PMC9812225](https://pmc.ncbi.nlm.nih.gov/articles/PMC9812225). Exact citation not confirmed; it may be Athamneh/Bickel-group work.
- An RCT of generalized versus domain-specific EFT for smoking cessation is registered as **NCT07158749**. No results were found. — [ClinicalTrials.gov NCT07158749](https://clinicaltrials.gov/study/NCT07158749)
- Computed illustration of V/A = 1/(1+kD). The k values are **hypothetical** because Bickel 1999 group k values were not retrievable. With k=0.001/day, a harm 30 years away (D≈10,950 days) retains 8.4% of its value. With k=0.01/day it retains 0.9%. A consequence 1 day away retains 99–99.9%.

### Inferences
- **R5. Make costs D≈0 and certain.** Display money lost *now* and acute body signals (minutes to hours) before any long-term disease risk. Long-horizon risks lose most of their weight under hyperbolic discounting with the steeper k that smokers show.
- **R6. Bring rewards closer.** Show the next milestone in hours or days ("smoke-free for 72 h in 9 h"; "£50 in 3 days"), not distant ones. Under a hyperbolic model the value of a near reward rises sharply as D→0.
- **R7. Add EFT micro-prompts.** During a craving or at daily check-in, ask a 20–60 s vivid prompt about a specific positive future event the user has entered (who, where, what they are doing with the money or health they have kept). Evidence: Stein 2016 lab effects (d≈0.6). Caveat: the web-based replication found no craving effect and a demand-characteristic signal, so call this "promising, unproven for quitting".
- **Optional personalisation:** a brief adjusting-amount discounting task (e.g., a 5-trial adjusting-delay task) could estimate a user's k and target more aggressive immediacy framing at high-k users. This is untested in an app context.

### Gaps
- **[UNVERIFIED] Mazur (1987)**, the hyperbolic equation V=A/(1+kD), in Commons et al. (eds.) *Quantitative Analyses of Behavior Vol. 5*, Erlbaum, pp. 55–73. This is a book chapter with no DOI, cited from memory.
- **[UNVERIFIED] Yoon et al. (2007)** *Exp Clin Psychopharmacol* 15(2):176–186: delay discounting predicted postpartum smoking relapse. **[UNVERIFIED] Sheffer et al. (2012)** *Am J Addict* 21(3):221–232, DOI [10.1111/j.1521-0391.2012.00224.x](https://doi.org/10.1111/j.1521-0391.2012.00224.x): discounting predicted treatment outcome in low-SES dependent smokers. The search budget ran out before these could be verified. Effect sizes are unknown here.
- Group-level k values for current, ex- and never-smokers (Bickel 1999) were not retrievable. Do not display or hard-code empirical k values without checking the paper.
- No evidence was found on whether discounting-informed UI (immediacy framing) improves abstinence in a digital RCT.

---

## Q3. Loss- versus gain-framed messages, financial incentives, deposit contracts and commitment devices

### Takeaway
For persuasive *messages*, gain frames outperform loss frames for prevention behaviours, and smoking cessation is one of the domains where the gain advantage is strongest (overall r=0.083). For *money*, incentives clearly work: Cochrane 2025 gives RR 1.52 at ≥6 months, high certainty. Loss-framed deposit contracts reach far fewer people (13.7% versus 90% acceptance) but produced much higher abstinence among those who took them up. The reconciliation: use gain-framed language and an endowment-style metric display, keep the loss component in the numbers rather than in fear messages, and offer deposit or commitment contracts as an opt-in add-on.

### Cited Findings
- **Gallagher & Updegraff (2012)**, *Ann Behav Med* 43(1):101–116, DOI 10.1007/s12160-011-9308-7:
  - 94 studies, 189 effect sizes.
  - Gain-framed messages beat loss-framed ones for **prevention behaviours (r=0.083, p=0.002)**.
  - The gain advantage was strongest for **smoking cessation**, skin-cancer prevention and physical activity.
  - **No framing effect** on attitudes or intentions, and none for detection (screening) behaviours. Effects were larger when behaviour, rather than intention, was measured.
  — [science.gov summary of framing literature](https://www.science.gov/topicpages/m/message+framing+effects); [Epistemonikos record](https://www.epistemonikos.org/en/documents/92c502e2262254e4500fda3f7c063fc38b468809)
  - A smoking-specific r was not retrievable.
- **Cochrane: Notley et al. (2025)** "Incentives for smoking cessation," CD004307.pub7, published 13 Jan 2025. — [Cochrane record](https://cochranelibrary.com/cdsr/doi/10.1002/14651858.CD004307.pub7/information); [UEA eprint](https://ueaeprints.uea.ac.uk/id/eprint/98253); [Physician's Weekly summary](https://www.physiciansweekly.com/incentives-aid-smoking-cessation-across-populations/)
  - **Mixed populations:** RR **1.52** for quitting at ≥6 months (I²=23%; 39 studies; 18,303 participants; **high-certainty**).
  - **Sensitivity analysis** excluding trials that still paid incentives at final follow-up: RR **1.46**. The effect persists after incentives stop.
  - **Pregnancy:** RR **2.13 (95% CI 1.58–2.86)** to up to 48 weeks postpartum (13 studies; 3,942; high certainty).
  - **Moderators:** no clear difference between low- and high-value incentives, or for trials encouraging redeemable self-deposits.
  - **Previous (2019) version:** RR 1.49 (1.28–1.73), 31 RCTs.
  - Secondary sources give inconsistent total study counts (47 versus 48). The 95% CI for RR 1.52 was not captured, so check it in the full text.
- **Halpern et al. (2015)** *NEJM* 372:2108–2117, DOI 10.1056/NEJMoa1414293. — [Penn CHIBE](https://chibe.upenn.edu/news/deposit-based-financial-incentive-programs-for-smoking-cessation-are-superior-to-reward-based-programs/); [Pharmaceutical Journal](https://pharmaceutical-journal.com/article/news/paying-people-to-quit-smoking-promotes-sustained-abstinence); [NAQC](https://www.naquitline.org/news/231700/-Randomized-Trial-of-Four-Financial-Incentive-Programs-for-Smoking-Cessation..htm); [MDedge](https://mdedge-cache.qa01.mdedge.com/psychiatry/article/100739/addiction-medicine/carrots-and-sticks-lead-smoking-cessation)
  - **Design:** 2,538 CVS Caremark employees plus friends and family, randomized to usual care or one of four programmes (individual or group × reward or deposit). Rewards were about $800. The deposit arms required a $150 refundable deposit plus $650 in rewards.
  - **Acceptance:** about **90% for rewards versus 13.7% for deposits**.
  - **6-month sustained abstinence:** usual care **6.0%**. Rewards beat deposits among all randomized participants (**15.7% versus 10.2%**; MDedge reports 15.2% for rewards).
  - **Among acceptors:** deposit-arm abstinence was about **52.3%**. This figure appears in a secondary source only. In instrumental-variable analysis, deposits were about **twice as effective as rewards and about 5× usual care** among people who would accept either.
  - **Relapse:** about half of 6-month quitters had relapsed by 12 months.

### Inferences
- **R8. Copy versus counters.** Default notifications and coaching copy should be **gain-framed** ("Each hour smoke-free, your body…", "You've kept £N"). Loss framing lives only in the *numbers*: a cigarette shown as a decrement of an endowed, already-earned balance (Q1 R1), not as threats or disease imagery. This reconciles Gallagher & Updegraff (gain messages win for cessation) with the loss-aversion lever (balances you could lose).
- **R9. Two-tier incentive offer.** Default to a reward-style "virtual or real rewards for verified milestones" path, because of its 90% uptake. Offer an **opt-in commitment or deposit contract** ("put £X on the line, refunded at verified 4 weeks / 6 months smoke-free"), presented as a stronger tool for the motivated minority. Halpern's data show deposits help acceptors most but repel most people, so never make them mandatory.
- **R10. Verification matters.** Deposit and incentive effects in trials depend on biochemical verification (cotinine or CO). Without verification, an in-app deposit becomes self-report and is open to gaming. Other sections of the blueprint should cover CO-monitor or cotinine-strip options.
- Effects persisted after incentives ended (Cochrane sensitivity RR 1.46), which supports time-limited reward schedules in-app.

### Gaps
- **[UNVERIFIED] Toll et al. (2007)** *Psychol Addict Behav* 21(4):534–544, DOI [10.1037/0893-164X.21.4.534](https://doi.org/10.1037/0893-164X.21.4.534): gain- versus loss-framed messages with bupropion, recalled as favouring gain frames. **[UNVERIFIED] Toll et al. (2010)** *J Natl Cancer Inst* 102(2):96–106, DOI [10.1093/jnci/djp468](https://doi.org/10.1093/jnci/djp468): quitline specialists trained in gain-framed messages, recalled as showing no significant overall abstinence difference. No "Toll 2014" paper was identified. The search budget ran out before verification.
- **[UNVERIFIED] Giné, Karlan & Zinman (2010)** "Put your money where your butt is: a commitment contract for smoking cessation," *Am Econ J Appl Econ* 2(4):213–235, DOI [10.1257/app.2.4.213](https://doi.org/10.1257/app.2.4.213) (the CARES savings-account commitment in the Philippines). Uptake and effect sizes were not verified. **stickK**: no peer-reviewed outcome data retrieved.
- The exact NEJM figures for reward-acceptor abstinence, the range across the four arms, and the 52.3% deposit-acceptor figure should be checked against the NEJM abstract. They were not fetched directly.
- No evidence was retrieved on the legal and payment-platform feasibility of real-money deposit contracts in app stores across countries. This needs regulatory and legal review (gambling and escrow rules).

---

## Q4. Concrete metric-framing equations for the app (money, minutes of life, biomarker, streak) and ethics

### Takeaway
The best-supported "time" conversion is about **20 minutes of life expectancy lost per cigarette on average** (17 min for men, 22 min for women), from UK cohort data (Jackson, Jarvis & West, *Addiction*, DOI 10.1111/add.16757). This supersedes Shaw et al.'s 2000 male-only estimate of about 11 minutes. Both are crude averages that attribute equal harm to every cigarette, so the app must label them "on average". No verified per-cigarette COHb or heart-rate figures were obtained, so none are proposed here.

### Cited Findings
- **Shaw, Mitchell & Dorling (2000)** "Time for a smoke? One cigarette reduces your life by 11 minutes," *BMJ* 320:53, DOI 10.1136/bmj.320.7226.53. — [PMC record](https://pmc.ncbi.nlm.nih.gov/articles/pmid/10617536); [Bristol research record](https://research-information.bris.ac.uk/en/publications/time-for-a-fag-one-cigarette-is-equivalent-to-11-minutes-of-life-)
  - **Method:** a life-expectancy gap of **6.5 years** between male smokers and non-smokers, from the British Doctors Study applied to English and Welsh life tables. Average **5,772 cigarettes/year** from age **17 to 71**, giving **311,688 cigarettes**. 6.5 years ≈ **3,418,560 minutes**, which divided by 311,688 ≈ **11 min** (computed check: 10.97).
  - **Authors' caveat:** "admittedly crude"; it assumes each cigarette contributes equally, and covers men only.
- **Jackson, Jarvis & West (2025)** "The price of a cigarette: 20 minutes of life?" *Addiction* editorial, DOI 10.1111/add.16757. It was online in late December 2024 and covered in early January 2025. Several outlets called the journal "Journal of Addiction", which is a press error; the journal is *Addiction*. — [drugsandalcohol.ie record](https://www.drugsandalcohol.ie/42487); [ScienceAlert](https://www.sciencealert.com/just-one-cigarette-steals-20-minutes-of-your-life-expectancy-study-finds); [Dentistry.co.uk](https://dentistry.co.uk/2025/01/02/smoking-one-cigarette-could-cut-20-minutes-off-life-expectancy/)
  - **Estimate:** about **20 min per cigarette** (men **17**, women **22**), commissioned by the UK Department of Health and Social Care.
  - **Data:** British Doctors Study (men) and Million Women Study (women). Notes that daily consumption in Britain has fallen since 2000.
  - **Illustration:** a 10-a-day smoker who quits on 1 January avoids losing about **50 days** of life by year-end (computed check: 10×365×20 min = 50.7 days). "Almost seven hours of life lost per pack" of 20 (20×20 min = 6.7 h). — [AOL/PA coverage](https://www.aol.com/news/single-cigarette-slashes-20-minutes-121032622.html)

### Inferences
Design formulas, to be shown in the UI with "on average" labels.

- **Inputs:**
  - C₀ = baseline cigarettes/day (user-reported pre-quit average).
  - P = local pack price; S = cigarettes per pack.
  - p_c = P/S = price per cigarette.
  - t = days since quit (fractional, so counters tick live).
  - n(t) = cigarettes logged since the quit date.
  - m = minutes of life expectancy per cigarette. Default 20, or 17/22 by sex if the user provides it. Offer 11 (Shaw 2000) as a "conservative" option, or show the range "11–20".
- **Cigarettes not smoked:** N(t) = max(0, C₀·t − n(t)).
- **Money kept:** M(t) = p_c · N(t). Projection: M_year = 365·C₀·p_c.
  - Locale note: in a global app, prices must come from the user, or from a maintained price table with a visible date and source.
- **Life expectancy kept (expected value):** L(t) = m · N(t) minutes. Display as days/hours/minutes, with the label "average estimate from UK studies; your own risk differs."
- **Cost of the next cigarette (shown during a craving):** ΔM = p_c (certain, now), ΔL = m (expected), plus streak status. Display as 3–4 **segregated** loss chips (Q1 R2).
  - Example: "This one: −£0.xx · −about 20 min average life expectancy · streak 41 days."
- **Streak with endowment and no shame:** show two numbers, current streak and **total smoke-free days (never erased)**. A lapse resets the streak but not the cumulative total, money kept or minutes kept, so gains are preserved and the loss is integrated (Q1 R2).
- **Ethics rules:**
  - **Honest averages:** always label life-expectancy figures as population averages, and never say "this cigarette *will* take 20 minutes from you."
  - **No fear or disgust imagery in the craving flow:** gain-framed copy per Q3 R8.
  - **No moralising after lapses:** "slip" language, a focus on the next 24 h, and preserved totals.
  - **Opt-out of loss displays:** let users turn off loss chips (some find them aversive).
  - **Vulnerable users:** avoid aggressive loss framing in pregnancy and in users with depression or anxiety flags. Test any framing change for harm (drop-out, negative affect) as well as benefit.

### Gaps
- **Per-cigarette COHb, exhaled CO or heart-rate "penalty":** I found no verified figures this session, and none are given here. Another blueprint section on biomarkers should provide sourced values before any "per-cigarette CO/HR" chip is built.
- Jackson et al. 2025 is an *editorial-style* estimate based on two UK cohorts. Generalisability to other countries, to low-intensity or non-daily smokers, and to other tobacco products is uncertain. Male and female figures come from different cohorts and eras.
- The marginal per-cigarette harm is not linear. Duration matters more than intensity, so "minutes per cigarette" is a communication device, not a dose-response law. A "minutes regained" counter implies benefit accrues only with sustained abstinence. No evidence was found that minutes-of-life counters improve quit rates in RCTs.
- No evidence was retrieved on "streak at risk" loss framing in cessation apps specifically. The abstinence-violation-effect rationale (Marlatt) for not resetting totals is **[UNVERIFIED]** this session.

---

## Q5. Approach Bias Modification (ApBM / AAT training) for smoking: protocols and honest effect sizes

### Takeaway
The best and largest smoking ApBM trial is null. **Wittekind et al. 2026 (*Am J Psychiatry*, N=351)** found 6-month biochemically verified prolonged abstinence of **19.3% with ApBM versus 17.4% with sham versus 16.2% with treatment as usual**, not significant, and a companion fMRI RCT found no cue-reactivity change. Smaller and app-based trials show reductions in cigarettes per day, but sham training often matches active training, and change in approach bias does not mediate outcomes. Meta-analyses of cognitive bias modification for addiction show negligible pooled effects (g=0.08, non-significant). ApBM should be at most an optional, clearly labelled "experimental" exercise. It should not be a headline efficacy claim.

### Cited Findings
- **Wittekind et al. (2026)** "Approach Bias Modification as an Add-On to Smoking Cessation Treatment: A Randomized Controlled Trial," *Am J Psychiatry* (April 2026), DOI 10.1176/appi.ajp.20250189. — [AJP](https://psychiatryonline.org/doi/10.1176/appi.ajp.20250189); [LMU author PDF](https://cms-cdn.lmu.de/media/11-psychologie-und-paedagogik/psy/dokumente_downloads/dokumente_lehr_forschungseinheiten/lehrstuhl_klinischepsychologie/wittekind-et-al.-2026-abm-add-on-smoking-rct.pdf); [Mental Elf commentary](https://www.nationalelfservice.net/mental-health/addiction/approach-bias-modification-for-smoking-cessation-nhs-contender-or-game-over/)
  - **Design:** double-blind superiority RCT of 351 adults with tobacco dependence in Germany. All received a one-day CBT cessation programme (TAU), then were randomized to TAU+ApBM, TAU+sham or TAU only.
  - **Primary outcome:** Russell Standard biochemically verified prolonged abstinence at 6 months. ITT results: **19.3% versus 17.4% versus 16.2%**. ApBM was not significantly superior to sham or TAU.
  - **Secondary outcomes:** dependence, craving and consumption fell over time in **all** groups.
  - **Commentary note:** fidelity of the behavioural intervention was not formally assessed.
  - **Registration and protocol:** DRKS00019221; protocol in *Trials* 2022 described it as the first large-scale trial with a TAU-only arm. — [DRKS00019221](https://drks.de/search/en/trial/DRKS00019221); [Trials 2022 protocol PDF](https://oa-fund.ub.uni-muenchen.de/316/1/s13063-022-06155-6.pdf)
- **Companion fMRI RCT (2026, *Scientific Reports*):** no significant group×time interactions on smoking cue-reactivity, and ApBM did not enhance abstinence. — [Nature Sci Rep s41598-026-45748-y](https://www.nature.com/articles/s41598-026-45748-y)
- **Long-term follow-up (2026, *Behaviour Research and Therapy*, S0005796726001439):** a search snippet says ApBM "increased abstinence 4 years later compared to sham", using VR- and app-based training from earlier trials. This is the **only positive long-term signal**. It was seen only as a snippet, and its sample, numbers and design are unverified. — [ScienceDirect](https://www.sciencedirect.com/science/article/pii/S0005796726001439)
- **Qualitative 4-year follow-up (*JMIR Human Factors* 2026):** participants from 2 prior ApBM RCTs often remembered the training's intent years later. It reports experiences, not efficacy. — [JMIR Hum Factors e93238](https://humanfactors.jmir.org/2026/1/e93238)
- **Machulska et al. (2023), smartphone ApBM:** N=131 smokers seeking abstinence, all given a cessation intervention, then randomized to app-ApBM, app-sham or no training. Training ran at home on **14 consecutive days**, with outcomes at pre, post and 6-week follow-up. — [Siegen repository](https://dspace.ub.uni-siegen.de/handle/ubsi/1919); [ISRCTN15690771](https://www.isrctn.com/ISRCTN15690771); [Protocol, *Trials* 2019, DOI 10.1186/s13063-019-3835-0](https://trialsjournal.biomedcentral.com/counter/pdf/10.1186/s13063-019-3835-0.pdf)
  - App-ApBM reduced cigarettes **more than no training**.
  - **Both** active and sham training reduced nicotine dependence more than no training.
  - Sham was better on alcohol use.
  - Approach bias for *positive* cues rose after training but **did not mediate** outcome. Other biases were unchanged.
  - The journal (*Int J Ment Health Addict*?) is unconfirmed, and effect sizes were not retrieved.
- **Machulska et al. (2016)** "Approach bias modification in inpatient psychiatric smokers," *J Psychiatr Res* 76:44–51, DOI 10.1016/j.jpsychires.2015.11.015. Note: this is *J Psychiatr Res*, **not** *Addict Behav* as stated in the brief. — [Siegen publication list](https://psychologie.uni-siegen.de/professuren/klucken/files/publikationsliste.pdf); [Trials 2019 protocol](https://trialsjournal.biomedcentral.com/counter/pdf/10.1186/s13063-019-3835-0.pdf)
  - AAT training produced a larger reduction in nicotine consumption at 3-month follow-up than sham. The sham pushed and pulled smoking pictures **equally often (50/50)**.
  - There was **no evidence** that reduced approach bias was the mechanism.
- **Baird et al. (2017)** "Reducing approach bias to achieve smoking cessation: a pilot randomized placebo-controlled trial," *Cogn Ther Res*, DOI 10.1007/s10608-017-9835-z. The record exists but its results were not retrieved. A 2019 protocol summarises smoking ApBM effects as "small in size or… even mixed." — [Springer](https://link.springer.com/10.1007/s10608-017-9835-z); [Trials 2019 protocol](https://trialsjournal.biomedcentral.com/counter/pdf/10.1186/s13063-019-3835-0.pdf)
- **Modif-i Tobacco (ACTRN12624000633583):** an Australian RCT of a smartphone CBM app in which users **swipe** tobacco versus non-tobacco images. No results were found. — [ANZCTR](https://anzctr.org.au/ACTRN12624000633583.aspx)
- **Cristea, Kok & Cuijpers (2016)** *PLOS ONE* 11(9):e0162226, DOI 10.1371/journal.pone.0162226. 25 RCTs of CBM for addiction gave **g=0.08 (95% CI −0.02 to 0.18)** at post-test, not significant. — [PMC5017662](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5017662/)
- **Boffo et al. (2019)** *Neuropsychol Rev* 29:52–78, DOI 10.1007/s11065-018-9386-4. A Bayesian individual-participant-data meta-analysis of CBM for alcohol and tobacco, with outcomes of bias change and use or relapse. Its numeric results were not retrieved. — [HAL record](https://hal.parisnanterre.fr/hal-04329027v1); [PMC6499757](https://pmc.ncbi.nlm.nih.gov/articles/PMC6499757)
- **Alcohol IPD update (Pan et al., *Clin Psychol Rev* 2026):** 23 studies, 8,297 participants. Small unadjusted effects on bias and **relapse (NNT 18.7)**, none on consumption, and attenuated after moderator adjustment. This is alcohol, not tobacco, and the record URL attribution is uncertain. — [EUR Pure record](https://pure.eur.nl/en/publications/cognitive-bias-modification-in-alcohol-use-disorder-and-problemat/)

### Inferences
- **R11. Position.** Ship ApBM, if at all, as an optional "train your automatic reactions" mini-game with honest copy ("research results are mixed"). Do not count it toward core efficacy claims, and do not put it in the acute craving SOS flow ahead of breathing or movement, which have better acute evidence.
- **R12. Protocol if built.** This mirrors the verified features of the trials:
  - **Dose:** daily sessions over **14 consecutive days** (Machulska 2023).
  - **Task:** smoking images are *pushed* away (swipe up or away with a shrinking/zoom-out effect) and neutral or positive images are *pulled* (enlarging). The sham or control variant uses 50/50 push/pull of smoking images (Machulska 2016).
  - **Evaluation:** use an internal randomized A/B test against a sham, because sham often matches active training.
- **R13. Measure honestly.** Log cigarettes per day and abstinence, not only in-app bias scores, because bias change does not mediate outcomes in these trials.

### Gaps
- Trials per session (e.g., "200"), number of sessions in the large trial, image sets and the "90/10 avoid ratio": **not verified this session**. Do not specify these as evidence-based. **[UNVERIFIED]** from memory: Wiers et al. 2011 alcohol ApBM (*Psychol Sci* 22(4):490–497, DOI [10.1177/0956797611400615](https://doi.org/10.1177/0956797611400615)) used about 4 sessions in inpatients and reported about 13 percentage points lower 1-year relapse.
- **[UNVERIFIED]** Wittekind et al. 2015 (*J Behav Ther Exp Psychiatry* 46:115–120, online AAT pilot) and Wittekind et al. 2019 (*Behav Res Ther* 114:35–43, "Approach-avoidance modification as an add-on in smoking cessation"). The brief's attribution of the latter to *J Consult Clin Psychol* appears incorrect, but this was not verified. **[UNVERIFIED]** Kong et al. 2015 adolescent pilot (*Am J Drug Alcohol Abuse*).
- No peer-reviewed results were found for a "SmokeFree ApBM app" or a "Kopetz" app, and no "Wen et al. 2021" CBM meta-analysis was found.
- Boffo 2019 numeric posteriors were not retrieved.

---

## Q6. Slow-paced / resonance-frequency (≈0.1 Hz, ≈6 breaths/min) breathing and HRV biofeedback for craving and withdrawal

### Takeaway
A 2026 *Addiction* meta-analysis (Roxburgh et al.) finds controlled breathing and HRV biofeedback produce a **small, consistent reduction in craving (g=0.30, 95% CI 0.12–0.48; 12 studies; 696 participants)** across substances including nicotine. Effects on withdrawal are uncertain. Smoking-specific trials show **acute, short-lived** craving relief: Shahab 2013, N=96, showed an immediate effect but none at 24 h, with low adherence. HRV biofeedback has small-to-moderate general effects on anxiety and depression. A pacer is a reasonable, low-risk SOS tool. Pacer parameters (6 bpm, exhale longer than inhale, 2–5 min) are physiologically motivated but weakly tested against craving specifically.

### Cited Findings
- **Roxburgh, Rowland, Lubman, Kaur Bains, Pek, Tso, Manning & Arunogiri (2026)** "Controlled breathing and heart rate variability biofeedback for substance use-related outcomes: a systematic review and meta-analysis," *Addiction*, early online, DOI 10.1111/add.70542 (searches to November 2025). — [drugsandalcohol.ie record](https://www.drugsandalcohol.ie/46435/); [Addiction press release](https://addictionjournal.org/press-release/controlled-breathing-may-reduce-drug-cravings-new-study-finds/); [HealthDay](https://www.healthday.com/health-news/mental-health/breathing-exercises-can-curb-addiction-cravings-review-finds); [Neuroscience News](https://neurosciencenews.com/controlled-breathing-cravings-addiction-31157/); [News-Medical](https://www.news-medical.net/news/20260729/Controlled-breathing-shows-promise-for-reducing-substance-use-cravings.aspx)
  - **Scope:** 20 studies and 1,249 participants overall, 15 of them meta-analysed.
  - **Craving:** **g=0.30 (0.12–0.48), I²=23.5%, 12 studies, n=696.**
  - **Withdrawal:** g=0.46 (95% CI −0.28 to 1.19), I²=89.7%, 4 studies, n=289. Uncertain.
  - **Dependence:** g=0.85, 2 studies, n=144. Preliminary.
  - **Substances:** effects were consistent across nicotine, alcohol, opioids, stimulants and polysubstance use, but **no nicotine-only estimate** was reported in the summaries.
  - **Conflict:** HealthDay reports no difference between breathing types. Neuroscience News reports HRVB evidence concentrated in multi-session protocols and non-HRVB breathing having stronger evidence for *immediate single-session* relief. Check the paper.
- **Shahab, Sarkar & West (2013)** "The acute effects of yogic breathing exercises on craving and withdrawal symptoms in abstaining smokers," *Psychopharmacology* 225(4):875–882, DOI 10.1007/s00213-012-2876-9. — [UCL Discovery](https://discovery.ucl.ac.uk/id/eprint/1380458/); [Springer PDF](https://link.springer.com/content/pdf/10.1007%2Fs00213-012-2876-9.pdf)
  - **Design:** RCT, N=96, yogic breathing versus video control.
  - **Results:** all craving measures were reduced **immediately** after the session, with **no** effect on mood or physical symptoms. Adherence over the next 24 h was low, and there was **no craving reduction at 24 h**.
- **McClernon, Westman & Rose (2004)** "The effects of controlled deep breathing on smoking withdrawal symptoms in dependent smokers," *Addict Behav* 29(4):765–772, DOI 10.1016/j.addbeh.2004.02.005. — [Duke Scholars](https://scholars.duke.edu/publication/697782); [PMC review table](https://pmc.ncbi.nlm.nih.gov/articles/PMC6422009/table/T2)
  - **Design:** within-subject lab study. Smokers abstained for 4 h. In one session they took a series of deep breaths every 30 min; in the control session they sat quietly. About 21 participants (per a later review table).
  - **Results:** deep breathing reduced withdrawal symptoms, including craving and negative affect, while keeping arousal at baseline. Heavier smoking history was linked to larger arousal increases during breathing. The authors called it preliminary.
- **Balban et al. (2023)** "Brief structured respiration practices enhance mood and reduce physiological arousal," *Cell Rep Med* 4(1):100895, DOI 10.1016/j.xcrm.2022.100895, NCT05304000. — [PMC9873947](https://pmc.ncbi.nlm.nih.gov/articles/9873947/); [Stanford Huberman Lab page](https://hubermanlab.stanford.edu/publications/brief-structured-respiration-practices-enhance-mood-and-reduce-physiological-arousal?.com)
  - **Design:** remote RCT of 5 min/day for 1 month comparing cyclic sighing, box breathing, cyclic hyperventilation with retention, and mindfulness meditation. Physiology was measured with a consumer wearable.
  - **Results:** breathwork, **especially exhale-focused cyclic sighing**, improved mood and reduced respiratory rate more than mindfulness (p<0.05). The cyclic-sighing advantage grew with days of practice. All arms improved positive affect and reduced state anxiety.
  - **Limits:** not a smoking sample, and effect sizes were not retrieved.
- **Lehrer et al. (2020)** "Heart rate variability biofeedback improves emotional and physical health and performance: a systematic review and meta-analysis," *Appl Psychophysiol Biofeedback* 45(3):109–129, DOI 10.1007/s10484-020-09466-z. — [AAPB PDF](https://aapb.starchapter.com/images/meta_analysis_andstatus_of_field_.pdf); [Rutgers record](https://scholarship.libraries.rutgers.edu/esploro/outputs/journalArticle/Heart-Rate-Variability-Biofeedback-Improves-Emotional/991031738034904646)
  - 58 studies (from 1,868 screened) showed a **small-to-moderate** effect favouring HRVB, comparable to other effective treatments.
  - The largest effects were for anxiety, depression, anger and athletic/artistic performance; the smallest for PTSD, sleep and quality of life.
  - The pooled g was not retrieved.
- **HRVB for depressive symptoms:** a meta-analysis of 14 RCTs found **g=0.38**. — [PMC7988005](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7988005/)

### Inferences
**R14. Breathing pacer spec (default):**
- **Rate:** 6.0 breaths/min (0.1 Hz; 10-s cycle), user-adjustable from 4.5 to 7.0 bpm. The default should be **inhale 4 s, exhale 6 s (40:60)**. Making the exhale longer than the inhale is motivated by the cyclic-sighing (exhale-emphasis) results and general vagal physiology, but its craving-specific advantage is unverified.
- **Duration:** a minimum of 2 min, with a recommended 5 min (Balban's 5-min dose, matching typical single-session breathing studies).
- **Variant:** offer a "cyclic sigh" mode (double inhale through the nose, long exhale through the mouth, for 5 min) as a second option.
- **Guidance and feedback:** use haptic and visual pacing, show craving ratings before and after (0–10), and nudge repetition because effects are acute.
- **Hourly prompts:** follow McClernon's repeated-every-30-min design and Shahab's finding of decay by 24 h by offering short repeated bouts during the first abstinent days.

**R15. Personal resonance frequency.** RF estimation needs a beat-to-beat HR signal, from a chest strap or validated camera-PPG. Without one, use the 6-bpm default. If HR data are available, step through rates from about 6.5 down to 4.5 bpm in 2-min blocks and choose the rate with the largest HR oscillation amplitude. This protocol is **[UNVERIFIED]** this session (see Gaps).

**R16. Claims.** Market the pacer as "may ease a craving in the moment (small effect)". Do not market it as a quit aid. Measure in-app before/after craving as an engagement and efficacy signal.

**Safety:** cap any hyperventilation-type breathing (e.g., cyclic hyperventilation with retention) out of the craving flow, because of dizziness risk. This is an inference; no smoking-specific safety data were found.

### Gaps
- **[UNVERIFIED] Lehrer & Gevirtz (2014)** *Front Psychol* 5:756, DOI [10.3389/fpsyg.2014.00756](https://doi.org/10.3389/fpsyg.2014.00756). Mechanisms of RF breathing at about 0.1 Hz: baroreflex resonance and maximal HR oscillation.
- **[UNVERIFIED] Vaschillo, Vaschillo & Lehrer (2006)** *Appl Psychophysiol Biofeedback* 31(2):129–142, DOI [10.1007/s10484-006-9009-3](https://doi.org/10.1007/s10484-006-9009-3). Resonance about 0.1 Hz, with an individual range commonly cited as roughly 4.5–7 bpm.
- **[UNVERIFIED]** Lehrer, Vaschillo & Vaschillo (2000) RF assessment manual (*Appl Psychophysiol Biofeedback* 25(3):177–191) and Shaffer & Meehan (2020, *Front Neurosci*) practical RF-assessment guide. Neither was retrieved.
- **Inhale:exhale ratio:** **[UNVERIFIED]** Van Diest et al. (2014) *Appl Psychophysiol Biofeedback* 39:171–180, DOI [10.1007/s10484-014-9253-x](https://doi.org/10.1007/s10484-014-9253-x), recalled as finding greater self-rated relaxation with a short-inhale/long-exhale ratio at 6 bpm. **[UNVERIFIED]** Laborde et al. (2022) *Neurosci Biobehav Rev* 138:104711 meta-analysis of slow breathing on HRV. The search budget was exhausted before either could be checked, so the 40:60 default is therefore a design choice, not an evidence-based optimum for craving.
- **[UNVERIFIED]** Zaccaro et al. (2018) *Front Hum Neurosci* 12:353 (slow-breathing review) and Ma et al. (2017) *Front Psychol* 8:874 (8-week diaphragmatic breathing lowered salivary cortisol). Not retrieved. **[UNVERIFIED]** Cropley, Ussher & Charitou (2007) *Addiction* 102(6):989–993 tested a body-scan relaxation, not paced breathing, on craving.
- No nicotine-specific pooled estimate exists in the retrieved summaries of Roxburgh 2026. No RCT was found testing a 6-bpm smartphone pacer against a control on smoking abstinence. HRVB-for-addiction trials (e.g., Eddie 2015; Penzlin 2015 for alcohol) were not retrieved.

---

## Q7. Exercise as an acute craving tool (the 180-second "move" option)

### Takeaway
Short bouts of physical activity reduce cigarette craving acutely and robustly. In an individual-participant-data meta-analysis, the SMD for strength of desire was about −1.9 to −2.0, with all studies pointing the same way. Effects lasted up to about 50 min, and time to next cigarette was 2–3× longer. The shortest verified effective doses were **5 min of isometric exercise** and **15 min at low intensity (24% HRR)**. A 180-s bout is not directly supported by the retrieved evidence.

### Cited Findings
- **Taylor, Ussher & Faulkner (2007)** "The acute effects of exercise on cigarette cravings, withdrawal symptoms, affect and smoking behaviour: a systematic review," *Addiction* 102(4):534–543. — [Plymouth record](https://researchportal.plymouth.ac.uk/en/publications/the-acute-effects-of-exercise-on-cigarette-cravings-withdrawal-sy-2); [Stirling record](https://www.stir.ac.uk/research/hub/publication/498667)
  - **Evidence base:** 14 studies. All 12 that compared exercise with a passive control found benefits on cravings, withdrawal and smoking behaviour. The 2 studies comparing intensities found no difference.
  - **Durability:** effects appeared during exercise and lasted **up to 50 min** after it.
  - **Smoking behaviour:** in 4 studies, time to the next cigarette was **2–3× longer**.
  - **Doses that worked:** from 60–85% HRR for 30–40 min down to **24% HRR for 15 min**, and **isometric exercise for 5 min**.
  - **Limits:** distraction was probably not the main mechanism. Nearly all studies used temporary, experimentally induced abstinence.
- **Haasova et al. (2013)** "The acute effects of physical activity on cigarette cravings: systematic review and meta-analysis with individual participant data," *Addiction*. Author order is listed inconsistently across repositories. — [Exeter ORE](https://ore.exeter.ac.uk/repository/handle/10871/21859); [Plymouth record](https://researchportal.plymouth.ac.uk/en/publications/the-acute-effects-of-physical-activity-on-cigarette-cravings-syst-2/)
  - **Strength of desire:** **SMD −1.91 (95% CI −2.59 to −1.22), 15 studies.**
  - **Desire to smoke:** **SMD −2.03, 17 studies.**
  - **Heterogeneity:** high, but every study pointed in the same direction.
- **Haasova et al. (2014)** *Psychopharmacology* IPD analysis by intensity. Craving reductions on a 0–100 scale versus control were **−9.22 for light, −34.57 for moderate and −31.29 for vigorous** activity. — [Plymouth record](https://researchportal.plymouth.ac.uk/en/publications/the-acute-effects-of-physical-activity-on-cigarette-cravings-expl-2/)

### Inferences
- **R17. "Move" SOS option.** Offer three choices:
  - "3-min starter": brisk walk, stair climb or wall-sit/isometric holds, with a timer.
  - A prompt at the end: "keep going to 5–10 min for a stronger effect."
  - A 10–15 min walk option.
- **Intensity and claims:** encourage *moderate* intensity, because light activity had much smaller effects in the 2014 IPD. Describe the 180-s version as a starter that "may help", and A/B test 3 versus 5 versus 10 min against in-app craving ratings.
- **Pairing:** the effect lasts up to about 50 min, so the move option can be paired with planning for the next high-risk window.

### Gaps
- No retrieved study tests ≤3-min bouts. The 180-s duration is therefore unsupported and should be treated as an adherence-friendly entry point, not an evidence-based dose.
- Most lab evidence uses brief, experimentally induced abstinence. Generalisation to real-world quit attempts and to long-term abstinence is not established here. The Cochrane review of exercise *interventions for cessation* was located but not read.
- Exact DOIs for Taylor 2007 and Haasova 2013/2014 were not captured in search results. They are recalled as **[UNVERIFIED]** DOI 10.1111/j.1360-0443.2006.01739.x (Taylor 2007) and 10.1111/j.1360-0443.2012.04034.x (Haasova 2013) and should be confirmed.
