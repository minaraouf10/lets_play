import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';

/// The LEGO brick colors the child can build with (visual only — completion
/// checks position, not color).
const List<Color> kBrickColors = [
  Color(0xFFFFC400), // yellow
  Color(0xFFE53935), // red
  Color(0xFF1E9BFF), // blue
  Color(0xFF2ECC40), // green
];

class BrickPalette extends StatelessWidget {
  const BrickPalette({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < kBrickColors.length; i++)
          GestureDetector(
            onTap: () => onSelected(i),
            child: Container(
              width: AppDimensions.iconLg,
              height: AppDimensions.iconLg,
              margin: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spaceSm,
              ),
              decoration: BoxDecoration(
                color: kBrickColors[i],
                borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                border: Border.all(
                  color: selectedIndex == i ? Colors.black : Colors.transparent,
                  width: 3,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
