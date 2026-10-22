// Renders the prototype to PNG screens, an overview board and video frames.
// Usage (Playwright is resolved from NODE_PATH):
//   node render.cjs stills  <outDir>
//   node render.cjs board   <outFile>
//   node render.cjs frames  <outDir> [fps] [fromSec] [toSec]
const path = require('path');
const fs = require('fs');
const { chromium } = require('playwright');

const PAGE = 'file://' + path.join(__dirname, 'prototype.html');
const SCREENS = ['onboarding', 'lungage', 'home', 'craving', 'rode', 'slip', 'timeline', 'nrt', 'insights'];

async function main() {
  const [mode, out, ...rest] = process.argv.slice(2);
  const browser = await chromium.launch();
  try {
    if (mode === 'stills') {
      fs.mkdirSync(out, { recursive: true });
      const page = await browser.newPage({ viewport: { width: 520, height: 960 }, deviceScaleFactor: 2 });
      for (const [i, id] of SCREENS.entries()) {
        await page.goto(`${PAGE}?still=${id}`);
        await page.evaluate(() => document.fonts.ready);
        const file = path.join(out, `${String(i + 1).padStart(2, '0')}-${id}.png`);
        await page.locator('#cap').screenshot({ path: file, omitBackground: true });
        console.log(file);
      }
    } else if (mode === 'board') {
      const page = await browser.newPage({ viewport: { width: 1720, height: 1200 }, deviceScaleFactor: 1.25 });
      await page.goto(`${PAGE}?board=1`);
      await page.evaluate(() => document.fonts.ready);
      await page.locator('#cap').screenshot({ path: out });
      console.log(out);
    } else if (mode === 'frames') {
      fs.mkdirSync(out, { recursive: true });
      const fps = Number(rest[0] || 30);
      const page = await browser.newPage({ viewport: { width: 1920, height: 1080 }, deviceScaleFactor: 1 });
      await page.goto(`${PAGE}?frames=1`);
      await page.evaluate(() => document.fonts.ready);
      const total = await page.evaluate(() => window.TOTAL);
      const from = Number(rest[1] || 0), to = Math.min(Number(rest[2] || total), total);
      const n0 = Math.round(from * fps), n1 = Math.round(to * fps);
      for (let n = n0; n < n1; n++) {
        await page.evaluate((T) => window.setTime(T), n / fps);
        await page.screenshot({ path: path.join(out, `f${String(n).padStart(5, '0')}.jpg`), type: 'jpeg', quality: 92 });
        if (n % 150 === 0) console.log(`frame ${n}/${n1}`);
      }
      console.log(`done ${n1 - n0} frames, total ${total.toFixed(1)} s`);
    } else {
      throw new Error('mode must be stills | board | frames');
    }
  } finally {
    await browser.close();
  }
}
main().catch((e) => { console.error(e); process.exit(1); });
