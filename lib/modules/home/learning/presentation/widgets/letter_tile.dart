import '../../../../../core/utils/app_imports.dart';


/// One cell in the letter/lesson grid.
/// Unlocked: solid level color, black neo-brutalist border + hard shadow.
/// Locked: flat neutral grey, no border, dimmed text.
class LetterTile extends StatelessWidget {
  const LetterTile({
    super.key,
    required this.lesson,
    required this.accentColor,
    required this.onAccentColor,
    this.onTap,
  });

  final LessonEntity lesson;
  final Color accentColor;
  final Color onAccentColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final unlocked = lesson.isUnlocked;
    final textColor = unlocked ? onAccentColor : AppColors.textSecondary;
    return InkWell(
      onTap: unlocked ? onTap : null,
      borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
      child: Container(
        decoration: BoxDecoration(
          color: unlocked ? accentColor : AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
          border: unlocked
              ? Border.all(
                  color: AppColors.ink,
                  width: AppDimensions.neoBorderWidthSm,
                )
              : null,
          boxShadow: unlocked
              ? const [
                  BoxShadow(
                    color: AppColors.ink,
                    offset: Offset(
                      AppDimensions.neoShadowOffsetSm,
                      AppDimensions.neoShadowOffsetSm,
                    ),
                  ),
                ]
              : null,
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                lesson.glyph,
                textDirection: TextDirection.rtl,
                style: AppTextStyles.letterGlyph.copyWith(color: textColor),
              ),
              Text(
                lesson.transliteration,
                // Latin, so it keeps its own direction inside the RTL grid.
                textDirection: TextDirection.ltr,
                style: AppTextStyles.letterHint.copyWith(color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
