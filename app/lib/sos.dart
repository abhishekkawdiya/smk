// Craving SOS: the 180-second Urge Surfer (§2.1) on a 0.1 Hz pacer,
// 18 × (4 s in + 6 s out) (§2.5, §4.5), craving mode visuals (§4.6).
// Success is "didn't smoke"; there is no failed state.
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main.dart';
import 'model.dart';

const _contexts = ['Stress', 'After a meal', 'Coffee', 'Alcohol', 'Boredom', 'People smoking'];
const _bodyParts = ['Mouth', 'Throat', 'Chest', 'Stomach', 'Hands', 'Head'];
const _feels = ['Tight', 'Buzzy', 'Hollow', 'Warm', 'Restless', 'Pulling'];
const _trends = ['Still rising', 'Steady', 'Easing'];
const _nexts = ['Drink some water', 'Short walk', 'Text someone', 'Back to what I was doing'];

class SosScreen extends StatefulWidget {
  const SosScreen({super.key});
  @override
  State<SosScreen> createState() => _SosScreenState();
}

class _SosScreenState extends State<SosScreen> with SingleTickerProviderStateMixin {
  // One monotonic clock drives the ring, the breath circle and the haptics.
  late final AnimationController clock = AnimationController(vsync: this, duration: const Duration(seconds: 180))
    ..addListener(_beat)
    ..addStatusListener((s) {
      if (s == AnimationStatus.completed) setState(() => done = true);
    })
    ..forward();

  int? pre, post;
  final ctx = <String>{}, body = <String>{}, feel = <String>{};
  String? trend, nextAct;
  bool done = false, logged = false;
  int lastBeat = -1;

  double get t => clock.value * 180;

  void _beat() {
    final beat = (t / 10).floor() * 2 + (t % 10 < 4 ? 0 : 1);
    if (beat == lastBeat) return;
    lastBeat = beat;
    buzz(beat.isEven ? HapticFeedback.selectionClick : HapticFeedback.lightImpact); // exhale weighted
  }

  void _log() {
    if (logged) return;
    logged = true;
    app.log('surf', {
      'pre': pre, 'post': post, 'ctx': ctx.toList(), 'body': body.toList(), 'feel': feel.toList(),
      'trend': trend, 'next': nextAct, 'secs': t.round(), 'full': t >= 179,
    });
  }

  void _surfAgain() {
    _log();
    setState(() {
      logged = false;
      done = false;
      pre = post;
      post = null;
      trend = nextAct = null;
      lastBeat = -1;
    });
    clock.forward(from: 0);
  }

  void _exit() {
    _log();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    clock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PopScope(
        onPopInvokedWithResult: (_, __) => _log(), // system back: exit is always allowed, logged silently
        child: Scaffold(
          backgroundColor: AppColors.cravingBg,
          body: SafeArea(
            child: AnimatedBuilder(animation: clock, builder: (context, _) => done ? _done() : _active(context)),
          ),
        ),
      );

  Widget _topBar() => Row(children: [
        IconButton(tooltip: 'Exit', onPressed: _exit, icon: const Icon(Icons.close, color: AppColors.variant)),
        const Spacer(),
        IconButton(
          tooltip: app.haptics ? 'Turn vibration off' : 'Turn vibration on',
          onPressed: () => setState(() {
            app.haptics = !app.haptics;
            app.save();
          }),
          icon: Icon(app.haptics ? Icons.vibration : Icons.mobile_off, color: AppColors.variant),
        ),
      ]);

  Widget _active(BuildContext context) {
    final still = MediaQuery.disableAnimationsOf(context);
    final ph = (t % 10) / 10;
    double ease(double x) => -(cos(pi * x) - 1) / 2;
    final p = ph < .4 ? ease(ph / .4) : 1 - ease((ph - .4) / .6); // 0 = empty, 1 = full
    final left = (180 - t).ceil();
    final narration = switch (t) {
      < 10 => "Thanks for opening this instead of the pack. You don't have to make this urge go away. We'll just watch it together.",
      < 30 => 'Feel your feet on the floor. Let the breath set the pace.',
      < 70 => "Where is the urge living right now? What does it feel like? Not what it's telling you to do, just how it feels.",
      < 130 => "Urges rise, peak and fall. It may get stronger before it eases, and that's normal. You're on the board, not under the water. If 'just one' shows up, notice it: that's a thought, not an order.",
      < 160 => "Whatever it's doing is OK. Make a little room for it, the way you'd let a wave pass under you.",
      _ => 'Nearly there. Notice how the urge feels now.',
    };
    return Column(children: [
      _topBar(),
      SizedBox(
        width: 250,
        height: 250,
        child: Stack(alignment: Alignment.center, children: [
          SizedBox.expand(
            child: CircularProgressIndicator(
              value: 1 - t / 180,
              strokeWidth: 6,
              color: AppColors.calm,
              backgroundColor: const Color(0xFF222222),
            ),
          ),
          Container(
            width: still ? 200 : 110 + 110 * p,
            height: still ? 200 : 110 + 110 * p,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.calm.withValues(alpha: still ? .12 + .3 * p : .2),
              border: Border.all(color: AppColors.calm.withValues(alpha: .6)),
            ),
          ),
          Semantics(
            liveRegion: true,
            label: ph < .4 ? 'Breathe in' : 'Breathe out',
            child: Text('${left ~/ 60}:${(left % 60).toString().padLeft(2, '0')}',
                style: const TextStyle(fontSize: 52, fontWeight: FontWeight.w600, fontFeatures: tabular)),
          ),
        ]),
      ),
      const SizedBox(height: 10),
      AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: Text(ph < .4 ? 'Breathe in' : 'Breathe out',
            key: ValueKey(ph < .4), style: const TextStyle(fontSize: 22, color: AppColors.calm)),
      ),
      Expanded(
        child: ListView(padding: const EdgeInsets.fromLTRB(24, 16, 24, 8), children: [
          Text(narration, textAlign: TextAlign.center, style: const TextStyle(fontSize: 17, height: 1.45)),
          const SizedBox(height: 18),
          if (t < 30) ...[
            const Text('How strong is the urge? (optional)', style: muted),
            const SizedBox(height: 8),
            _scale(pre, (v) => pre = v),
            const SizedBox(height: 14),
            Chips(_contexts, selected: ctx, color: AppColors.calm, onTap: (o) => setState(() => _toggle(ctx, o))),
          ] else if (t < 70) ...[
            Chips(_bodyParts, selected: body, color: AppColors.calm, onTap: (o) => setState(() => _toggle(body, o))),
            const SizedBox(height: 12),
            Chips(_feels, selected: feel, color: AppColors.calm, onTap: (o) => setState(() => _toggle(feel, o))),
          ] else if (t >= 130 && t < 160)
            Chips(_trends, selected: {?trend}, color: AppColors.calm, onTap: (o) => setState(() => trend = o)),
        ]),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 4),
        child: SizedBox(
          width: double.infinity,
          child: FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.calm, foregroundColor: AppColors.onCalm, minimumSize: const Size(64, 60)),
            onPressed: () {
              clock.stop();
              setState(() => done = true);
            },
            child: const Text("I'm OK now"),
          ),
        ),
      ),
      TextButton(onPressed: _otherWays, child: const Text('Other ways', style: TextStyle(color: AppColors.variant))),
    ]);
  }

  Widget _done() {
    final secs = t.round();
    return Column(children: [
      _topBar(),
      Expanded(
        child: ListView(padding: const EdgeInsets.fromLTRB(24, 8, 24, 16), children: [
          const Icon(Icons.waves, size: 48, color: AppColors.calm),
          const SizedBox(height: 12),
          const Text('You rode it out.', textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(
            'You stayed with ${secs ~/ 60}:${(secs % 60).toString().padLeft(2, '0')} of a craving without smoking.',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 17, color: AppColors.variant),
          ),
          const SizedBox(height: 28),
          const Text('How strong is it now?', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          _scale(post, (v) {
            post = v;
            buzz(HapticFeedback.mediumImpact);
          }),
          if (post != null) ...[
            const SizedBox(height: 14),
            const Center(child: Chip(avatar: Icon(Icons.check, size: 16, color: AppColors.calm), label: Text('Craving surfed'))),
          ],
          const SizedBox(height: 24),
          const Text("What's one thing you'll do next that matters to you?", style: TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          Chips(_nexts, selected: {?nextAct}, color: AppColors.calm, onTap: (o) => setState(() => nextAct = o)),
        ]),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
        child: Row(children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(minimumSize: const Size(64, 56), foregroundColor: AppColors.calm),
              onPressed: _surfAgain,
              child: const Text('Surf again'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: FilledButton(
              style: FilledButton.styleFrom(backgroundColor: AppColors.calm, foregroundColor: AppColors.onCalm, minimumSize: const Size(64, 56)),
              onPressed: _exit,
              child: const Text('Done'),
            ),
          ),
        ]),
      ),
    ]);
  }

  Widget _scale(int? value, ValueChanged<int> set) => Chips(
        [for (var i = 0; i <= 10; i++) '$i'],
        selected: {if (value != null) '$value'},
        color: AppColors.calm,
        onTap: (o) => setState(() => set(int.parse(o))),
      );

  void _toggle(Set<String> s, String o) => s.contains(o) ? s.remove(o) : s.add(o);

  void _otherWays() => showModalBottomSheet<void>(
        context: context,
        backgroundColor: AppColors.high,
        builder: (_) => const Padding(
          padding: EdgeInsets.fromLTRB(24, 24, 24, 32),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Move for 3 minutes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 6),
            Text('Brisk walk, stairs, or a wall-sit. Keep going to 5–10 minutes for a stronger effect.', style: muted),
            SizedBox(height: 18),
            Text('Name it', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 6),
            Text('"I\'m noticing the thought that I need a smoke… and I can choose what I do next."', style: muted),
            SizedBox(height: 18),
            Text('Reach out', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 6),
            Text('Call or text someone who backs your quit.', style: muted),
          ]),
        ),
      );
}
