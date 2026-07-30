import 'package:flutter/material.dart';

import '../constants/app_dimensions.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Reusable primary button with loading state. No hardcoded sizes.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = AppColors.primary,
    this.textColor = AppColors.textOnColor,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final Color color;
  final Color textColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.buttonHeight,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          ),
        ),
        child: isLoading
            ?  SizedBox(
                height: AppDimensions.iconMd,
                width: AppDimensions.iconMd,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: textColor,
                ),
              )
            : Text(label, style: AppTextStyles.button.copyWith(color: textColor)),
      ),
    );
  }
}
