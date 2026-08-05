import 'package:equatable/equatable.dart';

import 'word_option.dart';

/// The full 4-step content bundle for one word lesson.
///
/// Each step has its own correct answer id — screen 4's answer is not the
/// lesson's [targetWord] (e.g. target is "أب" but the image step asks for
/// "أسد"), so correctness is always looked up explicitly rather than
/// derived from a single "the target word" rule.
class WordLesson extends Equatable {
  WordLesson({
    required this.lessonId,
    required this.targetWord,
    required this.illustration,
    required this.audioOptions,
    required this.textOptions,
    required this.imagePromptWord,
    required this.imageOptions,
    required this.correctAudioOptionId,
    required this.correctTextOptionId,
    required this.correctImageOptionId,
  }) : assert(
          imageOptions.every((o) => o.imageAsset != null),
          'Every image-step option must have an imageAsset.',
        );

  final String lessonId;

  /// The word taught on steps 1–3 (spoken and matched by sound/text).
  final String targetWord;

  /// Shown on steps 1 and 2.
  final String illustration;

  /// Step 2: 3 speaker+word cards.
  final List<WordOption> audioOptions;

  /// Step 3: 2 large text cards.
  final List<WordOption> textOptions;

  /// The word shown in the step-4 banner.
  final String imagePromptWord;

  /// Step 4: 2 image cards, all guaranteed to carry an [WordOption.imageAsset].
  final List<WordOption> imageOptions;

  final String correctAudioOptionId;
  final String correctTextOptionId;
  final String correctImageOptionId;

  @override
  List<Object?> get props => [
        lessonId,
        targetWord,
        illustration,
        audioOptions,
        textOptions,
        imagePromptWord,
        imageOptions,
        correctAudioOptionId,
        correctTextOptionId,
        correctImageOptionId,
      ];
}
