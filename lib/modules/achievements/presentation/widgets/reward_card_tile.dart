import '../../../../core/utils/app_imports.dart';
import '../../../achievements/domain/entities/reward_card.dart';
import 'reward_progress_bar.dart';

class RewardCardTile extends StatelessWidget {
  const RewardCardTile(this.reward);

  final RewardCard reward;

  @override
  Widget build(BuildContext context) {
    return NeoContainer(
      color: AppColors.highlightCard,
      padding: const EdgeInsets.all(AppDimensions.spaceMd),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(reward.title, style: AppTextStyles.rewardTitle),
              const SizedBox(height: AppDimensions.spaceXs),
              Text(reward.subtitle, style: AppTextStyles.rewardSubtitle),
              const SizedBox(height: AppDimensions.spaceMd),
              RewardProgressBar(progress: reward.progress),
            ],
          ),
          if (reward.isLocked)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                  color: AppColors.rewardLockScrim,
                ),
                child: const Center(
                  child: Icon(
                    Icons.lock_rounded,
                    size: AppDimensions.rewardPadlockSize,
                    color: AppColors.textOnColor,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
