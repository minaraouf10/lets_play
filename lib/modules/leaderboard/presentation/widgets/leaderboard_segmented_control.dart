import '../../../../core/utils/app_imports.dart';
import '../../../leaderboard/domain/entities/leaderboard_tab.dart';

/// 2-segment pill (Leadership | Tournaments).
/// Tournaments tap fires context.showComingSoon() without emitting.
class LeaderboardSegmentedControl extends StatelessWidget {
  const LeaderboardSegmentedControl({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final LeaderboardTab selected;
  final ValueChanged<LeaderboardTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.segmentedHeight,
      decoration: BoxDecoration(
        color: AppColors.segmentedTrack,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
      ),
      padding: const EdgeInsets.all(AppDimensions.spaceXs),
      child: Row(
        children: [
          Expanded(
            child: _SegmentButton(
              label: 'Leadership',
              isSelected: selected == LeaderboardTab.leadership,
              onTap: () => onChanged(LeaderboardTab.leadership),
            ),
          ),
          Expanded(
            child: _SegmentButton(
              label: 'Tournaments',
              isSelected: selected == LeaderboardTab.tournaments,
              onTap: () => context.showComingSoon(),
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTextStyles.segmentLabel.copyWith(
              color:
                  isSelected ? AppColors.textOnColor : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
