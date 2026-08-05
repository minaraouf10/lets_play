import '../../../../../core/constants/app_assets.dart';
import '../../domain/entities/tashkeel_sample.dart';
import '../../domain/entities/tashkeel_word.dart';

/// The carrier letters each tashkeel lesson walks through, keyed by lessonId.
///
/// The mark is the lesson; the carriers are just vehicles for showing it, so
/// adding a new tashkeel lesson is a data change only.
const Map<String, List<TashkeelSample>> kTashkeelSamples = {
  'l2_fatha': [
    TashkeelSample(
      glyph: 'كَ',
      carrierName: 'KAF',
      syllable: 'Ka',
      spoken: 'كَ',
    ),
    TashkeelSample(
      glyph: 'لَ',
      carrierName: "LAM'",
      syllable: 'La',
      spoken: 'لَ',
    ),
    TashkeelSample(
      glyph: 'تَ',
      carrierName: "TA'",
      syllable: 'Ta',
      spoken: 'تَ',
    ),
  ],
};

/// The whole word each tashkeel lesson teaches after its carrier letters.
///
/// The word is heard and repeated first, then rebuilt by dragging the missing
/// piece back into place.
const Map<String, TashkeelWord> kTashkeelWords = {
  'l2_fatha': TashkeelWord(
    word: 'أَكَلَ',
    meaning: 'Ate',
    illustration: AppAssets.fathersImage,
    // Displayed right-to-left, so 'أَ' is the rightmost piece.
    pieces: ['أَ', 'كَ', 'لَ'],
    missingIndex: 1,
    distractors: ['كِ', 'كُ'],
  ),
};

/// The two shapes offered on the "match the mark to its shape" step: the mark
/// drawn above the line and the same mark drawn below it. Only one is right,
/// and which one depends on the mark.
const Map<String, bool> kTashkeelSitsAbove = {
  'l2_fatha': true,
  'l2_damma': true,
  'l2_kasra': false,
};

/// The short vowel each mark adds, used in the "KAF+a= Ka" equation.
const Map<String, String> kTashkeelVowels = {
  'l2_fatha': 'a',
  'l2_kasra': 'i',
  'l2_damma': 'u',
};

/// Display name of the mark itself, e.g. "Fatha".
const Map<String, String> kTashkeelMarkNames = {
  'l2_fatha': 'Fatha',
  'l2_kasra': 'Kasra',
  'l2_damma': 'Damma',
};

/// True when [lessonId] is a tashkeel lesson with sample data.
bool isTashkeelLesson(String lessonId) =>
    kTashkeelSamples.containsKey(lessonId);

List<TashkeelSample> tashkeelSamplesFor(String lessonId) =>
    kTashkeelSamples[lessonId] ?? const [];

String tashkeelVowelFor(String lessonId) => kTashkeelVowels[lessonId] ?? 'a';

String tashkeelMarkNameFor(String lessonId) =>
    kTashkeelMarkNames[lessonId] ?? 'Tashkeel';

TashkeelWord? tashkeelWordFor(String lessonId) => kTashkeelWords[lessonId];

/// Whether this lesson's mark is written above the line (fatha, damma) or
/// below it (kasra).
bool tashkeelSitsAbove(String lessonId) =>
    kTashkeelSitsAbove[lessonId] ?? true;
