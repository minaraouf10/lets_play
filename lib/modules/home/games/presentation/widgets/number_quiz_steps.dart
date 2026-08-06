import '../../../../../core/utils/app_imports.dart';
import '../../data/datasources/number_data.dart';
import '../constants/puzzle_brick_colors.dart';
import 'brick_shape.dart';
import 'number_option_button.dart';
import 'quiz_sound_buttons.dart';
import 'trace_canvas.dart';
import 'word_mic_button.dart';
import 'word_speaker_button.dart';

/// Q1: a pink card states what the number means — answer true or false.
class NumberStatementStep extends StatelessWidget {
  const NumberStatementStep({
    super.key,
    required this.lesson,
    required this.answer,
    required this.onAnswer,
  });

  final NumberLesson lesson;

  /// What the player answered, if anything. The claim is always true.
  final bool? answer;
  final ValueChanged<bool> onAnswer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppDimensions.spaceMd),
        Expanded(
          child: Center(
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.accentPink,
                  border: Border.all(
                    color: AppColors.ink,
                    width: AppDimensions.neoBorderWidth,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      lesson.wordAr,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        fontSize: AppDimensions.numberStatementGlyphSize,
                        color: AppColors.textOnColor,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spaceMd),
                    Text(
                      'Means "${lesson.meaningEn}"',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textOnColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceMd),
        Row(
          children: [
            Expanded(
              child: _AnswerButton(
                label: 'True',
                isSelected: answer == true,
                // The claim is always true, so only 'True' is ever right.
                isRight: answer == true,
                onPressed: () => onAnswer(true),
              ),
            ),
            const SizedBox(width: AppDimensions.spaceMd),
            Expanded(
              child: _AnswerButton(
                label: 'False',
                isSelected: answer == false,
                isRight: false,
                onPressed: () => onAnswer(false),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _AnswerButton extends StatelessWidget {
  const _AnswerButton({
    required this.label,
    required this.isSelected,
    required this.isRight,
    required this.onPressed,
  });

  final String label;
  final bool isSelected;
  final bool isRight;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final borderColor = !isSelected
        ? AppColors.border
        : isRight
            ? AppColors.success
            : AppColors.error;

    return SizedBox(
      height: AppDimensions.optionRowHeight,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.surface,
          side: BorderSide(
            color: borderColor,
            width: isSelected
                ? AppDimensions.neoBorderWidth
                : AppDimensions.borderWidth,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary),
        ),
      ),
    );
  }
}

/// Q2: hear the word on a blue banner, then pick its digit from a 3x3 grid.
class NumberListenStep extends StatelessWidget {
  const NumberListenStep({
    super.key,
    required this.lesson,
    required this.options,
    required this.selectedGlyph,
    required this.audioUnavailable,
    required this.onPlay,
    required this.onPlaySlowly,
    required this.onSelect,
  });

  final NumberLesson lesson;
  final List<String> options;
  final String? selectedGlyph;
  final bool audioUnavailable;
  final VoidCallback onPlay;
  final VoidCallback onPlaySlowly;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppDimensions.spaceLg),
        Text('Listen & choose the number',
            style: AppTextStyles.headingMedium, textAlign: TextAlign.center),
        const SizedBox(height: AppDimensions.spaceLg),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: AppDimensions.spaceSm),
          decoration: BoxDecoration(
            color: AppColors.levelNumbers,
            border: Border.all(
              color: AppColors.ink,
              width: AppDimensions.neoBorderWidth,
            ),
          ),
          child: Text(
            lesson.wordAr,
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              fontSize: AppDimensions.numberBannerGlyphSize,
              color: AppColors.textOnColor,
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceLg),
        QuizSoundButtons(onPlay: onPlay, onPlaySlowly: onPlaySlowly),
        if (audioUnavailable) ...[
          const SizedBox(height: AppDimensions.spaceSm),
          Text(
            'No Arabic voice installed on this device.\n'
            'Settings > Accessibility > Text-to-speech',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
          ),
        ],
        const SizedBox(height: AppDimensions.spaceLg),
        // Fixed 3x3 block of digits, sized to content so it never fights the
        // scroll view it sits in.
        Wrap(
          alignment: WrapAlignment.center,
          spacing: AppDimensions.numberGridSpacing,
          runSpacing: AppDimensions.numberGridSpacing,
          children: [
            for (var i = 0; i < options.length; i++)
              NumberOptionButton(
                glyph: options[i],
                // Index-keyed so tapping one cell never lights up its repeats.
                isSelected: selectedGlyph != null &&
                    selectedGlyph == options[i] &&
                    _firstIndexOf(options[i]) == i,
                isCorrect: options[i] == lesson.glyph,
                onTap: () => onSelect(options[i]),
                width: AppDimensions.numberOptionSize * 1.4,
              ),
          ],
        ),
      ],
    );
  }

  int _firstIndexOf(String glyph) => options.indexOf(glyph);
}

/// Q3: count the bricks on screen and pick that digit.
class NumberCountStep extends StatelessWidget {
  const NumberCountStep({
    super.key,
    required this.lesson,
    required this.legoCount,
    required this.options,
    required this.selectedGlyph,
    required this.audioUnavailable,
    required this.onPlay,
    required this.onPlaySlowly,
    required this.onSelect,
  });

  final NumberLesson lesson;
  final int legoCount;
  final List<String> options;
  final String? selectedGlyph;
  final bool audioUnavailable;
  final VoidCallback onPlay;
  final VoidCallback onPlaySlowly;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppDimensions.spaceLg),
        Text('How many legos?', style: AppTextStyles.headingMedium),
        const SizedBox(height: AppDimensions.spaceXl),
        // One 2x2-stud brick per unit, so the count is what is being asked.
        Wrap(
          alignment: WrapAlignment.center,
          spacing: AppDimensions.spaceMd,
          runSpacing: AppDimensions.spaceMd,
          children: [
            for (var i = 0; i < legoCount; i++)
              BrickShape(
                cells: const [
                  BlockPosition(0, 0),
                  BlockPosition(0, 1),
                  BlockPosition(1, 0),
                  BlockPosition(1, 1),
                ],
                color: kPuzzleBrickColors[2 % kPuzzleBrickColors.length],
                cellPitch: AppDimensions.numberLegoSize / 2,
              ),
          ],
        ),
        const SizedBox(height: AppDimensions.spaceXl),
        QuizSoundButtons(onPlay: onPlay, onPlaySlowly: onPlaySlowly),
        if (audioUnavailable) ...[
          const SizedBox(height: AppDimensions.spaceSm),
          Text(
            'No Arabic voice installed on this device.\n'
            'Settings > Accessibility > Text-to-speech',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
          ),
        ],
        const SizedBox(height: AppDimensions.spaceXl),
        Row(
          children: [
            for (final option in options) ...[
              Expanded(
                child: NumberOptionButton(
                  glyph: option,
                  isSelected: option == selectedGlyph,
                  isCorrect: option == lesson.glyph,
                  onTap: () => onSelect(option),
                  width: double.infinity,
                ),
              ),
              if (option != options.last)
                const SizedBox(width: AppDimensions.spaceMd),
            ],
          ],
        ),
      ],
    );
  }
}

/// Q4: trace the digit along a dotted baseline.
class NumberWriteStep extends StatelessWidget {
  const NumberWriteStep({
    super.key,
    required this.puzzle,
    required this.filledCells,
    required this.onTouchCell,
  });

  final LetterPuzzle puzzle;
  final Set<BlockPosition> filledCells;
  final ValueChanged<BlockPosition> onTouchCell;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppDimensions.spaceLg),
        Text('Write the number', style: AppTextStyles.headingMedium),
        const SizedBox(height: AppDimensions.spaceXl),
        SizedBox(
          height: AppDimensions.numberWriteHeight,
          child: TraceCanvas(
            puzzle: puzzle,
            filledCells: filledCells,
            onTouchCell: onTouchCell,
          ),
        ),
        const SizedBox(height: AppDimensions.spaceMd),
        // The writing line the digit sits on.
        const _DottedBaseline(),
      ],
    );
  }
}

/// The dashed writing guide under the tracing area.
class _DottedBaseline extends StatelessWidget {
  const _DottedBaseline();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const dashWidth = AppDimensions.spaceXs;
        final dashCount =
            (constraints.maxWidth / (dashWidth * 2)).floor().clamp(0, 200);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            dashCount,
            (_) => Container(
              width: dashWidth,
              height: AppDimensions.borderWidth,
              color: AppColors.border,
            ),
          ),
        );
      },
    );
  }
}

/// Q5: hear the number on a blue card, then say it into the mic.
class NumberPronounceStep extends StatelessWidget {
  const NumberPronounceStep({
    super.key,
    required this.lesson,
    required this.isRecording,
    required this.hasRecorded,
    required this.audioUnavailable,
    required this.onPlay,
    required this.onRecord,
  });

  final NumberLesson lesson;
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
        Text('Pronounce the number', style: AppTextStyles.headingMedium),
        const SizedBox(height: AppDimensions.spaceXl),
        Container(
          width: double.infinity,
          height: AppDimensions.numberPronounceHeight,
          decoration: BoxDecoration(
            color: AppColors.levelNumbers,
            border: Border.all(
              color: AppColors.ink,
              width: AppDimensions.neoBorderWidth,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                lesson.glyph,
                style: const TextStyle(
                  fontSize: AppDimensions.numberPronounceGlyphSize,
                  color: AppColors.textOnColor,
                ),
              ),
              const SizedBox(width: AppDimensions.spaceLg),
              WordSpeakerButton(
                onPressed: onPlay,
                size: AppDimensions.wordCardSpeakerSize,
              ),
            ],
          ),
        ),
        if (audioUnavailable) ...[
          const SizedBox(height: AppDimensions.spaceSm),
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

/// Q6: pick the digit that matches the illustration.
class NumberPickStep extends StatelessWidget {
  const NumberPickStep({
    super.key,
    required this.lesson,
    required this.legoCount,
    required this.options,
    required this.selectedGlyph,
    required this.onSelect,
  });

  final NumberLesson lesson;
  final int legoCount;
  final List<String> options;
  final String? selectedGlyph;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppDimensions.spaceLg),
        Text('Pick the correct number', style: AppTextStyles.headingMedium),
        const SizedBox(height: AppDimensions.spaceXl),
        SizedBox(
          height: AppDimensions.numberIllustrationHeight,
          child: SvgPicture.asset(
            AppAssets.levelThreeIntroImage,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: AppDimensions.spaceXl),
        Row(
          children: [
            for (final option in options) ...[
              Expanded(
                child: NumberOptionButton(
                  glyph: option,
                  isSelected: option == selectedGlyph,
                  isCorrect: option == lesson.glyph,
                  onTap: () => onSelect(option),
                  width: double.infinity,
                ),
              ),
              if (option != options.last)
                const SizedBox(width: AppDimensions.spaceMd),
            ],
          ],
        ),
      ],
    );
  }
}
