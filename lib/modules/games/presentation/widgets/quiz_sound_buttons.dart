import '../../../../core/utils/app_imports.dart';

/// The speaker (normal speed) and snail (slow) pronunciation buttons.
class QuizSoundButtons extends StatelessWidget {
  const QuizSoundButtons({
    super.key,
    required this.onPlay,
    required this.onPlaySlowly,
  });

  final VoidCallback onPlay;
  final VoidCallback onPlaySlowly;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _SoundButton(
          asset: AppAssets.speakerIcon,
          size: AppDimensions.quizSpeakerSize,
          onPressed: onPlay,
        ),
        const SizedBox(width: AppDimensions.spaceMd),
        _SoundButton(
          asset: AppAssets.snailIcon,
          size: AppDimensions.quizSnailSize,
          onPressed: onPlaySlowly,
        ),
      ],
    );
  }
}

class _SoundButton extends StatelessWidget {
  const _SoundButton({
    required this.asset,
    required this.size,
    required this.onPressed,
  });

  final String asset;
  final double size;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(AppDimensions.spaceSm),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
          border: Border.all(
            color: AppColors.ink,
            width: AppDimensions.neoBorderWidth,
          ),
        ),
        child: SvgPicture.asset(asset, fit: BoxFit.contain),
      ),
    );
  }
}
