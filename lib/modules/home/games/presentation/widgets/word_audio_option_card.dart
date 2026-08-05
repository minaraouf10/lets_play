import '../../../../../core/utils/app_imports.dart';
import '../../domain/entities/word_option.dart';
import 'word_speaker_button.dart';

/// Step 2 card: a speaker icon plus the option's word. Tapping the speaker
/// plays the word; tapping elsewhere on the card selects it.
class WordAudioOptionCard extends StatelessWidget {
  const WordAudioOptionCard({
    super.key,
    required this.option,
    required this.isSelected,
    required this.isCorrect,
    required this.onPlay,
    required this.onTap,
  });

  final WordOption option;
  final bool isSelected;
  final bool isCorrect;
  final VoidCallback onPlay;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = !isSelected
        ? AppColors.border
        : isCorrect
            ? AppColors.success
            : AppColors.error;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppDimensions.wordAudioCardHeight,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          border: Border.all(
            color: borderColor,
            width: isSelected ? AppDimensions.neoBorderWidth : AppDimensions.borderWidth,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WordSpeakerButton(size: AppDimensions.wordCardSpeakerSize, onPressed: onPlay),
            const SizedBox(height: AppDimensions.spaceMd),
            Text(option.word, style: AppTextStyles.cardTitle),
          ],
        ),
      ),
    );
  }
}
