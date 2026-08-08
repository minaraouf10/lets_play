import '../../../../../../core/utils/app_imports.dart';
import '../../../data/datasources/letter_forms_data.dart';

/// Stage tabs above the canvas, one per positional form of the letter being
/// built. Each tab is written with the form it stands for — أ, ـا, ـا — so
/// the child sees the shape named while assembling it.
// TODO(product): `completed` is a fixed placeholder; wire it to real
// per-stage progress once multi-stage lessons are defined.
class GameStageBricks extends StatelessWidget {
  const GameStageBricks({
    super.key,
    required this.lessonId,
    this.completed = 1,
  });

  final String lessonId;
  final int completed;

  @override
  Widget build(BuildContext context) {
    final forms = kLetterForms[lessonId] ?? const [];
    if (forms.isEmpty) return const SizedBox.shrink();

    return Directionality(
      // Arabic reads right to left, so the initial form sits on the right.
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < forms.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spaceXs,
              ),
              child: Container(
                width: AppDimensions.gameStageBrickWidth,
                height: AppDimensions.gameStageBrickHeight,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color:
                      i < completed ? AppColors.success : AppColors.brickGrey,
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radiusSm / 2,
                  ),
                  border: Border.all(
                    color: AppColors.ink,
                    width: AppDimensions.neoBorderWidthSm,
                  ),
                ),
                child: Text(
                  forms[i].glyph,
                  style: AppTextStyles.letterGlyph.copyWith(
                    color: i < completed
                        ? AppColors.textOnColor
                        : AppColors.textPrimary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
