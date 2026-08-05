import '../../../../core/utils/app_imports.dart';
import 'stat_kind_style.dart';

class StatTile extends StatelessWidget {
  const StatTile({
    super.key,
    required this.stat,
    this.size = AppDimensions.statTileHeight,
  });

  final UserStat stat;
  final double size;

  @override
  Widget build(BuildContext context) {
    final color = stat.kind.color;
    final asset = stat.kind.asset;

    return NeoContainer(
      color: color,
      padding: const EdgeInsets.all(AppDimensions.spaceMd),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            asset,
            width: AppDimensions.statTileIconSize,
            height: AppDimensions.statTileIconSize,
            colorFilter:
                const ColorFilter.mode(AppColors.textOnColor, BlendMode.srcIn),
          ),
          const SizedBox(height: AppDimensions.spaceXs),
          Text(
            '${stat.value}',
            style: AppTextStyles.statValue,
          ),
        ],
      ),
    );
  }
}
