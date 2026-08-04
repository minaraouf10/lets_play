import '../../../../core/utils/app_imports.dart';
import '../../../achievements/domain/entities/reward_card.dart';
import 'reward_card_tile.dart';

class RewardsRow extends StatelessWidget {
  const RewardsRow(this.rewards);

  final List<RewardCard> rewards;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.rewardCardHeight,
      child: Row(
        children: [
          if (rewards.isNotEmpty)
            Expanded(child: RewardCardTile(rewards[0]))
          else
            const Expanded(
              child: SizedBox(),
            ),
          const SizedBox(width: AppDimensions.spaceMd),
          if (rewards.length > 1)
            Expanded(child: RewardCardTile(rewards[1]))
          else
            const Expanded(
              child: SizedBox(),
            ),
        ],
      ),
    );
  }
}
