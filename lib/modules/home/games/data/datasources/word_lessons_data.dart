import '../../../../../core/constants/app_assets.dart';
import '../../domain/entities/word_lesson.dart';
import '../../domain/entities/word_option.dart';

/// Static content for the word-lesson flow, keyed by lessonId.
///
/// Seeded with a single أب/أسد/حصان bundle. Every unlocked Level 4 lesson
/// opens this same content today — see [wordLessonFor].
final Map<String, WordLesson> kWordLessons = {
  'l4_fi': WordLesson(
    lessonId: 'l4_fi',
    targetWord: 'أب',
    illustration: AppAssets.fathersImage,
    audioOptions: const [
      WordOption(id: 'w_ab', word: 'أب'),
      WordOption(id: 'w_asad', word: 'أسد'),
      WordOption(id: 'w_hisan', word: 'حصان'),
    ],
    textOptions: const [
      WordOption(id: 'w_ab', word: 'أب'),
      WordOption(id: 'w_asad', word: 'أسد'),
    ],
    imagePromptWord: 'أسد',
    imageOptions: [
      WordOption(id: 'w_asad', word: 'أسد', imageAsset: AppAssets.lionImage),
      WordOption(id: 'w_ab', word: 'أب', imageAsset: AppAssets.fathersImage),
    ],
    correctAudioOptionId: 'w_ab',
    correctTextOptionId: 'w_ab',
    correctImageOptionId: 'w_asad',
  ),
};

/// The word lesson for [lessonId], falling back to the first defined
/// lesson so any Level 4 tile can reach this flow during the prototype.
WordLesson? wordLessonFor(String lessonId) {
  final lesson = kWordLessons[lessonId];
  if (lesson != null) return lesson;
  return kWordLessons.values.isEmpty ? null : kWordLessons.values.first;
}
