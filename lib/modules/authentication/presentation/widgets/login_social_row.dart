import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_colors.dart';

class LoginSocialRow extends StatelessWidget {
  const LoginSocialRow({
    super.key,
    required this.onTwitterPressed,
    required this.onGooglePressed,
  });

  final VoidCallback onTwitterPressed;
  final VoidCallback onGooglePressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialButton(
          icon: Icons.flutter_dash, // Twitter / bird placeholder icon
          onPressed: onTwitterPressed,
        ),
        const SizedBox(width: AppDimensions.spaceLg),
        _SocialButton(
          icon: Icons.g_mobiledata, // Google+ placeholder icon
          iconSize: 34,
          onPressed: onGooglePressed,
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.onPressed,
    this.iconSize = AppDimensions.socialIconSize,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.buttonHeight,
      height: AppDimensions.buttonHeight,
      decoration: const BoxDecoration(
        color: AppColors.background,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: AppColors.loginBackground,
          size: iconSize,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
