/// Level 3 (Numbers) lesson content.
///
/// Numbers reuse the Level 1 puzzle/trace machinery, but they have no
/// positional forms — so instead of a "letter forms" card the review flow
/// ends on a "listen and read" card showing the number's Arabic word and its
/// English meaning. Adding a number is a data change only.
class NumberLesson {
  const NumberLesson({
    required this.glyph,
    required this.wordAr,
    required this.transliteration,
    required this.meaningEn,
  });

  /// The digit itself, e.g. '١'.
  final String glyph;

  /// The number spelled out in Arabic, e.g. 'واحد'.
  final String wordAr;

  /// Latin reading of [wordAr], shown as the review/quiz screen title.
  final String transliteration;

  /// English meaning, e.g. 'One'.
  final String meaningEn;
}

const Map<String, NumberLesson> kNumberLessons = {
  'l3_one': NumberLesson(
    glyph: '١',
    wordAr: 'واحد',
    transliteration: 'Wahed',
    meaningEn: 'One',
  ),
};

/// True when [lessonId] is a number lesson with content recorded.
bool isNumberLesson(String lessonId) => kNumberLessons.containsKey(lessonId);

NumberLesson? numberLessonFor(String lessonId) => kNumberLessons[lessonId];
