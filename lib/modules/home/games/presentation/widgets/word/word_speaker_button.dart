import '../../../../../../core/utils/app_imports.dart';

/// Standalone neo-brutalist speaker button — used to play a single word on
/// the word-lesson screens (a public version of what [QuizSoundButtons]
/// keeps private as `_SoundButton`).
class WordSpeakerButton extends StatelessWidget {
  const WordSpeakerButton({
    super.key,
    required this.onPressed,
    this.size = AppDimensions.quizSpeakerSize,
  });

  final VoidCallback onPressed;
  final double size;

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
        child: SvgPicture.asset(AppAssets.speakerIcon, fit: BoxFit.contain),
      ),
    );
  }
}
