import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Top HUD showing coins/stars, hearts and energy, using the real design
/// icons. Values are placeholders wired to a gamification cubit later.
class LearningHud extends StatelessWidget {
  const LearningHud({
    super.key,
    this.coins = 0,
    this.hearts = 0,
    this.energy = 0,
    this.onSettingsTap,
  });

  final int coins;
  final int hearts;
  final int energy;
  final VoidCallback? onSettingsTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.hudHeight,
      child: Row(
        children: [
          _HudChip(asset: AppAssets.coin, value: '$coins'),
          const SizedBox(width: AppDimensions.spaceMd),
          _HudChip(asset: AppAssets.heart, value: '$hearts'),
          const SizedBox(width: AppDimensions.spaceMd),
          _HudChip(asset: AppAssets.energy, value: '$energy'),
          const Spacer(),
          IconButton(
            onPressed: onSettingsTap,
            icon: Image.asset(
              AppAssets.settings,
              width: AppDimensions.iconLg,
              height: AppDimensions.iconLg,
            ),
          ),
        ],
      ),
    );
  }
}

class _HudChip extends StatelessWidget {
  const _HudChip({required this.asset, required this.value});

  final String asset;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          asset,
          width: AppDimensions.iconMd,
          height: AppDimensions.iconMd,
        ),
        const SizedBox(width: AppDimensions.spaceXs),
        Text(value, style: AppTextStyles.bodyLarge),
      ],
    );
  }
}
