import '../../../../core/utils/app_imports.dart';
import 'podium_avatar.dart';

/// One colored podium block: avatar on top, rank number below.
class PodiumBlock extends StatelessWidget {
  const PodiumBlock({
    super.key,
    required this.rank,
    required this.color,
    required this.height,
    required this.avatarAsset,
    this.showCrown = false,
  });

  final int rank;
  final Color color;
  final double height;
  final String avatarAsset;
  final bool showCrown;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimensions.podiumBlockWidth,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Center(
              child: PodiumAvatar(
                asset: avatarAsset,
                size: AppDimensions.podiumAvatarSize,
                showCrown: showCrown,
              ),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppDimensions.radiusMd),
                bottomRight: Radius.circular(AppDimensions.radiusMd),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              height: AppDimensions.rankBadgeSize + AppDimensions.spaceMd,
              child: Center(
                child: Text(
                  '$rank',
                  style: AppTextStyles.podiumRank,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
