import '../../../../core/utils/app_imports.dart';

/// White neo-brutalist header card showing the letter's display name, used
/// across every step of the post-game letter review flow.
class LetterReviewCard extends StatelessWidget {
  const LetterReviewCard({super.key, required this.letterName});

  final String letterName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.spaceMd),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
        border: Border.all(
          color: AppColors.ink,
          width: AppDimensions.neoBorderWidth,
        ),
      ),
      child: Text(
        letterName,
        textAlign: TextAlign.center,
        style: AppTextStyles.headingMedium.copyWith(
          color: AppColors.loginBackground,
        ),
      ),
    );
  }
}
