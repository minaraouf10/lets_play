import '../../../../core/utils/app_imports.dart';
import '../../../leaderboard/domain/entities/podium_place.dart';
import 'podium_avatar.dart';

/// Single [AppAssets.podiumRankImage] (3 lego blocks: 2nd, 1st, 3rd) with
/// avatars and rank numbers overlaid proportionally on each block.
class Podium extends StatelessWidget {
  const Podium({super.key, required this.places});

  final List<PodiumPlace> places;

  static const double _imageAspectRatio = 1052 / 584;

  @override
  Widget build(BuildContext context) {
    assert(
      places.length == 3,
      'Podium requires exactly 3 places',
    );

    final second = places.firstWhere((p) => p.rank == 2);
    final first = places.firstWhere((p) => p.rank == 1);
    final third = places.firstWhere((p) => p.rank == 3);

    return AspectRatio(
      aspectRatio: _imageAspectRatio,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(AppAssets.podiumRankImage, fit: BoxFit.contain),
          Align(
            alignment: const Alignment(-0.62, -0.35),
            child: _PodiumSlot(place: second),
          ),
          Align(
            alignment: const Alignment(0, -0.75),
            child: _PodiumSlot(place: first, showCrown: true),
          ),
          Align(
            alignment: const Alignment(0.62, -0.15),
            child: _PodiumSlot(place: third),
          ),
        ],
      ),
    );
  }
}

class _PodiumSlot extends StatelessWidget {
  const _PodiumSlot({required this.place, this.showCrown = false});

  final PodiumPlace place;
  final bool showCrown;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PodiumAvatar(
          asset: place.avatarAsset,
          size: AppDimensions.podiumAvatarSize,
          showCrown: showCrown,
        ),
        const SizedBox(height: AppDimensions.spaceXs),
        Text('${place.rank}', style: AppTextStyles.podiumRank),
      ],
    );
  }
}
