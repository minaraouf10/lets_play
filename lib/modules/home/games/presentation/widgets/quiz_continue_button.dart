import '../../../../../core/utils/app_imports.dart';

/// Full-width CONTINUE button that stays greyed out until the current
/// question has been answered correctly.
class QuizContinueButton extends StatelessWidget {
  const QuizContinueButton({
    super.key,
    required this.enabled,
    required this.onPressed,
  });

  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.buttonHeight,
      child: OutlinedButton(
        onPressed: enabled ? onPressed : null,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.surface,
          disabledBackgroundColor: AppColors.surface,
          side: BorderSide(
            color: enabled ? AppColors.ink : AppColors.border,
            width: AppDimensions.neoBorderWidthSm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
          ),
        ),
        child: Text(
          'CONTINUE',
          style: AppTextStyles.button.copyWith(
            color: enabled ? AppColors.textPrimary : AppColors.textSecondary,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}
