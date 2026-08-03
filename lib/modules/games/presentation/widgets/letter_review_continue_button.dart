import '../../../../core/utils/app_imports.dart';

/// Full-width neo-brutalist CONTINUE button shared by every step of the
/// post-game letter review flow.
class LetterReviewContinueButton extends StatelessWidget {
  const LetterReviewContinueButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.buttonHeight,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.background,
          side: const BorderSide(
            color: AppColors.ink,
            width: AppDimensions.neoBorderWidth,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          ),
        ),
        child: Text(
          'CONTINUE',
          style: AppTextStyles.button.copyWith(color: AppColors.textPrimary),
        ),
      ),
    );
  }
}
