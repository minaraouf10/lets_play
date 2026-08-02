import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Icon + numeric value pair used by [LearningHud].
class HudChip extends StatelessWidget {
  const HudChip({super.key, required this.asset, required this.value});

  final String asset;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(asset, height: AppDimensions.hudIconHeight),
        const SizedBox(width: AppDimensions.spaceXs),
        Text(value, style: AppTextStyles.bodyLarge),
      ],
    );
  }
}
