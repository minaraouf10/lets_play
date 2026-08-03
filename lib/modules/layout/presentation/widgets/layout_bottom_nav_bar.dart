import '../../../../core/utils/app_imports.dart';

import '../models/layout_nav_destination.dart';
import 'layout_nav_item.dart';

/// White bar, subtle top border, 4 full-color SVG tabs evenly spaced.
/// SafeArea lives INSIDE so the background bleeds behind the gesture-nav
/// home indicator.
class LayoutBottomNavBar extends StatelessWidget {
  const LayoutBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.navBarBackground,
          border: Border(
            top: BorderSide(
              color: AppColors.navBarBorder,
              width: AppDimensions.navBarBorderWidth,
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: AppDimensions.navBarHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var i = 0; i < LayoutNavDestination.all.length; i++)
                  LayoutNavItem(
                    destination: LayoutNavDestination.all[i],
                    isSelected: i == currentIndex,
                    onTap: () => onTap(i),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
