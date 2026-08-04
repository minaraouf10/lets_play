import '../../../../core/utils/app_imports.dart';

/// Back chevron + "Leaderboard" title + trailing avatar icon.
class LeaderboardHeader extends StatelessWidget {
  const LeaderboardHeader({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spaceMd,
        vertical: AppDimensions.spaceSm,
      ),
      child: Row(
        children: [
          InkResponse(
            onTap: onBack,
            radius: AppDimensions.navBarTapRadius,
            child: const Padding(
              padding: EdgeInsets.all(AppDimensions.spaceSm),
              child: Icon(Icons.chevron_left),
            ),
          ),
          const SizedBox(width: AppDimensions.spaceMd),
          Text(
            'Leaderboard',
            style: AppTextStyles.screenTitle,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(AppDimensions.spaceSm),
            child: CircleAvatar(
              radius: AppDimensions.profileAvatarSm / 2,
              backgroundColor: AppColors.surface,
              child: const Icon(Icons.person),
            ),
          ),
        ],
      ),
    );
  }
}
