import '../../../../core/utils/app_imports.dart';
import 'assembled_letter_bricks.dart';
import 'letter_review_card.dart';
import 'letter_review_continue_button.dart';

/// Review step 2: shows the letter assembled from its puzzle bricks.
class LetterBricksStep extends StatelessWidget {
  const LetterBricksStep({
    super.key,
    required this.letterName,
    required this.puzzle,
    required this.onContinue,
  });

  final String letterName;
  final LetterPuzzle puzzle;
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
              Expanded(child: AssembledLetterBricks.puzzle(puzzle)),
              const SizedBox(height: AppDimensions.spaceLg),
              LetterReviewContinueButton(onPressed: onContinue),
            ],
          ),
        ),
      ),
    );
  }
}
