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
};

/// The text to pronounce for [lessonId], falling back to [glyph] when the
/// lesson has no name recorded yet.
String spokenLetterFor(String lessonId, String glyph) =>
    kSpokenLetterNames[lessonId] ?? glyph;
