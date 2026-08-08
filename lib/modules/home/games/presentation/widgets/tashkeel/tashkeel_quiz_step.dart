import '../../../../../../core/utils/app_imports.dart';
import '../../../domain/entities/tashkeel_sample.dart';

/// Step 2: "Choose the pronunciation" — an orange card showing the glyph with
/// an inline speaker, above three syllable options.
class TashkeelQuizStep extends StatelessWidget {
  const TashkeelQuizStep({
    super.key,
    required this.sample,
    required this.options,
    required this.selectedSyllable,
    required this.audioUnavailable,
    required this.onPlay,
    required this.onSelect,
  });

  final TashkeelSample sample;
  final List<String> options;
  final String? selectedSyllable;
  final bool audioUnavailable;
  final VoidCallback onPlay;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppDimensions.spaceLg),
        Text('Choose the pronunciation', style: AppTextStyles.headingMedium),
        const SizedBox(height: AppDimensions.spaceLg),
        _GlyphCard(glyph: sample.glyph, onPlay: onPlay),
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
        for (final option in options) ...[
          _SyllableOption(
            label: option,
            isSelected: option == selectedSyllable,
            isCorrect: option == sample.syllable,
            onTap: () => onSelect(option),
          ),
          const SizedBox(height: AppDimensions.spaceMd),
        ],
      ],
    );
  }
}

/// Orange card holding the glyph, with the speaker button pinned to its right.
class _GlyphCard extends StatelessWidget {
  const _GlyphCard({required this.glyph, required this.onPlay});

  final String glyph;
  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppDimensions.quizOptionHeight,
      padding: const EdgeInsets.all(AppDimensions.spaceMd),
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
      child: Stack(
        children: [
          Center(
            child: FittedBox(
              child: Text(
                glyph,
                style: TextStyle(
                  fontSize: AppDimensions.quizGlyphSize * 2,
                  color: AppColors.textOnColor,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: onPlay,
              child: Container(
                padding: const EdgeInsets.all(AppDimensions.spaceSm),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusSm),
                  border: Border.all(
                    color: AppColors.ink,
                    width: AppDimensions.neoBorderWidthSm,
                  ),
                ),
                child: SvgPicture.asset(
                  AppAssets.speakerIcon,
                  width: AppDimensions.iconMd,
                  height: AppDimensions.iconMd,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SyllableOption extends StatelessWidget {
  const _SyllableOption({
    required this.label,
    required this.isSelected,
    required this.isCorrect,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final bool isCorrect;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = !isSelected
        ? AppColors.border
        : isCorrect
            ? AppColors.success
            : AppColors.error;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: AppDimensions.buttonHeight,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
          border: Border.all(
            color: borderColor,
            width: isSelected
                ? AppDimensions.neoBorderWidth
                : AppDimensions.borderWidth,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
