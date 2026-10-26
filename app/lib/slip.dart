// Slip Response (§2.4, §4.6): amber, never red; cumulative days kept;
// chain analysis → if-then plan → recommit. "Smoking again" routes to
// planning the next quit, with every total banked.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main.dart';
import 'model.dart';

const _places = {'Home': 'at home', 'Work': 'at work', 'Car': 'in the car', 'Bar': 'at a bar', "Friend's place": "at a friend's place"};
const _who = {'Alone': 'alone', 'With smokers': 'with smokers', 'Partner': 'with my partner', 'Colleagues': 'with colleagues'};
const _feelings = ['Stressed', 'Angry', 'Low', 'Bored', 'Celebrating', 'Hungry', 'Lonely', 'Tired'];
const _actions = ['step outside for 3 breaths', 'open Craving SOS', 'hold a drink in my smoking hand', 'text someone', 'take a short walk'];
const _chain = {
  'Where?': ['Home', 'Work', 'Car', 'Bar', "Friend's place"],
  'Who?': ['Alone', 'With smokers', 'Partner', 'Colleagues'],
  'Feeling just before?': _feelings,
  'Anything else?': ['Alcohol', 'Coffee'],
  'Where did it come from?': ['Bought it', 'Bummed it', 'Had a stash'],
  'The thought that tipped it?': ['"Just one"', '"I deserve it"', '"I\'ve already blown it today"', '"Nobody will know"'],
};

ButtonStyle get _amber => FilledButton.styleFrom(backgroundColor: AppColors.repair, foregroundColor: AppColors.onRepair);

class SlipScreen extends StatefulWidget {
  const SlipScreen({super.key});
  @override
  State<SlipScreen> createState() => _SlipScreenState();
}

class _SlipScreenState extends State<SlipScreen> {
  String step = 'count';
  Map<String, dynamic>? ev;
  String? reframe;
  final chain = {for (final k in _chain.keys) k: <String>{}};

  // Re-quit
  String since = 'Today', newQuit = 'Today';

  void go(String s) => setState(() => step = s);

  void _count(int n) {
    ev = app.log('slip', {'n': n});
    final days = consecutiveSmokingDays(app.slips.map((s) => s.at), DateTime.now());
    go(isRelapse(regular: false, smokingDaysInRow: days) ? 'requit' : 'reframe');
  }

  bool get _needsCompassion => (app.answers?.selfCritical ?? false) || reframe == 'a';

  void _commit() {
    ev?.addAll({
      'reframe': reframe,
      for (final e in chain.entries) e.key: e.value.toList(),
    });
    app.save();
    buzz(HapticFeedback.lightImpact); // one soft confirm, never an error haptic
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => PopScope(
        onPopInvokedWithResult: (_, __) => app.save(),
        child: Scaffold(
          appBar: AppBar(backgroundColor: AppColors.surface, title: const Text('A slip is one moment')),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              children: switch (step) {
                'count' => _countStep(),
                'reframe' => _reframeStep(),
                'chain' => _chainStep(),
                'kind' => _kindStep(),
                'plan' => [
                    const Text("What's your next step?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    const Text('One if-then plan for this situation, ready for next time.', style: muted),
                    const SizedBox(height: 16),
                    PlanBuilder(
                      color: AppColors.repair,
                      place: chain['Where?']!.firstOrNull,
                      who: chain['Who?']!.firstOrNull,
                      feel: chain['Feeling just before?']!.firstOrNull,
                      onSave: (s) {
                        app.plans.add(s);
                        ev?['plan'] = s;
                        go('recommit');
                      },
                    ),
                    TextButton(
                      onPressed: () => go('recommit'),
                      child: const Text('Skip', style: TextStyle(color: AppColors.repair)),
                    ),
                  ],
                'recommit' => _recommitStep(),
                _ => _requitStep(),
              },
            ),
          ),
        ),
      );

  List<Widget> _countStep() => [
        const Text('Thanks for telling us.', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        const Text('How many?', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 16),
        OptionTile('1', selected: false, color: AppColors.repair, onTap: () => _count(1)),
        OptionTile('2–5', selected: false, color: AppColors.repair, onTap: () => _count(3)),
        OptionTile('More than 5', selected: false, color: AppColors.repair, onTap: () => _count(6)),
        OptionTile("I've been smoking regularly", selected: false, color: AppColors.repair, onTap: () => go('requit')),
      ];

  List<Widget> _reframeStep() => [
        const Text(
          'Thanks for logging this. That honesty is part of quitting. One cigarette is a slip, not a restart: '
          "your smoke-free days still count. Let's take 60 seconds to learn from it.",
          style: TextStyle(fontSize: 18, height: 1.45),
        ),
        const SizedBox(height: 24),
        const Text('Which feels closer?', style: TextStyle(fontSize: 16, color: AppColors.variant)),
        const SizedBox(height: 10),
        OptionTile('"I\'m just not able to quit."', selected: reframe == 'a', color: AppColors.repair, onTap: () => setState(() => reframe = 'a')),
        OptionTile('"That situation was tough and I didn\'t have a plan for it yet."',
            selected: reframe == 'b', color: AppColors.repair, onTap: () => setState(() => reframe = 'b')),
        if (reframe != null) ...[
          const SizedBox(height: 8),
          Section(
            color: AppColors.repair.withValues(alpha: .12),
            const Text(
              'The second is almost always closer to the truth. Slips usually follow specific situations, '
              'and situations can be planned for.',
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ),
          FilledButton(style: _amber, onPressed: () => go('chain'), child: const Text('Next')),
        ],
      ];

  List<Widget> _chainStep() => [
        const Text('What was going on?', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        const Text('Tap what fits. Skip anything.', style: muted),
        for (final e in _chain.entries) ...[
          const SizedBox(height: 18),
          Text(e.key, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Chips(e.value, selected: chain[e.key]!, color: AppColors.repair, onTap: (o) {
            setState(() => chain[e.key]!.contains(o) ? chain[e.key]!.remove(o) : chain[e.key]!.add(o));
          }),
        ],
        const SizedBox(height: 24),
        FilledButton(style: _amber, onPressed: () => go(_needsCompassion ? 'kind' : 'plan'), child: const Text('Next')),
      ];

  List<Widget> _kindStep() => [
        const Text('Take a breath with this', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
        const SizedBox(height: 16),
        for (final line in const [
          'This is a hard moment.',
          'Slips happen to lots of people who are quitting.',
          'May I be patient with myself while I get back on track.',
        ])
          Padding(padding: const EdgeInsets.only(bottom: 14), child: Text(line, style: const TextStyle(fontSize: 19, height: 1.4))),
        const SizedBox(height: 8),
        const Text('What would you say to a friend who just had one cigarette?', style: muted),
        const SizedBox(height: 24),
        FilledButton(style: _amber, onPressed: () => go('plan'), child: const Text('Next')),
      ];

  List<Widget> _recommitStep() {
    final s = app.stats(DateTime.now());
    final total = s.sinceQuit.inDays;
    return [
      const Text('Keep your quit going', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
      const SizedBox(height: 16),
      Section(
        color: AppColors.repair.withValues(alpha: .12),
        Text(
          total > 0
              ? 'You kept ${s.smokeFreeDays - app.bankedDays} of $total days smoke-free. They stay yours.'
              : 'Your progress so far stays yours.',
          style: const TextStyle(fontSize: 17, height: 1.4),
        ),
      ),
      const Text("Today's goal: get back to 0.", style: TextStyle(fontSize: 18)),
      const SizedBox(height: 6),
      const Text("Never miss twice: if tomorrow's tough, open Craving SOS early.", style: muted),
      const SizedBox(height: 24),
      FilledButton(style: _amber, onPressed: _commit, child: const Text('Keep my quit going from now')),
    ];
  }

  List<Widget> _requitStep() {
    const sinceDays = {'Today': 0, 'A few days ago': 3, 'About a week ago': 7, 'Longer': 14};
    const quitDays = {'Today': 0, 'Tomorrow': 1, 'In 3 days': 3, 'In a week': 7};
    return [
      const Text("Let's plan your next quit", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
      const SizedBox(height: 10),
      const Text(
        'Thanks for being straight with yourself. Your smoke-free days, money kept and badges stay with you.',
        style: TextStyle(fontSize: 17, height: 1.4),
      ),
      const SizedBox(height: 20),
      const Text('Since about when have you been smoking?', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
      const SizedBox(height: 8),
      Chips(sinceDays.keys.toList(), selected: {since}, color: AppColors.repair, onTap: (o) => setState(() => since = o)),
      const SizedBox(height: 18),
      const Text('New quit day', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
      const SizedBox(height: 8),
      Chips(quitDays.keys.toList(), selected: {newQuit}, color: AppColors.repair, onTap: (o) => setState(() => newQuit = o)),
      const SizedBox(height: 18),
      const Section(
        Text(
          'Stop-smoking medicine makes another try more likely to stick. A pharmacist or doctor can help '
          'you choose, and a quitline can talk it through with you.',
          style: muted,
        ),
      ),
      FilledButton(
        style: _amber,
        onPressed: () {
          final now = DateTime.now();
          final today = DateTime(now.year, now.month, now.day);
          final d = quitDays[newQuit]!;
          app.requit(d == 0 ? now : today.add(Duration(days: d)), now.subtract(Duration(days: sinceDays[since]!)));
          buzz(HapticFeedback.lightImpact);
          Navigator.pop(context);
        },
        child: const Text('Set my new quit day'),
      ),
    ];
  }
}

/// If-then plan builder (§2.4 S5), also used from the home screen.
class PlanBuilder extends StatefulWidget {
  const PlanBuilder({super.key, this.place, this.who, this.feel, required this.onSave, this.color = AppColors.oxygen});
  final String? place, who, feel;
  final ValueChanged<String> onSave;
  final Color color;

  @override
  State<PlanBuilder> createState() => _PlanBuilderState();
}

class _PlanBuilderState extends State<PlanBuilder> {
  late String? place = widget.place, who = widget.who, feel = widget.feel;
  String? action;

  String get sentence {
    final where = [if (place != null) _places[place]!, if (who != null) _who[who]!].join(' ');
    final cond = [if (where.isNotEmpty) "I'm $where", if (feel != null) "I'm feeling ${feel!.toLowerCase()}"].join(' and ');
    return "If ${cond.isEmpty ? 'I feel the pull' : cond}, then I'll ${action ?? '…'}.";
  }

  Widget _pick(String label, List<String> opts, String? value, ValueChanged<String?> set) => Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Chips(opts, selected: {?value}, color: widget.color, onTap: (o) => setState(() => set(o == value ? null : o))),
        ]),
      );

  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        _pick('Where?', _places.keys.toList(), place, (v) => place = v),
        _pick('Who with?', _who.keys.toList(), who, (v) => who = v),
        _pick('Feeling?', _feelings, feel, (v) => feel = v),
        _pick("Then I'll…", _actions, action, (v) => action = v),
        Section(color: widget.color.withValues(alpha: .12), Text(sentence, style: const TextStyle(fontSize: 17, height: 1.4))),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: widget.color, foregroundColor: Colors.black),
          onPressed: action == null ? null : () => widget.onSave(sentence),
          child: const Text('Save this plan'),
        ),
      ]);
}
