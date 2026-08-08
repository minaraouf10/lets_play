import '../../../../../../core/utils/app_imports.dart';

/// One digit tile in the number quiz's option grids and rows.
///
/// Stays neutral until it is tapped, then turns green when it is the number
/// being taught and red when it is not — the same feedback the letter quiz
/// gives on its option cards.
class NumberOptionButton extends StatelessWidget {
  const NumberOptionButton({
    super.key,
    required this.glyph,
    required this.isSelected,
    required this.isCorrect,
    required this.onTap,
    this.width,
  });

  final String glyph;
  final bool isSelected;
  final bool isCorrect;
  final VoidCallback onTap;

  /// Fixed width for row layouts; null makes the tile square.
  final double? width;

  @override
  Widget build(BuildContext context) {
    final borderColor = !isSelected
        ? AppColors.border
        : isCorrect
            ? AppColors.success
            : AppColors.error;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? AppDimensions.numberOptionSize,
        height: AppDimensions.numberOptionSize,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
          border: Border.all(
            color: borderColor,
            width: isSelected
                ? AppDimensions.neoBorderWidth
                : AppDimensions.borderWidth,
          ),
        ),
        child: Center(
          child: Text(
            glyph,
            style: TextStyle(
              fontSize: AppDimensions.numberOptionGlyphSize,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
