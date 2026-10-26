import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home.dart';
import 'model.dart';
import 'onboarding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await app.load();
  runApp(const ClearwayApp());
}

/// §4.4 colour tokens. No red outside clinical red-flag copy.
abstract final class AppColors {
  static const surface = Color(0xFF131313);
  static const container = Color(0xFF1F1F1F);
  static const high = Color(0xFF2A2A2A);
  static const highest = Color(0xFF353535);
  static const onSurface = Color(0xFFE2E2E2);
  static const variant = Color(0xFF9E9E9E);
  static const oxygen = Color(0xFF4FD1C5);
  static const tissue = Color(0xFFFFB59E);
  static const data = Color(0xFFC6B8FF);
  static const calm = Color(0xFF8AB4F8);
  static const onCalm = Color(0xFF0B1B33);
  static const cravingBg = Color(0xFF0E0E0E);
  static const repair = Color(0xFFF6B26B);
  static const onRepair = Color(0xFF2B1700);
  static const dangerSoft = Color(0xFFF28B82);
}

const tabular = [FontFeature.tabularFigures()];

/// Haptics are optional (HIG); all calls go through here.
void buzz(Future<void> Function() f) {
  if (app.haptics) f();
}

class ClearwayApp extends StatelessWidget {
  const ClearwayApp({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = const ColorScheme.dark(
      primary: AppColors.oxygen,
      onPrimary: Color(0xFF0D2422),
      secondary: AppColors.data,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      error: AppColors.dangerSoft,
    );
    return MaterialApp(
      title: 'Clearway',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        scaffoldBackgroundColor: AppColors.surface,
        textTheme: ThemeData.dark().textTheme.apply(bodyColor: AppColors.onSurface, displayColor: AppColors.onSurface),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(minimumSize: const Size(64, 52), textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ),
      ),
      home: ListenableBuilder(
        listenable: app,
        builder: (_, __) => app.consentAt == null
            ? const ConsentScreen()
            : app.answers == null
                ? const Onboarding()
                : const HomeScreen(),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared widgets
// ---------------------------------------------------------------------------

/// Large single-choice row, ≥48 dp tall.
class OptionTile extends StatelessWidget {
  const OptionTile(this.label, {super.key, required this.selected, required this.onTap, this.color = AppColors.oxygen});
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Material(
          color: selected ? color.withValues(alpha: .18) : AppColors.container,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: selected ? color : Colors.transparent, width: 1.5),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              buzz(HapticFeedback.selectionClick);
              onTap();
            },
            child: Container(
              constraints: const BoxConstraints(minHeight: 56),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              alignment: Alignment.centerLeft,
              child: Row(children: [
                Expanded(child: Text(label, style: const TextStyle(fontSize: 16))),
                if (selected) Icon(Icons.check_circle, color: color, size: 20),
              ]),
            ),
          ),
        ),
      );
}

/// Wrap of choice chips; [selected] holds the chosen labels.
class Chips extends StatelessWidget {
  const Chips(this.options, {super.key, required this.selected, required this.onTap, this.color = AppColors.oxygen});
  final List<String> options;
  final Set<String> selected;
  final ValueChanged<String> onTap;
  final Color color;

  @override
  Widget build(BuildContext context) => Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final o in options)
            ChoiceChip(
              label: Text(o),
              selected: selected.contains(o),
              showCheckmark: false,
              selectedColor: color.withValues(alpha: .22),
              backgroundColor: AppColors.container,
              side: BorderSide(color: selected.contains(o) ? color : AppColors.highest),
              labelStyle: TextStyle(color: selected.contains(o) ? color : AppColors.onSurface),
              materialTapTargetSize: MaterialTapTargetSize.padded,
              onSelected: (_) {
                buzz(HapticFeedback.selectionClick);
                onTap(o);
              },
            ),
        ],
      );
}

/// Evidence-grade badge (§1.2). Grade D never ships.
class GradeBadge extends StatelessWidget {
  const GradeBadge(this.grade, {super.key});
  final String grade;

  @override
  Widget build(BuildContext context) {
    final c = switch (grade) { 'A' => AppColors.oxygen, 'B' => AppColors.data, _ => AppColors.variant };
    return Container(
      margin: const EdgeInsets.only(left: 4),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(border: Border.all(color: c), borderRadius: BorderRadius.circular(5)),
      child: Text(grade, style: TextStyle(color: c, fontSize: 11, fontWeight: FontWeight.w700)),
    );
  }
}

class Section extends StatelessWidget {
  const Section(this.child, {super.key, this.color = AppColors.container, this.onTap});
  final Widget child;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onTap,
            child: Padding(padding: const EdgeInsets.all(16), child: child),
          ),
        ),
      );
}

const muted = TextStyle(color: AppColors.variant, fontSize: 14, height: 1.35);

// ---------------------------------------------------------------------------
// First-launch consent (§6.6 B)
// ---------------------------------------------------------------------------

class ConsentScreen extends StatefulWidget {
  const ConsentScreen({super.key});
  @override
  State<ConsentScreen> createState() => _ConsentScreenState();
}

class _ConsentScreenState extends State<ConsentScreen> {
  bool adult = false, notDevice = false, health = false;

  @override
  Widget build(BuildContext context) {
    final ok = adult && notDevice && health;
    Widget box(String text, bool v, ValueChanged<bool> on) => CheckboxListTile(
          value: v,
          onChanged: (x) => setState(() => on(x!)),
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          title: Text(text, style: const TextStyle(fontSize: 15)),
        );
    return Scaffold(
      body: SafeArea(
        child: ListView(padding: const EdgeInsets.fromLTRB(20, 24, 20, 24), children: [
          const Text('Welcome to Clearway', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          const Text(
            'Clearway helps you build a smoke-free routine with craving tools, progress you keep, and '
            'visual estimates of recovery. It is not a medical device and does not give medical advice, '
            'diagnosis, or treatment. Its recovery visuals are educational estimates from published '
            'research, not measurements of your body.',
            style: TextStyle(fontSize: 16, height: 1.4),
          ),
          const SizedBox(height: 16),
          Section(
            color: AppColors.high,
            const Text(
              'If you feel unwell: chest pain, severe shortness of breath, fainting, coughing up blood, or '
              'thoughts of harming yourself, stop using the app and call your local emergency number now '
              '(112 in India and the EU, 911 in the US, 999 in the UK).',
              style: TextStyle(color: AppColors.dangerSoft, height: 1.4),
            ),
          ),
          box('I am 18 or older.', adult, (v) => adult = v),
          box('I understand this is a wellness prototype, not a medical device.', notDevice, (v) => notDevice = v),
          box(
            'I agree to Clearway processing the smoking and craving information I enter, on this device only, '
            'to personalise my plan.',
            health,
            (v) => health = v,
          ),
          const SizedBox(height: 4),
          const Text(
            'Everything stays on this device. Nothing is sent anywhere. You can delete it all from the menu.',
            style: muted,
          ),
          if (!adult) ...[
            const SizedBox(height: 8),
            const Text('Clearway is for adults only.', style: muted),
          ],
          const SizedBox(height: 20),
          FilledButton(
            onPressed: ok
                ? () {
                    app.consentAt = DateTime.now();
                    app.save();
                  }
                : null,
            child: const Text('Continue'),
          ),
        ]),
      ),
    );
  }
}
