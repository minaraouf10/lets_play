import '../../../../../core/utils/app_imports.dart';
import 'assembled_letter_bricks.dart';

/// One positional form: its brick drawing above a yellow neo-brutalist label.
// TODO(product): the label is display-only; wire it to a form-practice screen
// once that flow is designed.
class LetterFormTile extends StatelessWidget {
  const LetterFormTile({super.key, required this.form});

  final LetterForm form;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AssembledLetterBricks(
            bricks: form.bricks,
            rows: form.rows,
            cols: form.cols,
          ),
        ),
        const SizedBox(height: AppDimensions.spaceSm),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spaceMd,
            vertical: AppDimensions.spaceXs,
          ),
          decoration: BoxDecoration(
            color: AppColors.splashYellow,
            borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
            border: Border.all(
              color: AppColors.ink,
              width: AppDimensions.neoBorderWidthSm,
            ),
          ),
          child: Text(form.label, style: AppTextStyles.cardTitle),
        ),
      ],
    );
  }
}
