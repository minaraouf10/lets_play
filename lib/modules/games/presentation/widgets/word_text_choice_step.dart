import '../../../../core/utils/app_imports.dart';
import '../../domain/entities/word_lesson.dart';
import '../../domain/entities/word_option.dart';
import 'quiz_sound_buttons.dart';
import 'word_text_choice_card.dart';

/// Screen 3: hear the word again, then pick it from two text cards.
class WordTextChoiceStep extends StatelessWidget {
  const WordTextChoiceStep({
    super.key,
    required this.lesson,
    required this.selectedOptionId,
    required this.audioUnavailable,
    required this.onPlay,
    required this.onPlaySlowly,
    required this.onSelect,
  });

  final WordLesson lesson;
  final String? selectedOptionId;
  final bool audioUnavailable;
  final VoidCallback onPlay;
  final VoidCallback onPlaySlowly;
  final ValueChanged<WordOption> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppDimensions.spaceLg),
        Text('Repeat what you heard', style: AppTextStyles.headingMedium),
        const SizedBox(height: AppDimensions.spaceXl),
        QuizSoundButtons(onPlay: onPlay, onPlaySlowly: onPlaySlowly),
        if (audioUnavailable) ...[
          const SizedBox(height: AppDimensions.spaceMd),
          Text(
            'No Arabic voice installed on this device.\n'
            'Settings > Accessibility > Text-to-speech',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
          ),
        ],
        const SizedBox(height: AppDimensions.spaceXxl),
        Row(
          children: [
            for (final option in lesson.textOptions) ...[
              Expanded(
                child: WordTextChoiceCard(
                  option: option,
                  isSelected: option.id == selectedOptionId,
                  isCorrect: option.id == lesson.correctTextOptionId,
                  onTap: () => onSelect(option),
                ),
              ),
              if (option != lesson.textOptions.last)
                const SizedBox(width: AppDimensions.spaceMd),
            ],
          ],
        ),
      ],
    );
  }
}
