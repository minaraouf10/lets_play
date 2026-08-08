import '../../../../../../core/utils/app_imports.dart';
import '../../../domain/entities/tashkeel_sample.dart';
import '../word/word_speaker_button.dart';

/// Step 1: the carrier letter with the mark applied, a speaker button, and
/// the red "KAF+a= Ka" equation card.
class TashkeelReviewStep extends StatelessWidget {
  const TashkeelReviewStep({
    super.key,
    required this.sample,
    required this.vowel,
    required this.audioUnavailable,
    required this.onPlay,
  });

  final TashkeelSample sample;
  final String vowel;
  final bool audioUnavailable;
  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: AppDimensions.tashkeelGlyphHeight,
          child: Center(
            child: FittedBox(
              child: Text(
                sample.glyph,
                style: AppTextStyles.headingLarge.copyWith(
                  fontSize: 220,
                  fontWeight: FontWeight.bold,
                  color: AppColors.ink,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceXl),
        WordSpeakerButton(onPressed: onPlay),
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
        _EquationCard(text: sample.equationFor(vowel)),
        const SizedBox(height: AppDimensions.spaceXl),
      ],
    );
  }
}

/// Red neo-brutalist card holding the "CARRIER+vowel= syllable" formula.
class _EquationCard extends StatelessWidget {
  const _EquationCard({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spaceLg,
        vertical: AppDimensions.spaceXl,
      ),
      decoration: BoxDecoration(
        color: AppColors.accentPink,
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
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: AppTextStyles.headingMedium.copyWith(
          color: AppColors.textOnColor,
        ),
      ),
    );
  }
}
