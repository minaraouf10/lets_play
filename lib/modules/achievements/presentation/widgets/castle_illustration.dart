import '../../../../core/utils/app_imports.dart';

class CastleIllustration extends StatelessWidget {
  const CastleIllustration();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.castleHeight,
      child: Image.asset(
        AppAssets.achievementsCastle,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return NeoContainer(
            color: AppColors.surface,
            child: const Center(
              child: Text(
                'Castle',
                style: AppTextStyles.bodyMedium,
              ),
            ),
          );
        },
      ),
    );
  }
}
