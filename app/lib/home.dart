// Home (§4.3 inspect mode): never-resetting totals, the two-number Recovery
// Index with evidence grades, the lung illustration, and the one hero card.
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'main.dart';
import 'model.dart';
import 'slip.dart';
import 'sos.dart';

/// Quit-day soot density for the illustration. A visual metaphor [M], not a dose.
double tarAtQuit(int cpd) => (0.25 + 0.02 * cpd).clamp(0.25, 0.85);

String fmtDur(Duration d) => d.inDays >= 1
    ? '${d.inDays} d${d.inHours % 24 == 0 ? '' : ' ${d.inHours % 24} h'}'
    : d.inHours >= 1
    ? '${d.inHours} h'
    : '${d.inMinutes} min';

String fmtLife(double min) => min < 60
    ? '~${min.round()} min'
    : min < 1440
    ? '~${(min / 60).round()} h'
    : '~${(min / 1440).toStringAsFixed(min < 14400 ? 1 : 0)} days';

String fmtMoney(double v) => '${app.currency}${v.toStringAsFixed(v < 100 ? 2 : 0)}';

List<String> topN(Iterable<Object?> values, int n) {
  final counts = <String, int>{};
  for (final v in values) {
    for (final x in v is List ? v : [v]) {
      if (x != null) counts[x.toString()] = (counts[x.toString()] ?? 0) + 1;
    }
  }
  return (counts.keys.toList()..sort((a, b) => counts[b]!.compareTo(counts[a]!))).take(n).toList();
}

const _weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Timer tick;

  @override
  void initState() {
    super.initState();
    tick = Timer.periodic(const Duration(seconds: 30), (_) => setState(() {})); // live counters
  }

  @override
  void dispose() {
    tick.cancel();
    super.dispose();
  }

  void _open(Widget screen) => Navigator.push(context, MaterialPageRoute<void>(builder: (_) => screen));

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final s = app.stats(now);
    final a = app.answers!;
    final pre = app.quitAt == null || now.isBefore(app.quitAt!);
    final fast = weighted(s.recovery, fast: true), slow = weighted(s.recovery, fast: false);
    final haze = app.slips.fold(0.0, (h, sl) {
      final hrs = now.difference(sl.at).inMinutes / 60;
      return hrs < 0 || hrs > 72 ? h : max(h, exp(-hrs / 24));
    });
    final day = s.sinceQuit.inDays;
    final hero = heroCard(a);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          children: [
            Row(
              children: [
                Text(_weekdays[now.weekday - 1], style: muted.copyWith(fontSize: 16)),
                const Spacer(),
                IconButton(tooltip: 'Menu', onPressed: _menu, icon: const Icon(Icons.more_horiz)),
              ],
            ),
            ..._header(s, pre),
            const SizedBox(height: 16),
            _lungCard(s, fast, slow, haze, day, pre),
            Row(
              children: [
                Expanded(child: _ring('Fast', 'CO, nicotine, heart-rate spike', fast, AppColors.oxygen, const ['A', 'C', 'B'])),
                const SizedBox(width: 12),
                Expanded(child: _ring('Slow', 'Airways, vessels, smell, resting HR', slow, AppColors.data, const ['B', 'C', 'B', 'C'])),
              ],
            ),
            if (!pre) _counters(s),
            if (s.slips7d >= 3) _support() else _badges(s),
            Section(
              color: AppColors.data.withValues(alpha: .10),
              onTap: switch (hero.action) {
                'sos' => () => _open(const SosScreen()),
                'plan' => _addPlan,
                _ => null,
              },
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(hero.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Text(hero.body, style: muted),
                      ],
                    ),
                  ),
                  if (hero.action != 'none') const Icon(Icons.arrow_forward, color: AppColors.data),
                ],
              ),
            ),
            if (!pre && day >= 3 && day <= 42) _clearance(day),
            if (app.plans.isNotEmpty) _plans(),
            if (!pre) _next(s),
            _patterns(),
            _timeline(s, pre),
            const SizedBox(height: 8),
            const Text(
              'Clearway is a wellness prototype, not a medical device. Recovery figures are educational '
              'estimates from published population research, not measurements of your body.',
              style: TextStyle(color: AppColors.variant, fontSize: 12, height: 1.4),
            ),
            TextButton(onPressed: () => _methodology(context), child: const Text('How these estimates work')),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
          child: Row(
            children: [
              if (!pre)
                TextButton(
                  onPressed: () => _open(const SlipScreen()),
                  style: TextButton.styleFrom(foregroundColor: AppColors.repair, minimumSize: const Size(96, 64)),
                  child: const Text('I smoked'),
                ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.calm,
                    foregroundColor: AppColors.onCalm,
                    minimumSize: const Size(64, 64),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                  ),
                  onPressed: () => _open(const SosScreen()),
                  icon: const Icon(Icons.waves),
                  label: const Text('Craving SOS', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _header(Stats s, bool pre) {
    if (pre) {
      final q = app.quitAt;
      return [
        Text(
          q == null ? 'No quit day yet' : 'Quit day in ${fmtDur(q.difference(DateTime.now()))}',
          style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        const Text('Craving SOS works now too. Practising before your quit day helps.', style: muted),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: OutlinedButton(onPressed: _setQuitDay, child: Text(q == null ? 'Set a quit day' : 'Change quit day')),
        ),
      ];
    }
    final hours = s.smokeFreeDays == 0;
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            hours ? '${s.run.inHours}' : '${s.smokeFreeDays}',
            style: const TextStyle(fontSize: 72, fontWeight: FontWeight.w700, height: 1.05, fontFeatures: tabular),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(hours ? 'hours smoke-free' : 'days smoke-free', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
      Text('Your total · never resets  ·  current run ${fmtDur(s.run)}', style: muted),
    ];
  }

  Widget _lungCard(Stats s, double fast, double slow, double haze, int day, bool pre) {
    final tar0 = tarAtQuit(app.cpd);
    final clearing = !pre && day >= 3 && day <= 42;
    return Section(
      onTap: () => _inspect(s),
      Column(
        children: [
          // Wrap, not Row, so large accessibility text flows to a second line.
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: clearing ? WrapAlignment.spaceBetween : WrapAlignment.end,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 8,
              children: [
                if (clearing)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: AppColors.repair.withValues(alpha: .15), borderRadius: BorderRadius.circular(20)),
                    child: Text('Clearance window · day $day', style: const TextStyle(color: AppColors.repair, fontSize: 13)),
                  ),
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.info_outline, size: 16, color: AppColors.variant),
                    SizedBox(width: 4),
                    Text('Illustration', style: TextStyle(color: AppColors.variant, fontSize: 13)),
                  ],
                ),
              ],
            ),
          ),
          // Delta reveal: animate last-seen → now, then remember now (§4.3).
          TweenAnimationBuilder<double>(
            tween: Tween(begin: app.lastSeenSlow, end: slow),
            duration: const Duration(milliseconds: 2500),
            curve: Curves.easeInOut,
            onEnd: () {
              if ((app.lastSeenSlow - slow).abs() > .001) {
                app.lastSeenSlow = slow;
                app.save();
              }
            },
            builder: (_, v, __) =>
                LungView(tar: tar0 * (1 - .85 * v) + .05 * haze, inflam: pre ? .8 : 1 - fast, o2: s.recovery['CO']!, haze: haze, size: 230),
          ),
        ],
      ),
    );
  }

  Widget _ring(String title, String sub, double v, Color c, List<String> grades) => Section(
    onTap: () => _inspect(app.stats(DateTime.now())),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: 52,
              height: 52,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox.expand(
                    child: CircularProgressIndicator(value: v, strokeWidth: 5, color: c, backgroundColor: AppColors.highest),
                  ),
                  Text(
                    '${(v * 100).floor()}%',
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, fontFeatures: tabular),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 8),
        Text(sub, style: muted.copyWith(fontSize: 13)),
        const SizedBox(height: 6),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          runSpacing: 4,
          children: [
            const Text('Evidence', style: TextStyle(fontSize: 11, color: AppColors.variant)),
            for (final g in grades) GradeBadge(g),
          ],
        ),
      ],
    ),
  );

  Widget _counters(Stats s) {
    Widget cell(String big, String small, [Color color = AppColors.onSurface]) => Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            child: Text(
              big,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: color, fontFeatures: tabular),
            ),
          ),
          Text(small, style: muted.copyWith(fontSize: 13)),
        ],
      ),
    );
    return Section(
      Column(
        children: [
          Row(
            children: [
              cell(fmtMoney(s.notSmoked * app.pricePerCig), 'money kept', AppColors.oxygen),
              cell('${s.notSmoked.floor()}', 'not smoked'),
              cell(fmtLife(s.notSmoked * minutesPerCigarette), 'life kept, on avg.*'),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '*Population average from UK studies (~20 min per cigarette). Your own risk differs.',
            style: TextStyle(color: AppColors.variant, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _badges(Stats s) {
    final surfs = app.ofType('surf').length;
    final slipped = app.slips.isNotEmpty;
    final earned = [
      if (surfs > 0) 'Craving surfed ×$surfs',
      if (slipped && s.run.inHours >= 24) 'Back on track',
      if (slipped && s.run.inDays >= 7) 'Comeback',
      if (s.smokeFreeDays >= 7) 'First week',
    ];
    if (earned.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final b in earned)
            Chip(
              avatar: const Icon(Icons.star_rounded, size: 16, color: AppColors.tissue),
              label: Text(b),
            ),
        ],
      ),
    );
  }

  // ≥3 slips in 7 days: gamification gives way to human and medication support (§4.3, §4.6).
  Widget _support() => const Section(
    color: AppColors.high,
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("You don't have to do this alone", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        SizedBox(height: 6),
        Text(
          'Several slips this week is a sign to add support, not a sign you can\'t quit. Stop-smoking '
          'medicine and a quitline both raise the odds. A pharmacist or doctor can help you choose.',
          style: muted,
        ),
      ],
    ),
  );

  Widget _clearance(int day) => Section(
    color: AppColors.repair.withValues(alpha: .10),
    onTap: _whenToCheck,
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Clearance window',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.repair),
        ),
        const SizedBox(height: 6),
        const Text(
          'Some people notice more coughing, a sore throat or cold-like symptoms in the first couple of weeks. '
          "It's common and usually temporary. Many doctors think this is partly your airways clearing out.",
          style: TextStyle(height: 1.4),
        ),
        const SizedBox(height: 8),
        const Row(
          children: [
            Text('When to get checked', style: TextStyle(color: AppColors.repair)),
            SizedBox(width: 4),
            Icon(Icons.arrow_forward, size: 16, color: AppColors.repair),
          ],
        ),
      ],
    ),
  );

  Widget _plans() => Section(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text('My if-then plans', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            ),
            IconButton(tooltip: 'Add a plan', onPressed: _addPlan, icon: const Icon(Icons.add)),
          ],
        ),
        for (final p in app.plans)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Expanded(child: Text(p, style: const TextStyle(height: 1.35))),
                IconButton(
                  tooltip: 'Remove plan',
                  icon: const Icon(Icons.close, size: 18, color: AppColors.variant),
                  onPressed: () {
                    app.plans.remove(p);
                    app.save();
                  },
                ),
              ],
            ),
          ),
      ],
    ),
  );

  Widget _next(Stats s) {
    final m = milestones.where((m) => (m.sinceLastCig ? s.run : s.sinceQuit) < m.at).firstOrNull;
    if (m == null) return const SizedBox.shrink();
    final have = m.sinceLastCig ? s.run : s.sinceQuit;
    return Section(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Next', style: TextStyle(color: AppColors.variant)),
              const Spacer(),
              Text('in ${fmtDur(m.at - have)}', style: const TextStyle(fontFeatures: tabular)),
            ],
          ),
          const SizedBox(height: 6),
          Text(m.title, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: have.inSeconds / m.at.inSeconds,
              minHeight: 6,
              color: AppColors.data,
              backgroundColor: AppColors.highest,
            ),
          ),
        ],
      ),
    );
  }

  Widget _patterns() {
    final surfs = app.ofType('surf').toList();
    if (surfs.isEmpty && app.slips.isEmpty) return const SizedBox.shrink();
    final rated = surfs.where((e) => e['pre'] != null && e['post'] != null).toList();
    final drop = rated.isEmpty ? null : rated.fold<int>(0, (t, e) => t + (e['pre'] as int) - (e['post'] as int)) / rated.length;
    final ctx = topN(surfs.map((e) => e['ctx']), 1);
    final triggers = topN(app.ofType('slip').expand((e) => [e['Where?'], e['Feeling just before?'], e['The thought that tipped it?']]), 3);
    return Section(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Your patterns', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text('Cravings ridden out: ${surfs.length}'),
          if (drop != null)
            Text(
              drop >= 0
                  ? 'Urges eased by ${drop.toStringAsFixed(1)} points on average during a surf'
                  : "Urges rose ${(-drop).toStringAsFixed(1)} points on average during a surf, and you still didn't smoke",
            ),
          if (ctx.isNotEmpty) Text('Most often: ${ctx.first.toLowerCase()}'),
          if (triggers.isNotEmpty) Text('Slip triggers: ${triggers.join(', ')}'),
          const SizedBox(height: 6),
          const Text('Logging helps you notice your patterns.', style: muted),
        ],
      ),
    );
  }

  Widget _timeline(Stats s, bool pre) => Section(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Recovery timeline', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        const Text('Typical findings from studies, not measurements of you.', style: muted),
        const SizedBox(height: 10),
        for (final m in milestones)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  !pre && (m.sinceLastCig ? s.run : s.sinceQuit) >= m.at ? Icons.check_circle : Icons.radio_button_unchecked,
                  size: 20,
                  color: !pre && (m.sinceLastCig ? s.run : s.sinceQuit) >= m.at ? AppColors.oxygen : AppColors.highest,
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 60,
                  child: Text(fmtDur(m.at), style: muted.copyWith(fontFeatures: tabular)),
                ),
                Expanded(child: Text(m.title, style: const TextStyle(height: 1.3))),
                GradeBadge(m.grade),
              ],
            ),
          ),
        const Text('Later: WHO notes coughing and shortness of breath decrease within 1–9 months.', style: muted),
      ],
    ),
  );

  // ---- sheets ----

  Future<void> _sheet(Widget child) => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.high,
    builder: (_) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: .75,
      maxChildSize: .95,
      builder: (_, sc) => ListView(controller: sc, padding: const EdgeInsets.fromLTRB(20, 20, 20, 32), children: [child]),
    ),
  );

  void _inspect(Stats s) => _sheet(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Why does my lung look like this?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        Text(
          'Built from ${app.cpd} cigarettes a day, your quit day and ${app.slips.length} logged slip(s). '
          'It is a visual metaphor, not a scan.',
          style: muted,
        ),
        const SizedBox(height: 16),
        for (final fast in [true, false]) ...[
          Text(
            fast ? 'FAST: hours after your last cigarette' : 'SLOW: days after your quit day',
            style: const TextStyle(fontSize: 12, letterSpacing: 1.2, color: AppColors.variant, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          for (final d in domains.where((d) => d.fast == fast))
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 52,
                    child: Text(
                      '${(s.recovery[d.key]! * 100).floor()}%',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, fontFeatures: tabular),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(d.label, style: const TextStyle(fontWeight: FontWeight.w600)),
                            GradeBadge(d.grade),
                          ],
                        ),
                        Text(d.note, style: muted.copyWith(fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 8),
        ],
        const Text(
          'Grades: A = strong primary study, B = small or indirect study, C = extrapolated. '
          'How much each part counts is a design choice, not a published formula.',
          style: muted,
        ),
      ],
    ),
  );

  void _whenToCheck() => _sheet(
    const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('When to get checked', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        SizedBox(height: 12),
        Text('Talk to a doctor if you notice:', style: TextStyle(fontSize: 16)),
        SizedBox(height: 8),
        Text(
          '• Coughing up blood\n• Chest pain\n• Breathlessness that is getting worse\n• A fever\n• Symptoms that last beyond about 6 weeks',
          style: TextStyle(fontSize: 16, height: 1.6, color: AppColors.dangerSoft),
        ),
        SizedBox(height: 12),
        Text('In an emergency, call your local emergency number (112 in India and the EU).', style: muted),
        SizedBox(height: 12),
        Text('Draft list: needs clinical sign-off before release.', style: TextStyle(color: AppColors.variant, fontSize: 12)),
      ],
    ),
  );

  void _addPlan() => _sheet(
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('New if-then plan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 16),
        PlanBuilder(
          onSave: (p) {
            app.plans.add(p);
            app.save();
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );

  Future<void> _setQuitDay() async {
    final now = DateTime.now();
    final d = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(const Duration(days: 1)),
      lastDate: now.add(const Duration(days: 60)),
    );
    if (d == null) return;
    app.quitAt = d.year == now.year && d.month == now.month && d.day == now.day ? now : d;
    app.save();
  }

  void _menu() => showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.high,
    builder: (ctx) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          StatefulBuilder(
            builder: (_, set) => SwitchListTile(
              title: const Text('Vibration'),
              value: app.haptics,
              onChanged: (v) => set(() {
                app.haptics = v;
                app.save();
              }),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.science_outlined),
            title: const Text('How these estimates work'),
            onTap: () {
              Navigator.pop(ctx);
              _methodology(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: const Text('Delete all my data'),
            onTap: () async {
              Navigator.pop(ctx);
              final yes = await showDialog<bool>(
                context: context,
                builder: (d) => AlertDialog(
                  title: const Text('Delete everything?'),
                  content: const Text('This removes your answers, progress and logs from this device. It cannot be undone.'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(d, false), child: const Text('Cancel')),
                    TextButton(onPressed: () => Navigator.pop(d, true), child: const Text('Delete')),
                  ],
                ),
              );
              if (yes == true) app.wipe();
            },
          ),
        ],
      ),
    ),
  );
}

void _methodology(BuildContext context) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  backgroundColor: AppColors.high,
  builder: (_) => DraggableScrollableSheet(
    expand: false,
    initialChildSize: .85,
    maxChildSize: .95,
    builder: (_, sc) => ListView(
      controller: sc,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      children: const [
        Text('How our estimates work', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
        SizedBox(height: 4),
        Text('Methodology v0.1 (prototype)', style: muted),
        SizedBox(height: 16),
        Text('What these numbers are, and aren\'t', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
        SizedBox(height: 6),
        Text(
          'The Recovery Index and the lung picture are models. They combine published population research '
          'with what you enter. They do not measure anything inside your body and can differ from what a clinical '
          'test would show. Clearway is not a medical device.',
          style: muted,
        ),
        SizedBox(height: 16),
        Text('Recovery Index', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
        SizedBox(height: 6),
        Text(
          'Fast: carbon monoxide clearance with a ~4.5-hour daytime half-life (Sandberg et al., PLoS ONE 2011); '
          'nicotine ~2-hour half-life (secondary source); the heart-rate spike passing within ~30 minutes. Each '
          'cigarette after your quit day adds a small decaying bump.\n\n'
          'Slow: resting heart rate ~7 bpm lower after a week (Minami et al., Hypertension 1999); nasal clearance '
          'normal by day 15 in one study (Ramos et al., Respirology 2011); vascular function improving within about '
          'a month (2025 systematic review); smell improved by 45 days in one study. Several curves are '
          'interpolations between a few published time points. Weights are a design choice.',
          style: muted,
        ),
        SizedBox(height: 16),
        Text('Money and life kept', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
        SizedBox(height: 6),
        Text(
          'Cigarettes not smoked = your usual daily number × days since your quit day, minus any you logged. '
          'Life kept uses ~20 minutes per cigarette, a population average from UK studies (Jackson, Jarvis & '
          'West, Addiction 2025). It is a communication device, not a prediction for you.',
          style: muted,
        ),
        SizedBox(height: 16),
        Text('Craving SOS', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
        SizedBox(height: 6),
        Text(
          'Urge surfing based on acceptance and commitment therapy, paced at 6 breaths a minute. Slow breathing '
          'may ease a craving in the moment (small effect). This app feature has not been tested in a clinical trial.',
          style: muted,
        ),
        SizedBox(height: 16),
        Text('Always consult a qualified health professional before making medical decisions.', style: muted),
      ],
    ),
  ),
);

// ---------------------------------------------------------------------------
// Lung illustration: a CustomPainter port of the mockup SVG (stand-in for the
// planned Rive file). Bound to tarDensity, bronchialInflammation and
// alveolarOxygenation (§4.3). No avatar polish before Gate #2 (§0.6).
// ---------------------------------------------------------------------------

class LungView extends StatefulWidget {
  const LungView({super.key, required this.tar, required this.inflam, required this.o2, this.haze = 0, this.size = 230});
  final double tar, inflam, o2, haze, size;

  @override
  State<LungView> createState() => _LungViewState();
}

class _LungViewState extends State<LungView> with SingleTickerProviderStateMixin {
  late final AnimationController breath = AnimationController(vsync: this, duration: const Duration(seconds: 5))..repeat(reverse: true);

  @override
  void dispose() {
    breath.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final still = MediaQuery.disableAnimationsOf(context);
    return Semantics(
      label: 'Lung illustration',
      child: SizedBox.square(
        dimension: widget.size,
        child: AnimatedBuilder(
          animation: breath,
          builder: (_, __) => CustomPaint(
            painter: LungPainter(
              tar: widget.tar.clamp(0, 1),
              inflam: widget.inflam.clamp(0, 1),
              o2: widget.o2.clamp(0, 1),
              haze: widget.haze,
              breath: still ? .5 : Curves.easeInOut.transform(breath.value),
            ),
          ),
        ),
      ),
    );
  }
}

class LungPainter extends CustomPainter {
  LungPainter({required this.tar, required this.inflam, required this.o2, required this.breath, this.haze = 0});
  final double tar, inflam, o2, breath, haze;

  static Path _path(List<double> p) {
    final path = Path()..moveTo(p[0], p[1]);
    for (var i = 2; i + 5 < p.length; i += 6) {
      path.cubicTo(p[i], p[i + 1], p[i + 2], p[i + 3], p[i + 4], p[i + 5]);
    }
    return path..close();
  }

  static final _lungs = Path()
    ..addPath(
      _path([138, 92, 120, 70, 84, 76, 66, 112, 48, 148, 42, 200, 50, 238, 56, 266, 82, 282, 108, 276, 126, 272, 136, 262, 138, 246]),
      Offset.zero,
    )
    ..addPath(
      _path([
        162,
        92,
        180,
        70,
        216,
        76,
        234,
        112,
        252,
        148,
        258,
        200,
        250,
        238,
        244,
        266,
        218,
        282,
        192,
        276,
        176,
        272,
        166,
        264,
        164,
        252,
        176,
        240,
        178,
        222,
        170,
        208,
        165,
        200,
        162,
        192,
        162,
        184,
      ]),
      Offset.zero,
    );

  static const List<List<double>> _bronchiL = [
    [150, 100, 124, 122, 9],
    [124, 122, 104, 148, 7],
    [104, 148, 84, 134, 4],
    [84, 134, 68, 126, 2.5],
    [84, 134, 80, 112, 2.2],
    [104, 148, 92, 184, 5],
    [92, 184, 74, 200, 3],
    [74, 200, 62, 214, 2],
    [92, 184, 84, 220, 3.5],
    [84, 220, 80, 250, 2.2],
    [104, 148, 116, 186, 4],
    [116, 186, 122, 222, 2.8],
    [122, 222, 118, 252, 1.8],
    [116, 186, 130, 200, 2],
  ];

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 300);
    const white = Color(0xFFFFFFFF), black = Color(0xFF000000);
    final tissue = Color.lerp(Color.lerp(const Color(0xFF5B6573), AppColors.tissue, o2), const Color(0xFF43474E), tar * .62)!;

    final r = 116 + 8 * breath;
    canvas.drawCircle(
      const Offset(150, 172),
      r,
      Paint()
        ..shader = RadialGradient(
          colors: [
            AppColors.oxygen.withValues(alpha: .14 + .26 * o2),
            AppColors.oxygen.withValues(alpha: 0),
          ],
        ).createShader(Rect.fromCircle(center: const Offset(150, 172), radius: r)),
    );

    canvas.save();
    final s = 1 + .035 * (breath - .5) * 2;
    canvas
      ..translate(150, 175)
      ..scale(s)
      ..translate(-150, -175);

    canvas.drawPath(
      _lungs,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.lerp(tissue, white, .14)!, Color.lerp(tissue, black, .12)!],
        ).createShader(const Rect.fromLTWH(40, 70, 220, 215)),
    );

    canvas.save();
    canvas.clipPath(_lungs);
    final alv = Random(7);
    final alvFill = Paint()..color = Color.lerp(tissue, white, .22)!.withValues(alpha: .28);
    final alvStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = .6
      ..color = Color.lerp(tissue, black, .25)!.withValues(alpha: .28);
    for (var i = 0; i < 170; i++) {
      final c = Offset(40 + alv.nextDouble() * 220, 85 + alv.nextDouble() * 200);
      final rad = 2.8 + alv.nextDouble() * 4.2;
      canvas
        ..drawCircle(c, rad, alvFill)
        ..drawCircle(c, rad, alvStroke);
    }
    final soot = Random(11);
    for (var i = 0; i < (330 * tar).round(); i++) {
      final c = Offset(42 + soot.nextDouble() * 216, 88 + soot.nextDouble() * 196);
      final rad = .7 + soot.nextDouble() * 1.7;
      canvas.drawCircle(c, rad, Paint()..color = const Color(0xFF18191B).withValues(alpha: .55 + soot.nextDouble() * .35));
    }
    if (haze > 0) {
      canvas.drawRect(
        const Rect.fromLTWH(30, 70, 240, 220),
        Paint()
          ..color = const Color(0xFF9AA0A8).withValues(alpha: haze * .45)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
      );
    }
    canvas.restore();

    canvas.drawPath(
      _lungs,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..color = Color.lerp(tissue, white, .35)!.withValues(alpha: .5),
    );

    // Airways: warm amber with inflammation, never saturated red.
    final brW = 1 + .12 * inflam;
    final brC = Color.lerp(const Color(0xFFF6D9CE), AppColors.repair, inflam)!;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(150 - 7 * brW, 22, 14 * brW, 80), const Radius.circular(7)),
      Paint()..color = brC.withValues(alpha: .95),
    );
    final ring = Paint()
      ..color = Color.lerp(brC, black, .22)!
      ..strokeWidth = 1.3;
    for (final y in [34.0, 46.0, 58.0, 70.0, 82.0]) {
      canvas.drawLine(Offset(150 - 7 * brW, y), Offset(150 + 7 * brW, y), ring);
    }
    final br = Paint()
      ..color = brC.withValues(alpha: .92)
      ..strokeCap = StrokeCap.round;
    for (final b in _bronchiL) {
      br.strokeWidth = b[4] * brW;
      canvas
        ..drawLine(Offset(b[0], b[1]), Offset(b[2], b[3]), br)
        ..drawLine(Offset(300 - b[0], b[1]), Offset(300 - b[2], b[3]), br);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(LungPainter old) => old.tar != tar || old.inflam != inflam || old.o2 != o2 || old.breath != breath || old.haze != haze;
}
