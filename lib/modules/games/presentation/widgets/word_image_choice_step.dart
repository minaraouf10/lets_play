import '../../../../core/utils/app_imports.dart';
import '../../domain/entities/word_lesson.dart';
import '../../domain/entities/word_option.dart';
import 'word_image_option_card.dart';
import 'word_speaker_button.dart';

/// Screen 4: hear the prompt word, then pick the matching picture.
class WordImageChoiceStep extends StatelessWidget {
  const WordImageChoiceStep({
    super.key,
    required this.lesson,
    required this.selectedOptionId,
    required this.onPlay,
    required this.onSelect,
  });

  final WordLesson lesson;
  final String? selectedOptionId;
  final VoidCallback onPlay;
  final ValueChanged<WordOption> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppDimensions.spaceMd),
        Container(
          width: double.infinity,
          height: AppDimensions.wordBannerHeight,
          decoration: BoxDecoration(
            color: AppColors.wordBanner,
            borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
            border: Border.all(color: AppColors.ink, width: AppDimensions.neoBorderWidth),
            boxShadow: const [
              BoxShadow(
                color: AppColors.ink,
                offset: Offset(AppDimensions.neoShadowOffset, AppDimensions.neoShadowOffset),
              ),
            ],
          ),
          child: Center(
            child: Text(lesson.imagePromptWord, style: AppTextStyles.wordBannerGlyph),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceMd),
        WordSpeakerButton(onPressed: onPlay),
        const SizedBox(height: AppDimensions.spaceXl),
        Row(
          children: [
            for (final option in lesson.imageOptions) ...[
              Expanded(
                child: WordImageOptionCard(
                  option: option,
                  isSelected: option.id == selectedOptionId,
                  isCorrect: option.id == lesson.correctImageOptionId,
                  onTap: () => onSelect(option),
                ),
              ),
              if (option != lesson.imageOptions.last)
                const SizedBox(width: AppDimensions.spaceMd),
            ],
          ],
        ),
      ],
    );
  }
}
