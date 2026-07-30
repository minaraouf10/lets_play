import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_colors.dart';

/// Bottom navigation bar matching the design (home / rewards / leaderboard /
/// profile) using the extracted design icons.
class LearningBottomNav extends StatelessWidget {
  const LearningBottomNav({super.key, this.currentIndex = 0, this.onTap});

  final int currentIndex;
  final ValueChanged<int>? onTap;

  static const _items = [
    AppAssets.home,
    AppAssets.sparkle,
    AppAssets.crown,
    AppAssets.smiley,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.buttonHeight,
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (var i = 0; i < _items.length; i++)
            GestureDetector(
              onTap: () => onTap?.call(i),
              child: Opacity(
                opacity: currentIndex == i ? 1 : 0.5,
                child: Image.asset(
                  _items[i],
                  width: AppDimensions.iconLg,
                  height: AppDimensions.iconLg,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
