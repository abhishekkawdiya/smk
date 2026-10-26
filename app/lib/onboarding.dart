// 12-tap onboarding (§3.2, original wording), quit plan, and the one-time
// quit-day lung reveal (§4.1), which fear-control users skip.
import 'package:flutter/material.dart';

import 'home.dart';
import 'main.dart';
import 'model.dart';

typedef _Q = ({String id, String section, String text, String why, List<String> opts, void Function(int) set});

const _freq = ['Never', 'Rarely', 'Sometimes', 'Often', 'Almost always'];
const _agree = ['Strongly disagree', 'Disagree', 'Somewhat disagree', 'Neutral', 'Somewhat agree', 'Agree', 'Strongly agree'];
const _wake = ['Within 5 minutes', '6–30 minutes', '31–60 minutes', 'After 60 minutes'];
const _stages = ['PC', 'C', 'P', 'A', 'M', 'CUT'];
const _whyTrigger = 'Knowing your main trigger lets us put the right tool first on your home screen.';
const _whyEppm = 'This helps us decide how much to lead with how quitting helps versus how to do it.';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});
  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final a = Answers();
  final picked = <String, int>{};
  int step = 0;
  bool planning30 = false;

  // Quit plan
  String? when; // today | tomorrow | date | notyet
  DateTime? date;
  final price = TextEditingController();
  String currency = '₹';
  int perPack = 20;

  List<_Q> get questions => [
        (
          id: 'product', section: 'About you', text: 'What do you use right now?',
          why: 'Clearway v1 is built for people who smoke cigarettes. Vape-only support comes later.',
          opts: ['Cigarettes', 'Cigarettes and vapes'], set: (i) => a.dualUse = i == 1,
        ),
        (
          id: 'ttfc', section: 'Dependence', text: 'After you wake up, how soon do you usually have your first cigarette?',
          why: 'How soon you smoke after waking is the best single sign of how strongly nicotine pulls you.',
          opts: _wake, set: (i) => a.ttfc = 3 - i,
        ),
        (id: 'cpd', section: 'Dependence', text: 'On a typical day, about how many cigarettes do you smoke?',
          why: 'Used for your cigarettes-not-smoked and money-kept counters.', opts: const [], set: (_) {}),
        if (a.dualUse)
          (
            id: 'ttfcVape', section: 'Dependence', text: 'After you wake up, how soon do you usually first vape?',
            why: 'Vaping adds to how strongly nicotine pulls you.', opts: _wake, set: (i) => a.ttfcVape = 3 - i,
          ),
        (
          id: 'aff', section: 'Triggers',
          text: "I reach for a cigarette to take the edge off when I'm stressed, anxious, angry or down.",
          why: _whyTrigger, opts: _freq, set: (i) => a.aff = i,
        ),
        (
          id: 'cue', section: 'Triggers',
          text: 'Certain places, times or routines (coffee, after meals, driving, breaks) switch on an urge to smoke.',
          why: _whyTrigger, opts: _freq, set: (i) => a.cue = i,
        ),
        (
          id: 'auto', section: 'Triggers', text: 'I often light up without really deciding to, out of habit or boredom.',
          why: _whyTrigger, opts: _freq, set: (i) => a.auto = i,
        ),
        (
          id: 'soc', section: 'Triggers', text: "I smoke most when I'm around other smokers, or out drinking or socialising.",
          why: _whyTrigger, opts: _freq, set: (i) => a.soc = i,
        ),
        (
          id: 'stage', section: 'Readiness', text: 'Where are you with quitting right now?',
          why: 'No wrong answer. Every tool stays open whatever you pick.',
          opts: [
            'Not planning to in the next 6 months',
            'Thinking about it in the next 6 months',
            'Planning to quit in the next 30 days',
            'Already quit, under 6 months',
            'Quit 6+ months, staying quit',
            'I want to cut down first',
          ],
          set: (i) {
            a.stage = _stages[i];
            planning30 = i == 2;
          },
        ),
        if (planning30)
          (
            id: 'tried', section: 'Readiness',
            text: 'In the past year, have you gone at least 24 hours without smoking because you were trying to quit?',
            why: 'A recent try means you already have experience to build on.',
            opts: ['Yes', 'No'], set: (i) => a.stage = i == 0 ? 'P' : 'C',
          ),
        (id: 'sev', section: 'Your view', text: 'If I keep smoking, the damage to my health could be serious.',
          why: _whyEppm, opts: _agree, set: (i) => a.sev = i + 1),
        (id: 'sus', section: 'Your view', text: "I'm likely to get a smoking-related illness if I don't stop.",
          why: _whyEppm, opts: _agree, set: (i) => a.sus = i + 1),
        (id: 'resp', section: 'Your view', text: 'Stopping smoking would really lower my health risks.',
          why: _whyEppm, opts: _agree, set: (i) => a.resp = i + 1),
        (id: 'self', section: 'Your view', text: "I'm confident I can quit, with the right support.",
          why: _whyEppm, opts: _agree, set: (i) => a.self = i + 1),
        (id: 'avoid', section: 'Your view', text: "Honestly, I'd rather not think about what smoking does to my health.",
          why: "That's a common feeling. If it fits you, we'll go easy on health warnings.", opts: _agree,
          set: (i) => a.avoid = i + 1),
        (id: 'critic', section: 'Your view', text: "When I slip up, I'm hard on myself.",
          why: "If so, we'll offer a kinder way back after a slip.", opts: ['Agree', 'Disagree'],
          set: (i) => a.selfCritical = i == 0),
      ];

  bool get showReveal => eppm(a) != 'FEAR_CONTROL_RISK';
  int get total => questions.length + (showReveal ? 2 : 1);

  void next() => setState(() => step++);

  void finish() {
    final now = DateTime.now();
    final day = DateTime(now.year, now.month, now.day);
    app.quitAt = switch (when) {
      'today' => now,
      'tomorrow' => day.add(const Duration(days: 1)),
      'date' => date,
      _ => null,
    };
    app.packPrice = double.tryParse(price.text) ?? 0;
    app.perPack = perPack;
    app.currency = currency;
    app.lastSeenSlow = 0;
    app.answers = a;
    app.save();
  }

  @override
  Widget build(BuildContext context) {
    final qs = questions;
    final Widget body = step < qs.length
        ? (qs[step].id == 'cpd' ? _cpd(qs[step]) : _question(qs[step]))
        : step == qs.length
            ? _plan()
            : _reveal();
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 8, 20, 0),
            child: Row(children: [
              IconButton(
                tooltip: 'Back',
                onPressed: step == 0 ? null : () => setState(() => step--),
                icon: const Icon(Icons.arrow_back),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(value: (step + 1) / total, minHeight: 6, backgroundColor: AppColors.high),
                ),
              ),
              const SizedBox(width: 12),
              Text('${step + 1}/$total', style: muted.copyWith(fontFeatures: tabular)),
            ]),
          ),
          Expanded(child: body),
        ]),
      ),
    );
  }

  Widget _frame(String section, String text, List<Widget> children, {String? why}) => ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: [
          Text(section.toUpperCase(), style: const TextStyle(color: AppColors.oxygen, fontSize: 12, letterSpacing: 1.4, fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          Text(text, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, height: 1.3)),
          const SizedBox(height: 22),
          ...children,
          if (why != null) ...[
            const SizedBox(height: 6),
            Section(
              color: const Color(0xFF181818),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Icon(Icons.info_outline, size: 18, color: AppColors.oxygen),
                const SizedBox(width: 10),
                Expanded(child: Text('Why we ask: $why', style: muted)),
              ]),
            ),
          ],
        ],
      );

  Widget _question(_Q q) => _frame(q.section, q.text, why: q.why, [
        for (var i = 0; i < q.opts.length; i++)
          OptionTile(q.opts[i], selected: picked[q.id] == i, onTap: () {
            setState(() {
              q.set(i);
              picked[q.id] = i;
            });
            Future.delayed(const Duration(milliseconds: 180), () {
              if (mounted) next();
            });
          }),
      ]);

  Widget _cpd(_Q q) => _frame(q.section, q.text, why: q.why, [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton.filledTonal(
            iconSize: 28,
            tooltip: 'Fewer',
            onPressed: a.cpd > 1 ? () => setState(() => a.cpd--) : null,
            icon: const Icon(Icons.remove),
          ),
          SizedBox(
            width: 120,
            child: Text('${a.cpd}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 56, fontWeight: FontWeight.w700, fontFeatures: tabular)),
          ),
          IconButton.filledTonal(
            iconSize: 28,
            tooltip: 'More',
            onPressed: a.cpd < 80 ? () => setState(() => a.cpd++) : null,
            icon: const Icon(Icons.add),
          ),
        ]),
        const Center(child: Text('cigarettes a day', style: muted)),
        const SizedBox(height: 20),
        FilledButton(onPressed: next, child: const Text('Next')),
      ]);

  Widget _plan() {
    final quit = const {'A', 'M'}.contains(a.stage);
    final explore = const {'PC', 'C', 'CUT'}.contains(a.stage);
    Future<void> pick() async {
      final now = DateTime.now();
      final d = await showDatePicker(
        context: context,
        initialDate: quit ? now.subtract(const Duration(days: 1)) : now.add(const Duration(days: 2)),
        firstDate: quit ? now.subtract(const Duration(days: 365)) : now,
        lastDate: quit ? now : now.add(const Duration(days: 60)),
      );
      if (d != null) {
        setState(() {
          when = 'date';
          date = d;
        });
      }
    }

    final ok = when != null && (double.tryParse(price.text) ?? 0) > 0;
    String fmt(DateTime d) => '${d.day}/${d.month}/${d.year}';
    return _frame('Your plan', quit ? 'When did you quit?' : "When's your quit day?", [
      if (!quit) ...[
        OptionTile('Today, starting now', selected: when == 'today', onTap: () => setState(() => when = 'today')),
        OptionTile('Tomorrow', selected: when == 'tomorrow', onTap: () => setState(() => when = 'tomorrow')),
      ],
      OptionTile(when == 'date' ? 'Quit day: ${fmt(date!)}' : 'Pick a date', selected: when == 'date', onTap: pick),
      if (explore)
        OptionTile('Not yet, just exploring', selected: when == 'notyet', onTap: () => setState(() => when = 'notyet')),
      const SizedBox(height: 16),
      const Text('What does a pack cost you?', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
      const SizedBox(height: 10),
      Chips(const ['₹', '\$', '£', '€'], selected: {currency}, onTap: (c) => setState(() => currency = c)),
      const SizedBox(height: 10),
      TextField(
        controller: price,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(prefixText: '$currency ', hintText: 'Pack price', border: const OutlineInputBorder()),
      ),
      const SizedBox(height: 10),
      Chips(const ['10 per pack', '20 per pack'], selected: {'$perPack per pack'},
          onTap: (c) => setState(() => perPack = int.parse(c.split(' ').first))),
      const SizedBox(height: 24),
      FilledButton(onPressed: ok ? (showReveal ? next : finish) : null, child: const Text('Continue')),
    ]);
  }

  Widget _reveal() => _frame('Your starting point', 'Your lungs on quit day: an illustration', [
        Center(child: LungView(tar: tarAtQuit(a.cpd), inflam: .8, o2: 0, size: 240)),
        const SizedBox(height: 12),
        const Text(
          'This picture is built from what you told us. It is a visual metaphor, not a scan or a test.',
          style: muted,
        ),
        const SizedBox(height: 12),
        const Text(
          'From your quit day, it follows the recovery you cause. Carbon monoxide starts clearing within '
          'hours, and the heart-rate spike from a cigarette passes in about 30 minutes.',
          style: TextStyle(fontSize: 16, height: 1.4),
        ),
        const SizedBox(height: 24),
        FilledButton(onPressed: finish, child: const Text('See my plan')),
      ]);
}
