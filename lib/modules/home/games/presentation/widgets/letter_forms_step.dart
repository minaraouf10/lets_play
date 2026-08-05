import '../../../../../core/utils/app_imports.dart';
import '../../data/datasources/letter_forms_data.dart';
import 'letter_form_tile.dart';
import 'letter_review_continue_button.dart';

/// Review step 3: the letter's positional forms, each drawn from bricks.
class LetterFormsStep extends StatelessWidget {
  const LetterFormsStep({
    super.key,
    required this.letterName,
    required this.lessonId,
    required this.onContinue,
  });

  final String letterName;
  final String lessonId;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final forms = kLetterForms[lessonId] ?? const [];

    return ColoredBox(
      color: AppColors.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceMd),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.close, color: AppColors.ink),
                  onPressed: () => context.pop(),
                ),
              ),
              _HeaderCard(letterName: letterName),
              const SizedBox(height: AppDimensions.spaceLg),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: AppDimensions.spaceLg,
                  crossAxisSpacing: AppDimensions.spaceLg,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    for (final form in forms) LetterFormTile(form: form),
                  ],
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

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.letterName});

  final String letterName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spaceXl,
        vertical: AppDimensions.spaceSm,
      ),
      decoration: BoxDecoration(
        color: AppColors.splashYellow,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
        border: Border.all(
          color: AppColors.ink,
          width: AppDimensions.neoBorderWidth,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(letterName, style: AppTextStyles.headingMedium),
          Text('Letter Forms', style: AppTextStyles.bodyLarge),
        ],
      ),
    );
  }
}
