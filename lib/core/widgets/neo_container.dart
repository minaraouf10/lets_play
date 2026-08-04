import '../utils/app_imports.dart';

/// A reusable neo-brutalist container: solid color + 2px ink border +
/// hard shadow at offset + radiusSm. Used by stat tiles, badges, and other
/// components across profile/leaderboard/achievements modules.
class NeoContainer extends StatelessWidget {
  const NeoContainer({
    super.key,
    required this.color,
    required this.child,
    this.padding = const EdgeInsets.all(AppDimensions.spaceMd),
    this.shadowOffset = const Offset(4, 4),
    this.onTap,
  });

  final Color color;
  final Widget child;
  final EdgeInsets padding;
  final Offset shadowOffset;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
          border: Border.all(
            color: AppColors.ink,
            width: AppDimensions.neoBorderWidth,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.ink,
              offset: shadowOffset,
              blurRadius: 0,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
