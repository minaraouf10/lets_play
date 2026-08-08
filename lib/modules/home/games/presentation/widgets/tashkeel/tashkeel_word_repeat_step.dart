import '../../../../../../core/utils/app_imports.dart';
import '../../../domain/entities/tashkeel_word.dart';
import '../quiz/quiz_sound_buttons.dart';
import '../word/word_mic_button.dart';

/// Step 5: the whole word in an orange card with its meaning, heard at either
/// speed, then repeated into the mic.
class TashkeelWordRepeatStep extends StatelessWidget {
  const TashkeelWordRepeatStep({
    super.key,
    required this.word,
    required this.isRecording,
    required this.hasRecorded,
    required this.audioUnavailable,
    required this.onPlay,
    required this.onPlaySlowly,
    required this.onRecord,
  });

  final TashkeelWord word;
  final bool isRecording;
  final bool hasRecorded;
  final bool audioUnavailable;
  final VoidCallback onPlay;
  final VoidCallback onPlaySlowly;
  final VoidCallback onRecord;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: AppDimensions.spaceLg),
        Text('Repeat what you heard', style: AppTextStyles.headingMedium),
        const SizedBox(height: AppDimensions.spaceXl),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.spaceXl,
            horizontal: AppDimensions.spaceLg,
          ),
          decoration: BoxDecoration(
            color: AppColors.levelTashkeel,
            border: Border.all(
              color: AppColors.ink,
              width: AppDimensions.neoBorderWidth,
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColors.ink,
                offset: Offset(
                  AppDimensions.neoShadowOffsetSm,
                  AppDimensions.neoShadowOffsetSm,
                ),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                word.word,
                textAlign: TextAlign.center,
                style: AppTextStyles.wordGlyph.copyWith(
                  color: AppColors.textOnColor,
                ),
              ),
              const SizedBox(height: AppDimensions.spaceMd),
              Text(
                word.meaning,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textOnColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
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
