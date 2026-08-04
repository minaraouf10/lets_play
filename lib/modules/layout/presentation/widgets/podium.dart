import '../../../../core/utils/app_imports.dart';
import '../pages/leaderboard_page.dart';

/// Three-level podium showing top 3 ranked players with avatars, names, and points.
class Podium extends StatelessWidget {
  const Podium({super.key, required this.places});

  final List<PodiumPlace> places;

  Color _colorForRank(int rank) {
    switch (rank) {
      case 1:
        return AppColors.podiumFirst;
      case 2:
        return AppColors.podiumSecond;
      case 3:
        return AppColors.podiumThird;
      default:
        return AppColors.surface;
    }
  }

  double _heightForRank(int rank) {
    switch (rank) {
      case 1:
        return AppDimensions.podiumHeightFirst;
      case 2:
        return AppDimensions.podiumHeightSecond;
      case 3:
        return AppDimensions.podiumHeightThird;
      default:
        return 60;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.spaceMd),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(places.length, (i) {
          final place = places[i];
          final height = _heightForRank(place.rank);
          final color = _colorForRank(place.rank);

          return Expanded(
            child: Column(
              children: [
                Text(
                  '${place.rank}',
                  style: AppTextStyles.podiumRank,
                ),
                const SizedBox(height: AppDimensions.spaceXs),
                CircleAvatar(
                  radius: AppDimensions.podiumAvatarSize / 2,
                  backgroundColor: AppColors.surface,
                  child: const Icon(Icons.person),
                ),
                const SizedBox(height: AppDimensions.spaceXs),
                Text(
                  place.name,
                  style: AppTextStyles.podiumName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Container(
                  height: height,
                  width: AppDimensions.podiumBlockWidth,
                  decoration: BoxDecoration(
                    color: color,
                    border: Border.all(
                      color: AppColors.ink,
                      width: AppDimensions.neoBorderWidth,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppDimensions.radiusMd),
                      topRight: Radius.circular(AppDimensions.radiusMd),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${place.points}',
                      style: AppTextStyles.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
