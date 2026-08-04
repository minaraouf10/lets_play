import '../../../../core/utils/app_imports.dart';
import 'letter_review_card.dart';
import 'letter_review_continue_button.dart';

/// Review step 1: shows the plain letter glyph on a blue background.
class LetterGlyphStep extends StatelessWidget {
  const LetterGlyphStep({
    super.key,
    required this.letterName,
    required this.glyph,
    required this.onContinue,
  });

  final String letterName;
  final String glyph;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.loginBackground,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceMd),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.close, color: AppColors.textOnColor),
                  onPressed: () => context.pop(),
                ),
              ),
              LetterReviewCard(letterName: letterName),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.spaceXl,
                    ),
                    child: FittedBox(
                      child: Text(
                        glyph,
                        style: AppTextStyles.headingLarge.copyWith(
                          color: AppColors.textOnColor,
                          fontSize: 300,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                'Press on the letter',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textOnColor,
                ),
              ),
              const SizedBox(height: AppDimensions.spaceLg),
              LetterReviewContinueButton(onPressed: onContinue),
            ],
          ),
        ),
      ),
    );
  }
}
