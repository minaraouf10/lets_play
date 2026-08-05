import '../../../../core/utils/app_imports.dart';

class CastleIllustration extends StatelessWidget {
  const CastleIllustration({super.key});

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
            child: Center(
              child:SvgPicture.asset(AppAssets.pointsIcon)
            ),
          );
        },
      ),
    );
  }
}
