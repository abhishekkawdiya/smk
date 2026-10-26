import 'dart:math';

import 'package:clearway/model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('dependence: HSI bands, TTFC override, dual-use bump (§3.3)', () {
    expect(dependence(Answers()..ttfc = 0..cpd = 10), Dep.low);
    expect(dependence(Answers()..ttfc = 1..cpd = 15), Dep.moderate);
    expect(dependence(Answers()..ttfc = 3..cpd = 5), Dep.moderateHigh); // TTFC ≤5 min overrides HSI 3
    expect(dependence(Answers()..ttfc = 3..cpd = 25), Dep.high);
    expect(dependence(Answers()..ttfc = 1..cpd = 15..dualUse = true..ttfcVape = 2), Dep.moderateHigh);
  });

  test('phenotype: low, diffuse, primary with AFF > AUTO > CUE > SOC tie-break', () {
    expect(phenotype(Answers()..aff = 1..cue = 1).kind, 'LOW_TRIGGER');
    expect(phenotype(Answers()..aff = 3..cue = 3..auto = 2..soc = 3).kind, 'DIFFUSE');
    final p = phenotype(Answers()..cue = 4..auto = 4..soc = 0..aff = 1);
    expect((p.primary, p.secondary), ('AUTO', 'CUE'));
    expect(phenotype(Answers()..soc = 4).primary, 'SOC');
  });

  test('EPPM quadrants, fear-control checked first', () {
    expect(eppm(Answers()..sev = 6..sus = 6..resp = 6..self = 6), 'DANGER_CONTROL');
    expect(eppm(Answers()..sev = 7..sus = 7..resp = 5..self = 5), 'FEAR_CONTROL_RISK'); // CV = −4
    expect(eppm(Answers()..sev = 6..sus = 6..resp = 6..self = 6..avoid = 5), 'FEAR_CONTROL_RISK');
    expect(eppm(Answers()..sev = 2..sus = 2..resp = 6..self = 6), 'LOW_RELEVANCE');
    expect(eppm(Answers()..sev = 2..sus = 2..resp = 2..self = 2), 'LOW_LOW');
  });

  test('recovery: CO half-life 4.5 h, slip dip clears, slow terms ignore slips', () {
    final q = DateTime(2026, 1, 1, 8);
    final r = recovery(quitAt: q, slips: [], cpd: 15, now: q.add(const Duration(minutes: 270)));
    expect(r['CO'], closeTo(0.5, 0.01));
    expect(recovery(quitAt: q, slips: [], cpd: 15, now: q.subtract(const Duration(hours: 1)))['CO'], 0);

    final day3 = q.add(const Duration(days: 3));
    final slip = (at: day3, n: 1);
    final justAfter = recovery(quitAt: q, slips: [slip], cpd: 15, now: day3.add(const Duration(minutes: 1)));
    final dayLater = recovery(quitAt: q, slips: [slip], cpd: 15, now: day3.add(const Duration(days: 1)));
    final clean = recovery(quitAt: q, slips: [], cpd: 15, now: day3);
    expect(justAfter['CO']!, lessThan(clean['CO']!)); // a dip...
    expect(justAfter['CO']!, greaterThan(0.8)); // ...not a reset to quit day
    expect(dayLater['CO']!, greaterThan(0.95));
    final noSlip = recovery(quitAt: q, slips: [], cpd: 15, now: day3.add(const Duration(minutes: 1)));
    expect(justAfter['MCC'], noSlip['MCC']); // slow domains follow the quit date only
    expect(clean['MCC'], closeTo(1 - exp(-3 / 6), 1e-9));
  });

  test('stats: smoke-free days never reset, money counts cigarettes smoked', () {
    final s = AppState()
      ..answers = (Answers()..cpd = 10)
      ..quitAt = DateTime(2026, 1, 1)
      ..packPrice = 200
      ..perPack = 20
      ..events = [
        {'t': DateTime(2026, 1, 10, 20).toIso8601String(), 'type': 'slip', 'n': 3},
      ];
    final st = s.stats(DateTime(2026, 1, 21));
    expect(st.smokeFreeDays, 19); // 20 days elapsed, 1 slip day
    expect(st.notSmoked, 197); // 10/day × 20 − 3
    expect(st.notSmoked * s.pricePerCig, 1970);
    expect(st.run.inHours, 10 * 24 + 4);
  });

  test('requit banks totals; relapse routing', () {
    final s = AppState()
      ..answers = (Answers()..cpd = 10)
      ..quitAt = DateTime(2026, 1, 1);
    s.requit(DateTime(2026, 2, 1), DateTime(2026, 1, 11));
    expect(s.bankedDays, 10);
    expect(s.stats(DateTime(2026, 2, 3)).smokeFreeDays, 12);

    final now = DateTime(2026, 3, 10, 12);
    final week = [for (var i = 0; i < 7; i++) DateTime(2026, 3, 10 - i, 9)];
    expect(consecutiveSmokingDays(week, now), 7);
    expect(consecutiveSmokingDays(week.skip(1), now), 0);
    expect(isRelapse(regular: false, smokingDaysInRow: 7), isTrue);
    expect(isRelapse(regular: false, smokingDaysInRow: 2), isFalse);
  });
}
