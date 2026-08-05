import '../../../../../core/utils/app_imports.dart';
import '../../domain/entities/word_lesson.dart';
import '../../domain/entities/word_option.dart';
import 'word_audio_option_card.dart';

/// Screen 2: pick the word matching the illustration by listening.
class WordAudioOptionsStep extends StatelessWidget {
  const WordAudioOptionsStep({
    super.key,
    required this.lesson,
    required this.selectedOptionId,
    required this.onPlay,
    required this.onSelect,
  });

  final WordLesson lesson;
  final String? selectedOptionId;
  final ValueChanged<WordOption> onPlay;
  final ValueChanged<WordOption> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppDimensions.spaceLg),
        Text('Choose the correct answer', style: AppTextStyles.headingMedium),
        const SizedBox(height: AppDimensions.spaceXl),
        SizedBox(
          height: AppDimensions.wordIllustrationHeight,
          child: SvgPicture.asset(lesson.illustration, fit: BoxFit.contain),
        ),
        const SizedBox(height: AppDimensions.spaceXl),
        Row(
          children: [
            for (final option in lesson.audioOptions) ...[
              Expanded(
                child: WordAudioOptionCard(
                  option: option,
                  isSelected: option.id == selectedOptionId,
                  isCorrect: option.id == lesson.correctAudioOptionId,
                  onPlay: () => onPlay(option),
                  onTap: () => onSelect(option),
                ),
              ),
              if (option != lesson.audioOptions.last)
                const SizedBox(width: AppDimensions.spaceSm),
            ],
          ],
        ),
      ],
    );
  }
}
