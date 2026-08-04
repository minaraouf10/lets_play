import '../../../../core/utils/app_imports.dart';

import 'hud_chip.dart';
/// Top HUD showing coins/stars, hearts and energy, using the real design
/// icons. Values are placeholders wired to a gamification cubit later.
class LearningHud extends StatelessWidget {
  const LearningHud({
    super.key,
    this.coins = 0,
    this.hearts = 0,
    this.energy = 0,
    this.showCoins = true,
    this.onSettingsTap,
  });

  final int coins;
  final int hearts;
  final int energy;
  final bool showCoins;
  final VoidCallback? onSettingsTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.hudHeight,
      child: Row(
        children: [
          if (showCoins) ...[
            HudChip(asset: AppAssets.hudCoin, value: '$coins'),
            const SizedBox(width: AppDimensions.spaceMd),
          ],
          HudChip(asset: AppAssets.hudHeart, value: '$hearts'),
          const SizedBox(width: AppDimensions.spaceMd),
          HudChip(asset: AppAssets.hudEnergy, value: '$energy'),
          const Spacer(),
          IconButton(
            onPressed: onSettingsTap,
            icon: SvgPicture.asset(
              AppAssets.hudSettings,
              width: AppDimensions.hudSettingsHeight,
              height: AppDimensions.hudSettingsHeight,
            ),
          ),
        ],
      ),
    );
  }
}
