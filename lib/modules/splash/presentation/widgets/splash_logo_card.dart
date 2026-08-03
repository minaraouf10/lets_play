import '../../../../core/utils/app_imports.dart';


/// The resting frame after the GIF finishes — shown for a fixed duration
/// (see [SplashCubit.logoDuration]) before auto-advancing to Login.
class SplashLogoCard extends StatelessWidget {
  const SplashLogoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.splashRed,
      child: SizedBox.expand(
        child: Center(
          child: SvgPicture.asset(
            AppAssets.splashLogo,
            width: AppDimensions.splashLogoWidth,
          ),
        ),
      ),
    );
  }
}
