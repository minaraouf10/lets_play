import '../../../../../core/utils/app_imports.dart';
import 'quiz_sound_buttons.dart';
import 'word_mic_button.dart';

/// Step 3: hear the syllable at either speed, then "repeat" it into the mic.
class TashkeelRepeatStep extends StatelessWidget {
  const TashkeelRepeatStep({
    super.key,
    required this.isRecording,
    required this.hasRecorded,
    required this.audioUnavailable,
    required this.onPlay,
    required this.onPlaySlowly,
    required this.onRecord,
  });

  final bool isRecording;
  final bool hasRecorded;
  final bool audioUnavailable;
  final VoidCallback onPlay;
  final VoidCallback onPlaySlowly;
  final VoidCallback onRecord;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppDimensions.spaceXl),
        Text('Listen', style: AppTextStyles.headingMedium),
        const SizedBox(height: AppDimensions.spaceXl),
        QuizSoundButtons(onPlay: onPlay, onPlaySlowly: onPlaySlowly),
        if (audioUnavailable) ...[
          const SizedBox(height: AppDimensions.spaceMd),
          Text(
            'No Arabic voice installed on this device.\n'
            'Settings > Accessibility > Text-to-speech',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
          ),
        ],
        const SizedBox(height: AppDimensions.spaceXxl),
        Text('Repeat what you heard', style: AppTextStyles.headingMedium),
        const SizedBox(height: AppDimensions.spaceXl),
        WordMicButton(
          isRecording: isRecording,
          isDone: hasRecorded,
          onPressed: onRecord,
        ),
      ],
    );
  }
}
