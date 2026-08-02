import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_colors.dart';

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
