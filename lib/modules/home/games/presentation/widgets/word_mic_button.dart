import '../../../../../core/utils/app_imports.dart';

/// The big microphone button on the "repeat what you heard" screen.
///
/// Placeholder only — there is no speech recognition behind it, just a
/// timed "recording" visual state driven by [WordLessonCubit.startRecording].
class WordMicButton extends StatelessWidget {
  const WordMicButton({
    super.key,
    required this.isRecording,
    required this.isDone,
    required this.onPressed,
  });

  final bool isRecording;
  final bool isDone;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final borderColor = isDone ? AppColors.success : AppColors.ink;
    final fillColor = isRecording ? AppColors.micRecording : AppColors.background;

    return GestureDetector(
      onTap: (isRecording || isDone) ? null : onPressed,
      child: AnimatedScale(
        scale: isRecording ? 1.08 : 1.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Container(
          width: AppDimensions.wordMicSize,
          height: AppDimensions.wordMicSize,
          padding: const EdgeInsets.all(AppDimensions.spaceMd),
          decoration: BoxDecoration(
            color: fillColor,
            //shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: AppDimensions.neoBorderWidth),
          ),
          child: SvgPicture.asset(
            AppAssets.microphoneIcon,
            width: AppDimensions.wordMicIconSize,
            height: AppDimensions.wordMicIconSize,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
