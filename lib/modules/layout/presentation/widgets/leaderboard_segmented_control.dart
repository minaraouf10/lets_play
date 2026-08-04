import '../../../../core/utils/app_imports.dart';

/// Tab selector: Friends | Global
class LeaderboardSegmentedControl extends StatelessWidget {
  const LeaderboardSegmentedControl({
    super.key,
    required this.selectedTab,
    required this.onChanged,
  });

  final String selectedTab;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.segmentedTrack,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      height: AppDimensions.segmentedHeight,
      child: Row(
        children: [
          Expanded(
            child: _SegmentButton(
              label: 'Friends',
              isSelected: selectedTab == 'friends',
              onTap: () => onChanged('friends'),
            ),
          ),
          Expanded(
            child: _SegmentButton(
              label: 'Global',
              isSelected: selectedTab == 'global',
              onTap: () => onChanged('global'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  const _SegmentButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.background : Colors.transparent,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd - 2),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTextStyles.segmentLabel.copyWith(
              color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
