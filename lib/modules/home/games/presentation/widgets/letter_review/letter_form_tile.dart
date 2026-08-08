import '../../../../../../core/utils/app_imports.dart';
import '../puzzle/assembled_letter_bricks.dart';

/// One positional form: the written letter, its brick drawing, and the
/// position named in Arabic along the bottom.
// TODO(product): the tile is display-only; wire it to a form-practice screen
// once that flow is designed.
class LetterFormTile extends StatelessWidget {
  const LetterFormTile({super.key, required this.form});

  final LetterForm form;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.brickGrey,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      ),
      child: Column(
        children: [
          // How the letter is written in this position.
          Padding(
            padding: const EdgeInsets.only(top: AppDimensions.spaceSm),
            child: Text(form.glyph, style: AppTextStyles.letterGlyph),
          ),
          // The same shape built from bricks.
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spaceSm,
                vertical: AppDimensions.spaceXs,
              ),
              child: AssembledLetterBricks(
                bricks: form.bricks,
                rows: form.rows,
                cols: form.cols,
              ),
            ),
          ),
          // Position name, on the bar across the bottom of the card.
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spaceXs,
              vertical: AppDimensions.spaceXs,
            ),
            color: AppColors.slotOutline,
            child: Text(
              form.label,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.letterHint,
            ),
          ),
        ],
      ),
    );
  }
}
