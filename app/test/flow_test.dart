// Drives the real UI: consent → onboarding → home → Craving SOS → slip.
import 'package:clearway/main.dart';
import 'package:clearway/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('first run to a logged surf', (t) async {
    t.view.physicalSize = const Size(1170, 7500); // phone width, tall enough that nothing needs scrolling
    t.view.devicePixelRatio = 3;
    addTearDown(t.view.reset);
    SharedPreferences.setMockInitialValues({});
    await app.load();
    await t.pumpWidget(const ClearwayApp());

    for (final box in ['I am 18 or older.', 'wellness prototype, not a medical device.', 'on this device only, to']) {
      await t.tap(find.textContaining(box));
    }
    await t.pump();
        await t.tap(find.text('Continue'));
    await t.pumpAndSettle();

    expect(app.consentAt, isNotNull);
    Future<void> pick(String label) async {
      await t.tap(find.text(label));
      await t.pump(const Duration(milliseconds: 300)); // auto-advance delay
      await t.pumpAndSettle();
    }

    await pick('Cigarettes');
    await pick('6–30 minutes');
    await t.tap(find.text('Next'));
    await t.pumpAndSettle();
    for (final f in ['Almost always', 'Often', 'Sometimes', 'Rarely']) {
      await pick(f); // AFF, CUE, AUTO, SOC
    }
    await pick('Planning to quit in the next 30 days');
    await pick('Yes'); // 8b → Preparation
    for (var i = 0; i < 4; i++) {
      await pick('Agree'); // EPPM: T = E = 12 → danger control, so the reveal shows
    }
    await pick('Disagree'); // avoidance probe
    await pick('Agree'); // hard on myself

    await t.tap(find.text('Today, starting now'));
    await t.enterText(find.byType(TextField), '340');
    await t.pump();
        await t.tap(find.text('Continue'));
    await t.pump(const Duration(milliseconds: 500));
    expect(find.textContaining('Your lungs on quit day'), findsOneWidget);
        await t.tap(find.text('See my plan'));
    await t.pump(const Duration(seconds: 1)); // lung keeps breathing, so never "settles"

    expect(app.answers!.cpd, 10);
    expect(phenotype(app.answers!).primary, 'AFF');
    expect(find.text('hours smoke-free'), findsOneWidget);
    expect(find.text('Stress is your top trigger'), findsOneWidget);

    await t.tap(find.text('Craving SOS'));
    await t.pump(const Duration(seconds: 1));
    await t.pump(const Duration(seconds: 2));
    await t.tap(find.text("I'm OK now"));
    await t.pump(const Duration(milliseconds: 500));
    expect(find.text('You rode it out.'), findsOneWidget);
    await t.tap(find.text('Done'));
    await t.pump(const Duration(seconds: 1));
    await t.pump(const Duration(seconds: 1));
    expect(app.ofType('surf').single['secs'], greaterThanOrEqualTo(2));

    await t.pumpWidget(const SizedBox()); // dispose timers
  });

  testWidgets('I smoked opens the slip response and logs it', (t) async {
    t.view.physicalSize = const Size(1170, 7500);
    t.view.devicePixelRatio = 3;
    addTearDown(t.view.reset);
    SharedPreferences.setMockInitialValues({});
    await app.load();
    app
      ..consentAt = DateTime.now()
      ..answers = Answers()
      ..quitAt = DateTime.now().subtract(const Duration(days: 3));
    await t.pumpWidget(const ClearwayApp());
    await t.pump();

    await t.tap(find.text('I smoked'));
    await t.pump(); // a pushed route's first frame is offstage (Hero measuring)
    await t.pump(const Duration(seconds: 1));
    await t.tap(find.text('1'));
    await t.pump(const Duration(milliseconds: 500));
    expect(find.textContaining('One cigarette is a slip, not a restart'), findsOneWidget);
    expect(app.slips.single.n, 1);

    await t.pumpWidget(const SizedBox()); // dispose timers
  });
}
