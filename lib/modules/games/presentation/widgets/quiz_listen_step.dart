import '../../../../core/utils/app_imports.dart';
import 'quiz_sound_buttons.dart';

/// Question 1: hear the letter, then pick its shape from two cards.
class QuizListenStep extends StatelessWidget {
  const QuizListenStep({
    super.key,
    required this.options,
    required this.selectedOptionId,
    required this.correctId,
    required this.onPlay,
    required this.onPlaySlowly,
    required this.onSelect,
    this.audioUnavailable = false,
  });

  final List<LessonEntity> options;
  final String? selectedOptionId;
  final String correctId;

  /// True when the device has no Arabic voice, so the buttons stay silent.
  final bool audioUnavailable;
  final VoidCallback onPlay;
  final VoidCallback onPlaySlowly;
  final ValueChanged<LessonEntity> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppDimensions.spaceLg),
        Text('Listen and choose', style: AppTextStyles.headingMedium),
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
            for (final option in options) ...[
              Expanded(
                child: _OptionCard(
                  option: option,
                  isSelected: option.id == selectedOptionId,
                  isCorrect: option.id == correctId,
                  onTap: () => onSelect(option),
                ),
              ),
              if (option != options.last)
                const SizedBox(width: AppDimensions.spaceMd),
            ],
          ],
        ),
      ],
    );
  }
}

class _OptionCard extends StatelessWidget {
  const _OptionCard({
    required this.option,
    required this.isSelected,
    required this.isCorrect,
    required this.onTap,
  });

  final LessonEntity option;
  final bool isSelected;
  final bool isCorrect;
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
        height: AppDimensions.quizOptionHeight,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          border: Border.all(
            color: borderColor,
            width: isSelected
                ? AppDimensions.neoBorderWidth
                : AppDimensions.borderWidth,
          ),
        ),
        child: Center(
          child: Text(
            option.glyph,
            style: TextStyle(
              fontSize: AppDimensions.quizGlyphSize,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
