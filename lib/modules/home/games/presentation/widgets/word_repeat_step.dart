import '../../../../../core/utils/app_imports.dart';
import '../../domain/entities/word_lesson.dart';
import 'word_mic_button.dart';
import 'word_speaker_button.dart';

/// Screen 1: hear the target word, then "repeat" it into the mic.
class WordRepeatStep extends StatelessWidget {
  const WordRepeatStep({
    super.key,
    required this.lesson,
    required this.isRecording,
    required this.hasRecorded,
    required this.audioUnavailable,
    required this.onPlay,
    required this.onRecord,
  });

  final WordLesson lesson;
  final bool isRecording;
  final bool hasRecorded;
  final bool audioUnavailable;
  final VoidCallback onPlay;
  final VoidCallback onRecord;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppDimensions.spaceLg),
        Text('Repeat what you heard', style: AppTextStyles.headingMedium),
        const SizedBox(height: AppDimensions.spaceXl),
        SizedBox(
          height: AppDimensions.wordIllustrationHeight,
          child: SvgPicture.asset(lesson.illustration, fit: BoxFit.contain),
        ),
        const SizedBox(height: AppDimensions.spaceXl),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(lesson.targetWord, style: AppTextStyles.wordGlyph),
            const SizedBox(width: AppDimensions.spaceMd),
            WordSpeakerButton(onPressed: onPlay),
          ],
        ),
        if (audioUnavailable) ...[
          const SizedBox(height: AppDimensions.spaceMd),
          Text(
            'No Arabic voice installed on this device.\n'
            'Settings > Accessibility > Text-to-speech',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
          ),
        ],
        const SizedBox(height: AppDimensions.spaceXl),
        WordMicButton(isRecording: isRecording, isDone: hasRecorded, onPressed: onRecord),
      ],
    );
  }
}
