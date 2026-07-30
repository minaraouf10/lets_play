import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';

/// Success sheet shown when the letter is fully built.
class GameResultOverlay extends StatelessWidget {
  const GameResultOverlay({
    super.key,
    required this.glyph,
    required this.transliteration,
    required this.stars,
    required this.onReplay,
    required this.onDone,
  });

  final String glyph;
  final String transliteration;
  final int stars;
  final VoidCallback onReplay;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black54,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(AppDimensions.spaceLg),
          padding: const EdgeInsets.all(AppDimensions.spaceLg),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('أحسنت! Great job!', style: AppTextStyles.headingMedium),
              const SizedBox(height: AppDimensions.spaceMd),
              Text(glyph, style: const TextStyle(fontSize: 64)),
              Text(transliteration, style: AppTextStyles.bodyMedium),
              const SizedBox(height: AppDimensions.spaceMd),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < 3; i++)
                    Icon(
                      i < stars ? Icons.star_rounded : Icons.star_border_rounded,
                      color: AppColors.coin,
                      size: AppDimensions.iconLg,
                    ),
                ],
              ),
              const SizedBox(height: AppDimensions.spaceLg),
              AppButton(
                label: 'Continue',
                color: AppColors.success,
                onPressed: onDone,
              ),
              const SizedBox(height: AppDimensions.spaceSm),
              TextButton(onPressed: onReplay, child: const Text('Play again')),
            ],
          ),
        ),
      ),
    );
  }
}
