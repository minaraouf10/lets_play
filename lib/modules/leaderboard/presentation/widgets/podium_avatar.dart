import '../../../../core/utils/app_imports.dart';
import '../../../profile/presentation/widgets/profile_avatar.dart';

/// ProfileAvatar with optional crown glyph overlay.
class PodiumAvatar extends StatelessWidget {
  const PodiumAvatar({
    super.key,
    required this.asset,
    required this.size,
    this.showCrown = false,
  });

  final String asset;
  final double size;
  final bool showCrown;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ProfileAvatar(
          radius: size / 2,
          asset: asset,
        ),
        if (showCrown)
          Positioned(
            top: -AppDimensions.podiumCrownSize / 2,
            child: Text(
              '👑',
              style: TextStyle(fontSize: AppDimensions.podiumCrownSize),
            ),
          ),
      ],
    );
  }
}
