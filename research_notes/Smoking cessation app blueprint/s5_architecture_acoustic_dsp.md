# Section 5.1 + 5.2 (DSP half): Offline-first mobile architecture, encrypted local storage, wearable pipeline, microphone breath-detection DSP

Research date: 2026-10-21. Scope: stack choice, encrypted local DB and key management, HealthKit and Health Connect ingestion, background execution and notification/geofence limits, microphone exhale detection for the 180-second "Urge Surfer", audio-capture APIs, and the security/privacy baseline.

**Method and access caveat (read first):** The shared WebSearch budget ran out partway through, and this sandbox's egress policy blocked most publisher and doc hosts: ieeexplore, dl.acm.org, doi.org, crossref, PubMed/PMC, docs.flutter.dev, drift.simonbinder.eu, reactnative.dev, rive.app, mas.owasp.org, zetetic.net and support.google.com all failed. Verified sources are limited to these hosts:
- developer.apple.com, read through its documentation JSON endpoints.
- developer.android.com.
- pub.dev, plus its API for live package versions.
- registry.npmjs.org, for live versions.
- raw.githubusercontent.com, for official READMEs, changelogs and OWASP MASVS control files.
- repo1.maven.org and kotlinlang.org.
- A handful of earlier search-result abstracts (IEEE Xplore record for Nam et al. 2016; JetBrains blog; MongoDB docs/forum).

Literature citations I could not resolve in-session are put in Gaps with a "verify" flag rather than stated as findings. All package versions below are live registry values fetched on 2026-10-21.

---

## Q1. Stack choice: Flutter vs React Native (New Architecture) vs Kotlin/Compose Multiplatform for a graphics-heavy, offline-first health app

### Takeaway
I recommend **Flutter** (Dart ≥3.10, Flutter ≥3.44 per current package constraints), with thin native Swift/Kotlin modules for two things: (a) HealthKit background delivery and (b) low-latency microphone capture and DSP.
- Flutter has the most complete, actively maintained single-codebase coverage for every hard requirement as of Oct 2026:
  - `health` 13.3.2, covering both HealthKit and Health Connect, including HC history and background permission methods.
  - drift 2.35.2 with `sqlite3` 3.7.1, where SQLCipher or SQLite3MultipleCiphers is selectable by a build hook.
  - `rive` 0.14.11, which runs on the native Rive renderer via `rive_native` on iOS and Android.
  - `record` 7.1.2, which streams raw PCM16.
  - flutter_local_notifications 22.3.2 and workmanager 0.10.10.
- React Native is a credible second choice, but its Rive runtime is mid-migration to a young Nitro-based package.
- KMP/Compose Multiplatform has stable iOS UI since 1.8.0 (May 2025), but I found no first-party Rive Compose MP runtime and no verified cross-platform health library.

### Cited Findings
**Flutter ecosystem (live pub.dev versions, 2026-10-21)**
- `health` 13.3.2, published 2026-08-14 by verified publisher carp.dk.
  - The data-type table lists `HEART_RATE`, `RESTING_HEART_RATE`, `RESPIRATORY_RATE`, `BLOOD_OXYGEN` and `STEPS` on both Apple Health and Health Connect.
  - `HEART_RATE_VARIABILITY_SDNN` is Apple-only ("Requires Apple Watch to write the data"). `HEART_RATE_VARIABILITY_RMSSD` is Health Connect-only. `SLEEP_SESSION` is Health Connect-only.
  - No VO2max row appeared in the type table. — [pub.dev/packages/health](https://pub.dev/packages/health)
- `health` exposes Android-only methods `requestHealthDataHistoryAuthorization` / `isHealthDataHistoryAuthorized` and `requestHealthDataInBackgroundAuthorization` / `isHealthDataInBackgroundAvailable()` / `isHealthDataInBackgroundAuthorized()`.
  - It requires `MainActivity` to extend `FlutterFragmentActivity` on Android 14, plus a `<queries>` entry for `com.google.android.apps.healthdata` and a `ViewPermissionUsageActivity` activity-alias.
  - The README does not mention HealthKit background delivery or observer queries. — [pub.dev/packages/health](https://pub.dev/packages/health)
- Other live versions:
  - drift 2.35.2 (2026-10-07), drift_flutter 0.3.1, sqlite3 3.7.1 (2026-10-13).
  - flutter_secure_storage 11.2.0 (2026-09-16).
  - rive 0.14.11 and rive_native 0.1.11 (2026-08-03).
  - record 7.1.2 (2026-10-09; requires Flutter ≥3.44.0, Dart ^3.12).
  - flutter_local_notifications 22.3.2 (2026-10-12), workmanager 0.10.10 (2026-09-07), background_fetch 1.7.0, permission_handler 13.0.2, audio_session 0.2.4, native_geofence 1.3.1.
  - sentry_flutter 10.1.0, flutter_onnxruntime 1.9.0, tflite_flutter 0.12.1 (last published 2025-10-28).
  - geofence_service is **discontinued**, replaced by `geofencing_api`.
  - Sources: [pub.dev/packages/drift](https://pub.dev/packages/drift), [pub.dev/packages/sqlite3](https://pub.dev/packages/sqlite3), [pub.dev/packages/rive](https://pub.dev/packages/rive), [pub.dev/packages/record](https://pub.dev/packages/record), [pub.dev/packages/flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications), [pub.dev/packages/workmanager](https://pub.dev/packages/workmanager), [pub.dev/packages/geofence_service](https://pub.dev/packages/geofence_service)
- Rive Flutter:
  - The `rive` package depends on `rive_native`. Developers choose `Factory.rive` (Rive renderer) or `Factory.flutter` (Skia/Impeller) per `File`.
  - Both renderers are supported on iOS, Android, macOS, Windows, Linux and Web.
  - The README warns of possible rendering discrepancies under Impeller, which has been the default on iOS since Flutter 3.10. — [rive-flutter README](https://github.com/rive-app/rive-flutter/blob/master/README.md)
- `record` 7.1.2 can stream: `record.startStream(const RecordConfig(encoder: AudioEncoder.pcm16bits))`.
  - `pcm16bits` streaming is supported on Android, iOS, web, Windows, macOS and Linux.
  - `RecordConfig` has `autoGain`, `echoCancel` and `noiseSuppress` (all default `false`), `sampleRate` (default 44100), `numChannels` (default 2) and `streamBufferSize`.
  - `AndroidRecordConfig.audioSource` takes an `AndroidAudioSource` enum that includes `voiceRecognition` and `unprocessed`.
  - `IosRecordConfig` exposes only `categoryOptions` and `allowHapticsAndSystemSoundsDuringRecording`, with **no AVAudioSession mode setter**.
  - Sources: [record README](https://github.com/llfbandit/record/blob/master/record/README.md), [record_config.dart](https://github.com/llfbandit/record/blob/master/record_platform_interface/lib/src/types/record_config.dart), [android_record_config.dart](https://github.com/llfbandit/record/blob/master/record_platform_interface/lib/src/types/android_record_config.dart), [ios_record_config.dart](https://github.com/llfbandit/record/blob/master/record_platform_interface/lib/src/types/ios_record_config.dart)

**React Native ecosystem (live npm versions)**
- `react-native` 0.88.0 was published 2026-10-15. The 0.87/0.88 CHANGELOG entries remove legacy-architecture code, e.g. "Remove legacy architecture code guarded by RCT_REMOVE_LEGACY_ARCH from RN iOS" and opt-in `RCT_REMOVE_LEGACY_MODULE_INTEROP` / `RCT_REMOVE_LEGACY_COMPONENT_INTEROP`. — [npm react-native](https://www.npmjs.com/package/react-native); [RN CHANGELOG](https://github.com/facebook/react-native/blob/main/CHANGELOG.md)
- Health libraries:
  - `@kingstinct/react-native-healthkit` 16.2.0 (2026-10-12) is built on `react-native-nitro-modules` and exposes `subscribeToChanges`. It has an Expo config-plugin `background: true` option. — [npm](https://www.npmjs.com/package/@kingstinct/react-native-healthkit)
  - `react-native-health` 1.19.0 was last published 2024-10-15, so it is stale. Its README sends Android users to react-native-health-connect. — [npm](https://www.npmjs.com/package/react-native-health)
  - `react-native-health-connect` 4.1.3 (2026-08-06) needs `minSdkVersion=26` and ships Expo config inside the package as of v4. Play Console data-access declaration is required. — [npm](https://www.npmjs.com/package/react-native-health-connect)
- Storage libraries:
  - `@op-engineering/op-sqlite` 18.2.5 (2026-09-20) has "SQLCipher is supported as a compilation target", plus libsql/Turso, FTS5, sqlite-vec and reactive queries. — [npm](https://www.npmjs.com/package/@op-engineering/op-sqlite)
  - `@nozbe/watermelondb` 0.28.0 was last published 2025-04-07. — [npm](https://www.npmjs.com/package/@nozbe/watermelondb)
  - `expo-sqlite` is at 58.0.13. — [npm](https://www.npmjs.com/package/expo-sqlite)
- Rive and graphics:
  - The legacy `rive-react-native` 9.8.6 README says "The new Rive React Native runtime is now available. Built with Nitro…" and points to `@rive-app/react-native`. That package is at 0.5.5 (2026-10-13) and requires iOS 15.1+, Android SDK 24+, Xcode 16.4+ and Nitro Modules ≥0.33.2. — [rive-react-native README](https://github.com/rive-app/rive-react-native/blob/main/README.md); [npm @rive-app/react-native](https://www.npmjs.com/package/@rive-app/react-native)
  - `@shopify/react-native-skia` is at 2.14.0 (2026-10-01). — [npm](https://www.npmjs.com/package/@shopify/react-native-skia)
  - `react-native-audio-api` is at 0.13.6. — [npm](https://www.npmjs.com/package/react-native-audio-api)

**Kotlin / Compose Multiplatform**
- JetBrains announced Compose Multiplatform 1.8.0 in May 2025 as "Compose Multiplatform for iOS Is Stable and Production-Ready". — [JetBrains Kotlin blog](https://blog.jetbrains.com/kotlin/2025/05/compose-multiplatform-1-8-0-released-compose-multiplatform-for-ios-is-stable-and-production-ready/)
- The Kotlin docs stability page (dated 10 Sept 2025) lists:
  - Compose Multiplatform UI: Android, iOS and Desktop Stable; Web/Wasm Beta.
  - Core KMP: Android, iOS, JVM and JS Stable; watchOS and tvOS Beta.
  - [kotlinlang.org supported-platforms](https://kotlinlang.org/docs/multiplatform/supported-platforms.html)
- Maven Central versions:
  - Compose gradle plugin: latest stable 1.12.2; 1.13.0-alpha02 updated 2026-10-15. — [maven-metadata](https://repo1.maven.org/maven2/org/jetbrains/compose/compose-gradle-plugin/maven-metadata.xml)
  - SQLDelight runtime: 2.4.1 (2026-10-06). — [maven-metadata](https://repo1.maven.org/maven2/app/cash/sqldelight/runtime/maven-metadata.xml)
  - `net.zetetic:sqlcipher-android`: 4.19.1 (2026-09-29). — [maven-metadata](https://repo1.maven.org/maven2/net/zetetic/sqlcipher-android/maven-metadata.xml)

**Platform constraints that apply to any stack**
- On iOS, HealthKit observer queries for background delivery should be set up in the app delegate's `application(_:didFinishLaunchingWithOptions:)`. This is native code whichever cross-platform framework is used. — [Apple: enableBackgroundDelivery](https://developer.apple.com/documentation/healthkit/hkhealthstore/enablebackgrounddelivery(for:frequency:withcompletion:))

### Inferences
- **Recommendation: Flutter.** Rationale:
  1. Rive with the native Rive renderer is first-party and stable-numbered (0.14.x) on Flutter. In RN the recommended runtime is a 0.x Nitro rewrite still completing feature parity, and KMP has no Compose MP Rive runtime I could find.
  2. Encrypted SQLite is a first-class build option (`hooks: user_defines: sqlite3: source: sqlcipher | sqlite3mc`) with SBOM and SLSA attestations (see Q2).
  3. `health` covers both platforms, including HC background and history permissions.
  4. A single Dart UI layer keeps the graphics-heavy Urge Surfer (Rive state machines plus fragment shaders) consistent across platforms.
- Plan for native "escape hatches" in Flutter:
  - (a) A Swift `AppDelegate` that registers `HKObserverQuery` and calls `enableBackgroundDelivery`, then runs `HKAnchoredObjectQuery` and writes into the same encrypted DB. One option is a shared C ABI through `sqlite3`. A simpler option is a small native buffer that Dart drains on next launch.
  - (b) Native audio capture: AVAudioEngine/AVAudioSinkNode or RemoteIO on iOS; Oboe/AAudio on Android. The DSP core is written once in C/C++ (or Rust) and called via `dart:ffi`, emitting about 30–60 Hz feature events to Dart. `record` alone cannot set `AVAudioSession.Mode.measurement`.
- When to pick RN instead: if the team is JS-heavy. In that case use RN ≥0.82 New Architecture, `@kingstinct/react-native-healthkit`, `react-native-health-connect`, `op-sqlite` (SQLCipher target), `@rive-app/react-native`, `react-native-skia` for shaders, and a custom native audio module.
- When to pick KMP: if the team is Android/Kotlin-first and accepts hand-writing HealthKit interop and embedding native Rive views (`UIKitView` / `AndroidView`).
- Flutter ≥3.44 must exist as a stable release by Oct 2026, because `record` 7.1.2 and `sentry_flutter` 10.1.0 require it (from pubspec constraints).

### Gaps
- I could not reach docs.flutter.dev, so I did not verify Flutter's current stable version number, Impeller-on-Android default status, or the FragmentProgram/fragment-shader doc page.
- I could not reach rive.app docs to confirm whether any official Rive runtime exists for Compose Multiplatform. Treat "none" as unverified.
- I could not open reactnative.dev to quote the 0.82 "New Architecture only" announcement. The CHANGELOG evidence above shows legacy code removal in 0.87/0.88.
- I did not verify a maintained KMP HealthKit + Health Connect wrapper library.

---

## Q2. Local encrypted database, key management, backup exclusion, alternatives, and a concrete normalized schema

### Takeaway
Use **drift 2.35 on `package:sqlite3` 3.x, selecting the SQLCipher (or SQLite3MultipleCiphers) build via pubspec build-hook user-defines**. `sqlcipher_flutter_libs` is end-of-life and must not be used.
- Use a random 256-bit raw key, passed as `PRAGMA key = "x'…'"` so PBKDF2 is skipped, issued as the first statement.
- Store the key in iOS Keychain (`kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly`) and Android Keystore-wrapped storage via flutter_secure_storage 11.x defaults (RSA-OAEP + AES-GCM).
- Exclude the DB from iCloud backup and Android cloud backup/device transfer, and do not put PHI in iCloud (App Review 5.1.3(ii)).
- Realm's Device SDKs/Sync are EOL (30 Sept 2025), so avoid Realm for new work.

### Cited Findings
**Drift / sqlite3 / SQLCipher on Flutter**
- `sqlcipher_flutter_libs` latest is `0.7.0+eol`. Its metadata says "Not used anymore, update to version 3.x of package:sqlite3 instead", and "Starting from version 0.7.0, this package no longer does anything." `sqlite3_flutter_libs` is likewise `0.6.0+eol`. — [pub.dev sqlcipher_flutter_libs](https://pub.dev/packages/sqlcipher_flutter_libs)
- The sqlite3 3.0.0 changelog: "Breaking change: Use build hooks to load SQLite instead of DynamicLibrary… You should drop your dependencies on `sqlite3_flutter_libs` and `sqlcipher_flutter_libs` when upgrading." — [sqlite3 CHANGELOG](https://github.com/simolus3/sqlite3.dart/blob/main/sqlite3/CHANGELOG.md)
- Each `package:sqlite3` release ships three prebuilt binary sets:
  - upstream SQLite;
  - SQLite3MultipleCiphers;
  - "A SQLCipher community edition build".
  - The selection is made in `pubspec.yaml`:
    ```yaml
    hooks:
      user_defines:
        sqlite3:
          source: sqlite3mc   # or: sqlcipher ; default: sqlite3
    ```
  - "the SQLCipher build links OpenSSL on Windows, Linux and Android" and "may include an older SQLite version than the default and SQLite3 Multiple Ciphers builds". SQLite3MC and SQLCipher have their own licenses. — [sqlite3 hook.md](https://github.com/simolus3/sqlite3.dart/blob/main/sqlite3/doc/hook.md)
- Supply chain:
  - Binaries are built on GitHub Actions, use immutable releases and are verified by sha256 hashes shipped in the pub.dev sources.
  - SLSA level 3 attestations have been available since sqlite3 3.5.2 (`gh attestation verify --repo simolus3/sqlite3.dart <file>`).
  - A CycloneDX SBOM is available for all builds.
  - A custom `source: source` build from a vendored `sqlite3.c`, or `source: executable` for static linking, is possible. — [sqlite3 hook.md](https://github.com/simolus3/sqlite3.dart/blob/main/sqlite3/doc/hook.md)
- Default compile options of the prebuilt binaries include `SQLITE_ENABLE_FTS5`, `SQLITE_ENABLE_MATH_FUNCTIONS`, `SQLITE_DQS=0`, `SQLITE_TEMP_STORE=2` (temp tables in memory) and `SQLITE_ENABLE_SESSION`. — [sqlite3 hook.md](https://github.com/simolus3/sqlite3.dart/blob/main/sqlite3/doc/hook.md)
- SQLCipher behavior:
  - "256 bit AES encryption of database files".
  - `PRAGMA key = 'passphrase';` passes the passphrase through PBKDF2.
  - A raw key is a "64 character hex string, which will be converted directly to 32 bytes (256 bits)": `PRAGMA key = "x'2DD2…6D99'";`.
  - "PRAGMA key… should be called as the first operation when a database is open".
  - Rekeying uses `PRAGMA rekey`.
  - SQLCipher 4 will not open 1.x–3.x databases by default.
  - Plaintext databases can be converted with `ATTACH` + `sqlcipher_export()`.
  - [SQLCipher README](https://github.com/sqlcipher/sqlcipher/blob/master/README.md)
- The sqlite3 web build supports encryption via the `sqlite3mc.wasm` asset with `pragma key = '…'`. — [pub.dev sqlite3](https://pub.dev/packages/sqlite3)

**Key storage**
- flutter_secure_storage:
  - "Version 10.0.0 introduces a major security update with custom cipher implementations. The deprecated Jetpack Security library's `encryptedSharedPreferences` is no longer recommended".
  - The default `AndroidOptions()` uses key cipher RSA/ECB/OAEPWithSHA-256AndMGF1Padding and storage cipher AES/GCM/NoPadding.
  - `AndroidOptions.biometric(enforceBiometrics: true)` requires API 28+.
  - `migrateOnAlgorithmChange` is on by default.
  - iOS `IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device)` is available.
  - The README warns that Android Auto Backup can cause `java.security.InvalidKeyException: Failed to unwrap key` and recommends `android:allowBackup="false"` or excluding its sharedprefs.
  - [flutter_secure_storage README](https://github.com/juliansteenbakker/flutter_secure_storage/blob/develop/README.md)
- Apple `kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly`: "recommended for items that need to be accessed by background applications. Items with this attribute do not migrate to a new device." — [Apple docs](https://developer.apple.com/documentation/security/ksecattraccessibleafterfirstunlockthisdeviceonly)
- Apple Secure Enclave:
  - Works only with NIST P-256 EC keys, for signing or ECDH ("and by extension, symmetric encryption").
  - It can't import pre-existing keys.
  - It requires an A7-or-later processor.
  - Example access control: `kSecAttrAccessibleWhenUnlockedThisDeviceOnly` + `.privateKeyUsage`, optionally `.biometryAny`.
  - [Apple: Protecting keys with the Secure Enclave](https://developer.apple.com/documentation/security/protecting-keys-with-the-secure-enclave)
- Android Keystore StrongBox:
  - StrongBox KeyMint exists on some API 28+ devices and supports a subset of algorithms: RSA 2048, AES 128/256, ECDSA/ECDH P-256 and HMAC-SHA256.
  - Request it via `KeyGenParameterSpec.Builder.setIsStrongBoxBacked(true)` and fall back on `StrongBoxUnavailableException`.
  - Check availability via `FEATURE_STRONGBOX_KEYSTORE`.
  - "For most apps, StrongBox is not necessary" because it is slower.
  - [Android Keystore](https://developer.android.com/privacy-and-security/keystore)

**File protection and backups**
- iOS `FileProtectionType.completeUntilFirstUserAuthentication`: after first unlock, "your app can access the file and continue to access it even if the user subsequently locks the device". This is needed for DB writes from background tasks. — [Apple docs](https://developer.apple.com/documentation/foundation/fileprotectiontype/completeuntilfirstuserauthentication)
- iOS `isExcludedFromBackupKey`: "Set this property each time you save a file because some common file operations cause this property to reset to false." — [Apple docs](https://developer.apple.com/documentation/foundation/urlresourcekey/isexcludedfrombackupkey)
- App Review Guideline 5.1.3(ii): apps "may not store personal health information in iCloud". 5.1.3(i) forbids using health/HealthKit data for advertising, marketing or use-based data mining. The guidelines page was last updated October 16, 2026. — [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)
- Android backup:
  - `android:dataExtractionRules` applies on API 31+, with `<cloud-backup>` and `<device-transfer>` sections. `<cross-platform-transfer platform="ios">` applies from Android 16 QPR2 (API 36.1).
  - `android:fullBackupContent` is still required for Android ≤11.
  - The `database` domain covers `getDatabasePath()`, and `<exclude>` takes precedence.
  - There is a 25 MB backup quota per app user.
  - For API 31+ targets, `allowBackup="false"` "on some manufacturers' devices disables cloud-based backup… but doesn't disable device-to-device transfers".
  - `disableIfNoEncryptionCapabilities="true"` is available.
  - [Android Auto Backup](https://developer.android.com/identity/data/autobackup)

**Alternatives**
- Realm/Atlas Device SDKs:
  - Deprecated September 2024. They "will reach end-of-life and be removed on September 30, 2025".
  - Atlas Device Sync is deprecated.
  - "The on-device database will continue to exist as an open source project".
  - [MongoDB docs (via search result)](https://mongodb.com/docs/realm); [MongoDB forum EOL notice](https://mongodb.com/community/forums/t/update-to-end-of-life-and-deprecation-notice/297168)
- The realm-swift README says to "install version 20 or see the `community` branch" for a sync-free build. realm-kotlin says to use `3.0.0+` or the `community` branch. — [realm-swift README](https://github.com/realm/realm-swift/blob/master/README.md); [realm-kotlin README](https://github.com/realm/realm-kotlin/blob/main/README.md)
- SQLDelight 2.4.1 is the KMP option; pair it with `net.zetetic:sqlcipher-android` 4.19.1 on Android. — [Maven SQLDelight](https://repo1.maven.org/maven2/app/cash/sqldelight/runtime/maven-metadata.xml); [Maven sqlcipher-android](https://repo1.maven.org/maven2/net/zetetic/sqlcipher-android/maven-metadata.xml)
- op-sqlite (SQLCipher compile target) is the RN option. — [npm op-sqlite](https://www.npmjs.com/package/@op-engineering/op-sqlite)

**Health Connect deletion duty**
- "When a user deletes their own data from your app, make sure that the data is also removed from Health Connect. Use `deleteRecords`" (by record type plus ids/clientRecordIds, or by `timeRangeFilter`). — [Health Connect sync-data](https://developer.android.com/health-and-fitness/health-connect/sync-data)

### Inferences

#### Recommended encryption and key-management design
1. **Key generation.** On first launch, generate 32 random bytes (`Random.secure()`) and store them with flutter_secure_storage:
   - iOS: `IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device)`, so background tasks can open the DB after first unlock and the key never migrates in device backups.
   - Android: default `AndroidOptions()` (RSA-OAEP-wrapped AES-GCM).
2. **Opening the DB.** Open with drift `NativeDatabase` and, in its setup callback, execute:
   - `PRAGMA key = "x'<64 hex>'"` (raw key, so no PBKDF2 cost at each open);
   - then (SQLCipher only, optional) `PRAGMA cipher_memory_security = ON` — pragma name from prior knowledge, not verified in-session;
   - then `PRAGMA foreign_keys = ON`;
   - then `PRAGMA journal_mode = WAL`.
   Verify the cipher is active by querying `PRAGMA cipher_version` (SQLCipher) or `PRAGMA cipher` (SQLite3MC). Both pragma names are from prior knowledge, not verified in-session. Fail closed if the result is empty. Also confirm that a read with a wrong key fails.
3. **Cipher build choice.**
   - `sqlite3mc` avoids the OpenSSL link on Android and tracks newer SQLite.
   - `sqlcipher` gives a widely audited format and interop with SQLCipher tools.
   - Pick one at project start; switching later means a migration via `sqlcipher_export` / ATTACH.
   - Check `SELECT sqlite_version()` at startup if you depend on `STRICT` tables, since the SQLCipher build may lag.
4. **Secure Enclave.** It is optional and adds little for a symmetric DB key. If used, create a P-256 SE key and ECIES-wrap the DB key (the wrapped blob is stored in Keychain). Tie decryption to `.privateKeyUsage` without biometry, otherwise background opens fail.
5. **Backups.**
   - iOS: put the DB in Application Support with `isExcludedFromBackupKey = true`, re-applied after every VACUUM or file replace, and file protection `completeUntilFirstUserAuthentication`.
   - Android: `dataExtractionRules` excludes `database` (the DB file plus `-wal`/`-shm`) and flutter_secure_storage prefs from both `<cloud-backup>` and `<device-transfer>`, with matching `fullBackupContent` for ≤ API 30.
   - Also set `allowBackup="false"`, while noting that it does not stop D2D on some OEMs.
   - A restored DB without its key would be unreadable anyway; exclusion keeps the failure mode clean.
6. **Optional E2E-encrypted backup.** This is an app-managed sync, not OS backup.
   - Rows go through a `sync_outbox` and are serialized and encrypted client-side (XChaCha20-Poly1305 or AES-256-GCM) with a backup key derived from a user recovery code (Argon2id).
   - The server stores opaque blobs only.
   - Do not use iCloud/CloudKit for PHI (5.1.3(ii)).

#### Schema conventions
- All tables are `STRICT` where available.
- Primary key `id TEXT` is a UUIDv7 generated on device, which makes it time-sortable and merge-safe.
- Event times use `*_utc_ms INTEGER` (Unix epoch ms, UTC), `tz_offset_min INTEGER` (local offset at event time, e.g. +330), and `tz_id TEXT` (IANA zone) to preserve local time-of-day features across travel and DST.
- Every user-data table carries:
  - `created_at_utc_ms`, `updated_at_utc_ms`;
  - `deleted_at_utc_ms` (NULL = live; soft-delete tombstone);
  - `rev INTEGER` (monotonic per row; hybrid logical clock if multi-device);
  - `sync_state INTEGER` (0 = local-only, 1 = dirty, 2 = synced).
- Booleans are INTEGER 0/1. Enums are TEXT with CHECK constraints. JSON goes in TEXT validated by `json_valid()`.

#### Proposed DDL (condensed; drift tables map 1:1)

```sql
-- identity & consent ----------------------------------------------------------
CREATE TABLE user_profile (
  id TEXT PRIMARY KEY, display_name TEXT, birth_year INTEGER, sex_at_birth TEXT,
  country_code TEXT, locale TEXT, tz_id TEXT NOT NULL,
  cigs_per_day_baseline REAL, years_smoked REAL, pack_price_minor INTEGER, currency TEXT,
  ftnd_score INTEGER, hsi_score INTEGER,
  created_at_utc_ms INTEGER NOT NULL, updated_at_utc_ms INTEGER NOT NULL,
  deleted_at_utc_ms INTEGER, rev INTEGER NOT NULL DEFAULT 0, sync_state INTEGER NOT NULL DEFAULT 0
) STRICT;

CREATE TABLE consent_log (            -- append-only; GDPR accountability
  id TEXT PRIMARY KEY, purpose TEXT NOT NULL CHECK (purpose IN
     ('core','healthkit','health_connect','microphone','location','notifications',
      'analytics','crash_reports','research','e2e_backup')),
  granted INTEGER NOT NULL, policy_version TEXT NOT NULL,
  at_utc_ms INTEGER NOT NULL, tz_offset_min INTEGER NOT NULL
) STRICT;

-- onboarding & phenotyping ----------------------------------------------------
CREATE TABLE onboarding_responses (
  id TEXT PRIMARY KEY, instrument TEXT NOT NULL,      -- 'FTND','WISDM-37','QSU-brief',...
  instrument_version TEXT NOT NULL, item_code TEXT NOT NULL,
  value_num REAL, value_text TEXT,
  answered_at_utc_ms INTEGER NOT NULL, tz_offset_min INTEGER NOT NULL,
  created_at_utc_ms INTEGER NOT NULL, updated_at_utc_ms INTEGER NOT NULL,
  deleted_at_utc_ms INTEGER, rev INTEGER NOT NULL DEFAULT 0, sync_state INTEGER NOT NULL DEFAULT 0,
  UNIQUE (instrument, instrument_version, item_code)
) STRICT;

CREATE TABLE phenotype_scores (
  id TEXT PRIMARY KEY, phenotype_code TEXT NOT NULL,  -- e.g. 'stress_driven','cue_driven'
  score REAL NOT NULL, method TEXT NOT NULL, model_version_id TEXT REFERENCES model_versions(id),
  computed_at_utc_ms INTEGER NOT NULL,
  created_at_utc_ms INTEGER NOT NULL, updated_at_utc_ms INTEGER NOT NULL,
  deleted_at_utc_ms INTEGER, rev INTEGER NOT NULL DEFAULT 0, sync_state INTEGER NOT NULL DEFAULT 0
) STRICT;
CREATE INDEX ix_phenotype_code_time ON phenotype_scores(phenotype_code, computed_at_utc_ms);

-- quit journey ------------------------------------------------------------------
CREATE TABLE quit_attempts (
  id TEXT PRIMARY KEY, target_quit_utc_ms INTEGER NOT NULL, started_utc_ms INTEGER,
  ended_utc_ms INTEGER, end_reason TEXT CHECK (end_reason IN ('relapse','abandoned','success_6m', NULL)),
  method TEXT,                                         -- 'cold_turkey','reduce_to_quit','nrt','varenicline',...
  tz_offset_min INTEGER NOT NULL,
  created_at_utc_ms INTEGER NOT NULL, updated_at_utc_ms INTEGER NOT NULL,
  deleted_at_utc_ms INTEGER, rev INTEGER NOT NULL DEFAULT 0, sync_state INTEGER NOT NULL DEFAULT 0
) STRICT;

CREATE TABLE smoking_events (          -- every cigarette / puff session logged
  id TEXT PRIMARY KEY, quit_attempt_id TEXT REFERENCES quit_attempts(id),
  occurred_at_utc_ms INTEGER NOT NULL, tz_offset_min INTEGER NOT NULL, tz_id TEXT,
  product TEXT NOT NULL CHECK (product IN ('cigarette','rolled','cigar','pipe','ecig','heated','other')),
  quantity REAL NOT NULL DEFAULT 1,
  context_location TEXT, context_activity TEXT, context_social TEXT,   -- coded vocabularies
  mood_valence INTEGER, stress_0_10 INTEGER, craving_0_10_before INTEGER,
  trigger_codes TEXT CHECK (trigger_codes IS NULL OR json_valid(trigger_codes)),
  logged_retrospectively INTEGER NOT NULL DEFAULT 0, source TEXT NOT NULL DEFAULT 'manual',
  created_at_utc_ms INTEGER NOT NULL, updated_at_utc_ms INTEGER NOT NULL,
  deleted_at_utc_ms INTEGER, rev INTEGER NOT NULL DEFAULT 0, sync_state INTEGER NOT NULL DEFAULT 0
) STRICT;
CREATE INDEX ix_smoking_time ON smoking_events(occurred_at_utc_ms) WHERE deleted_at_utc_ms IS NULL;
CREATE INDEX ix_smoking_attempt ON smoking_events(quit_attempt_id, occurred_at_utc_ms);

CREATE TABLE cravings (
  id TEXT PRIMARY KEY, quit_attempt_id TEXT REFERENCES quit_attempts(id),
  onset_utc_ms INTEGER NOT NULL, tz_offset_min INTEGER NOT NULL,
  intensity_0_10 INTEGER NOT NULL CHECK (intensity_0_10 BETWEEN 0 AND 10),
  duration_s INTEGER, trigger_codes TEXT,
  intervention TEXT CHECK (intervention IN ('urge_surfer','breathing','defusion','distraction',
                            'nrt_fast','call_buddy','none', NULL)),
  intervention_session_id TEXT REFERENCES breath_sessions(id),
  intensity_after_0_10 INTEGER,
  outcome TEXT CHECK (outcome IN ('resisted','lapsed','unknown')),
  prompted_by_prediction_id TEXT REFERENCES predictions(id),
  created_at_utc_ms INTEGER NOT NULL, updated_at_utc_ms INTEGER NOT NULL,
  deleted_at_utc_ms INTEGER, rev INTEGER NOT NULL DEFAULT 0, sync_state INTEGER NOT NULL DEFAULT 0
) STRICT;
CREATE INDEX ix_cravings_time ON cravings(onset_utc_ms);

CREATE TABLE lapses (                  -- post-quit-date smoking, links to smoking_events
  id TEXT PRIMARY KEY, quit_attempt_id TEXT NOT NULL REFERENCES quit_attempts(id),
  smoking_event_id TEXT REFERENCES smoking_events(id), craving_id TEXT REFERENCES cravings(id),
  occurred_at_utc_ms INTEGER NOT NULL, tz_offset_min INTEGER NOT NULL,
  severity TEXT CHECK (severity IN ('slip','lapse','relapse')), reflection_text TEXT,
  created_at_utc_ms INTEGER NOT NULL, updated_at_utc_ms INTEGER NOT NULL,
  deleted_at_utc_ms INTEGER, rev INTEGER NOT NULL DEFAULT 0, sync_state INTEGER NOT NULL DEFAULT 0
) STRICT;

-- EMA ---------------------------------------------------------------------------
CREATE TABLE ema_prompts (
  id TEXT PRIMARY KEY, schedule_kind TEXT NOT NULL CHECK (schedule_kind IN ('random','fixed','event','jitai')),
  scheduled_utc_ms INTEGER NOT NULL, delivered_utc_ms INTEGER, opened_utc_ms INTEGER,
  expires_utc_ms INTEGER NOT NULL, tz_offset_min INTEGER NOT NULL, questionnaire_id TEXT NOT NULL,
  notification_id TEXT REFERENCES notifications_log(id), status TEXT NOT NULL
     CHECK (status IN ('pending','delivered','answered','missed','cancelled')),
  created_at_utc_ms INTEGER NOT NULL, updated_at_utc_ms INTEGER NOT NULL,
  deleted_at_utc_ms INTEGER, rev INTEGER NOT NULL DEFAULT 0, sync_state INTEGER NOT NULL DEFAULT 0
) STRICT;
CREATE INDEX ix_ema_status_time ON ema_prompts(status, scheduled_utc_ms);

CREATE TABLE ema_responses (
  id TEXT PRIMARY KEY, prompt_id TEXT NOT NULL REFERENCES ema_prompts(id),
  item_code TEXT NOT NULL, value_num REAL, value_text TEXT, rt_ms INTEGER,
  answered_utc_ms INTEGER NOT NULL,
  created_at_utc_ms INTEGER NOT NULL, updated_at_utc_ms INTEGER NOT NULL,
  deleted_at_utc_ms INTEGER, rev INTEGER NOT NULL DEFAULT 0, sync_state INTEGER NOT NULL DEFAULT 0,
  UNIQUE(prompt_id, item_code)
) STRICT;

-- pharmacotherapy -----------------------------------------------------------------
CREATE TABLE nrt_regimens (
  id TEXT PRIMARY KEY, quit_attempt_id TEXT REFERENCES quit_attempts(id),
  product TEXT NOT NULL CHECK (product IN ('patch','gum','lozenge','inhaler','spray','varenicline','cytisine','bupropion','other')),
  strength_mg REAL, schedule_json TEXT CHECK (schedule_json IS NULL OR json_valid(schedule_json)),
  start_utc_ms INTEGER NOT NULL, planned_end_utc_ms INTEGER, ended_utc_ms INTEGER,
  created_at_utc_ms INTEGER NOT NULL, updated_at_utc_ms INTEGER NOT NULL,
  deleted_at_utc_ms INTEGER, rev INTEGER NOT NULL DEFAULT 0, sync_state INTEGER NOT NULL DEFAULT 0
) STRICT;
CREATE TABLE nrt_doses (
  id TEXT PRIMARY KEY, regimen_id TEXT NOT NULL REFERENCES nrt_regimens(id),
  taken_utc_ms INTEGER NOT NULL, tz_offset_min INTEGER NOT NULL, dose_mg REAL,
  was_scheduled INTEGER NOT NULL DEFAULT 1, side_effects TEXT,
  created_at_utc_ms INTEGER NOT NULL, updated_at_utc_ms INTEGER NOT NULL,
  deleted_at_utc_ms INTEGER, rev INTEGER NOT NULL DEFAULT 0, sync_state INTEGER NOT NULL DEFAULT 0
) STRICT;
CREATE INDEX ix_nrt_doses ON nrt_doses(regimen_id, taken_utc_ms);

-- wearables -----------------------------------------------------------------------
CREATE TABLE wearable_samples (        -- raw imported samples (short retention)
  id TEXT PRIMARY KEY,
  platform TEXT NOT NULL CHECK (platform IN ('healthkit','health_connect')),
  external_id TEXT NOT NULL,           -- HKObject UUID / HC Metadata.id
  metric TEXT NOT NULL CHECK (metric IN ('rhr_bpm','hr_bpm','hrv_sdnn_ms','hrv_rmssd_ms',
         'resp_rate_brpm','spo2_pct','vo2max_ml_kg_min','steps','sleep_stage')),
  value REAL NOT NULL, start_utc_ms INTEGER NOT NULL, end_utc_ms INTEGER NOT NULL,
  tz_offset_min INTEGER, source_app TEXT, source_device TEXT, motion_context TEXT,
  imported_at_utc_ms INTEGER NOT NULL, deleted_at_utc_ms INTEGER,     -- source-side deletions
  UNIQUE(platform, external_id)
) STRICT;
CREATE INDEX ix_ws_metric_time ON wearable_samples(metric, start_utc_ms);

CREATE TABLE health_sync_state (       -- one row per platform x data type
  platform TEXT NOT NULL, data_type TEXT NOT NULL,
  hk_anchor BLOB,                      -- archived HKQueryAnchor
  hc_changes_token TEXT, hc_token_obtained_utc_ms INTEGER,   -- HC tokens expire within 30 days
  last_success_utc_ms INTEGER, last_error TEXT,
  PRIMARY KEY (platform, data_type)
) STRICT;

CREATE TABLE biomarker_snapshots (     -- derived daily/rolling indices (long retention)
  id TEXT PRIMARY KEY, day_local TEXT NOT NULL,       -- 'YYYY-MM-DD' in user tz
  metric TEXT NOT NULL, agg TEXT NOT NULL CHECK (agg IN ('mean','median','min','max','sum','last')),
  value REAL NOT NULL, n_samples INTEGER NOT NULL,
  baseline_median REAL, baseline_mad REAL, robust_z REAL,  -- per-user, per-metric, per-platform
  baseline_window_days INTEGER, platform TEXT NOT NULL,
  computed_at_utc_ms INTEGER NOT NULL,
  created_at_utc_ms INTEGER NOT NULL, updated_at_utc_ms INTEGER NOT NULL,
  deleted_at_utc_ms INTEGER, rev INTEGER NOT NULL DEFAULT 0, sync_state INTEGER NOT NULL DEFAULT 0,
  UNIQUE(day_local, metric, agg, platform)
) STRICT;

-- Urge Surfer (no raw audio is ever stored) ---------------------------------------------
CREATE TABLE breath_sessions (
  id TEXT PRIMARY KEY, started_utc_ms INTEGER NOT NULL, tz_offset_min INTEGER NOT NULL,
  planned_s INTEGER NOT NULL DEFAULT 180, completed_s INTEGER,
  mode TEXT NOT NULL CHECK (mode IN ('mic','touch','pacer_only')),
  target_exhale_s REAL NOT NULL DEFAULT 6, target_inhale_s REAL NOT NULL DEFAULT 4,
  n_exhales_detected INTEGER, mean_exhale_s REAL, sd_exhale_s REAL,
  mean_breath_rate_bpm REAL, adherence_pct REAL, median_snr_db REAL,
  calib_noise_floor_dbfs REAL, calib_exhale_peak_dbfs REAL, device_model TEXT, audio_route TEXT,
  craving_before_0_10 INTEGER, craving_after_0_10 INTEGER,
  created_at_utc_ms INTEGER NOT NULL, updated_at_utc_ms INTEGER NOT NULL,
  deleted_at_utc_ms INTEGER, rev INTEGER NOT NULL DEFAULT 0, sync_state INTEGER NOT NULL DEFAULT 0
) STRICT;

-- ML --------------------------------------------------------------------------------------
CREATE TABLE model_versions (
  id TEXT PRIMARY KEY, name TEXT NOT NULL, semver TEXT NOT NULL, runtime TEXT NOT NULL
    CHECK (runtime IN ('onnxruntime','litert','rules')), artifact_sha256 TEXT NOT NULL,
  feature_schema_version TEXT NOT NULL, activated_utc_ms INTEGER, retired_utc_ms INTEGER,
  UNIQUE(name, semver)
) STRICT;
CREATE TABLE predictions (
  id TEXT PRIMARY KEY, model_version_id TEXT NOT NULL REFERENCES model_versions(id),
  predicted_at_utc_ms INTEGER NOT NULL, tz_offset_min INTEGER NOT NULL,
  horizon_min INTEGER NOT NULL, risk REAL NOT NULL, threshold REAL,
  features_hash TEXT, top_features_json TEXT,
  action TEXT CHECK (action IN ('none','notify','in_app_card','suppressed_cap')),
  notification_id TEXT REFERENCES notifications_log(id),
  outcome_label INTEGER, outcome_observed_utc_ms INTEGER   -- for on-device evaluation
) STRICT;
CREATE INDEX ix_pred_time ON predictions(predicted_at_utc_ms);

-- engagement ------------------------------------------------------------------------------
CREATE TABLE notifications_log (
  id TEXT PRIMARY KEY, os_request_id TEXT NOT NULL, kind TEXT NOT NULL,
  scheduled_utc_ms INTEGER NOT NULL, delivered_utc_ms INTEGER, opened_utc_ms INTEGER,
  dismissed_utc_ms INTEGER, trigger TEXT CHECK (trigger IN ('time','calendar','geofence','prediction','ema')),
  geofence_id TEXT, payload_code TEXT, status TEXT NOT NULL
) STRICT;
CREATE INDEX ix_notif_sched ON notifications_log(status, scheduled_utc_ms);

CREATE TABLE achievements (id TEXT PRIMARY KEY, code TEXT UNIQUE NOT NULL, title_key TEXT NOT NULL,
  criteria_json TEXT NOT NULL CHECK (json_valid(criteria_json))) STRICT;
CREATE TABLE user_achievements (
  id TEXT PRIMARY KEY, achievement_id TEXT NOT NULL REFERENCES achievements(id),
  earned_utc_ms INTEGER NOT NULL, tz_offset_min INTEGER NOT NULL,
  created_at_utc_ms INTEGER NOT NULL, updated_at_utc_ms INTEGER NOT NULL,
  deleted_at_utc_ms INTEGER, rev INTEGER NOT NULL DEFAULT 0, sync_state INTEGER NOT NULL DEFAULT 0,
  UNIQUE(achievement_id)
) STRICT;

CREATE TABLE geofences (               -- user-defined trigger places (coarse, user-entered)
  id TEXT PRIMARY KEY, label TEXT NOT NULL, lat REAL NOT NULL, lon REAL NOT NULL,
  radius_m REAL NOT NULL CHECK (radius_m >= 100), priority INTEGER NOT NULL DEFAULT 0,
  active INTEGER NOT NULL DEFAULT 1,
  created_at_utc_ms INTEGER NOT NULL, updated_at_utc_ms INTEGER NOT NULL,
  deleted_at_utc_ms INTEGER, rev INTEGER NOT NULL DEFAULT 0, sync_state INTEGER NOT NULL DEFAULT 0
) STRICT;

-- optional E2E backup ------------------------------------------------------------------------
CREATE TABLE sync_outbox (
  seq INTEGER PRIMARY KEY AUTOINCREMENT, table_name TEXT NOT NULL, row_id TEXT NOT NULL,
  op TEXT NOT NULL CHECK (op IN ('upsert','delete')), row_rev INTEGER NOT NULL,
  enqueued_utc_ms INTEGER NOT NULL, attempts INTEGER NOT NULL DEFAULT 0
) STRICT;
CREATE TABLE retention_policy (table_name TEXT PRIMARY KEY, keep_days INTEGER NOT NULL) STRICT;
```

#### Retention and erasure plan (design)
- **Retention defaults:**
  - `wearable_samples`: 90 days, then rolled up to `biomarker_snapshots`.
  - `notifications_log` and `predictions`: 180 days.
  - Tombstones: purged 30 days after `sync_state = 2`.
  - `consent_log`: kept for the account lifetime.
  - A daily maintenance job (BGProcessingTask / WorkManager) runs `DELETE … WHERE …` then `PRAGMA incremental_vacuum`.
- **"Delete my data" (right to erasure), in order:**
  1. Delete app-written Health Connect records via `deleteRecords`.
  2. Delete server-side encrypted backup blobs and the account.
  3. Close the DB, delete the DB, WAL and SHM files, and delete the Keychain/Keystore key entries. This is crypto-shredding: any residual pages or forensic copies become unreadable.
  4. Clear caches and preferences.
  5. Reset to onboarding.

### Gaps
- drift.simonbinder.eu was unreachable, so I did not quote drift's own encryption page. The setup-callback `PRAGMA key` pattern above is standard drift/sqlite3 usage but is unverified in this session.
- I did not verify the exact SQLite version bundled in the current `source: sqlcipher` prebuilt, and therefore `STRICT` support (needs SQLite ≥3.37). Check at runtime.
- I did not fetch the GDPR Article 17 text (eur-lex) or EDPB guidance, so the legal framing of erasure and retention needs a privacy-counsel source.
- I did not verify Zetetic's SQLCipher 4 defaults (KDF iterations, HMAC algorithm, page size), because zetetic.net was blocked.

---

## Q3. Wearable pipeline: HealthKit and Health Connect APIs, permissions, background reads, and SDNN vs RMSSD normalization

### Takeaway
- **iOS:** register `HKObserverQuery` + `enableBackgroundDelivery` in `didFinishLaunching`, which needs the `com.apple.developer.healthkit.background-delivery` entitlement on iOS 15+. Pull deltas with `HKAnchoredObjectQuery`, which returns additions and deletions. Use `HKStatisticsCollectionQuery` for buckets.
- **Android:** use `connect-client` with per-type read permissions plus `READ_HEALTH_DATA_IN_BACKGROUND`, gated on `FEATURE_READ_HEALTH_DATA_IN_BACKGROUND`, and `READ_HEALTH_DATA_HISTORY` for data older than 30 days. Sync with per-type Changes tokens, which expire within 30 days, and complete the Play Console Health apps declaration.
- **HRV is not cross-comparable:** Apple stores SDNN and Health Connect stores RMSSD. Keep them as separate metrics and only use per-user, per-metric, per-platform baselines and z-scores.

### Cited Findings
**HealthKit**
- `heartRateVariabilitySDNN`: "HealthKit uses SDNN heart rate variability, which uses the standard deviation of the inter-beat (RR) intervals between normal heartbeats (typically measured in milliseconds). The system automatically records samples on Apple Watch." — [Apple docs](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/heartratevariabilitysdnn)
- `restingHeartRate` (count/time):
  - "the system estimates the resting heart rate by analyzing sedentary heart rate samples throughout the day".
  - "the system may delete earlier samples and replace them with better estimates. Apple Watch replaces only the samples written by the watch for the current or previous day."
  - It is distinct from `heartRate` with `HKHeartRateMotionContext.sedentary`.
  - [Apple docs](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/restingheartrate)
- Other quantity types:
  - `respiratoryRate` uses count/time units and is auto-recorded on Apple Watch. — [Apple docs](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/respiratoryrate)
  - `oxygenSaturation` uses percent units. — [Apple docs](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/oxygensaturation)
  - `vo2Max` is in ml/kg/min. It is auto-saved on Apple Watch Series 3+ after outdoor walk/run/hike, with an estimable range of 14–60 ml/kg/min. — [Apple docs](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/vo2max)
- `enableBackgroundDelivery(for:frequency:withCompletion:)`:
  - "For iOS 15 and watchOS 8 and later, you must enable the HealthKit Background Delivery by adding the `com.apple.developer.healthkit.background-delivery` entitlement". Without it the call fails with `HKError.Code.errorAuthorizationDenied`.
  - "Some sample types have a maximum frequency of `HKUpdateFrequency.hourly`… on iOS, `stepCount` samples have an hourly maximum frequency."
  - "set up all your observer queries in your app delegate's `application(_:didFinishLaunchingWithOptions:)`".
  - "you must call the update's completion handler… If your app fails to respond three times, HealthKit assumes your app can't receive data and stops sending background updates".
  - "Background server queries aren't supported on the Simulator".
  - `HKCorrelationType` is not supported.
  - watchOS: four updates per hour, shared with refresh tasks.
  - [Apple docs](https://developer.apple.com/documentation/healthkit/hkhealthstore/enablebackgrounddelivery(for:frequency:withcompletion:)); [entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.healthkit.background-delivery)
- `HKAnchoredObjectQuery` "returns an anchor value that corresponds to the last sample or deleted object received". It can act as both a snapshot and a long-running query. — [Apple docs](https://developer.apple.com/documentation/healthkit/hkanchoredobjectquery)
- `HKStatisticsCollectionQuery` computes statistics over fixed-length intervals, works for quantity samples only, and can be long-running. — [Apple docs](https://developer.apple.com/documentation/healthkit/hkstatisticscollectionquery)
- `HKObserverQuery` is long-running and alerts on saves and deletes. — [Apple docs](https://developer.apple.com/documentation/healthkit/hkobserverquery)
- Privacy rules:
  - "an app isn't aware when the user denies permission to read data. From the app's point of view, no data of that type exists."
  - `NSHealthShareUsageDescription` (read) and `NSHealthUpdateUsageDescription` (write) are required, or the app crashes on authorization.
  - "the device encrypts the HealthKit store when the user locks the device… your app may not be able to read data from the store when it runs in the background."
  - No advertising use. No disclosure to third parties without express permission. No selling to ad platforms or data brokers. A privacy policy is required.
  - [Apple: Protecting user privacy](https://developer.apple.com/documentation/healthkit/protecting-user-privacy); [NSHealthShareUsageDescription](https://developer.apple.com/documentation/bundleresources/information-property-list/nshealthshareusagedescription)
- App Review 5.1.3(i) and (ii): no advertising or marketing use of HealthKit data, disclose the specific health data collected, and no PHI in iCloud. — [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)

**Health Connect: record types and permissions** ([data types](https://developer.android.com/health-and-fitness/guides/health-connect/plan/data-types))

| Record | Read permission | Kind | Key field |
|---|---|---|---|
| `RestingHeartRateRecord` | `android.permission.health.READ_RESTING_HEART_RATE` | Instantaneous | `beatsPerMinute` |
| `HeartRateVariabilityRmssdRecord` | `android.permission.health.READ_HEART_RATE_VARIABILITY` | Instantaneous | `heartRateVariabilityMillis` (Double, ms) |
| `HeartRateRecord` | `…READ_HEART_RATE` | Series | `samples` |
| `RespiratoryRateRecord` | `…READ_RESPIRATORY_RATE` | Instantaneous | `rate` |
| `OxygenSaturationRecord` | `…READ_OXYGEN_SATURATION` | Instantaneous | `percentage` |
| `Vo2MaxRecord` | `…READ_VO2_MAX` | Instantaneous | `vo2MillilitersPerMinuteKilogram`, `measurementMethod` |
| `StepsRecord` | `…READ_STEPS` | Interval | `count` |
| `SleepSessionRecord` | `…READ_SLEEP` | Interval | `stages` |

- The `HeartRateVariabilityRmssdRecord(time, zoneOffset, heartRateVariabilityMillis: Double, metadata)` constructor and property were "Added in 1.1.0". — [API reference](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/HeartRateVariabilityRmssdRecord)
- Background reads: declare `android.permission.health.READ_HEALTH_DATA_IN_BACKGROUND`, then check `healthConnectClient.features.getFeatureStatus(HealthConnectFeatures.FEATURE_READ_HEALTH_DATA_IN_BACKGROUND) == FEATURE_STATUS_AVAILABLE`. The doc example schedules a WorkManager `PeriodicWorkRequestBuilder<…>(1, TimeUnit.HOURS)`. — [read-data](https://developer.android.com/health-and-fitness/guides/health-connect/develop/read-data)
- History limit: "all applications can read data from Health Connect for up to 30 days prior to when any permission was first granted".
  - Android 14+ has no limit for an app's own data.
  - Reading older records needs `PERMISSION_READ_HEALTH_DATA_HISTORY` (`android.permission.health.READ_HEALTH_DATA_HISTORY`).
  - After an uninstall/reinstall, the window restarts.
  - [read-data](https://developer.android.com/health-and-fitness/guides/health-connect/develop/read-data); [data types](https://developer.android.com/health-and-fitness/guides/health-connect/plan/data-types)
- Reading and aggregation:
  - `ReadRecordsRequest` default `pageSize` is 1000, with `pageToken` paging. On some Android 12/13 builds the token can be `""`, so check `isNullOrEmpty()`.
  - Use `aggregate(AggregateRequest(metrics = setOf(StepsRecord.COUNT_TOTAL), …))` for cumulative types to avoid double counting across sources.
  - [read-data](https://developer.android.com/health-and-fitness/guides/health-connect/develop/read-data)
- Platform availability:
  - "Starting Android 14 (API Level 34), Health Connect is part of the Android Framework… a framework module". On Android 13 and lower, the user installs the Health Connect app from Play.
  - The SDK supports Android 8 (API 26) or higher, but the HC app requires Android 9+.
  - The doc shows `androidx.health.connect:connect-client:1.2.0-alpha06`. "Version 1.1.0 and later… require compileSdk = 36 and AGP 8.9.1 or higher."
  - [get-started](https://developer.android.com/health-and-fitness/guides/health-connect/develop/get-started)
- Integration requirements:
  - Check availability with `HealthConnectClient.getSdkStatus(context)` (`SDK_AVAILABLE`).
  - Manifest `<queries><package android:name="com.google.android.apps.healthdata"/></queries>`.
  - A rationale activity handling `androidx.health.ACTION_SHOW_PERMISSIONS_RATIONALE` (≤13).
  - An `activity-alias` `ViewPermissionUsageActivity` with `android.permission.START_VIEW_PERMISSION_USAGE`, action `android.intent.action.VIEW_PERMISSION_USAGE` and category `android.intent.category.HEALTH_PERMISSIONS` (14+).
  - Request permissions with `PermissionController.createRequestPermissionResultContract()`.
  - "Google Fit APIs will be supported until the end of 2026."
  - [get-started](https://developer.android.com/health-and-fitness/guides/health-connect/develop/get-started)
- Changes tokens:
  - Use `getChangesToken(ChangesTokenRequest(recordTypes=…))` → `getChanges(token)` → `UpsertionChange` / `DeletionChange`.
  - "We recommend getting separate tokens per data type".
  - Skip upserts whose `dataOrigin.packageName` is your own app.
  - "an unused Changes token expires within 30 days". The documented recovery strategies are re-reading from the last timestamp or the last 30 days, then deduping by id.
  - [sync-data](https://developer.android.com/health-and-fitness/health-connect/sync-data)
- Rate limits: there are periodic and daily quotas for reads and changelog calls, and "background rate limiting is stricter than foreground". Prefer changelog sync over raw reads. — [rate-limiting](https://developer.android.com/health-and-fitness/health-connect/rate-limiting)
- Play Console: apps must complete the Data safety section and "the Health Apps declaration form". The declaration is repeated whenever data types change. Data-type access is allow-listed per package name. Apps that used the old Health Connect API Request form had to migrate by January 22, 2025. — [publish](https://developer.android.com/health-and-fitness/health-connect/publish)

### Inferences
- **iOS ingestion design:**
  1. At launch (native `AppDelegate`), for each of `restingHeartRate`, `heartRateVariabilitySDNN`, `heartRate`, `respiratoryRate`, `oxygenSaturation`, `vo2Max`, `stepCount` and `sleepAnalysis`: run `HKObserverQuery` and `enableBackgroundDelivery` (`.hourly`; `.immediate` is pointless for most types given the caps).
  2. In the observer handler, run `HKAnchoredObjectQuery(type, predicate: since(now-35d), anchor: stored)`.
  3. Upsert by HK UUID. Set `deleted_at_utc_ms` for deleted objects; this matters because Apple Watch replaces RHR estimates.
  4. Persist the new anchor, then call `completionHandler()` promptly. Missing it three times stops delivery.
  5. Because HealthKit is encrypted while locked, expect background reads to fail on locked devices. Retry on next foreground or app refresh.
- **Android ingestion design:**
  1. In onboarding, request only the types needed for user-facing features (Play declaration). Ask for `READ_HEALTH_DATA_IN_BACKGROUND` contextually, and ask for `READ_HEALTH_DATA_HISTORY` only if you need >30-day baselines.
  2. On first grant, read the 30-day backfill with paging, then store per-type Changes tokens.
  3. Run a WorkManager periodic job (≥15 min, and practically 1–4 h given stricter background quotas) that calls `getChanges`.
  4. If a token expires (>30 days unused), re-read from the last-success timestamp and dedupe by `Metadata.id`.
- **Normalization:**
  - Never pool SDNN (Apple) with RMSSD (Health Connect). Store them as distinct metrics (`hrv_sdnn_ms`, `hrv_rmssd_ms`).
  - Compute a per-user, per-metric, per-platform robust baseline: a 28-day rolling median and MAD of ln(HRV).
  - Emit `robust_z = (ln x − median)/(1.4826·MAD)`.
  - RHR is comparable across platforms in bpm but still z-scored per user. Treat source-device changes (a new watch) as baseline resets.
  - Require ≥7 valid days before the ML model uses HRV/RHR features. Otherwise mask them and use a missing-indicator.
- Steps should be aggregated with `aggregate()` (HC) and `HKStatisticsCollectionQuery` (iOS) daily buckets, not summed from raw samples. This avoids multi-source double counting.

### Gaps
- I could not fetch Shaffer & Ginsberg 2017 ("An Overview of Heart Rate Variability Metrics and Norms", Front Public Health 5:258, DOI 10.3389/fpubh.2017.00258) to cite SDNN/RMSSD non-comparability and recording-length dependence. The citation is from prior knowledge; verify it.
- I did not determine which Android wearables actually write `HeartRateVariabilityRmssdRecord` and `RestingHeartRateRecord` to Health Connect (e.g., Fitbit, Samsung Health, Pixel Watch). Coverage may be sparse, so plan for missing HRV on Android.
- Apple's documented SDNN measurement window/protocol on Apple Watch (e.g., length of the periodic readings) was not on the fetched page.
- I did not find a numeric value for HC rate-limit quotas on the fetched page.

---

## Q4. Background execution, local-notification caps, and geofencing limits

### Takeaway
- iOS gives opportunistic background time only:
  - `BGAppRefreshTask` is about 30 s, at a system-chosen time.
  - `BGProcessingTask` runs for minutes, typically overnight or while charging.
  - `BGContinuedProcessingTaskRequest` (iOS 26+) is user-initiated.
- iOS keeps only the soonest 64 pending local notifications and allows 20 monitored regions per app.
- Android gives WorkManager (≥15 min periodic), 100 geofences per app per user, runtime `POST_NOTIFICATIONS` (API 33+) and permission-gated exact alarms.
- Therefore, JITAI timing must be pre-planned on-device and refreshed opportunistically. It cannot rely on waking up exactly at predicted-risk times.

### Cited Findings
- **iOS background tasks:**
  - There are two `BGTaskScheduler` task types. `BGAppRefreshTask` is short; `BGProcessingTask` is time-consuming.
  - Enable "Background fetch" and/or "Background processing" in Background Modes.
  - List identifiers in `BGTaskSchedulerPermittedIdentifiers`; adding that key disables the legacy `setMinimumBackgroundFetchInterval`.
  - Register all tasks "before the end of the app launch sequence".
  - The example sets `earliestBeginDate` 15 min ahead.
  - [Apple: Using background tasks](https://developer.apple.com/documentation/uikit/using-background-tasks-to-update-your-app)
- iOS limits:
  - App refresh: "provides your app up to 30 seconds of background runtime".
  - Background pushes more frequent than three per hour get rate-limited.
  - `BGHealthResearchTask` / `BGHealthResearchTaskRequest` exist "for health research studies".
  - [Apple: Choosing background strategies](https://developer.apple.com/documentation/backgroundtasks/choosing-background-strategies-for-your-app)
- `BGContinuedProcessingTaskRequest` (iOS 26.0+): "Submission needs to occur as a result of a person's action… the system allows it to continue running even if the app moves to the background." — [Apple docs](https://developer.apple.com/documentation/backgroundtasks/bgcontinuedprocessingtaskrequest)
- **iOS local notifications:** "the system keeps the soonest-firing 64 notifications (with automatically rescheduled notifications counting as a single notification) and discards the rest".
  - This is from Apple's *archived* Local and Remote Notification Programming Guide. The current UserNotifications pages I fetched do not restate the number. — [Apple archive](https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/SchedulingandHandlingLocalNotifications.html)
  - Triggers are `UNCalendarNotificationTrigger`, `UNTimeIntervalNotificationTrigger` and `UNLocationNotificationTrigger`. Cancel with `removePendingNotificationRequests(withIdentifiers:)`. — [Apple: Scheduling a notification locally](https://developer.apple.com/documentation/usernotifications/scheduling-a-notification-locally-from-your-app)
- **iOS geofencing:**
  - "Core Location prevents any single app from monitoring more than 20 conditions of any type simultaneously".
  - The modern API is `CLMonitor` with `CLCircularGeographicCondition`.
  - The system relaunches the app on events, and the monitor must be recreated with the same identifier.
  - "monitoring can only occur after the user unlocks the device after a reboot".
  - [Apple: Monitoring proximity to regions](https://developer.apple.com/documentation/corelocation/monitoring-the-user-s-proximity-to-geographic-regions)
- App Review 2.5.4: background services only "for their intended purposes: VoIP, audio playback, location, task completion, local notifications, etc." — [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)
- **Android geofencing:**
  - "a limit of 100 per app, per device user".
  - The recommended minimum radius is 100–150 m.
  - Requires `ACCESS_FINE_LOCATION`, plus `ACCESS_BACKGROUND_LOCATION` when targeting API 29+.
  - Latency is usually <2 min, about 2–3 min under background location limits, and up to 6 min when stationary.
  - Re-register after reboot (`BOOT_COMPLETED`), reinstall, data clear, or `GEOFENCE_NOT_AVAILABLE`.
  - Use `GEOFENCE_TRANSITION_DWELL` with loitering delay to reduce spam.
  - [Android geofencing](https://developer.android.com/develop/sensors-and-location/location/geofencing)
- **WorkManager:** "Periodic work has a minimum interval of 15 minutes" (`MIN_PERIODIC_INTERVAL_MILLIS`). — [PeriodicWorkRequest](https://developer.android.com/reference/androidx/work/PeriodicWorkRequest)
- **Android exact alarms:**
  - `SCHEDULE_EXACT_ALARM` is "not pre-granted to fresh installs of apps targeting Android 13 (API level 33) and higher". It is user-revocable; check `canScheduleExactAlarms()`.
  - `USE_EXACT_ALARM` is auto-granted but limited by Play policy.
  - Use exact alarms "only if a user-facing function in your app requires precisely-timed actions".
  - [Android alarms](https://developer.android.com/develop/background-work/services/alarms)
- **Android notifications:** `POST_NOTIFICATIONS` is a runtime permission on Android 13 (API 33)+. — [Notification permission](https://developer.android.com/develop/ui/compose/notifications/notification-permission)
- **Android microphone FGS:**
  - It needs `foregroundServiceType="microphone"`, `FOREGROUND_SERVICE_MICROPHONE` and `RECORD_AUDIO`.
  - "RECORD_AUDIO … is subject to while-in-use restrictions… you cannot create a microphone foreground service while your app is in the background".
  - [FGS types](https://developer.android.com/develop/background-work/services/fgs/service-types)

### Inferences
- **Notification planner:**
  - Keep a rolling horizon of ≤48 pending iOS notifications. This leaves headroom under 64 for system or one-off prompts.
  - Recompute the horizon on every foreground, `BGAppRefreshTask`, HealthKit background delivery and geofence relaunch.
  - Use `UNLocationNotificationTrigger` for "arrived at trigger place" nudges. These fire without app code running and count toward the 20-region budget.
  - Store each scheduled request in `notifications_log` to reconcile delivered/opened state.
- **Model refresh:** the on-device risk model should run during these opportunistic windows and pre-schedule the next N hours of risk-gated prompts (EMA and JITAI). True "just-in-time" wake-ups would require server push, which conflicts with offline-first and privacy goals.
- **Geofence budgets:** allow at most 15 user geofences on iOS (reserving 5) and 90 on Android. Enforce radius ≥100–150 m. Prefer DWELL on Android.
- Avoid exact alarms. Inexact WorkManager plus pre-scheduled notifications satisfies the UX, and avoids `USE_EXACT_ALARM` policy review.
- The Urge Surfer runs only in the foreground, so no microphone FGS is needed. Stop capture on `didEnterBackground` / `onStop`.

### Gaps
- No current Apple doc page restating the 64-pending limit for `UNUserNotificationCenter` was found. The number comes from the archived guide and is widely relied on, but should be confirmed on a device.
- I did not verify the Flutter `native_geofence` 1.3.1 README for whether it uses `CLMonitor` or legacy `CLRegion` APIs.

---

## Q5. Microphone-based exhale detection DSP for the 180-second Urge Surfer (literature + concrete pipeline)

### Takeaway
- Smartphone microphones can capture breath airflow noise well enough to estimate breathing rate. Nam, Reyes & Chon (IEEE JBHI 2016) report median errors under 1% across 6–90 breaths/min from nasal breath sounds, with the mic up to 30 cm away.
- Real-time per-breath exhale segmentation for biofeedback is a different, harder task (onset/offset timing under noise).
- The recommended design is a deterministic, on-device, sub-100 ms pipeline:
  - 16 kHz mono capture with system processing off (iOS `.measurement`; Android `UNPROCESSED` → `VOICE_RECOGNITION` fallback);
  - 150 Hz high-pass and band-energy features;
  - adaptive noise-floor tracking;
  - a hysteresis state machine;
  - speech rejection (harmonicity / spectral flatness / optional Silero VAD);
  - a 3-breath calibration.
- Only session summaries are persisted; no raw audio is ever stored.

### Cited Findings
**Literature (verified in-session)**
- Nam Y, Reyes BA, Chon KH. "Estimation of Respiratory Rates Using the Built-in Microphone of a Smartphone or Headset." *IEEE J Biomed Health Inform* 2016;20(6):1493–1501. DOI 10.1109/JBHI.2015.2480838.
  - Setup: nasal airflow sound recorded by a smartphone mic or a headset mic under the nose; also tracheal sounds via a smartphone at the paralaryngeal space.
  - Reference: inductance plethysmography.
  - Spectral estimation: Welch periodogram and AR spectrum.
  - Subjects: 10 healthy, at 6–90 breaths/min.
  - Nasal-sound estimates had median errors under 1% across all ranges. Tracheal sounds were poor.
  - At high rates, nasal congestion produced outliers that often doubled the estimate.
  - Rates were accurately estimated with the phone mic up to 30 cm from the nose.
  - [IEEE Xplore record](https://ieeexplore.ieee.org/document/7273825); [UConn PDF](https://biosignal.uconn.edu/wp-content/uploads/sites/2503/2018/09/07_Nam_2016_JBHI.pdf). Details are from the search-indexed abstract; the full text was not readable in-session.

**Audio session and source controls (platform)**
- iOS `AVAudioSession.Mode.measurement` is for "apps that need to minimize the amount of system-supplied signal processing to input and output signals. If recording on devices with more than one built-in microphone, the session uses the primary microphone." It disables some dynamics processing. It applies to the `playback`, `record` and `playAndRecord` categories. — [Apple docs](https://developer.apple.com/documentation/avfaudio/avaudiosession/mode-swift.struct/measurement)
- iOS `voiceChat` mode with Voice-Processing I/O applies echo cancellation and automatic gain correction. Avoid it for breath sensing. — [Apple docs](https://developer.apple.com/documentation/avfaudio/avaudiosession/mode-swift.struct/voicechat); [setVoiceProcessingEnabled(_:)](https://developer.apple.com/documentation/avfaudio/avaudioionode/setvoiceprocessingenabled(_:))
- iOS `setPreferredIOBufferDuration(_:)`: the typical maximum is 0.093 s (4096 frames @ 44.1 kHz). "The minimum I/O buffer duration is at least 0.005 seconds (256 frames) but might be lower". — [Apple docs](https://developer.apple.com/documentation/avfaudio/avaudiosession/setpreferrediobufferduration(_:))
- iOS tap APIs:
  - `AVAudioNode.installTap(onBus:bufferSize:format:block:)` is marked **deprecated in iOS 27.0**: "The size of the incoming buffers. The implementation may choose another size."; one tap per bus; the block may be called off the main thread.
  - Its replacement, `installAudioTap(onBus:bufferSize:format:tapProvider:)` (iOS 27.0+), uses a sendable closure with read-only buffers. Its bufferSize "Supported range is [100, 400] ms", which is too coarse for a <100 ms feedback loop.
  - `AVAudioSinkNode` (iOS 13+) receives input via `AVAudioSinkNodeReceiverBlock`. It is input-chain only, has no format conversion, and its format should match the hardware input sample rate.
  - [installTap](https://developer.apple.com/documentation/avfaudio/avaudionode/installtap(onbus:buffersize:format:block:)); [installAudioTap](https://developer.apple.com/documentation/avfaudio/avaudionode/installaudiotap(onbus:buffersize:format:tapprovider:)); [AVAudioSinkNode](https://developer.apple.com/documentation/avfaudio/avaudiosinknode)
- Android `MediaRecorder.AudioSource`:
  - `UNPROCESSED` (API 24): "Microphone audio source tuned for unprocessed (raw) sound if available, behaves like DEFAULT otherwise."
  - `VOICE_RECOGNITION` (API 7): "tuned for voice recognition".
  - `VOICE_COMMUNICATION` is tuned for VoIP.
  - [AudioSource](https://developer.android.com/reference/android/media/MediaRecorder.AudioSource)
- `AudioManager.PROPERTY_SUPPORT_AUDIO_SOURCE_UNPROCESSED` (API 24) is the `getProperty` key "to determine if the unprocessed audio source is available and supported with the expected frequency range and level response". — [AudioManager](https://developer.android.com/reference/android/media/AudioManager)
- The Android latency guide advises removing unwanted processing "by using the VOICE_RECOGNITION preset when recording". Typical buffer sizes are 96–512 frames; nominal rates are 44.1/48 kHz. — [Audio latency](https://developer.android.com/ndk/guides/audio/audio-latency)
- Oboe: the default `InputPreset` "is set to VoiceRecognition, which is optimized for low latency". `SharingMode::Exclusive` gives the lowest latency but more disconnects. The I16 and Float formats are supported, with automatic conversion possible. — [Oboe FullGuide](https://github.com/google/oboe/blob/main/docs/FullGuide.md)
- Silero VAD:
  - "One audio chunk (30+ ms) takes less than 1ms to be processed on a single CPU thread".
  - Supports 8 kHz and 16 kHz.
  - MIT license; runs on ONNX Runtime; "no telemetry".
  - [silero-vad README](https://github.com/snakers4/silero-vad)
- Permissions:
  - iOS `NSMicrophoneUsageDescription` is required for mic APIs. — [Apple docs](https://developer.apple.com/documentation/bundleresources/information-property-list/nsmicrophoneusagedescription)
  - Use `AVAudioApplication.requestRecordPermission(completionHandler:)` (iOS 17+). `AVAudioSession.requestRecordPermission(_:)` was deprecated in iOS 17. — [AVAudioApplication](https://developer.apple.com/documentation/avfaudio/avaudioapplication/requestrecordpermission(completionhandler:)); [AVAudioSession](https://developer.apple.com/documentation/avfaudio/avaudiosession/requestrecordpermission(_:))

### Inferences

These are engineering design choices with stated rationale. Parameters are starting points to be tuned in a calibration study.

#### 1. Capture
- **iOS:**
  - `AVAudioSession` category `.playAndRecord` (pacer audio cues/haptics) or `.record`, with mode `.measurement`.
  - Preferred IO buffer 0.01 s; preferred sample rate 48 kHz. Read the actual `ioBufferDuration` and `sampleRate`.
  - Capture with `AVAudioSinkNode` on `inputNode`, or RemoteIO, at the hardware rate.
  - Decimate 48→16 kHz with a polyphase FIR (≥60 dB stopband, cutoff ~7 kHz).
  - Do not use `installAudioTap` (100–400 ms buffers) or rely on `installTap` buffer sizes for the real-time loop.
- **Android:**
  - Oboe/AAudio input stream with `PerformanceMode::LowLatency`, `SharingMode::Shared`, Float, mono.
  - InputPreset `Unprocessed` if `PROPERTY_SUPPORT_AUDIO_SOURCE_UNPROCESSED == "true"`, else `VoiceRecognition`. Never `VoiceCommunication`, because AGC/AEC/NS distort the noise envelope.
  - Fallback: `AudioRecord` with the same sources and `ENCODING_PCM_FLOAT`.
- **Flutter-only fallback:**
  - `record.startStream(RecordConfig(encoder: AudioEncoder.pcm16bits, sampleRate: 16000, numChannels: 1, autoGain: false, echoCancel: false, noiseSuppress: false, androidConfig: AndroidRecordConfig(audioSource: AndroidAudioSource.unprocessed), streamBufferSize: 640))`.
  - Set the iOS session mode via `audio_session` or native code.
  - Expect higher and more variable latency.

#### 2. Pre-processing at 16 kHz
- DC blocker: one-pole HPF at ~20 Hz.
- 4th-order Butterworth high-pass at 150 Hz, to remove handling, thump and HVAC rumble.
- Optionally a pre-emphasis-like spectral tilt is not needed, because features are computed per band.

#### 3. Framing
- 20 ms frames (320 samples) with a 10 ms hop (100 frames/s) and a Hann window, using a 512-point FFT (zero-padded).
- The short frame is chosen for onset latency; longer 32 ms frames add ~10 ms delay for marginal stability gain.

#### 4. Features per frame
- `E_b` = band energy in dBFS over 150–2000 Hz (primary airflow-noise band at close range).
- `E_h` = 2–6 kHz energy.
- `R_bh = E_b − E_h` (band-energy ratio).
- `SF` = spectral flatness (geometric/arithmetic mean of the power spectrum, 150–6000 Hz). Breath turbulence is noise-like, so SF is high; voiced speech is harmonic, so SF is low.
- `SC` = spectral centroid.
- `ZCR` = zero-crossing rate.
- `H` = harmonicity: the normalized autocorrelation peak for lags of 2.5–12.5 ms (80–400 Hz F0).
- Optional `p_speech` from Silero VAD on 32 ms chunks (<1 ms CPU each).

#### 5. Adaptive noise floor `N`
- Track the 10th percentile of `E_b` over a sliding 3 s window, updated only in the IDLE state.
- Equivalently, use minimum statistics with a 1.5–3 s search window.
- Clamp the per-second rise to +3 dB/s so a long exhale does not pull the floor up.

#### 6. Hysteresis state machine
- **IDLE → CANDIDATE** when all of:
  - `E_b > N + T_on` (start `T_on` = 10 dB, or 0.5·(calibrated peak − N), whichever is larger, capped at 20 dB);
  - `SF > SF_min` (start 0.25; tune per device);
  - `H < 0.45`;
  - `p_speech < 0.5`.
- **CANDIDATE → EXHALE** after 4 consecutive qualifying frames (40 ms debounce).
- **Stay in EXHALE** while `E_b > N + T_off` (`T_off = T_on − 4 dB`), tolerating ≤150 ms dropouts (gap bridging).
- **EXHALE → IDLE** when below `T_off` for ≥150 ms. The offset time is backdated to the first sub-threshold frame.
- **Accept** an exhale if its duration is 0.5–15 s. Reject it if >30% of its frames had `H ≥ 0.45` or `p_speech ≥ 0.5` (speech/hum).
- **Inhale = gap** between an accepted exhale offset and the next onset. Inhalation is typically much quieter at the mic. Optionally flag a weak inhale if a `+4 dB` bump with high SF occurs in the gap.

#### 7. Calibration (≈20 s, first use and when SNR drops)
- (a) 5 s silence → `N0`, `SF0`.
- (b) "Breathe out slowly toward the bottom of the phone" × 3 → per-breath peak `E_b`, median `SF`, `SC`.
- (c) Set `T_on`, `SF_min = max(0.15, 0.5·median SF_breath)`.
- (d) Require SNR = `median_peak − N0` ≥ 12 dB. Otherwise prompt the user to hold the phone 5–15 cm from the mouth/nose or move away from noise.
  - Nam et al. measured rate up to 30 cm, but per-breath segmentation needs more SNR.
- (e) Persist only the thresholds and `device_model` / `audio_route`.

#### 8. Pacer and feedback for 180 s
- The target is a 4 s inhale and 6 s exhale, i.e. a 10 s cycle = 6 breaths/min (0.1 Hz) → 18 cycles.
- **Visual:** a Rive state machine driven by the pacer clock (not the detector), plus a live "exhale meter" mapped from `(E_b − N)/(peak − N)` and smoothed with a 50 ms EMA.
- **Per-cycle metrics:**
  - exhale duration error `|d − 6 s|`;
  - onset lag relative to the exhale cue;
  - breath rate = 60 / median(last 3 cycle lengths), displayed with EMA α = 0.3;
  - adherence = % of cycles with exhale within 6 ± 1.5 s and onset within ±1 s.
- **Adaptive coaching:** if exhales consistently fall short (<4 s), first shorten the target to 5 s (rate ≈ 6.7/min), then step back up.

#### 9. Latency budget (target ≤100 ms, onset to visual response)
- HW/IO buffer: 5–10 ms.
- Decimation FIR group delay: ~2–4 ms.
- Frame 20 ms (effective ~10 ms alignment).
- Debounce 40 ms.
- Render ≤16.7 ms (60 Hz).
- **Total ≈ 75–90 ms.**
- The meter (no debounce) responds in ~35–50 ms.

#### 10. Robustness
- Device and microphone variability: thresholds are relative to the tracked floor, plus per-device calibration.
- Bluetooth headset mics (HFP) are narrowband (8/16 kHz) and processed. Detect the route; either keep thresholds on the 150–2000 Hz band or switch to touch mode.
- Wind and outdoor noise: elevated `N` and low SNR trigger touch/pacer-only fallback.
- Speech/TV: harmonicity and VAD gates.
- Nasal congestion: Nam et al. observed rate doubling at high rates. At 6/min this matters less, but reject double-detections with a minimum inter-onset interval of 2 s.

#### 11. Accuracy expectations to communicate
- Breathing-rate accuracy in quiet conditions can be very high (Nam et al.: median error <1%).
- Per-breath exhale onset/offset timing should be validated in-house against a reference (chest belt or nasal thermistor). Report:
  - onset/offset MAE (ms);
  - exhale-duration MAE (s);
  - event-level precision/recall (±300 ms tolerance);
  - stratified by SNR band and device.
- Gate the feature as "beta" until the duration MAE is below 0.5 s at SNR ≥12 dB.

#### 12. Privacy
- Audio exists only in a ≤1 s in-memory ring buffer inside the native DSP module. It is never written to disk, never sent to Dart as PCM (features only), and never transmitted.
- Store only the `breath_sessions` summary row.
- Mic permission is requested just-in-time on the first Urge Surfer launch, with touch mode offered if denied.
- `NSMicrophoneUsageDescription` example: "Urge Surfer listens for the sound of your out-breath to pace your breathing. Audio is analysed on your phone in real time and is never recorded or sent anywhere."

#### Pseudo-code (core loop, per 10 ms hop)

```text
x16 = decimate(hw_block)                       # 48k→16k
x16 = hpf150(dcblock(x16))
for frame in frames(x16, N=320, hop=160, win=hann):
    P   = |FFT512(frame)|^2
    Eb  = 10log10(sum(P[150..2000Hz]) + eps) ; Eh = 10log10(sum(P[2k..6k]) + eps)
    SF  = geomean(P[150..6k]) / mean(P[150..6k])
    H   = max_norm_autocorr(frame, lag 2.5..12.5 ms)
    ps  = vad.prob(frame32ms) if vad_enabled else 0
    if state==IDLE: noise.push(Eb); N = noise.p10(3s)
    q_on  = Eb > N+T_on and SF > SF_min and H < 0.45 and ps < 0.5
    q_off = Eb < N+T_off
    state machine: IDLE -(4×q_on)-> EXHALE -(≥150ms q_off)-> IDLE ; bridge gaps <150 ms
    on EXHALE end: if 0.5s ≤ dur ≤ 15s and speech_frac < 0.3 → emit Exhale(t_on, t_off)
    meter = ema50ms(clamp((Eb-N)/(peak-N), 0, 1)) → UI @60 Hz
```

### Gaps
Literature not verifiable in-session (publisher, DOI and crossref hosts blocked). These are candidate citations from prior knowledge: verify titles, DOIs and any figures before publication, and do not quote accuracy numbers from them until checked.
- **SpiroSmart:** Larson EC, Goel M, Boriello G, Heltshe S, Rosenfeld M, Patel SN. "SpiroSmart: using a microphone to measure lung function on a mobile phone." UbiComp 2012. DOI 10.1145/2370216.2370261. It is relevant for mic-based exhalation-flow estimation; I recall about 5% mean error vs a clinical spirometer for common measures, but this is **unverified**.
- **Breeze:** Shih CH-I, Tomita N, Lukic YX, Hernández Reguera Á, Fleisch E, Kowatsch T. "Breeze: Smartphone-based Acoustic Real-time Detection of Breathing Phases for a Gamified Biofeedback Breathing Training." I believe it is *Proc. ACM IMWUT* 3(4), 2019, DOI 10.1145/3369835, **not CHI** as stated in the brief. This is the closest prior art to Urge Surfer (real-time inhale/exhale/pause detection from the phone mic); retrieve its reported F1/accuracy and feature set.
- **BreathListener:** Xu X, Yu J, Chen Y, et al. "BreathListener: Fine-grained Breathing Monitoring in Driving Environments Utilizing Acoustic Signals." MobiSys 2019, DOI 10.1145/3307334.3326074 (likely). It uses active (inaudible) acoustic sensing, not passive breath noise.
- **Nandakumar et al., ApneaApp:** "Contactless Sleep Apnea Detection on Smartphones." MobiSys 2015, DOI 10.1145/2742647.2742674 (likely). Active FMCW sonar.
- **Ren Y, Wang C, Yang J, Chen Y:** "Fine-grained Sleep Monitoring: Hearing Your Breathing with Smartphones." IEEE INFOCOM 2015 (DOI not confirmed). Passive breath sounds.
- **Ruinskiy D, Lavner Y:** "An Effective Algorithm for Automatic Detection and Exact Demarcation of Breath Sounds in Speech and Song Signals." IEEE TASLP 2007;15(3):838–850, DOI 10.1109/TASL.2006.889750 (likely). Breath vs speech discrimination features.
- **Martin R:** "Noise power spectral density estimation based on optimal smoothing and minimum statistics." IEEE TSAP 2001;9(5):504–512, DOI 10.1109/89.928915. Noise-floor tracking.
- **Sohn J, Kim NS, Sung W:** "A statistical model-based voice activity detection." IEEE SPL 1999;6(1):1–3, DOI 10.1109/97.736233.
- **Lehrer PM, Gevirtz R:** "Heart rate variability biofeedback: how and why does it work?" Front Psychol 2014;5:756, DOI 10.3389/fpsyg.2014.00756. Rationale for ~6 breaths/min resonance breathing; this likely overlaps with another section's breathing-evidence notes.

Other gaps:
- I found no reliable source in-session on commercial breathing apps that use the microphone for exhale detection, or on their accuracy.
- The "orange dot" iOS recording indicator and Android 12+ privacy indicators were not verified, because support.apple.com and source.android.com were blocked. Both are widely documented platform behaviors, but cite the official pages before publishing.
- I did not find published per-device microphone frequency-response variability data for consumer phones.

---

## Q6. Audio APIs that deliver raw PCM in real time (iOS, Android, Flutter, RN)

### Takeaway
For the <100 ms loop:
- **iOS:** `AVAudioEngine` + `AVAudioSinkNode`, or RemoteIO, at the hardware rate with `.measurement` mode. `installTap` is deprecated in iOS 27, and its replacement `installAudioTap` only accepts 100–400 ms buffers.
- **Android:** Oboe/AAudio (or `AudioRecord`) with `UNPROCESSED` → `VOICE_RECOGNITION`.
- **Flutter:** `record` 7.1.2 `startStream` with `pcm16bits` is the only well-maintained raw-PCM plugin. `mic_stream` (last published Mar 2025) and `flutter_audio_capture` (Dec 2025) are less active.
- Production should use a native FFI DSP module.

### Cited Findings
- iOS tap and sink APIs, with their buffer semantics: see Q5. — [installTap](https://developer.apple.com/documentation/avfaudio/avaudionode/installtap(onbus:buffersize:format:block:)), [installAudioTap](https://developer.apple.com/documentation/avfaudio/avaudionode/installaudiotap(onbus:buffersize:format:tapprovider:)), [AVAudioSinkNode](https://developer.apple.com/documentation/avfaudio/avaudiosinknode), [inputNode](https://developer.apple.com/documentation/avfaudio/avaudioengine/inputnode)
- Android sources, the UNPROCESSED capability check, latency guidance and Oboe presets: see Q5. — [AudioSource](https://developer.android.com/reference/android/media/MediaRecorder.AudioSource), [AudioManager](https://developer.android.com/reference/android/media/AudioManager), [latency](https://developer.android.com/ndk/guides/audio/audio-latency), [Oboe](https://github.com/google/oboe/blob/main/docs/FullGuide.md)
- `record`: raw `pcm16bits` stream on all platforms. The `AndroidAudioSource` enum includes `unprocessed` and `voiceRecognition`. iOS config has no mode setter. — [record README](https://github.com/llfbandit/record/blob/master/record/README.md); [android_record_config.dart](https://github.com/llfbandit/record/blob/master/record_platform_interface/lib/src/types/android_record_config.dart)
- Versions:
  - `mic_stream` 0.7.2, last published 2025-03-01. — [pub.dev](https://pub.dev/packages/mic_stream)
  - `flutter_audio_capture` 1.1.12, published 2025-12-28. — [pub.dev](https://pub.dev/packages/flutter_audio_capture)
  - `audio_session` 0.2.4 (2026-06-29). — [pub.dev](https://pub.dev/packages/audio_session)
  - RN: `react-native-audio-api` 0.13.6 (active). `react-native-live-audio-stream` 1.1.1 was last published 2021, so it is abandoned. — [npm react-native-audio-api](https://www.npmjs.com/package/react-native-audio-api); [npm react-native-live-audio-stream](https://www.npmjs.com/package/react-native-live-audio-stream)

### Inferences
- Implement the DSP as a portable C/C++ library (`breathdsp`) with a pure-function API: `init(cfg)`, `push(float* pcm, n, ts)`, `poll(events*)`. Build it for iOS (XCFramework) and Android (NDK).
  - Flutter binds it via `dart:ffi` (or `ffigen`) and a native capture shim.
  - RN binds it via a Nitro/TurboModule.
  - KMP binds it via cinterop/JNI.
  - This keeps DSP identical across stacks and unit-testable with recorded fixtures. Fixtures come from consented lab sessions only, never from production users.
- Unit-test with synthetic signals (pink noise bursts of known duration, speech clips, ambient noise beds) and assert onset/offset errors below 50 ms at SNR ≥12 dB.

### Gaps
- I did not verify whether `flutter_audio_capture` or `mic_stream` expose iOS `.measurement` mode or Android `UNPROCESSED`.

---

## Q7. Security and privacy architecture (on-device processing, analytics, crash reporting, SBOM, OWASP MASVS v2)

### Takeaway
- Map controls to OWASP MASVS v2 groups STORAGE, CRYPTO, AUTH, NETWORK, PLATFORM, CODE, RESILIENCE and PRIVACY. For this app the key ones are:
  - STORAGE-1/2: encrypted DB, backup exclusion, no logs or PHI leakage.
  - CRYPTO-1/2: AES-256 via SQLCipher/SQLite3MC; Keychain/Keystore key management.
  - PRIVACY-1..4: minimization, unlinkability, transparency, user control.
- Combine this with Apple HealthKit/App Review 5.1.3 rules, the Play Health apps declaration and Data safety, Apple `PrivacyInfo.xcprivacy`, and SBOM/attestation from dependencies (sqlite3 ships CycloneDX + SLSA L3).

### Cited Findings
- MASVS-STORAGE:
  - STORAGE-1 "The app securely stores sensitive data."
  - STORAGE-2 "The app prevents leakage of sensitive data", which covers unintentional leaks via "backups or logs".
  - [MASVS-STORAGE-1](https://github.com/OWASP/masvs/blob/master/controls/MASVS-STORAGE-1.md); [MASVS-STORAGE-2](https://github.com/OWASP/masvs/blob/master/controls/MASVS-STORAGE-2.md); [MASVS-STORAGE](https://github.com/OWASP/masvs/blob/master/Document/05-MASVS-STORAGE.md)
- MASVS-CRYPTO:
  - CRYPTO-1 "The app employs current strong cryptography and uses it according to industry best practices."
  - CRYPTO-2 "The app performs key management according to industry best practices." It references NIST SP 800-175B and SP 800-57.
  - [MASVS-CRYPTO-1](https://github.com/OWASP/masvs/blob/master/controls/MASVS-CRYPTO-1.md); [MASVS-CRYPTO-2](https://github.com/OWASP/masvs/blob/master/controls/MASVS-CRYPTO-2.md); [MASVS-CRYPTO](https://github.com/OWASP/masvs/blob/master/Document/06-MASVS-CRYPTO.md)
- MASVS-PRIVACY:
  - PRIVACY-1 "The app minimizes access to sensitive data and resources."
  - PRIVACY-2 "The app prevents identification of the user."
  - PRIVACY-3 "The app is transparent about data collection and usage."
  - PRIVACY-4 "The app offers user control over their data."
  - It is explicitly not a substitute for a GDPR DPIA.
  - [MASVS-PRIVACY](https://github.com/OWASP/masvs/blob/master/Document/12-MASVS-PRIVACY.md); controls [1](https://github.com/OWASP/masvs/blob/master/controls/MASVS-PRIVACY-1.md), [2](https://github.com/OWASP/masvs/blob/master/controls/MASVS-PRIVACY-2.md), [3](https://github.com/OWASP/masvs/blob/master/controls/MASVS-PRIVACY-3.md), [4](https://github.com/OWASP/masvs/blob/master/controls/MASVS-PRIVACY-4.md)
- Apple privacy manifest: `PrivacyInfo.xcprivacy` records the data types collected and the required-reason APIs used, for the app and third-party SDKs. SDKs on Apple's list need a manifest and signature. — [Apple: Privacy manifest files](https://developer.apple.com/documentation/bundleresources/privacy-manifest-files)
- HealthKit data must not be used for ads, sold to brokers, or disclosed to third parties without express permission, and then only to health/fitness services. Research sharing requires consent. — [Apple: Protecting user privacy](https://developer.apple.com/documentation/healthkit/protecting-user-privacy)
- Play: Data safety section plus the Health apps declaration; request only data types that support user-facing features. — [Health Connect publish](https://developer.android.com/health-and-fitness/health-connect/publish)
- Dependency supply chain: the `sqlite3` native binaries have SLSA L3 provenance and CycloneDX SBOMs. "Dart dependencies should be reconstructed from pubspec locks." — [sqlite3 hook.md](https://github.com/simolus3/sqlite3.dart/blob/main/sqlite3/doc/hook.md)
- Silero VAD advertises "no telemetry, no keys, no registration", which suits on-device use. — [silero-vad](https://github.com/snakers4/silero-vad)
- Crash reporting: `sentry_flutter` is at 10.1.0 (2026-10-15). — [pub.dev sentry_flutter](https://pub.dev/packages/sentry_flutter)

### Inferences
**Architecture principles**
1. All inference (risk model, phenotype scoring, DSP) runs on-device. The network is used only for optional E2E backup, model/content downloads (signed and SHA-256-pinned in `model_versions`), and opt-in telemetry.
2. **Analytics:** no third-party analytics SDK by default.
   - If product metrics are needed, use an opt-in, first-party, aggregate-only event counter with coarse buckets: daily counts and app version, with no free text, health values, timestamps finer than a day, or stable device IDs.
   - Rotate a random install ID monthly (MASVS-PRIVACY-2).
   - HealthKit-derived values must never enter analytics (5.1.3).
3. **Crash reporting:** opt-in.
   - Turn off default PII and screenshots/view hierarchy.
   - Scrub breadcrumbs and DB paths, and never attach logs containing user content.
   - Self-host or use EU data residency for GDPR.
   - Strip `extra` fields in a `beforeSend` hook.
4. **Logging:** release builds log no PHI. Add a lint rule banning `print`/`debugPrint` of model or DB objects (MASVS-STORAGE-2).
5. **Transport:** TLS 1.2+ with certificate pinning only for backup and model endpoints (MASVS-NETWORK). Use App Attest / Play Integrity to protect the backup API from abuse, not as a user-tracking device.
6. **SBOM:** generate CycloneDX for Dart (from `pubspec.lock`), plus CocoaPods/SPM and Gradle. Attach the sqlite3 and Rive native SBOMs. Run `gh attestation verify` on native SQLite binaries in CI. Keep a vulnerability scan (OSV) gate in CI.
7. **Privacy UX (MASVS-PRIVACY-3/4):**
   - Just-in-time permission prompts with plain-language purpose (HealthKit/HC, mic, location, notifications).
   - An in-app privacy dashboard showing which sources are connected and their last sync.
   - One-tap disconnect per source.
   - Export (JSON/CSV, decrypted locally) and delete-everything (crypto-shred, Q2).
   - A consent log table.
   - Re-consent on policy-version change.
8. **Threat model priorities:**
   - lost or stolen device (encrypted DB plus Keychain/Keystore, with `ThisDeviceOnly` keys);
   - shared device / shoulder surfing (optional app lock with biometrics; notification content set to "private" — no "You smoked 3 cigarettes" on the lock screen);
   - backups (excluded);
   - malicious SDKs (minimize dependencies; review privacy manifests);
   - rooted or jailbroken devices: best-effort detection only (MASVS-RESILIENCE is optional for this risk profile).

### Gaps
- mas.owasp.org was unreachable, so I could not confirm the exact current MASVS release number (v2.x) or the full MASTG test IDs for each control. Control texts were taken from the official GitHub repository.
- I did not verify Sentry's current Flutter PII-default options (`sendDefaultPii`, screenshot/view-hierarchy attachments) against Sentry docs (blocked).
- I did not fetch an EU-specific privacy authority source (e.g., EDPB guidance on health apps).
