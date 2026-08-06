import '../../../../../core/utils/app_imports.dart';

/// White neo-brutalist header card showing the letter's display name, used
/// across every step of the post-game letter review flow.
///
/// Number lessons also pass [arabicWord], which is shown on the trailing edge
/// so the card reads "Wahed … واحد".
class LetterReviewCard extends StatelessWidget {
  const LetterReviewCard({
    super.key,
    required this.letterName,
    this.arabicWord,
  });

  final String letterName;

  /// The Arabic spelling shown opposite [letterName]; omitted for letters.
  final String? arabicWord;

  @override
  Widget build(BuildContext context) {
    final word = arabicWord;

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
      child: word == null
          ? Text(
              letterName,
              textAlign: TextAlign.center,
              style: AppTextStyles.headingMedium.copyWith(
                color: AppColors.loginBackground,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  letterName,
                  style: AppTextStyles.headingMedium.copyWith(
                    color: AppColors.loginBackground,
                  ),
                ),
                Text(
                  word,
                  textDirection: TextDirection.rtl,
                  style: AppTextStyles.headingMedium.copyWith(
                    color: AppColors.loginBackground,
                  ),
                ),
              ],
            ),
    );
  }
}
