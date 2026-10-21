# Section 4: UX psychology, interactive lung avatar, color, typography, haptics and gamification

> **Research-session conditions (read first).**
> - **Platform APIs.** Verified against primary docs fetched directly: Apple developer docs and HIG (JSON API at developer.apple.com), Android Developers reference pages, the Rive docs source repo (github.com/rive-app/rive-docs, which is the source of rive.app/docs), Flutter engine/framework source on GitHub, the W3C WCAG source repo and the Material Components Android repo. Every API name below appears in those docs or that source. Where only the type name was verified but not an initializer label, the item is flagged **[label unverified]**.
> - **Literature.** The shared web-search budget ran out partway through. All literature hosts (PubMed/PMC, Crossref, doi.org, publisher sites, Cochrane, ACM DL) were unreachable from this sandbox. Literature claims marked as cited come from search-result abstracts and summaries retrieved before the budget ran out. Studies I could not check in-session are listed under **Gaps** with candidate identifiers marked **UNVERIFIED**. Do not state their findings as fact without checking them.
> - **Cross-references.** Sibling notes already hold verified or flagged detail on related items: lung-age feedback (Parkes 2008, Clair 2019 Cochrane) in `s1_1_lung_function_models.md`; ACT/iCanQuit engagement, the abstinence-violation effect (AVE) and the "cravings last 3–5 min" claim in `s2_1_act_urge_surfing_ave_app_efficacy.md`; 0.1 Hz / 6-bpm resonance breathing in `s2_3_behavioral_econ_apbm_breathing.md`; the Smoke Free full vs reduced trial design in `s3_onboarding_phenotyping.md`.

---

## Q1. Evidence on visualizing smoking harm and personalized feedback (graphic warnings, morphing/face-aging, risk imaging, defensive reactions, self-affirmation)

### Takeaway
Pictorial (graphic) harm imagery reliably beats text for attention, emotional reaction and quit intentions (meta-analysis of 37 studies, N=33,613). In a 4-week RCT it also increased quit attempts (40% vs 34%) and short-term abstinence (5.7% vs 3.8%). Pictorial warnings also provoke more reactance than text. A lung avatar should therefore show baseline harm only briefly and personally. It should give the most visual weight to recovery and agency, and should never use gore-style fear in the craving or slip modes.

### Cited Findings
- **Noar SM, Hall MG, Francis DB, Ribisl KM, Pepper JK, Brewer NT. "Pictorial cigarette pack warnings: a meta-analysis of experimental studies." *Tobacco Control* 2016;25(3):341–354.** 37 studies with 48 independent samples (N=33,613) were pooled with random-effects models. Pictorial warnings beat text-only warnings on 12 of 17 effectiveness outcomes (all p<0.05). They attracted and held attention better, produced stronger cognitive and emotional reactions, and raised intentions not to start and to quit more effectively. Gaps the authors noted: little assessment of actual smoking behaviour, and little theory-based research on mechanisms. — [CDC Stacks record](https://stacks.cdc.gov/view/cdc/42078); [RTI publication page](https://www.rti.org/publication/pictorial-cigarette-pack-warnings). (DOI believed to be 10.1136/tobaccocontrol-2014-051978; it was not resolved in-session.)
  - A news release on the same study gives a different count ("more effective on 20 of 25 outcome measures"). Use the journal abstract figure (12/17). The release also says pictorial warnings **triggered more psychological reactance** than text warnings. — [Newswise release](https://www.newswise.com/articles/view/633903/?sc=sphn); contradicted on the count by the [CDC Stacks abstract](https://stacks.cdc.gov/view/cdc/42078)
- **Brewer NT et al. Pictorial cigarette pack warnings RCT, *JAMA Internal Medicine* 2016.** 2,149 adult smokers in California and North Carolina (Sep 2014–Aug 2015) were randomized to pictorial or text-only warnings on their own packs for 4 weeks; 88% completed. Quit attempts were 40% vs 34% (described as a ~29% relative increase). Abstinence of at least 7 days at study end was 5.7% vs 3.8%. Limitations: short follow-up and possible self-selection. — [UNC Gillings news](https://sph.unc.edu/?p=265319); [UCSF Tobacco Center summary](https://tobacco.ucsf.edu/node/36056); [author PDF](https://noelbrewer.web.unc.edu/wp-content/uploads/sites/16987/2018/10/effect-of-pictorial-cig.pdf) (PMC5458743). (DOI believed to be 10.1001/jamainternmed.2016.2621; not resolved in-session.)
- Lung-age feedback (Parkes 2008 Step2quit) and the Cochrane review of biomedical risk feedback (Clair 2019) are covered in the sibling note `s1_1_lung_function_models.md`. That note reports Step2quit verified 12-month quit at 13.6% vs 6.4% (NNT ≈ 14), with the effect independent of whether lung age was abnormal. Its evidence labels apply; it is not re-verified here. — see `s1_1_lung_function_models.md`

### Inferences
- **Design rule ("show the damage once, then show the healing").** The pictorial-warning evidence supports showing a *personalized* harm visual at onboarding: the lung avatar at quit-day state, computed from pack-years. The reactance finding, plus the general fear-appeal literature (unverified here, see Gaps), argues against repeated graphic harm. After onboarding, the avatar's default narrative should be recovery (a "delta since quit day"), not decay.
- **Calibrate how alarming the avatar looks.** Even at max `tarDensity`, render the lung as stylized, not anatomically gory: no necrotic textures, no blood. Graphic packs work partly through negative affect, but an avatar is seen daily, including during cravings and after slips, when threat may trigger avoidance. Make "graphic baseline" an onboarding-only reveal that users can skip, with a toggle to hide it later.
- **Personalization is the likely active ingredient.** Step2quit gave an individual's own measured result. In the app the avatar parameters should come visibly from the user's own data (pack-years, days smoke-free, cigarettes avoided). Add a "Why does my lung look like this?" sheet that shows the inputs, so the visual reads as *their* evidence rather than generic propaganda. Self-reported or estimated data is weaker than measured data, so A/B-test whether the visual adds anything over numbers alone.
- **Pair any harm visual with an efficacy cue on the same screen.** Examples: "Your cilia start recovering within weeks" plus a one-tap plan. This follows EPPM logic (threat × efficacy) (theory citation unverified; see Gaps).
- **Self-affirmation before the harm reveal (candidate).** Add an optional 20–30-second values-affirmation step during onboarding ("Pick the value that matters most to you: family, health, independence…"), placed *before* the quit-day lung reveal. The supporting study (Harris et al. 2007) is UNVERIFIED in-session. Treat this as an A/B arm, not a requirement.

### Gaps
The following were requested but could not be retrieved or verified in-session (search budget exhausted; hosts unreachable). Identifiers are from prior knowledge and are **UNVERIFIED**:
- Harris PR, Mayle K, Mabbott L, Napper L. "Self-affirmation reduces smokers' defensiveness to graphic on-pack cigarette warning labels." *Health Psychology* 2007;26(4):437–446, DOI 10.1037/0278-6133.26.4.437. Exact effects (fear, message acceptance, intentions) not verified.
- Brinker TJ et al., face-aging / photoaging apps ("Smokerface"): candidate papers include *JMIR* 2017;19(9):e326 (DOI 10.2196/jmir.8743, "A Dermatologist's Ammunition in the War Against Smoking: A Photoaging App") and *JMIR* 2018 HIV-clinic waiting-room pilot (DOI 10.2196/10976). Titles, years and outcomes not verified. The user's "Brinker 2017 JMIR Photoaging smartphone app" may be one of these.
- Burford O, Jiwa M, Carter O, Parsons R, Hendrie D. "Internet-based photoaging within Australian pharmacies to promote smoking cessation: randomized controlled trial." *JMIR* 2013;15(3):e64, DOI 10.2196/jmir.2337. I recall a large difference in 6-month quit rates favouring photoaging; the figures are **not verified**.
- Bovet P et al. "Improved smoking cessation in smokers given ultrasound photographs of their own atherosclerotic plaques." *Prev Med* 2002;34(2):215–220, DOI 10.1006/pmed.2001.0976. Not verified.
- "Shahab 2007 Thorax lung age/COPD feedback" could not be identified. A candidate is Shahab L, Hall S, Marteau T, "Showing smokers with vascular disease images of their arteries to motivate cessation: a pilot study," *Br J Health Psychol* 2007 (not verified). The Thorax reference may be a different Shahab paper on COPD prevalence. Treat the requested citation as unconfirmed.
- Fear-appeal theory and meta-analyses: Witte K 1992 EPPM (*Commun Monogr* 59:329–349, DOI 10.1080/03637759209376276); Tannenbaum MB et al. 2015 *Psychol Bull* 141(6):1178–1204 (DOI 10.1037/a0039729); Kok G et al. 2018 *Health Psychol Rev* 12(2):111–125 (DOI 10.1080/17437199.2017.1415767). All UNVERIFIED in-session.
- No study was found (or searchable) that tests an *animated, data-driven organ avatar* for cessation specifically. Expected efficacy has to be extrapolated from pictorial-warning and risk-feedback evidence.

---

## Q2. "Quitter's flu": transient post-cessation symptoms, time course, and how to message them

### Takeaway
A prospective cohort (Ussher et al. 2003, n=174) found significant **increases in cold symptoms (including coughing and sore throat) and mouth ulcers after 1 and 2 weeks of abstinence**. The authors explicitly recommended telling smokers in advance, because psychological preparation may reduce the impact. The best-documented window is therefore **weeks 1–2**, which is earlier than the "weeks 2–4" in the brief. Hughes (2007) is the standard reference for withdrawal time course; its content was not verified in-session. Secondary evidence shows most withdrawal symptoms falling sharply over the first days, then declining more slowly through weeks 2–3.

### Cited Findings
- **Ussher M, West R, Steptoe A, McEwen A. "Increase in common cold symptoms and mouth ulcers following smoking cessation." *Tobacco Control* 2003;12(1):86–88 (DOI 10.1136/tc.12.1.86).** 174 smokers in a 7-week programme (behavioural support plus NRT) were tracked from 1 week before quitting to 6 weeks after. Among those still abstinent at 6 weeks:
  - Cold symptoms rose significantly after 1 and 2 weeks of abstinence.
  - After 1 week there were significant increases in **sore throat, coughing, deafness and sneezing**.
  - Mouth ulcers rose after 1 and 2 weeks (p=0.004 and p=0.008).
  - Authors' advice: "smokers should be informed that they have an increased chance of experiencing these symptoms on stopping smoking," and "being psychologically prepared for these effects may reduce their impact."
  - Design caveat: single cohort, no control group.
  — [PMC1759110](https://pmc.ncbi.nlm.nih.gov/articles/PMC1759110); [Tobacco Control citation page](https://tobaccocontrol.bmj.com/content/12/1/86.citation-tools); [UCL Discovery PDF record](https://discovery-pp.ucl.ac.uk/id/eprint/342)
- Press coverage of Ussher 2003 said all symptoms subsided by six weeks. The authors linked ulcers to loss of smoking's antibacterial effect and cold symptoms to a temporary dip in immune function. These mechanisms were hypotheses, and the article noted that relapse effects were not fully investigated. — [HealthDay](https://www.healthday.com/health-news/digestive-system/as-if-quitting-smoking-wasn-t-hard-enough-511915.html)
- **Hughes JR. "Effects of abstinence from tobacco: valid symptoms and time course." *Nicotine & Tobacco Research* 2007;9(3):315–327, DOI 10.1080/14622200701188919.** The citation is confirmed by the journal issue listing; its specific time-course claims were not retrieved in-session. — [NTR vol 9 issue 3 listing](https://dbpia.nl.go.kr/ntr/issue/9/3)
- A 21-day abstinence study found that "most symptoms decreased sharply during the first few days of cessation followed by a continued, but slower rate of decline in the second and third week of abstinence." — [UT Health San Antonio scholars record](https://scholars.uthscsa.edu/en/publications/reports-of-smoking-withdrawal-symptoms-over-a-21-day-period-of-ab/)
- A 2020 meta-analysis of early abstinence found significant (p<0.0001) increases in anxiety, anger/irritability, depressed mood/sadness and composite negative affect in the 24 hours after cessation. It cites Hughes 2007a for negative mood and anxiety during abstinence. — [Conti et al. 2020 accepted manuscript, St Andrews repository](https://research-repository.st-andrews.ac.uk/bitstream/10023/23233/1/Conti_2020_Severity_of_negative_mood_NBR_AAM.pdf)

### Inferences
- **Configurable "Clearance window" state.** Default window: day 3 to day 42, peak emphasis days 7–21 (matching the Ussher 1–2-week signal and its 6-week resolution). Make it a server-configurable range, not hard-coded to the brief's weeks 2–4. Enter it automatically by days-since-quit, or when the user logs "more cough/phlegm/sore throat" in a symptom check-in.
- **Anticipatory guidance (pre-emptive, per Ussher's recommendation).**
  - Day 2–3 notification and in-app card: "Some people notice more coughing, a sore throat or cold-like symptoms in the first couple of weeks. It's common and usually temporary. Your lungs are adjusting."
  - Repeat it as a "What you might feel this week" timeline item.
  - Copy should be hedged ("common", "usually", "may"). The causal story ("cilia waking up and clearing mucus") was not verified in-session, so avoid stating it as fact. Example: "Many doctors think this is partly your airways clearing out."
- **Avatar behaviour during the Clearance window.** Make the cough read as *cleanup*:
  - (1) Raise the `ciliaMotility` visual: faster, more coordinated upward travelling wave.
  - (2) Spawn "debris" particles that travel *up and out* of the bronchi (a mucus-escalator metaphor) and dissolve at the trachea.
  - (3) Visibly lower `tarDensity` during each particle exit, so the cough and the cleanup are causally linked on screen.
  - (4) Draw `bronchialInflammation` in a warm amber "repair" tint, not alarm red.
  - (5) Optional: a "cough log" button that plays a 1.5 s "clear-out" burst animation and records a symptom data point.
- **Safety net (needs clinical sign-off).** Positive reframing must not hide serious illness. Include a clinician-reviewed "When to get checked" list (e.g., coughing blood, chest pain, breathlessness, fever, symptoms persisting beyond the expected window). Exact thresholds were not sourced here and must come from clinical guidance.
- **Measure misattribution.** Ask a one-tap EMA during the window: "Do you think these symptoms mean quitting is bad for you?" (Y/N). Track it against lapse rates. This tests the Ussher hypothesis that symptoms may drive relapse.

### Gaps
- Mucociliary-clearance recovery time course after cessation (cilia function, mucus clearance rates) was not retrieved, and the cleanup mechanism for post-quit cough was not verified in-session. The avatar narrative should stay metaphorical until it is sourced.
- No trial was found (or searchable) that tests anticipatory guidance about post-cessation symptoms against no guidance. The recommendation rests on Ussher's expert advice.
- Cough-specific longitudinal data (e.g., Lung Health Study) and a post-quit sputum time course were not retrieved.
- The detailed figures and tables of Hughes 2007 (symptom-specific onset, peak and duration) were not retrieved.

---

## Q3. Visual state-machine design: Rive (data binding), custom-shader alternatives, parameter mappings, easing, reduced motion

### Takeaway
**Rive has deprecated state-machine Inputs in favour of Data Binding (View Models).** New work should bind the five lung variables as **number properties on a View Model**, drive 1D blend states and converters from them, and set them at runtime:
- Flutter: `vmi.number('path')!.value = x`
- Apple "New Runtime": `viewModelInstance.setValue(of: NumberProperty(path:), to:)`
- Android Compose: `vmi.setNumberProperty(path, value)`

Rive converters include **Range Map, Numeric Interpolator and Color Interpolator**, so smoothing and remapping can live inside the `.riv`. Custom-shader alternatives are viable: Flutter `FragmentProgram`/`FragmentShader` (uniform setters verified), and Android `RuntimeShader` (AGSL, API 33+).

### Cited Findings
**Rive: deprecation and core concepts**
- The Rive editor docs page for Inputs is headed "⚠️ DEPRECATED: Use Data Binding instead of Inputs". It says: "For new projects: Use Data Binding… For existing projects: Plan to migrate from Inputs to Data Binding as soon as possible," and "Data Binding is considered best practice since View Models are both more powerful and easier to control at runtime." The runtime Inputs pages (generic and Flutter) carry the same deprecation. — [Rive docs source: editor/state-machine/inputs.mdx](https://github.com/rive-app/rive-docs/blob/main/editor/state-machine/inputs.mdx) (published at rive.app/docs/editor/state-machine/inputs); [runtimes/flutter/inputs.mdx](https://github.com/rive-app/rive-docs/blob/main/runtimes/flutter/inputs.mdx)
- Legacy Flutter input API, for reference only: `stateMachine.number('myNumber')`, `stateMachine.boolean('myBool')`, `stateMachine.trigger('myTrigger')`, `myTrigger.fire()`, with nested `number(name, path: 'path/to/input')`. — [runtimes/flutter/inputs.mdx](https://github.com/rive-app/rive-docs/blob/main/runtimes/flutter/inputs.mdx)
- **Blend states.** There are three animation-state types: Single Animation, **1D Blend** and **Direct Blend**. "A 1D Blend State allows us to mix multiple timelines together with a single numerical view model property… Note that this mixing is not linear, but is additive and could give you unexpected results." Docs advise "use timelines with only a few properties keyed." Default states are Entry, Exit and Any State. — [editor/state-machine/states.mdx](https://github.com/rive-app/rive-docs/blob/main/editor/state-machine/states.mdx)
- **Layers.** "A state machine layer can play one state at a time. Add multiple layers when you want a state machine to play multiple animations… at once." Layer order sets priority when layers key the same property: "the animation in the lower layer takes priority." — [editor/state-machine/layers.mdx](https://github.com/rive-app/rive-docs/blob/main/editor/state-machine/layers.mdx)
- **Converters.** Number converters: **Range Map** ("Map a value from one range to another"), **Interpolator** ("Smoothly transitions between number values over time, easing changes instead of jumping instantly") and **Formula** (custom expressions, including `random()` with Once/Always modes). Color: **Color Interpolator**. Converter parameters can themselves be bound, e.g. a range map's max. — [editor/data-binding/converters.mdx](https://github.com/rive-app/rive-docs/blob/main/editor/data-binding/converters.mdx)

**Rive Flutter runtime (package `rive` 0.14.x; 0.14.11 bumps `rive_native` 0.1.11)**
- Loading and controller:
  - `File.asset('assets/x.riv', riveFactory: Factory.rive)`
  - `RiveWidgetController(file, stateMachineSelector: StateMachineSelector.byName('…'))`
  - `RiveWidget(controller: controller)`
  - `controller.active = false` pauses advancing and drawing.
  — [runtimes/flutter/state-machines.mdx](https://github.com/rive-app/rive-docs/blob/main/runtimes/flutter/state-machines.mdx); [pub.dev rive changelog](https://pub.dev/packages/rive/changelog)
- Data binding:
  - `controller.dataBind(DataBind.auto())`, or `DataBind.byName('VM')`, `DataBind.byIndex(0)`, `DataBind.byInstance(vmi)`.
  - Manual binding: `file.defaultArtboardViewModel(artboard)`, `vm.createDefaultInstance()`, `stateMachine.bindViewModelInstance(vmi)`.
  - Properties: `vmi.number("My Number Property")!` with `.value` get/set, `.addListener(cb)`, `.removeListener`, `.clearListeners()`, `.dispose()`. Nested paths look like `vmi.number("Nested VM/Child/Value")`.
  — [runtimes/flutter/data-binding.mdx](https://github.com/rive-app/rive-docs/blob/main/runtimes/flutter/data-binding.mdx)
- The official example also uses `.color('Energy_Bar/Bar_Color')!`, `.string('…')!`, `.trigger('Button/Pressed')!`, `.enumerator('…')!` and `.viewModel('…')!`. — [rive-flutter example databinding.dart](https://github.com/rive-app/rive-flutter/blob/master/example/lib/examples/databinding.dart)
- Timing caveat: an instance's initial values are not applied to bound elements until the state machine or artboard advances. — [rive.app Flutter data binding (search snippet)](https://rive.app/docs/runtimes/flutter/data-binding)

**Rive Apple runtime ("New Runtime" vs Legacy)**
- New Runtime: property APIs are on `ViewModelInstance` and called from a main-actor context. Reads use `try await`; sets "queue the change and return immediately."
  - Types: `NumberProperty` (Swift `Float`; read, write, `valueStream(of:)`), `BoolProperty`, `ColorProperty`, `EnumProperty`, `StringProperty`, and `TriggerProperty` (`fire(trigger:)`, `stream(of:)`).
  - Example: `let p = NumberProperty(path: "path/to/number"); viewModelInstance.setValue(of: p, to: 9001)`.
  - Binding: `try await artboard.createStateMachine(binding: viewModelInstance)` and `try await stateMachine.bindViewModelInstances(main:)`.
- Legacy runtime: `instance.numberProperty(fromPath:)!.value = …`, `triggerProperty(fromPath:)!.trigger()`, `riveViewModel.riveModel!.stateMachine.bind(instance)`.
— [runtimes/apple/data-binding.mdx](https://github.com/rive-app/rive-docs/blob/main/runtimes/apple/data-binding.mdx) (the docs label the tabs "New Runtime" vs Legacy)

**Rive Android runtime (Compose vs Legacy)**
- Compose: `val vmi = rememberViewModelInstance(riveFile, source)`; `vmi.setNumberProperty("Path/To/Property", 10f)`; reads via a Kotlin `Flow`: `vmi.numberPropertyFlow("Path").collectAsState(initial = 0f)`.
- Legacy: `vmi.getNumberProperty("…").value = 10f` and `numberProperty.valueFlow.collect { … }`.
— [runtimes/android/data-binding.mdx](https://github.com/rive-app/rive-docs/blob/main/runtimes/android/data-binding.mdx)

**Custom-shader alternatives**
- Flutter (`dart:ui`, stable):
  - `FragmentProgram.fromAsset(String assetKey)` → `program.fragmentShader()` → `FragmentShader`.
  - Uniform setters: `setFloat(int index, double value)`, `setImageSampler(int index, Image image, {filterQuality})`, and the named-uniform API `getUniformFloat(name, [index])`, `getUniformVec2/3/4(name)` (each returns a slot with `.set(...)`), plus `getImageSampler(name)`.
  — [Flutter engine source painting.dart (stable)](https://github.com/flutter/flutter/blob/stable/engine/src/flutter/lib/ui/painting.dart)
- Android: `RuntimeShader` "calculates a per-pixel color based on the output of a user defined Android Graphics Shading Language (AGSL) function." `setFloatUniform(String, float[])`, `setColorUniform(String, int)` and `setInputShader(String, Shader)` were all added in API 33. — [RuntimeShader reference](https://developer.android.com/reference/android/graphics/RuntimeShader)
  - Compose usage: `ShaderBrush(RuntimeShader(src))` with `setFloatUniform("iResolution", w, h)`. Whole-view effects use `view.setRenderEffect(RenderEffect.createRuntimeShaderEffect(shader, "background"))`, which is "more expensive than drawing a custom View." — [Using AGSL in your Android app](https://developer.android.com/develop/ui/views/graphics/agsl/using-agsl)

**Reduced motion**
- Apple HIG: when Reduce Motion is on, apps should reduce "automatic and repetitive animations, including zooming, scaling, and peripheral motion." Other recommended practices:
  - Tighten springs to reduce bounce.
  - Track animations directly with gestures.
  - Avoid animating z-axis depth.
  - Replace x/y/z transitions with fades.
  - Avoid animating into or out of blurs.
  — [HIG Accessibility](https://developer.apple.com/design/human-interface-guidelines/accessibility)
- iOS flag: `UIAccessibility.isReduceMotionEnabled` (iOS 8.0+). — [Apple docs](https://developer.apple.com/documentation/uikit/uiaccessibility/isreducemotionenabled)
- Flutter: `MediaQueryData.disableAnimations` / `MediaQuery.disableAnimationsOf(context)` (stable). On the Flutter **master** branch a separate `MediaQueryData.reduceMotion` maps to iOS Reduce Motion and "does not automatically alter framework animations." It was absent from the stable branch when fetched. — [media_query.dart (master)](https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/widgets/media_query.dart); [media_query.dart (stable)](https://github.com/flutter/flutter/blob/stable/packages/flutter/lib/src/widgets/media_query.dart)
- Android: `ValueAnimator.areAnimatorsEnabled()` (API 26) returns false if the user set animator duration scale to 0 or Battery Saver disabled animations. — [ValueAnimator reference](https://developer.android.com/reference/android/animation/ValueAnimator)
- WCAG 2.3.3 Animation from Interactions (**Level AAA**): "Support user preferences for motion, and eliminate unnecessary motion effects." Vestibular reactions include dizziness, nausea and headaches. — [WCAG Understanding source](https://github.com/w3c/wcag/blob/main/understanding/21/animation-from-interactions.html); [SC level](https://github.com/w3c/wcag/blob/main/guidelines/sc/21/animation-from-interactions.html)

### Inferences
**Recommended architecture (Rive primary, shader fallback or overlay)**
- One `.riv` with View Model `Lung`, holding number properties `tarDensity`, `bronchialInflammation`, `ciliaMotility`, `alveolarOxygenation` and `respirationRate`. Add an enum `mode` (`inspect` | `craving` | `slip` | `clearance`) and triggers `milestone` and `coughClear`. Do not use legacy Inputs.
- **Layers** (one state each, running in parallel):
  - L1 Breath loop: 1D blend of inhale/exhale poses, driven by a `breathPhase` number written each frame by app code.
  - L2 Tissue: 1D blend `clean ↔ tarred`, driven by `tarDensity`.
  - L3 Airway: 1D blend `calm ↔ inflamed` (`bronchialInflammation`).
  - L4 Cilia: a looping travelling-wave animation; speed comes from app-side time scaling or a Formula converter.
  - L5 Mode overlays (Any State → mode states).
  - Put L5 lowest in the list so mode overlays win when properties overlap (Rive: lower layer has priority).
- Because 1D blends are **additive, not linear** (Rive docs), key **one or two properties per timeline**. Verify midpoints visually; if needed, a Formula converter can pre-warp the input (e.g., `x^0.8`).
- **Smoothing in one place only.** Either use Rive's Numeric/Color Interpolator converters, or a critically damped spring in app code. Doing both stacks the lag.
- Recommended: smooth in app code (testable, and it respects Reduce Motion). Write the already-smoothed values to the View Model each frame while a transition runs, and stop writing at rest to save power.

**Parameter → visual mapping (proposal)**

| Variable (VM number) | Domain | Visual channels | Mapping (pre-smoothing) | Transition |
|---|---|---|---|---|
| `tarDensity` | 0–1 (1 = quit-day load estimated from pack-years) | Soot-speckle layer opacity; tissue saturation; particle count in airways | opacity = 0.85·t; saturation multiplier = 1 − 0.55·t; particles = round(400·t) (shader) or a Range Map 0–1→0–100% in Rive | Daily reveal: animate yesterday → today over 2.5 s |
| `bronchialInflammation` | 0–1 | Airway-wall warm hue shift; wall thickness; vessel glow | hue: neutral pink → **amber/orange (#F6B26B family), not saturated red**; wall scale 1.00 → 1.12; glow alpha 0.4·i | Spring, ~1.5 s settle |
| `ciliaMotility` | 0–1 | Travelling-wave speed and amplitude along bronchi (upward = clearance) | wave speed 0.2 → 1.5 cycles/s (visual metaphor, not physiological rate); amplitude 0.2 → 1.0; phase coherence ↑ with value | Spring, ~1 s; continuous phase accumulator |
| `alveolarOxygenation` | 0–1 | Alveolar brightness/bloom; color temperature | color lerp: cool desaturated slate (≈#5B6573) → luminous peach-coral (≈#FFB59E); bloom 0 → 0.6; sparkle density ↑ | Color Interpolator or spring, ~2 s |
| `respirationRate` | breaths/min, clamp 4–20 | Breath loop period; chest scale amplitude | period = 60/rate s; scale amplitude 2–4%; in `craving` mode locked to 6 bpm (4 s in / 6 s out) | **Phase-continuous** rate change (below) |

- **Phase-continuous breathing (no visual jumps when the rate changes):**
  - Keep a phase accumulator `φ += dt · rate/60`.
  - Map `φ mod 1` to `breathPhase`. For asymmetric 4:6 pacing in craving mode, use inhale fraction 0.4: `p = φmod1 < 0.4 ? easeInOutSine(φmod1/0.4) : 1 − easeInOutSine((φmod1−0.4)/0.6)`.
  - Smooth `rate` itself with a spring, never `breathPhase`.
- **Critically damped spring** (no overshoot, so it reads as calm):
  - `x'' = −2ω·x' − ω²·(x − target)`.
  - With zero initial velocity the error decays as `(1+ωt)·e^{−ωt}`, giving a 2% settling time ≈ **5.83/ω**. For a 1.5 s settle, ω ≈ 3.9 rad/s.
  - Integrate with semi-implicit Euler at the frame dt, clamping dt ≤ 1/30 s.
  - Under Reduce Motion, use ω large (≈ 12) or a 200 ms cross-fade, per the HIG advice to tighten springs and replace motion with fades.
- **Daily "delta reveal".** Daily values move only slightly. Persist the last-seen snapshot; on open, animate from snapshot to current values over 2–2.5 s, then fire the `milestone` trigger if a threshold was crossed. This makes slow physiological change perceptible without exaggerating it.
- **Shader route (if not Rive, or as an overlay for particles and bloom).** Use one fragment shader with uniforms `uTar`, `uInflam`, `uCilia`, `uO2`, `uBreath` (0–1) and `uTime`. Set them in Flutter via `shader.getUniformFloat('uTar').set(v)` (or `setFloat(index, v)`), and on Android 33+ via `runtimeShader.setFloatUniform("uTar", v)`. Keep the particle count small, or do particles procedurally in the shader. Do not advance `uTime` when Reduce Motion is on: render a static, fully informative frame.
- **Reduced-motion variant (all modes).**
  - Freeze cilia waves; show a static "cilia health" arrow-density pattern instead.
  - Replace the breath scale animation with a slow opacity pulse, or a text/haptic countdown ("Breathe in… 4, 3, 2, 1").
  - Drop debris particles; show tarDensity as a static texture plus a numeric label.
  - Turn off camera rotation, bloom pulsing and parallax.
  - Check the Flutter `disableAnimations` (and `reduceMotion` once stable), iOS `UIAccessibility.isReduceMotionEnabled` and Android `ValueAnimator.areAnimatorsEnabled()`.
- **2D vs 3D.** Rive is 2D vector with a runtime renderer, which suits a stylized avatar with reliable performance. A 3D lung needs its own engine (out of scope here). The bound-variable model above works for either.

### Gaps
- Rive's own guidance on performance budgets (number of bound properties or blend states per frame on low-end Android) was not retrieved.
- Rive's handling of the OS reduce-motion setting (whether the runtime reads it at all) was not found. Assume the app must handle it.
- The official Flutter fragment-shader guide (docs.flutter.dev) was unreachable. API names come from engine source instead. Platform-support caveats (e.g., Impeller/Skia limits, supported GLSL subset) were not verified.
- The rive.app site was unreachable directly; all Rive content comes from the official docs source repo, so the published pages could differ slightly.

---

## Q4. Color system (OLED/dark-first, contrast, color psychology, color-blind safety) and typography

### Takeaway
- Base on near-black, not pure black, for layered surfaces. Material's dark default is **#121212**; Material 3 dark surfaces are neutral tones 4–24, i.e. near-black greys. Apple's dark mode uses dimmer "base" and brighter "elevated" backgrounds.
- Meet WCAG AA: **4.5:1** for text, **3:1** for large text and UI components, and **24×24 CSS px** minimum target size. In practice, follow the platform minimums: 44×44 pt on iOS, 48×48 dp on Android.
- Use semantic mode palettes: **teal/oxygen** for inspection, **calm blue/lavender** for cravings (no red), and **warm amber/peach** for slips. Never let color alone carry meaning.
- Use tabular (monospaced) digits for all counters.

### Cited Findings
- **Material (Android).**
  - "The baseline Material Dark theme background and surface colors are dark grey instead of black, which increases visibility for shadows and also reduces eye strain for light text." Listed dark-theme benefits include "improved battery power conservation for devices with OLED screens." — [MDC-Android docs/theming/Dark.md](https://github.com/material-components/material-components-android/blob/master/docs/theming/Dark.md)
  - MDC resources define `design_dark_default_color_background` and `design_dark_default_color_surface` = **#121212**. — [MDC colors.xml](https://github.com/material-components/material-components-android/blob/master/lib/java/com/google/android/material/color/res/values/colors.xml)
  - In Material 3, "Surface with elevation overlays has been replaced… with the tonal surface color system." — [Dark.md](https://github.com/material-components/material-components-android/blob/master/docs/theming/Dark.md)
- **Material 3 dark color roles** (neutral palette tones):
  - `colorBackground` / `colorSurface` / `colorSurfaceDim` = neutral **6**
  - `colorSurfaceContainerLowest` = **4**
  - `colorSurfaceContainerLow` = **10**
  - `colorSurfaceContainer` = **12**
  - `colorSurfaceContainerHigh` = **17**
  - `colorSurfaceContainerHighest` = **22**
  - `colorSurfaceBright` = **24**
  - `colorOnSurface` = **90**
  - `colorOutline` = neutral-variant **60**
  — [MDC-Android docs/theming/Color.md](https://github.com/material-components/material-components-android/blob/master/docs/theming/Color.md)
- **Apple HIG Dark Mode.**
  - "The system uses two sets of background colors — called base and elevated… The base colors are dimmer… elevated colors are brighter." "Prefer the system background colors."
  - Dark Mode palettes have "dimmer background colors and brighter foreground colors."
  - Test with Increase Contrast and Reduce Transparency.
  - A permanently dark appearance can make sense "in rare cases", e.g. immersive media (Stocks); Apple otherwise advises against an app-specific appearance setting.
  — [HIG Dark Mode](https://developer.apple.com/design/human-interface-guidelines/dark-mode)
- **Apple HIG Color.**
  - "Avoid relying solely on color to differentiate between objects, indicate interactivity, or communicate essential information."
  - "Red communicates danger in some cultures, but has positive connotations in other cultures." Example: in the Stocks app, red indicates a positive trend in Chinese.
  - "Avoid hard-coding system color values."
  — [HIG Color](https://developer.apple.com/design/human-interface-guidelines/color)
- **Apple HIG Accessibility.**
  - Minimum contrast: text up to 17 pt needs **4.5:1**; 18 pt needs **3:1**; bold text at any size needs **3:1**.
  - iOS default text 17 pt, minimum 11 pt.
  - iOS control size: default **44×44 pt**, minimum **28×28 pt**; "add about 12 points of padding around elements that include a bezel."
  — [HIG Accessibility](https://developer.apple.com/design/human-interface-guidelines/accessibility)
- **WCAG 2.2.**
  - 1.4.3 Contrast (Minimum) (**AA**): 4.5:1. Thresholds are not rounded ("4.499:1 would not meet"). "18 point text or 14 point bold" counts as large (3:1). — [Understanding 1.4.3](https://github.com/w3c/wcag/blob/main/understanding/20/contrast-minimum.html)
  - 1.4.11 Non-text Contrast (**AA**): "Ensure meaningful visual cues achieve 3:1 against the background." — [Understanding 1.4.11](https://github.com/w3c/wcag/blob/main/understanding/21/non-text-contrast.html)
  - 2.5.8 Target Size (Minimum) (**AA**): at least 24×24 CSS px, with Spacing, Equivalent, Inline, User-agent and Essential exceptions; "consider aiming for the stricter 2.5.5 Target Size (Enhanced)." — [Understanding 2.5.8](https://github.com/w3c/wcag/blob/main/understanding/22/target-size-minimum.html); [SC level](https://github.com/w3c/wcag/blob/main/guidelines/sc/22/target-size-minimum.html)
- **Android touch targets:** "each interactive UI element have a focusable area, or touch target size, of at least 48dp×48dp. Larger is even better." — [Android: Make apps more accessible](https://developer.android.com/guide/topics/ui/accessibility/apps)
- **Apple Dynamic Type, default "Large" size (iOS)** — style: size/leading (pt):
  - Large Title 34/41
  - Title 1 28/34
  - Title 2 22/28
  - Title 3 20/25
  - Headline 17/22 (Semibold)
  - Body 17/22
  - Callout 16/21
  - Subhead 15/20
  - Footnote 13/18
  - Caption 1 12/16
  - Caption 2 11/13
  - The HIG lists larger accessibility steps up to e.g. Large Title 52/61 in the tables retrieved.
  - "Using text styles with the system fonts also ensures support for Dynamic Type"; custom fonts must implement the same behaviours.
  — [HIG Typography](https://developer.apple.com/design/human-interface-guidelines/typography)
- **Tabular digits.**
  - SwiftUI `View.monospacedDigit()` (iOS 15.0+): "Modifies the fonts of all child views to use fixed-width digits." — [Apple docs](https://developer.apple.com/documentation/swiftui/view/monospaceddigit())
  - Flutter `FontFeature.tabularFigures()` (= OpenType `tnum`). — [Flutter engine text.dart (stable)](https://github.com/flutter/flutter/blob/stable/engine/src/flutter/lib/ui/text.dart)
- Android Force Dark (Android 10) auto-darkens light themes. An avatar-centric app should implement a native dark theme instead. — [Android: Implement dark theme](https://developer.android.com/develop/ui/views/theming/darktheme)

### Inferences
**Neutral surface ramp (computed; achromatic equivalents of the M3 tones, derived from CIE L\* = tone)**

| Token | Tone | Hex (computed) | Use |
|---|---|---|---|
| `bg.canvas` | 0 | #000000 | Static full-bleed behind the avatar in craving mode only, where nothing scrolls over it |
| `bg.base` | 4 | #0E0E0E | Craving mode background |
| `surface` | 6 | #131313 | Default app background (≈ MDC #121212) |
| `surface.container` | 12 | #1F1F1F | Cards |
| `surface.high` | 17 | #2A2A2A | Sheets, elevated cards |
| `surface.highest` | 22 | #353535 | Pressed states, chips |
| `on.surface` | 90 | #E2E2E2 | Primary text: 14.3:1 on #131313 |
| `on.surface.variant` | — | #9E9E9E | Secondary text: 6.9:1 on #131313 |

Contrast ratios were computed with the WCAG relative-luminance formula; the script is in the scratchpad. Notably, #7A7A7A on #131313 = 4.33:1 and **fails** 4.5:1 for body text.

- **Black vs near-black.**
  - Pure #000 gives maximum OLED power saving and "infinite" contrast.
  - Material's stated reasons for dark grey are shadow visibility and eye strain.
  - Many OLED panels show smearing or ghosting when content scrolls from true black to dark grey. This is a widely reported panel behaviour but **not sourced in-session**.
  - Recommendation: use #000 only for static backdrops (the craving-mode canvas, where nothing scrolls), and #0E0E0E–#131313 for scrolling surfaces. Validate on Samsung/Pixel OLED panels.
- **Mode accent palettes** (contrast vs #131313 computed):
  - **Inspect / progress:** oxygen teal **#4FD1C5** (9.96:1); healthy-tissue peach **#FFB59E** (10.93:1); lavender **#C6B8FF** (10.35:1) for secondary data.
  - **Craving SOS:** calm blue **#8AB4F8** (8.82:1). The SOS button is filled #8AB4F8 with label text #0B1B33 (8.18:1). **No red, no amber.** The background drops to #0E0E0E so the breath circle is the brightest thing on screen.
  - **Post-slip:** warm amber **#F6B26B** (10.17:1) and peach **#FFB59E**. Button text #2B1700 on #F6B26B = 9.38:1. **No red, and no "error" styling.** HIG notes that red signals danger in many cultures.
  - **Inflammation on the avatar** uses an amber/orange ramp, not saturated red. Reserve soft red (#F28B82, 7.78:1) only for clinical red-flag safety copy.
- **Color-blind safety.** The modes are distinguished by blue vs amber (luminance and hue both differ), which is generally robust for red-green deficiencies; still verify with a CVD simulator. Every state change also carries a text label, an icon and a distinct layout (HIG: don't rely on color alone). On the avatar, encode `tarDensity` as texture (speckle density), not only hue.
- **Typography spec.**
  - Hero counter (days/hours smoke-free, money saved): system font with **tabular digits** (`.monospacedDigit()` / `FontFeature.tabularFigures()` / Compose `fontFeatureSettings = "tnum"` [the Compose property was not verified in-session]). Size ≈ Large Title ×1.5–2 (48–64 pt), scaling with Dynamic Type but capped so it never wraps; use a weight such as Semibold so it stays ≥3:1 when large.
  - Craving countdown: tabular digits, 56–72 pt, plus a ring.
  - Body: Body 17 pt (iOS) / Material 3 Body Large 16 sp. The M3 type scale values were not verified in-session.
  - Test at accessibility sizes (AX1–AX5). Collapse the avatar to a smaller frame rather than truncating text.

### Gaps
- Peer-reviewed color-psychology evidence (e.g., Elliot & Maier 2014 *Annu Rev Psychol* 65:95–120, DOI 10.1146/annurev-psych-010213-115035; Elliot et al. 2007 *J Exp Psychol Gen* on red and avoidance) was **not verified in-session**. The "blue calms, red alarms" claims for health apps are therefore unsourced here. The palette rationale above rests on HIG cultural-meaning guidance and contrast math, not on color-emotion RCTs.
- No source was retrieved on OLED black smear, PWM flicker at low brightness, or power savings of #000 vs #121212.
- The Material 3 type-scale values (Display/Headline/Title/Body/Label sizes) and the m3.material.io dark-theme guidance were unreachable.
- No color-blind-safe palette standard for health apps was retrieved.

---

## Q5. Haptics: iOS Core Haptics and Android VibrationEffect APIs, haptic-paced breathing evidence, and concrete patterns for the 3 modes

### Takeaway
- **iOS:** Core Haptics (iOS 13+) supports `hapticTransient` and `hapticContinuous` events with `hapticIntensity`/`hapticSharpness` (0–1). Parameter curves interpolate intensity linearly over time, and an advanced player can loop (`loopEnabled`, `loopEnd`).
- **Android:** use `VibrationEffect.Composition` primitives (API 30/31; check `areAllPrimitivesSupported`), amplitude waveforms (check `hasAmplitudeControl`), or the new **`BasicEnvelopeBuilder` (API 36)** with intensity/sharpness control points that must end at zero.
- **Evidence:** the PIV work (Miri et al., TOCHI 2020) favoured **frequency-based, strong-exhale-phased** vibrotactile breathing patterns.
- **Craving pacer default:** 0.1 Hz (4 s inhale / 6 s exhale) × **18 cycles = exactly 180 s**, with exhale-weighted haptics and both platforms' guidance against buzzy, overused haptics.

### Cited Findings
**iOS / Apple**
- `CHHapticEvent.EventType`:
  - `hapticTransient`: "A brief impulse occurring at a specific point in time, like the feedback from toggling a switch"
  - `hapticContinuous`: "A haptic event with a looped waveform of arbitrary length"
  - also `audioContinuous` and `audioCustom`
  — [EventType docs](https://developer.apple.com/documentation/corehaptics/chhapticevent/eventtype)
- `CHHapticEvent.ParameterID`: `hapticIntensity`, `hapticSharpness`, `attackTime`, `decayTime`, `releaseTime`, `sustained`, plus audio parameters. — [ParameterID docs](https://developer.apple.com/documentation/corehaptics/chhapticevent/parameterid)
- `CHHapticEngine` (iOS 13.0+) members:
  - `capabilitiesForHardware()`, `init()`, `start()`, `start(completionHandler:)`, `stop(completionHandler:)`
  - `stoppedHandler`, `resetHandler`, `isAutoShutdownEnabled`, `playsHapticsOnly`
  - `makePlayer(with:)`, `makeAdvancedPlayer(with:)`, `playPattern(from:)` (URL or Data)
  - `notifyWhenPlayersFinished(finishedHandler:)`, `currentTime`
  - `CHHapticDeviceCapability.supportsHaptics`
  — [CHHapticEngine](https://developer.apple.com/documentation/corehaptics/chhapticengine); [supportsHaptics](https://developer.apple.com/documentation/corehaptics/chhapticdevicecapability/supportshaptics)
- `CHHapticPattern` initializers: `init(events:parameters:)`, `init(events:parameterCurves:)`, `init(contentsOf:)` (AHAP URL), `init(dictionary:)`. — [CHHapticPattern](https://developer.apple.com/documentation/corehaptics/chhapticpattern)
- `CHHapticPatternPlayer`: `start(atTime:)`, `stop(atTime:)`, `sendParameters(_:atTime:)`, `scheduleParameterCurve(_:atTime:)`, `cancel()`, `isMuted`. `CHHapticAdvancedPatternPlayer` adds `loopEnabled`, `loopEnd`, `playbackRate`, `pause(atTime:)`, `resume(atTime:)`, `seek(toOffset:)` and `completionHandler`. `CHHapticTimeImmediate` schedules a command immediately. — [CHHapticPatternPlayer](https://developer.apple.com/documentation/corehaptics/chhapticpatternplayer); [CHHapticAdvancedPatternPlayer](https://developer.apple.com/documentation/corehaptics/chhapticadvancedpatternplayer)
- `CHHapticParameterCurve(parameterID:controlPoints:relativeTime:)`, with `CHHapticParameterCurve.ControlPoint` items. Curves "interpolate linearly between parameter values" and "apply to all events in a pattern; it isn't possible to apply one to only a single event." — [CHHapticParameterCurve](https://developer.apple.com/documentation/corehaptics/chhapticparametercurve)
- `CHHapticDynamicParameter.ID` values include `hapticIntensityControl`, `hapticSharpnessControl`, `hapticAttackTimeControl`, `hapticDecayTimeControl` and `hapticReleaseTimeControl`. — [Dynamic parameter IDs](https://developer.apple.com/documentation/corehaptics/chhapticdynamicparameter/id)
- **AHAP file format:**
  - Top-level keys are only `Pattern` and `Version`.
  - Events: `EventType` (`HapticTransient` | `HapticContinuous` | `AudioContinuous` | `AudioCustom`), `Time`, a duration key, and `EventParameters` (`ParameterID` + `ParameterValue`, normalized 0–1).
  - Pattern-level `Parameter` (dynamic) and `ParameterCurve` (`ParameterID`, `Time`, `ParameterCurveControlPoints`).
  - `HapticIntensityControl` is "between 0 and 1 and is applied multiplicatively." `HapticSharpnessControl` is −1…1, additive, and "affects only continuous haptics."
  - "Core Haptics… clamps out-of-range values… The framework ignores unsupported keys."
  - The duration key is documented in the term list as **`Duration`**. Apple's sample AHAP files (prior knowledge, unverified in-session) use `EventDuration`. Because unsupported keys are silently ignored, test which key your target OS honours. Better still, build patterns in code.
  — [Representing haptic patterns in AHAP files](https://developer.apple.com/documentation/corehaptics/representing-haptic-patterns-in-ahap-files)
- `UIImpactFeedbackGenerator.FeedbackStyle` (iOS 10+): `light`, `medium`, `heavy`, `soft`, `rigid`; initializers `init(style:)` and `init(style:view:)`. — [FeedbackStyle](https://developer.apple.com/documentation/uikit/uiimpactfeedbackgenerator/feedbackstyle)
- SwiftUI `SensoryFeedback` (iOS 17.0+):
  - Values: `success`, `warning`, `error`, `selection`, `increase`, `decrease`, `start`, `stop`, `alignment`, `levelChange`, `pathComplete`, `impact(weight:intensity:)`, `impact(flexibility:intensity:)`.
  - Played via `.sensoryFeedback(_:trigger:)`, `.sensoryFeedback(_:trigger:condition:)` or `.sensoryFeedback(trigger:_:)`.
  — [SensoryFeedback](https://developer.apple.com/documentation/swiftui/sensoryfeedback)
- **HIG Playing haptics:**
  - "Use haptics consistently… build a clear, causal relationship." Example: if a haptic is associated with failure, don't reuse it for success.
  - "Prefer using haptics to complement other feedback… match the intensity and sharpness of a haptic with the intensity and sharpness of the animation."
  - "Avoid overusing haptics."
  - "In most apps, prefer playing short haptics that complement discrete events… long-running haptics in an app can dilute the meaning."
  - "Make haptics optional."
  — [HIG Playing haptics](https://developer.apple.com/design/human-interface-guidelines/playing-haptics)

**Android**
- `VibrationEffect.Composition` primitives (API level added):
  - `PRIMITIVE_CLICK` (30): "sharp, crisp click"
  - `PRIMITIVE_TICK` (30): "very short… light crisp sensation intended to be used repetitively"
  - `PRIMITIVE_LOW_TICK` (31): "very short low frequency"
  - `PRIMITIVE_QUICK_RISE` (30), `PRIMITIVE_SLOW_RISE` (30): "slow upward movement against gravity"
  - `PRIMITIVE_QUICK_FALL` (30)
  - `PRIMITIVE_THUD` (31): "downwards movement with gravity… reverberation"
  - `PRIMITIVE_SPIN` (31)
  — [Composition reference](https://developer.android.com/reference/android/os/VibrationEffect.Composition)
- Composition methods:
  - `addPrimitive(id)`, `addPrimitive(id, scale)` and `addPrimitive(id, scale, delay)` (API 30). Scale is 0–1; delay is in ms; the default delay type is `DELAY_TYPE_PAUSE`, i.e. a gap after the previous primitive *ends*.
  - `addPrimitive(id, scale, delay, delayType)` (API 36), with `DELAY_TYPE_PAUSE` and `DELAY_TYPE_RELATIVE_START_OFFSET`. "A primitive will be dropped from the composition if it overlaps with previous ones."
  - `compose()`.
  — [Composition reference](https://developer.android.com/reference/android/os/VibrationEffect.Composition)
- `Vibrator` capability checks:
  - `areAllPrimitivesSupported(int...)` (API 30), `getPrimitiveDurations(int...)` (API 31), `hasAmplitudeControl()` (API 26)
  - `areEnvelopeEffectsSupported()`, `getEnvelopeEffectInfo()`, `getFrequencyProfile()` (API 36)
  - `isPresetSupported()`, `getPresetDuration()` ("Added in version 37.2")
  - `vibrate(VibrationEffect, VibrationAttributes)`, `cancel()`
  — [Vibrator reference](https://developer.android.com/reference/android/os/Vibrator)
- `VibrationEffect`:
  - `createOneShot(ms, amplitude)`; `createWaveform(long[] timings, int[] amplitudes, int repeat)` (API 26; amplitudes 0–255, repeat −1 = once)
  - `createPredefined(effectId)` with `EFFECT_CLICK`, `EFFECT_DOUBLE_CLICK`, `EFFECT_HEAVY_CLICK`, `EFFECT_TICK` (API 29)
  - `createRepeatingEffect(effect)` and `createRepeatingEffect(preamble, repeating)` (API 36)
  - `startComposition()`
  - Nested builders `BasicEnvelopeBuilder`, `WaveformEnvelopeBuilder`, `Builder`, `Preset`; `parseFromXml` (version 37.2)
  — [VibrationEffect reference](https://developer.android.com/reference/android/os/VibrationEffect)
- **`VibrationEffect.BasicEnvelopeBuilder` (API 36):**
  - `setInitialSharpness(f)`, `addControlPoint(float intensity, float sharpness, long durationMillis)`, `build()`.
  - Intensity 0–1 ("supported intensity values guarantee… above 10 dB SL"); sharpness 0–1 maps to the device's frequency range.
  - "Effects must end with a zero intensity control point" (otherwise `IllegalStateException`); effects start at 0 intensity.
  - The docs recommend ≤16 control points.
  — [BasicEnvelopeBuilder reference](https://developer.android.com/reference/android/os/VibrationEffect.BasicEnvelopeBuilder)
- **Android custom-effects guidance:**
  - Compositions "don't have automatic fallbacks. If a composition contains even one unsupported primitive, the entire vibration fails to play."
  - On devices without amplitude control, "Non-zero amplitudes are rounded up to 100%."
  - "Use delays of 50 ms or longer for discernible gaps." "Use scales that differ by a ratio of 1.4 or more"; "scales of 0.5, 0.7, and 1.0" give low, medium and high intensity. "A 0.0 scale… indicates minimum perceivable vibration, not off."
  - "Start and end a waveform at zero amplitude whenever possible"; ramping too fast "might also produce audible buzzing noises."
  - `VibrationEffect.Builder` gets automatic framework fallback "starting in Android 16 (26Q4)". `WaveformEnvelopeBuilder` effects have no fallback.
  — [Custom haptic effects](https://developer.android.com/develop/ui/views/haptics/custom-haptic-effects)
- **Android haptics design principles:**
  - Effects are classed as clear, rich and buzzy. "Given the choice of buzzy haptics or no haptics for touch feedback, choose no haptics."
  - "Prioritize predefined haptic constants," and "Correlate event importance and frequency with strength."
  — [Haptics design principles](https://developer.android.com/develop/ui/views/haptics/haptics-principles)
- `VibrationAttributes`:
  - `USAGE_TOUCH` (API 30): tap, long press, drag, scroll.
  - `USAGE_MEDIA` (API 33): "music, movie, soundtrack, animations, games, or any interactive media that isn't for touch feedback specifically."
  - `USAGE_ACCESSIBILITY` (API 33); `createForUsage(int)` (API 33).
  — [VibrationAttributes](https://developer.android.com/reference/android/os/VibrationAttributes)
- `HapticFeedbackConstants`: `CONFIRM` and `REJECT` (API 30), `GESTURE_START`/`GESTURE_END` (30), `SEGMENT_TICK`/`SEGMENT_FREQUENT_TICK`/`TOGGLE_ON` (34). — [HapticFeedbackConstants](https://developer.android.com/reference/android/view/HapticFeedbackConstants)

**Evidence on vibrotactile breathing pacing**
- Miri P et al. "PIV: Placement, Pattern, and Personalization of an Inconspicuous Vibrotactile Breathing Pacer," *ACM TOCHI* 2020. It examines which vibrotactile pattern works best for paced breathing and where tactors should sit. The authors favoured **frequency-based, strong-exhale-phased patterns** and abdomen placement for future studies. — [Stanford HCI paper page](https://hci.stanford.edu/publications/paper.php?id=384); [WeHAB PIV project](https://wehab.stanford.edu/research/piv)
- Miri P et al. "PIV++: Evaluating a Personalizable, Inconspicuous Vibrotactile (PIV) Breathing Pacer for In-the-Moment Affect Regulation," *CHI 2020*. It tested PIV for reducing anxiety under a cognitive stressor and is described as the first mixed-design study of a vibrotactile affect-regulation technology that accounts for individual differences and user-technology engagement. — [Stanford HCI paper page](https://hci.stanford.edu/publications/paper.php?id=383); [UCSC SET Lab](https://setlab.soe.ucsc.edu/research/PIV)
  - Note: the brief's title "PIV: Placement, Pattern, and Personalization…" is the **TOCHI** paper. The **CHI 2020** paper is PIV++.
- Rationale for 0.1 Hz (6 bpm) and the 4 s/6 s split: see sibling note `s2_3_behavioral_econ_apbm_breathing.md`. It recommends 6.0 bpm (inhale 4 s, exhale 6 s), adjustable from 4.5 to 7.0 bpm, and flags Lehrer & Gevirtz 2014 as unverified.

### Inferences
**Haptic grammar (consistent meanings across the app, per HIG and Android principles)**

| Meaning | iOS | Android | Used in |
|---|---|---|---|
| Neutral tap / select | `UIImpactFeedbackGenerator(style: .soft)` or `.sensoryFeedback(.selection, …)` | `HapticFeedbackConstants.CONFIRM` / `PRIMITIVE_TICK` @0.5 | Inspect: tapping lung regions |
| Progress / milestone | `.sensoryFeedback(.success, trigger:)` | `PRIMITIVE_SLOW_RISE` @0.5 → 60 ms → `PRIMITIVE_CLICK` @0.7 | Inspect: delta reveal end, badge |
| Breath pacer | Continuous + curve (below) | Envelope / waveform / primitives (below) | Craving only |
| "Clear-out" (cough log) | 3× `hapticTransient` 80 ms apart, intensity 0.3→0.5, sharpness 0.6 | 3× `PRIMITIVE_LOW_TICK` @0.5, 0.7, 1.0 (≥1.4 ratio) with 60 ms gaps | Clearance window |
| Commit after slip | `UIImpactFeedbackGenerator(style: .soft)` once | `CONFIRM` | Slip mode "Back on track" |
| **Never used** | `.error` / `.warning`, heavy/rigid impacts | `REJECT`, buzzy long waveforms | Slip and craving modes |

**(a) Daily progress inspection: sparse, short, discrete** (HIG: "prefer short haptics that complement discrete events")
- At most ~3 haptic events per session outside user taps.
- Tie each to a visible animation peak, e.g. the delta-reveal end-frame or a milestone badge landing. Match intensity and sharpness to the animation, per the HIG.

**(b) Acute craving emergency (180 s): 0.1 Hz breathing pacer, 18 cycles**
- Timing: 18 × (4 s inhale + 6 s exhale) = 180 s. The countdown ring shows the remaining 180 s; the breath circle and lung avatar are phase-locked to the same clock.
- Default pattern (exhale-weighted, following PIV's "strong-exhale-phased" finding):
  - Inhale: gentle *rising* continuous vibration, low sharpness. It is felt as "fill", and stays low so it does not dominate.
  - Exhale: a stronger onset, then a slow decay, *or* a slow train of soft transients (one per second, decreasing). A/B-test continuous-ramp vs transient-train exhale. The brief's own proposal (continuous ramp on inhale, gentle transients on exhale) is variant B.
  - Offer "haptics only / visuals only / both", and a "screen off, keep vibrating" mode for discreet use, if the platform allows background haptics (unverified, see Gaps).
- **iOS implementation sketch** (verified API names; ControlPoint initializer labels [label unverified]):
```swift
import CoreHaptics

final class BreathPacer {
    private var engine: CHHapticEngine?
    private var player: CHHapticAdvancedPatternPlayer?

    func prepare() throws {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return } // visual-only fallback
        let engine = try CHHapticEngine()
        engine.playsHapticsOnly = true
        engine.stoppedHandler = { _ in /* flag; restart on next user-visible cycle */ }
        engine.resetHandler = { [weak self] in try? self?.engine?.start(); try? self?.rebuildPlayer() }
        try engine.start()
        self.engine = engine
        try rebuildPlayer()
    }

    private func rebuildPlayer() throws {
        // 10 s cycle: inhale 0–4 s (continuous, soft, rising via curve); exhale 4–10 s (continuous, stronger start, decaying)
        let inhale = CHHapticEvent(eventType: .hapticContinuous,
            parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.45),
                         CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.10)],
            relativeTime: 0, duration: 4.0)
        let exhale = CHHapticEvent(eventType: .hapticContinuous,
            parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.70),
                         CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.20)],
            relativeTime: 4.0, duration: 6.0)
        // Intensity multiplier (0–1, multiplicative): rise during inhale, peak at exhale onset, decay to ~0 by 10 s
        let curve = CHHapticParameterCurve(parameterID: .hapticIntensityControl, controlPoints: [
            .init(relativeTime: 0.0, value: 0.15),
            .init(relativeTime: 4.0, value: 0.60),
            .init(relativeTime: 4.15, value: 1.00),
            .init(relativeTime: 9.8, value: 0.05)
        ], relativeTime: 0)
        let pattern = try CHHapticPattern(events: [inhale, exhale], parameterCurves: [curve])
        let p = try engine!.makeAdvancedPlayer(with: pattern)
        p.loopEnabled = true
        p.loopEnd = 10.0
        player = p
    }

    func start() throws { try player?.start(atTime: CHHapticTimeImmediate) }   // stop after 180 s or on exit
    func stop()  throws { try player?.stop(atTime: CHHapticTimeImmediate) }
}
```
- **Android implementation sketch** (verified API names and levels; tiered fallbacks):
```kotlin
// attrs: USAGE_MEDIA (API 33) – pacer accompanies an animation, it is not touch feedback
fun breathCycle(v: Vibrator): VibrationEffect? = when {
    Build.VERSION.SDK_INT >= 36 && v.areEnvelopeEffectsSupported() ->
        VibrationEffect.BasicEnvelopeBuilder()
            .setInitialSharpness(0.10f)
            .addControlPoint(0.40f, 0.10f, 4000)   // inhale: smooth rise
            .addControlPoint(0.70f, 0.20f, 150)    // exhale onset (stronger)
            .addControlPoint(0.00f, 0.15f, 5850)   // exhale decay – MUST end at 0 intensity
            .build()
    v.hasAmplitudeControl() -> {                    // 100 x 100 ms segments, starts/ends near 0
        val t = LongArray(100) { 100L }
        val a = IntArray(100) { i -> if (i < 40) 4 + i * 3 else ((99 - i) * 180 / 59) }
        VibrationEffect.createWaveform(t, a, -1)
    }
    Build.VERSION.SDK_INT >= 30 && v.areAllPrimitivesSupported(
        VibrationEffect.Composition.PRIMITIVE_SLOW_RISE, VibrationEffect.Composition.PRIMITIVE_QUICK_FALL) ->
        VibrationEffect.startComposition()
            .addPrimitive(VibrationEffect.Composition.PRIMITIVE_SLOW_RISE, 0.5f)
            // delay = 4000 − slowRiseDuration (query v.getPrimitiveDurations(...) on API 31+)
            .addPrimitive(VibrationEffect.Composition.PRIMITIVE_QUICK_FALL, 0.7f, 3500)
            .compose()
    else -> null   // no amplitude control & no primitives → visual-only (avoid "buzzy", per Android guidance)
}
// Re-trigger breathCycle() every 10 s from the same clock as the animation (better sync and cancellation
// than createRepeatingEffect); call v.cancel() on exit.
```
- Sync rule: drive the animation phase and haptic triggers from one monotonic clock. On iOS, re-anchor drift each cycle if you schedule per cycle (`engine.currentTime` exists). Do not let the haptic loop free-run for 180 s detached from the visual.
- Intensity personalization: a slider at 0.5/0.7/1.0 multipliers (Android's ≥1.4 perceptual-step guidance). PIV also emphasizes personalization.

**(c) Post-slip damage control: near-silent**
- One soft confirmation haptic when the user commits to a "next step." No error/warning/REJECT haptics anywhere in the flow. Per the HIG, a haptic used for failure becomes associated with failure, and the slip flow should not teach "you failed."

### Gaps
- The maximum duration of a `hapticContinuous` event, and whether Core Haptics keeps playing when the app is backgrounded or the screen locks, were not verified. Test on device: if the engine stops, `stoppedHandler` gives the reason.
- Whether the Android user setting for "touch feedback" or vibration intensity attenuates `USAGE_MEDIA` vs `USAGE_TOUCH` vibrations was not verified.
- The PIV papers' quantitative outcomes (anxiety reduction effect sizes, preferred frequencies) were not retrieved; only the abstract-level conclusions were.
- No RCT of phone-based haptic breathing for *tobacco craving* specifically was found or searchable. The craving-reduction claim must come from the breathing literature (see s2_3) and in-app measurement.
- The Apple Watch Breathe/Mindfulness haptic implementation details were not retrieved.

---

## Q6. Gamification evidence in cessation apps (badges, missions, streaks, milestones, SDT, over-gamification) and engagement

### Takeaway
The main experimental evidence on gamified components is the Smoke Free exploratory RCT: 28,112 smokers randomized to the full app (daily "missions" plus badges) or a reduced version without missions, with 3-month self-reported abstinence as the outcome. Its effect estimates could not be verified in-session (see the sibling note `s3`). It is exploratory, not preregistered, and the app's creator is an author with a financial interest. The more rigorous Smoke Free RCT (app vs no support; Jackson et al.) had a 2019 *Addiction* protocol, and a 2023 preprint reported under-recruitment (3,143 of 4,990 planned). Engagement mediates app efficacy in iCanQuit (sibling note `s2_1`). Design gamification to drive *engagement with effective content* (missions, skills), not points for their own sake.

### Cited Findings
- **Crane D, Ubhi HK, Brown J, West R. "Relative effectiveness of a full versus reduced version of the 'Smoke Free' mobile application for smoking cessation: an exploratory randomised controlled trial." *F1000Research* 2018;7:1524 (v2, Jan 2019).**
  - 28,112 adults aged 18+ who set a quit date.
  - Full version: virtual badges and daily missions. Reduced version: no missions.
  - Primary outcome: self-reported complete abstinence from the quit date, via a 3-month in-app questionnaire.
  - Crane created the app and derives income from it.
  — [F1000Research v2](https://f1000research.com/articles/7-1524/v2); [F1000 XML](https://f1000research.com/articles/7-1524/v1/xml)
- **Jackson SE, Perski O, Crane D, Michie S, West R, Brown J.** RCT protocol, Smoke Free app vs no support. *Addiction* 2019;114:2078–2086; primary outcome 26-week continuous abstinence. — [UCL Discovery record](https://discovery.ucl.ac.uk/id/eprint/10073536/)
  - Results preprint: 3,143 adult smokers recruited Aug 2020–Apr 2021, fewer than the 4,990 planned; not peer reviewed at the time. — [medRxiv 2023.01.12.23284463](https://medrxiv.org/content/10.1101/2023.01.12.23284463.full.pdf)
  - The brief's "Crane et al. 2019 Addiction… DOI 10.1111/add.14440" could not be confirmed. The 2019 *Addiction* paper retrieved is the **Jackson et al. protocol**, not a Crane badge RCT.
- Engagement as mediator: in iCanQuit, the effect ran through engagement (logins, minutes, unique days), which increased acceptance of cues, which led to cessation. See sibling note. — `s2_1_act_urge_surfing_ave_app_efficacy.md` (Bricker 2020 *JAMA Intern Med*, DOI 10.1001/jamainternmed.2020.4055; Bricker 2021 *JMIR mHealth uHealth* 9(11):e32847)
- The sibling note found **no empirical study of gamified streak resets causing disengagement** in quit apps. Its recommendation to keep cumulative totals rests on AVE theory. — `s2_1_act_urge_surfing_ave_app_efficacy.md`

### Inferences
- **Gamify behaviours that are plausibly active ingredients**, not time alone:
  - Badges for "Craving surfed" (completing an SOS session), "First week of cravings beaten," "Used a plan after a slip," and "Logged a Clearance-window symptom."
  - Health-milestone badges ("Cilia recovery stage 1") must use hedged, sourced timelines (see s1/s2 notes).
  - Keep the full vs reduced Smoke Free idea: *daily missions* = one short skill or practice per day.
- **Streak design:**
  - The primary counter is **cumulative smoke-free days**, which never resets.
  - A secondary "current run" counter can reset, but only with a "repair" path (24 h back on track restores the run's badge tier). See the AVE rationale in s2_1.
  - The avatar does **not** snap back to the quit-day state after a slip (see Q7).
- **SDT framing** (theory, unverified in-session):
  - Autonomy: user-chosen missions and the option to hide badges.
  - Competence: skills-based badges, plus the avatar visibly improving because of *their* actions.
  - Relatedness: optional buddy sharing.
  - Avoid leaderboards: social comparison risks shame after slips.
- **Over-gamification guardrails:**
  - No loss-framed streak notifications ("Don't lose your streak!").
  - No points or currency inflation.
  - Turn gamification off in craving mode (no badges pop during SOS) and in slip mode until the user completes the "next step."
- **Engagement metrics to instrument:** logins per day, unique days, SOS sessions started and completed, mission completion, and 7/30-day retention. Pre-register an A/B test of the avatar on vs off for 30-day retention and 3-month self-reported abstinence.

### Gaps
- Crane et al. effect sizes (abstinence per arm, RR, Bayes factor) were not retrieved this session; check `s3_onboarding_phenotyping.md` or the F1000 article.
- Jackson et al. final peer-reviewed results (if published 2023–2026) were not verified.
- UNVERIFIED candidates not checked in-session:
  - Ubhi HK et al. "A mobile app to aid smoking cessation: preliminary evaluation of SmokeFree28." *JMIR* 2015;17(1):e17, DOI 10.2196/jmir.3479.
  - El-Hilly AA et al. "Game On? Smoking cessation through the gamification of mHealth: a longitudinal qualitative study." *JMIR Serious Games* 2016;4(2):e18, DOI 10.2196/games.5678.
  - Perski O, Blandford A, West R, Michie S. "Conceptualising engagement with digital behaviour change interventions…" *Transl Behav Med* 2017;7(2):254–267, DOI 10.1007/s13142-016-0453-1.
  - Ryan & Deci 2000 SDT.
- No quantitative retention benchmarks for cessation apps (e.g., day-30 retention) were retrieved.

---

## Q7. Micro-interactions for the craving emergency (SOS) and post-slip mode

### Takeaway
The SOS path should be **one tap from anywhere**, have large targets (≥44 pt iOS / ≥48 dp Android, ideally far larger), and present **one primary action per screen**. A 180-s countdown ring and breath circle are phase-locked to the haptic pacer, the palette is low-arousal blue on near-black with no red, and motion is minimal. Post-slip mode should be warm (amber/peach), non-judgmental and forward-looking ("what next"). It should use no error haptics or red, and should preserve cumulative progress.

### Cited Findings
- Touch targets: iOS default control size 44×44 pt, minimum 28×28 pt, with about 12 pt padding. — [HIG Accessibility](https://developer.apple.com/design/human-interface-guidelines/accessibility). Android: ≥48×48 dp, "Larger is even better." — [Android accessibility](https://developer.android.com/guide/topics/ui/accessibility/apps). WCAG 2.5.8 (AA): ≥24×24 CSS px. — [Understanding 2.5.8](https://github.com/w3c/wcag/blob/main/understanding/22/target-size-minimum.html)
- Reduce Motion: reduce automatic and repetitive animation, and replace movement with fades. — [HIG Accessibility](https://developer.apple.com/design/human-interface-guidelines/accessibility)
- Haptic meaning consistency, and keeping haptics optional. — [HIG Playing haptics](https://developer.apple.com/design/human-interface-guidelines/playing-haptics)
- Red's cultural meaning varies; never rely on color alone. — [HIG Color](https://developer.apple.com/design/human-interface-guidelines/color)
- Live Activities exist via ActivityKit (iOS 16.1+): "Share live updates from your app as Live Activities on iPhone, iPad, Apple Watch, and the Mac." This is a candidate surface for a lock-screen SOS countdown. — [ActivityKit](https://developer.apple.com/documentation/activitykit)
- Cravings: the sibling note found no primary source for "cravings pass in 3–5 minutes." It recommends copy such as "urges rise and fall; many ease within minutes." — `s2_1_act_urge_surfing_ave_app_efficacy.md`
- The lapse vs relapse distinction, AVE, and a lapse-response protocol with streak repair are covered in the sibling note. — `s2_1_act_urge_surfing_ave_app_efficacy.md`

### Inferences
**Craving SOS flow (target: under 2 s from intent to breathing)**
1. **Entry points:**
   - A persistent SOS button on every main screen: bottom-centre thumb zone, ≥64 pt/dp visual, ≥72 pt hit area, label "Craving" plus icon. Never icon-only.
   - Also an app-icon long-press shortcut and a home-screen widget.
   - iOS: an optional Live Activity showing the countdown after start. (The Android Quick Settings tile and app-shortcut APIs were not verified.)
2. **Tap → immediate start with no confirmation dialog.**
   - The screen switches to `mode=craving`: background #0E0E0E (canvas #000 behind a static avatar), accent #8AB4F8.
   - The avatar simplifies: particles and cilia freeze; only the breath loop plays, at 6 bpm.
   - The haptic pacer starts at cycle 1.
3. **Layout:**
   - Top: the 180-s countdown as a thin ring around the avatar plus tabular-digit "2:47". It counts down, not up, so the end is visible.
   - Centre: a breath circle (or the lung itself) expanding for 4 s and contracting for 6 s. "Breathe in" / "Breathe out" labels cross-fade, ≤3 words each.
   - Bottom: one large secondary control ("I'm OK now", ≥48 dp/44 pt) plus a small "Other ways" link (distraction list, call buddy, urge-surfing audio).
   - Nothing else on screen.
4. **Cognitive load:**
   - At most one instruction at a time; no numbers other than the countdown; no badges or toasts.
   - Text at Body size or larger, Dynamic Type supported.
   - VoiceOver/TalkBack announce "Breathe in" / "Breathe out" on each phase, as an alternative to visuals and haptics.
5. **Completion (180 s):**
   - A gentle "You rode it out" plus one-tap craving rating 0–10 (before/after, for measurement).
   - Optional badge, shown *after* the rating, never mid-session.
   - The avatar returns to inspect mode with a subtle oxygen-glow pulse (skipped under Reduce Motion).
6. **Early exit:** always available; ask nothing. Log partial completion silently.
7. **Reduce Motion variant:** a static avatar and a numeric countdown; breath cues via text plus haptics only.

**Post-slip ("damage control") flow**
1. **Entry:**
   - From "I smoked" (neutral wording) on the home screen, or from a check-in.
   - Never infer a slip from the user's data and then announce it with a negative banner.
2. **Palette and motion:**
   - Warm amber/peach (#F6B26B / #FFB59E) on #131313. No red, no shake animations, no error haptics.
   - Avatar: show a **small, transient haze** (e.g., +0.05 `tarDensity` displayed for the slip day, decaying visually over the next 24–72 h of abstinence). **Do not reset** to the quit-day state.
   - Cumulative "smoke-free days" stays visible and unchanged.
3. **Copy pattern** (non-judgmental; specific; future-oriented):
   - "A slip is one moment, not the whole story."
   - Then one question: "What was going on?" (trigger chips: stress, alcohol, social, routine, other).
   - Then "What's your next step?" with 2–3 concrete options: set a plan for that trigger, use SOS next time, restart the run now.
   - Avoid "relapse," "failed," "reset" and "start over."
4. **Commit:** one soft haptic on "Back on track," then return to inspect mode. A "Back on track" badge can be earned after 24 h smoke-free (per the s2_1 streak-repair protocol).
5. **Repeated slips:** if lapses recur (e.g., ≥3 in 7 days), offer support escalation (quitline, pharmacotherapy information; see s2_6) rather than more gamification.

**Daily inspection mode micro-interactions**
- Pinch/drag to rotate or zoom (2D parallax or 3D). Tap a region (bronchi, alveoli, cilia) to open a bottom sheet with that variable's value, trend sparkline, plain-language meaning and source.
- "Since yesterday" delta reveal on open (Q3), plus a timeline scrubber over days smoke-free that lets the user preview future milestone states. Label them clearly as *projected*.

### Gaps
- No empirical study was retrieved comparing SOS interaction designs (one-tap vs menu, countdown vs open-ended) for cravings.
- Android Quick Settings tile (`TileService`) and app-shortcut APIs were not verified in-session.
- No evidence was retrieved on warm vs cool palettes reducing shame or defensiveness after lapses. The palette choice rests on HIG cultural-meaning guidance and design convention.
- The specific copy has not been user-tested. Recommend 5–8 moderated sessions with recent quitters, plus an A/B test of slip-mode avatar behaviour (haze vs no change).
