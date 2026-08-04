import '../../../../core/utils/app_imports.dart';
import '../../../leaderboard/domain/entities/podium_place.dart';
import 'podium_block.dart';

/// Row of 3 PodiumBlock in order [2nd, 1st, 3rd] where 1st is tallest.
class Podium extends StatelessWidget {
  const Podium({super.key, required this.places});

  final List<PodiumPlace> places;

  @override
  Widget build(BuildContext context) {
    assert(
      places.length == 3,
      'Podium requires exactly 3 places',
    );

    // Arrange: 2nd (left), 1st (center/tallest), 3rd (right)
    final second = places.firstWhere((p) => p.rank == 2);
    final first = places.firstWhere((p) => p.rank == 1);
    final third = places.firstWhere((p) => p.rank == 3);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        PodiumBlock(
          rank: second.rank,
          color: AppColors.podiumSecond,
          height: AppDimensions.podiumHeightSecond,
          avatarAsset: second.avatarAsset,
        ),
        SizedBox(width: AppDimensions.spaceMd),
        PodiumBlock(
          rank: first.rank,
          color: AppColors.podiumFirst,
          height: AppDimensions.podiumHeightFirst,
          avatarAsset: first.avatarAsset,
          showCrown: true,
        ),
        SizedBox(width: AppDimensions.spaceMd),
        PodiumBlock(
          rank: third.rank,
          color: AppColors.podiumThird,
          height: AppDimensions.podiumHeightThird,
          avatarAsset: third.avatarAsset,
        ),
      ],
    );
  }
}
