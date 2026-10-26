// Domain logic for the Gate #1 prototype. Section numbers (§) refer to
// reports/Smoking cessation app blueprint.md.
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ---------------------------------------------------------------------------
// Onboarding answers (§3.2) and scoring rubric (§3.3)
// ---------------------------------------------------------------------------

class Answers {
  bool dualUse = false; // item 1: cigarettes + vapes
  int ttfc = 0; // item 2 points: ≤5 min 3 · 6–30 2 · 31–60 1 · >60 0
  int cpd = 10; // item 3: exact cigarettes per day
  int ttfcVape = 0; // item 3b points (dual users only)
  int aff = 0, cue = 0, auto = 0, soc = 0; // items 4–7, 0–4
  String stage = 'P'; // item 8 (+8b): PC | C | P | A | M | CUT
  int sev = 4, sus = 4, resp = 4, self = 4; // items 9–12, 1–7
  int avoid = 1; // item 13, 1–7
  bool selfCritical = false; // optional item (§2.4)

  Map<String, dynamic> toJson() => {
        'dualUse': dualUse, 'ttfc': ttfc, 'cpd': cpd, 'ttfcVape': ttfcVape,
        'aff': aff, 'cue': cue, 'auto': auto, 'soc': soc, 'stage': stage,
        'sev': sev, 'sus': sus, 'resp': resp, 'self': self, 'avoid': avoid,
        'selfCritical': selfCritical,
      };

  static Answers fromJson(Map<String, dynamic> j) => Answers()
    ..dualUse = j['dualUse']
    ..ttfc = j['ttfc']
    ..cpd = j['cpd']
    ..ttfcVape = j['ttfcVape']
    ..aff = j['aff']
    ..cue = j['cue']
    ..auto = j['auto']
    ..soc = j['soc']
    ..stage = j['stage']
    ..sev = j['sev']
    ..sus = j['sus']
    ..resp = j['resp']
    ..self = j['self']
    ..avoid = j['avoid']
    ..selfCritical = j['selfCritical'];
}

enum Dep { low, moderate, moderateHigh, high }

int cpdPoints(int cpd) => cpd <= 10 ? 0 : cpd <= 20 ? 1 : cpd <= 30 ? 2 : 3;

/// HSI with PhenX bands, the Baker 2007 TTFC override and the dual-use bump.
Dep dependence(Answers a) {
  final hsi = a.ttfc + cpdPoints(a.cpd);
  var tier = hsi <= 1 ? Dep.low : hsi <= 4 ? Dep.moderate : Dep.high;
  if (a.ttfc == 3 && tier.index < Dep.moderateHigh.index) tier = Dep.moderateHigh;
  if (a.dualUse && a.ttfcVape >= 2) tier = Dep.values[min(tier.index + 1, Dep.high.index)];
  return tier;
}

typedef Phenotype = ({String kind, String? primary, String? secondary});

Phenotype phenotype(Answers a) {
  // Map order is the tie-break: AFF > AUTO > CUE > SOC.
  final s = {'AFF': a.aff, 'AUTO': a.auto, 'CUE': a.cue, 'SOC': a.soc};
  final hi = s.values.reduce(max), lo = s.values.reduce(min);
  if (hi <= 1) return (kind: 'LOW_TRIGGER', primary: null, secondary: null);
  if (hi - lo <= 1 && hi >= 3) return (kind: 'DIFFUSE', primary: null, secondary: null);
  String best(Iterable<String> keys) => keys.reduce((x, y) => s[y]! > s[x]! ? y : x);
  final p = best(s.keys);
  final sec = best(s.keys.where((k) => k != p));
  return (kind: 'PRIMARY', primary: p, secondary: s[sec]! >= 3 ? sec : null);
}

/// EPPM quadrant. Fear-control is checked first so its CV/avoidance clauses
/// can't be shadowed by the danger-control quadrant (protective reading).
String eppm(Answers a) {
  final t = a.sev + a.sus, e = a.resp + a.self;
  if ((t >= 10 && e < 10) || e - t <= -3 || a.avoid >= 5) return 'FEAR_CONTROL_RISK';
  if (t >= 10) return 'DANGER_CONTROL';
  return e >= 10 ? 'LOW_RELEVANCE' : 'LOW_LOW';
}

typedef HeroCard = ({String title, String body, String action}); // action: sos | plan | none

/// One hero card from §3.4. The priority order between rows is a design
/// choice [M]; A/B test phenotype-matched vs generic (§3.4).
HeroCard heroCard(Answers a) {
  if (eppm(a) == 'FEAR_CONTROL_RISK') {
    return (
      title: 'Quitting is a skill you can learn',
      body: 'In large reviews, stop-smoking medicines roughly double the odds of quitting '
          '(Cochrane 2023). Practising with urges helps too. Small wins count here.',
      action: 'sos',
    );
  }
  if (const {'PC', 'C', 'CUT'}.contains(a.stage)) {
    return (
      title: 'Your reasons, your pace',
      body: 'No pressure to pick a date. Notice what smoking costs you today: money, time, '
          'breath. Every tool here works before a quit day too.',
      action: 'none',
    );
  }
  if (dependence(a).index >= Dep.moderateHigh.index) {
    return (
      title: 'Medicine can make this easier',
      body: 'A nicotine patch plus a fast-acting form (gum or lozenge) works better than one '
          'form alone. Ask a pharmacist to help you choose. This app never sets doses.',
      action: 'none',
    );
  }
  return switch (phenotype(a).primary) {
    'AFF' => (
        title: 'Stress is your top trigger',
        body: 'When stress pulls, open Craving SOS: 3 minutes of slow breathing while you '
            'watch the urge rise and fall.',
        action: 'sos',
      ),
    'CUE' => (
        title: 'Routines switch on your urges',
        body: 'Write one if-then plan for your strongest routine, like coffee or after meals.',
        action: 'plan',
      ),
    'AUTO' => (
        title: 'A lot of smoking happens on autopilot',
        body: 'Each time you notice an urge, open Craving SOS. Noticing is the skill.',
        action: 'sos',
      ),
    'SOC' => (
        title: 'Other smokers pull you in',
        body: "Plan what you'll do before your next night out. One if-then plan is enough.",
        action: 'plan',
      ),
    _ => (
        title: 'Ride out urges as they come',
        body: 'Craving SOS is one tap away. Urges rise and fall; many ease within minutes.',
        action: 'sos',
      ),
  };
}

// ---------------------------------------------------------------------------
// Recovery Index (§1.2): two numbers, fast and slow, each domain graded
// ---------------------------------------------------------------------------

class Domain {
  const Domain(this.key, this.label, this.grade, this.w, this.fast, this.tc, this.note);
  final String key, label, grade, note;
  final double w; // v1 weight [M]; AUTO's 0.25 is split evenly fast/slow [M]
  final bool fast; // fast: tc in hours, decays per cigarette; slow: tc in days from quit date
  final double tc;
}

const domains = [
  Domain('CO', 'Carbon monoxide', 'A', .30, true, 6.49, '~4.5 h half-life while awake (Sandberg 2011)'),
  Domain('NIC', 'Nicotine', 'C', .15, true, 2.89, '~2 h half-life (secondary source)'),
  Domain('AUTOf', 'Heart-rate spike', 'B', .125, true, .72, 'Back to baseline ~30 min after a cigarette'),
  Domain('AUTOs', 'Resting heart rate', 'C', .125, false, 2.5, '~7 bpm lower after 1 week (Minami 1999); curve interpolated'),
  Domain('MCC', 'Airway clearance', 'B', .10, false, 6, 'Nasal clearance normal by day 15 in one study (Ramos 2011)'),
  Domain('VASC', 'Blood vessels', 'C', .15, false, 30, 'Improves within about a month (2025 review)'),
  Domain('OLF', 'Smell', 'B', .05, false, 45, 'Improved by 45 days in one study'),
];

typedef Slip = ({DateTime at, int n});

/// Share recovered (0–1) per domain. Fast domains treat the quit moment as
/// smoker steady state and each slipped cigarette as a decaying bolus
/// (first-order superposition); slow domains decay from the quit date only,
/// so a slip shows as a dip that clears, never a reset.
// ponytail: CO uses the awake τ around the clock; add the ×1.5–1.8 sleep τ when we know sleep times.
Map<String, double> recovery({
  required DateTime? quitAt,
  required List<Slip> slips,
  required int cpd,
  required DateTime now,
}) {
  if (quitAt == null || now.isBefore(quitAt)) return {for (final d in domains) d.key: 0.0};
  final h = now.difference(quitAt).inSeconds / 3600;
  final gap = 16 / max(cpd, 1); // hours between cigarettes over a 16-h waking day [M]
  return {
    for (final d in domains)
      d.key: d.fast
          ? 1 -
              min(
                1.0,
                exp(-h / d.tc) +
                    slips.fold(0.0, (s, e) {
                      final hs = now.difference(e.at).inSeconds / 3600;
                      return hs < 0 ? s : s + e.n * (1 - exp(-gap / d.tc)) * exp(-hs / d.tc);
                    }),
              )
          : 1 - exp(-h / 24 / d.tc),
  };
}

double weighted(Map<String, double> r, {required bool fast}) {
  final ds = domains.where((d) => d.fast == fast);
  return ds.fold(0.0, (s, d) => s + d.w * r[d.key]!) / ds.fold(0.0, (s, d) => s + d.w);
}

// Re-grounded milestones (§1.2 table). sinceLastCig: measured from the last
// cigarette (quit or slip); otherwise from the quit date.
typedef Milestone = ({String title, String grade, Duration at, bool sinceLastCig});

const milestones = <Milestone>[
  (title: 'The heart-rate spike from your last cigarette has passed', grade: 'B', at: Duration(minutes: 30), sinceLastCig: true),
  (title: 'About 75% of smoking-related carbon monoxide cleared (waking hours)', grade: 'A', at: Duration(hours: 9), sinceLastCig: true),
  (title: 'Most smoking-related carbon monoxide is gone', grade: 'A', at: Duration(hours: 24), sinceLastCig: true),
  (title: 'Resting heart rate typically ~7 bpm lower (less during sleep)', grade: 'A', at: Duration(days: 7), sinceLastCig: false),
  (title: 'Nasal clearance back in the normal range, in one study', grade: 'B', at: Duration(days: 15), sinceLastCig: false),
  (title: 'Blood-vessel function starts improving', grade: 'C', at: Duration(days: 30), sinceLastCig: false),
  (title: 'Smell measurably better, in one study', grade: 'B', at: Duration(days: 45), sinceLastCig: false),
];

// ---------------------------------------------------------------------------
// Slip routing (§2.4)
// ---------------------------------------------------------------------------

DateTime _day(DateTime t) => DateTime(t.year, t.month, t.day);

/// Calendar days in a row, ending today, with at least one logged cigarette.
int consecutiveSmokingDays(Iterable<DateTime> slipTimes, DateTime now) {
  final days = slipTimes.map(_day).toSet();
  var n = 0;
  for (var d = _day(now); days.contains(d); d = DateTime(d.year, d.month, d.day - 1)) {
    n++;
  }
  return n;
}

/// 1–5 cigarettes → lapse pathway; "smoking regularly" or ≥7 smoking days in a
/// row → plan the next quit. The Russell ≤5 rule stays internal (never shown).
bool isRelapse({required bool regular, required int smokingDaysInRow}) => regular || smokingDaysInRow >= 7;

// ---------------------------------------------------------------------------
// App state, persisted on device
// ---------------------------------------------------------------------------

class Stats {
  Stats(this.smokeFreeDays, this.run, this.notSmoked, this.recovery, this.slips7d, this.sinceQuit);
  final int smokeFreeDays; // never resets (§2.4)
  final Duration run; // since last cigarette; resets on a slip, shown second
  final double notSmoked; // N(t) = C0·t − n(t) (§2.3), banked across quit attempts
  final Map<String, double> recovery;
  final int slips7d;
  final Duration sinceQuit;
}

/// Minutes of life expectancy per cigarette, population average (Jackson 2025).
const minutesPerCigarette = 20;

// ponytail: JSON in SharedPreferences, unencrypted. Swap for drift + sqlite3mc (§5.2) before real users.
class AppState extends ChangeNotifier {
  static const _key = 'clearway.v1';
  SharedPreferences? _prefs;

  DateTime? consentAt;
  Answers? answers;
  DateTime? quitAt;
  double packPrice = 0;
  int perPack = 20;
  String currency = '₹';
  int bankedDays = 0;
  double bankedNotSmoked = 0;
  List<Map<String, dynamic>> events = [];
  List<String> plans = [];
  bool haptics = true;
  double lastSeenSlow = 0; // for the yesterday → today reveal (§4.3)

  Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();
    final s = _prefs!.getString(_key);
    _read(s == null ? {} : jsonDecode(s));
  }

  Future<void> save() async {
    notifyListeners();
    await _prefs?.setString(_key, jsonEncode(_write()));
  }

  /// One-tap "withdraw and delete" (§6.6).
  Future<void> wipe() async {
    await _prefs?.remove(_key);
    _read({});
    notifyListeners();
  }

  void _read(Map<String, dynamic> j) {
    DateTime? t(String k) => j[k] == null ? null : DateTime.parse(j[k]);
    consentAt = t('consentAt');
    answers = j['answers'] == null ? null : Answers.fromJson(j['answers']);
    quitAt = t('quitAt');
    packPrice = (j['packPrice'] ?? 0).toDouble();
    perPack = j['perPack'] ?? 20;
    currency = j['currency'] ?? '₹';
    bankedDays = j['bankedDays'] ?? 0;
    bankedNotSmoked = (j['bankedNotSmoked'] ?? 0).toDouble();
    events = [for (final e in j['events'] ?? []) Map<String, dynamic>.from(e)];
    plans = List<String>.from(j['plans'] ?? []);
    haptics = j['haptics'] ?? true;
    lastSeenSlow = (j['lastSeenSlow'] ?? 0).toDouble();
  }

  Map<String, dynamic> _write() => {
        'consentAt': consentAt?.toIso8601String(),
        'answers': answers?.toJson(),
        'quitAt': quitAt?.toIso8601String(),
        'packPrice': packPrice,
        'perPack': perPack,
        'currency': currency,
        'bankedDays': bankedDays,
        'bankedNotSmoked': bankedNotSmoked,
        'events': events,
        'plans': plans,
        'haptics': haptics,
        'lastSeenSlow': lastSeenSlow,
      };

  int get cpd => answers?.cpd ?? 10;
  double get pricePerCig => perPack == 0 ? 0 : packPrice / perPack;

  Map<String, dynamic> log(String type, [Map<String, dynamic> data = const {}]) {
    final e = {'t': DateTime.now().toIso8601String(), 'type': type, ...data};
    events.add(e);
    save();
    return e;
  }

  Iterable<Map<String, dynamic>> ofType(String type) => events.where((e) => e['type'] == type);

  List<Slip> get slips => [for (final e in ofType('slip')) (at: DateTime.parse(e['t']), n: e['n'] as int)];

  Stats stats(DateTime now) {
    final q = quitAt;
    final started = q != null && now.isAfter(q);
    final mine = started ? slips.where((s) => !s.at.isBefore(q) && !s.at.isAfter(now)).toList() : <Slip>[];
    final sinceQuit = started ? now.difference(q) : Duration.zero;
    final days = sinceQuit.inSeconds / 86400;
    final slipDays = mine.map((s) => _day(s.at)).toSet().length;
    final last = mine.fold<DateTime?>(q, (a, s) => a == null || s.at.isAfter(a) ? s.at : a);
    final smoked = mine.fold<int>(0, (t, s) => t + s.n);
    return Stats(
      bankedDays + max(0, days.floor() - slipDays),
      started ? now.difference(last!) : Duration.zero,
      bankedNotSmoked + max(0.0, cpd * days - smoked),
      recovery(quitAt: q, slips: mine, cpd: cpd, now: now),
      slips.where((s) => !s.at.isAfter(now) && now.difference(s.at).inDays < 7).length,
      sinceQuit,
    );
  }

  /// Plan the next quit after smoking again: bank this attempt's totals up to
  /// when smoking resumed, so nothing the user earned is erased (§2.4).
  void requit(DateTime newQuit, DateTime smokingSince) {
    final s = stats(smokingSince);
    bankedDays = s.smokeFreeDays;
    bankedNotSmoked = s.notSmoked;
    quitAt = newQuit;
    log('requit', {'quitAt': newQuit.toIso8601String()});
  }
}

final app = AppState();
