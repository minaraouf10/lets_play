/// Spoken Arabic name for each letter, keyed by lessonId.
///
/// Text-to-speech engines usually skip a bare letter character (e.g. "أ"),
/// so the quiz speaks the letter's *name* instead — which is also what the
/// child is meant to learn.
const Map<String, String> kSpokenLetterNames = {
  'l1_alef': 'أَلِف',
  'l1_ba': 'بَاء',
  'l1_ta': 'تَاء',
  'l1_tha': 'ثَاء',
  'l1_jeem': 'جِيم',

  // Level 2 (Tashkeel) — spoken as the mark's name, not the carrier letter.
  'l2_fatha': 'فَتْحَة',
};

/// The text to pronounce for [lessonId], falling back to [glyph] when the
/// lesson has no name recorded yet.
String spokenLetterFor(String lessonId, String glyph) =>
    kSpokenLetterNames[lessonId] ?? glyph;

/// Latin display name for each lesson, shown as the review/quiz screen title.
const Map<String, String> kDisplayLetterNames = {
  'l1_alef': 'Alef',
  'l1_ba': 'Baa',
  'l1_ta': 'Taa',
  'l1_tha': 'Thaa',
  'l1_jeem': 'Jeem',
  'l2_fatha': 'Fat-hah',
};

/// The title to show for [lessonId], falling back to 'Letter' when the lesson
/// has no display name recorded yet.
String displayLetterNameFor(String lessonId) =>
    kDisplayLetterNames[lessonId] ?? 'Letter';
