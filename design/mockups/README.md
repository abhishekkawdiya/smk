# Clearway concept mockups

Concept screens and an 83-second walkthrough video for the quit-smoking and lung-recovery app. They are derived from `reports/Smoking cessation app blueprint.md`. "Clearway" is a placeholder working title. All figures shown on screen (days, money, lung-age gap, percentages) are illustrative.

| File | What it is |
|---|---|
| `clearway-walkthrough.mp4` | 1920×1080, 30 fps walkthrough. Each scene has a side panel giving the research rationale and the blueprint section it comes from |
| `clearway-overview.png` | All nine screens on one board |
| `screens/01-…09-*.png` | Individual screens at 2× |
| `prototype.html` | Single-file source for all of the above. Open it in a browser to watch the walkthrough loop live |
| `render.cjs` | Playwright renderer for stills, the board and video frames |

## Screens and the blueprint rules they implement

1. **Onboarding** (§3.2–3.4): 12 taps with original wording and a "why we ask" note on each question.
2. **Lung estimate** (§1.1, §6.2): the lung-age gap is shown with a range on a Fletcher–Peto-style curve. There are no normal/abnormal bands.
3. **Home** (§1.2, §2.3, §4.3): the lung avatar runs a delta reveal and has five bound variables. It shows a two-number Recovery Index and totals that never reset.
4. **Craving SOS** (§2.1, §2.5, §4.5, §5.6): a 180-second Urge Surfer with a 4 s in / 6 s out pacer. The microphone is used on-device only.
5. **Rode it out** (§2.1): success means "didn't smoke". The badge appears only after the re-rating.
6. **Slip response** (§2.4, §4.6): amber, never red. Cumulative days are kept and the user writes an if-then plan.
7. **Recovery timeline** (§1.2, §4.2): the clearance window (quitter's flu) is explained ahead of time, and each item shows an A–D evidence grade.
8. **Medication plan** (§2.6, §6.4): the regimen is entered by the user from the label, with label-quoted technique tips. The app never calculates a dose.
9. **Insights** (§2.2): personal craving windows, with at most 3 nudges a day.

The lung is an SVG stand-in for the planned Rive file. It is driven by the same `tarDensity`, `bronchialInflammation`, `ciliaMotility`, `alveolarOxygenation` and breath-phase values specified in §4.3. The colours are the §4.4 tokens.

## Regenerating

```bash
cd design/mockups
export NODE_PATH=/opt/node22/lib/node_modules   # wherever Playwright is installed
node render.cjs stills screens
node render.cjs board clearway-overview.png
node render.cjs frames /tmp/frames 30
ffmpeg -framerate 30 -i /tmp/frames/f%05d.jpg -c:v libx264 -crf 21 -pix_fmt yuv420p -movflags +faststart clearway-walkthrough.mp4
```

Video frames are rendered deterministically from a single clock (`window.setTime(t)`), so every render produces the same output.
