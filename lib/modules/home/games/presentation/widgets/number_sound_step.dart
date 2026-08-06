import '../../../../../core/utils/app_imports.dart';
import '../../data/datasources/number_data.dart';
import 'assembled_letter_bricks.dart';
import 'game_top_bar.dart';
import 'quiz_continue_button.dart';
import 'word_speaker_button.dart';

/// Final review step for a number lesson: the number in bricks, a speaker
/// button that pronounces it, and a banner with its Arabic word and English
/// meaning. Numbers have no positional forms, so this replaces the letter
/// forms card that ends the Level 1 review.
class NumberSoundStep extends StatelessWidget {
  const NumberSoundStep({
    super.key,
    required this.puzzle,
    required this.lesson,
    required this.hearts,
    required this.progress,
    required this.audioUnavailable,
    required this.onPlay,
    required this.onContinue,
  });

  final LetterPuzzle puzzle;
  final NumberLesson lesson;
  final int hearts;
  final double progress;

  /// True when the device has no Arabic voice, so the button stays silent.
  final bool audioUnavailable;
  final VoidCallback onPlay;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceMd),
          child: Column(
            children: [
              GameTopBar(
                hearts: hearts,
                progress: progress,
                heartsLeading: true,
                onClose: () => context.pop(),
              ),
              Expanded(child: AssembledLetterBricks.puzzle(puzzle)),
              const SizedBox(height: AppDimensions.spaceLg),
              WordSpeakerButton(
                onPressed: onPlay,
                size: AppDimensions.wordCardSpeakerSize * 2,
              ),
              if (audioUnavailable) ...[
                const SizedBox(height: AppDimensions.spaceSm),
                Text(
                  'No Arabic voice installed on this device.\n'
                  'Settings > Accessibility > Text-to-speech',
                  textAlign: TextAlign.center,
                  style:
                      AppTextStyles.bodySmall.copyWith(color: AppColors.error),
                ),
              ],
              const SizedBox(height: AppDimensions.spaceLg),
              _MeaningBanner(lesson: lesson),
              const SizedBox(height: AppDimensions.spaceLg),
              QuizContinueButton(enabled: true, onPressed: onContinue),
            ],
          ),
        ),
      ),
    );
  }
}

/// Blue neo-brutalist banner: the number's Arabic word over its English
/// meaning.
class _MeaningBanner extends StatelessWidget {
  const _MeaningBanner({required this.lesson});

  final NumberLesson lesson;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spaceMd),
      decoration: BoxDecoration(
        color: AppColors.levelNumbers,
        border: Border.all(
          color: AppColors.ink,
          width: AppDimensions.neoBorderWidth,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.ink,
            offset: Offset(
              AppDimensions.neoShadowOffset,
              AppDimensions.neoShadowOffset,
            ),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            lesson.wordAr,
            textDirection: TextDirection.rtl,
            style: AppTextStyles.headingLarge.copyWith(
              color: AppColors.textOnColor,
            ),
          ),
          Text(
            lesson.meaningEn,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textOnColor,
            ),
          ),
        ],
      ),
    );
  }
}
