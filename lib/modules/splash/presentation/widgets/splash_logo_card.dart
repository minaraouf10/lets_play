import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_colors.dart';

/// The build-up animation's resting frame. Stays on screen — tap anywhere
/// to continue to Login (see [onTap]).
class SplashLogoCard extends StatelessWidget {
  const SplashLogoCard({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: ColoredBox(
        color: AppColors.splashRed,
        child: SizedBox.expand(
          child: Center(
            child: SvgPicture.asset(
              AppAssets.splashLogo,
              width: AppDimensions.splashLogoWidth,
            ),
          ),
        ),
      ),
    );
  }
}
