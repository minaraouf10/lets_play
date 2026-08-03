import '../../../../core/utils/app_imports.dart';

/// Question 2: a red card claims a letter means something — answer true/false.
class QuizStatementStep extends StatelessWidget {
  const QuizStatementStep({
    super.key,
    required this.statementLetter,
    required this.claimName,
    required this.answer,
    required this.isCorrect,
    required this.onAnswer,
  });

  final LessonEntity statementLetter;

  /// The name the card claims this letter means, e.g. "Alif".
  final String claimName;
  final bool? answer;
  final bool isCorrect;
  final ValueChanged<bool> onAnswer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppDimensions.spaceMd),
        Text('Choose the correct answer', style: AppTextStyles.headingMedium),
        const SizedBox(height: AppDimensions.spaceLg),
        Expanded(
          child: Center(
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.accentPink,
                  border: Border.all(
                    color: AppColors.ink,
                    width: AppDimensions.neoBorderWidth,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      statementLetter.glyph,
                      style: const TextStyle(
                        fontSize: AppDimensions.quizStatementGlyphSize,
                        color: AppColors.textOnColor,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spaceMd),
                    Text(
                      'Means "$claimName"',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textOnColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceMd),
        Row(
          children: [
            Expanded(
              child: _AnswerButton(
                label: 'True',
                isSelected: answer == true,
                isRight: isCorrect,
                onPressed: () => onAnswer(true),
              ),
            ),
            const SizedBox(width: AppDimensions.spaceMd),
            Expanded(
              child: _AnswerButton(
                label: 'False',
                isSelected: answer == false,
                isRight: isCorrect,
                onPressed: () => onAnswer(false),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _AnswerButton extends StatelessWidget {
  const _AnswerButton({
    required this.label,
    required this.isSelected,
    required this.isRight,
    required this.onPressed,
  });

  final String label;
  final bool isSelected;
  final bool isRight;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final borderColor = !isSelected
        ? AppColors.border
        : isRight
            ? AppColors.success
            : AppColors.error;

    return SizedBox(
      height: AppDimensions.optionRowHeight,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.surface,
          side: BorderSide(
            color: borderColor,
            width: isSelected
                ? AppDimensions.neoBorderWidth
                : AppDimensions.borderWidth,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary),
        ),
      ),
    );
  }
}
