/// Non-visual, app-wide constants.
///
/// Keep secrets OUT of here — they belong in `.env` (see `.env.example`)
/// and are injected at build/runtime.
class AppConstants {
  const AppConstants._();

  static const String appName = "Let's Play!";
  static const String appNameAr = 'يلا نلعب';

  /// Lesson the prototype drops the user into after onboarding.
  static const String firstLessonId = 'l1_alef';

  // Firestore collections (single source of truth for collection names).
  static const String usersCollection = 'users';
  static const String progressCollection = 'progress';
  static const String levelsCollection = 'levels';

  // Firebase Storage buckets/paths.
  static const String userRecordingsPath = 'recordings';

  // Networking timeouts (ms) — used later for Azure Speech / NLP endpoints.
  static const int connectTimeoutMs = 20000;
  static const int receiveTimeoutMs = 20000;
}
