import '../../../../core/utils/app_imports.dart';

import '../models/layout_nav_destination.dart';

/// One tab. The SVGs are multi-color illustrations, so selection is shown
/// with opacity — never a colorFilter, which would destroy the artwork.
class LayoutNavItem extends StatelessWidget {
  const LayoutNavItem({
    super.key,
    required this.destination,
    required this.isSelected,
    required this.onTap,
  });

  final LayoutNavDestination destination;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      label: destination.label,
      child: InkResponse(
        onTap: onTap,
        radius: AppDimensions.navBarTapRadius,
        child: Opacity(
          opacity: isSelected ? AppDimensions.navIconOpacityActive : AppDimensions.navIconOpacityInactive,
          child: SvgPicture.asset(
            destination.asset,
            height: AppDimensions.navBarIconHeight,
          ),
        ),
      ),
    );
  }
}
