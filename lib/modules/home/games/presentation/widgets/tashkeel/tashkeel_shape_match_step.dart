import '../../../../../../core/utils/app_imports.dart';
import '../word/word_speaker_button.dart';

/// Step 7: the mark's Arabic name in a card, dragged onto whichever shape
/// draws it in the right place — above the line or below it.
class TashkeelShapeMatchStep extends StatelessWidget {
  const TashkeelShapeMatchStep({
    super.key,
    required this.markNameArabic,
    required this.markGlyph,
    required this.selectedIsAbove,
    required this.markSitsAbove,
    required this.onPlay,
    required this.onChoose,
  });

  /// The mark's name as written in Arabic, e.g. "فتحة".
  final String markNameArabic;

  /// The mark on its own, e.g. "َ".
  final String markGlyph;

  final bool? selectedIsAbove;

  /// Whether this mark is actually written above the line.
  final bool markSitsAbove;

  final VoidCallback onPlay;
  final ValueChanged<bool> onChoose;

  bool get _isAnswered => selectedIsAbove == markSitsAbove;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: AppDimensions.spaceLg),
        Text(
          'Match the diacritical mark\nto its correct shape',
          textAlign: TextAlign.center,
          style: AppTextStyles.headingMedium,
        ),
        const SizedBox(height: AppDimensions.spaceXl),
        _NameCard(
          markNameArabic: markNameArabic,
          isPlaced: _isAnswered,
          onPlay: onPlay,
        ),
        const SizedBox(height: AppDimensions.spaceXl),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _ShapeTarget(
              isAbove: true,
              markGlyph: markGlyph,
              markNameArabic: markNameArabic,
              selectedIsAbove: selectedIsAbove,
              markSitsAbove: markSitsAbove,
              onChoose: onChoose,
            ),
            _ShapeTarget(
              isAbove: false,
              markGlyph: markGlyph,
              markNameArabic: markNameArabic,
              selectedIsAbove: selectedIsAbove,
              markSitsAbove: markSitsAbove,
              onChoose: onChoose,
            ),
          ],
        ),
      ],
    );
  }
}

/// The draggable card holding the mark's Arabic name.
class _NameCard extends StatelessWidget {
  const _NameCard({
    required this.markNameArabic,
    required this.isPlaced,
    required this.onPlay,
  });

  final String markNameArabic;
  final bool isPlaced;
  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    final label = _NameChip(markNameArabic: markNameArabic);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.spaceMd),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Once matched there is nothing left to drag.
          if (isPlaced)
            Opacity(opacity: 0.3, child: label)
          else
            Draggable<String>(
              data: markNameArabic,
              feedback: Material(color: Colors.transparent, child: label),
              childWhenDragging: Opacity(opacity: 0.3, child: label),
              child: label,
            ),
          const SizedBox(width: AppDimensions.spaceMd),
          WordSpeakerButton(onPressed: onPlay),
        ],
      ),
    );
  }
}

class _NameChip extends StatelessWidget {
  const _NameChip({required this.markNameArabic});

  final String markNameArabic;

  @override
  Widget build(BuildContext context) {
    return Text(markNameArabic, style: AppTextStyles.wordGlyph);
  }
}

/// One of the two shape cards: the mark drawn above or below a dashed line.
class _ShapeTarget extends StatelessWidget {
  const _ShapeTarget({
    required this.isAbove,
    required this.markGlyph,
    required this.markNameArabic,
    required this.selectedIsAbove,
    required this.markSitsAbove,
    required this.onChoose,
  });

  final bool isAbove;
  final String markGlyph;
  final String markNameArabic;
  final bool? selectedIsAbove;
  final bool markSitsAbove;
  final ValueChanged<bool> onChoose;

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onAcceptWithDetails: (_) => onChoose(isAbove),
      builder: (context, candidate, rejected) {
        final isHovered = candidate.isNotEmpty;
        final isSelected = selectedIsAbove == isAbove;
        final isRight = isAbove == markSitsAbove;

        final borderColor = !isSelected
            ? (isHovered ? AppColors.primary : AppColors.border)
            : isRight
                ? AppColors.success
                : AppColors.error;

        // The mark sits above the line on one card and below it on the other.
        final glyph = Text(
          markGlyph,
          style: const TextStyle(fontSize: 28, color: AppColors.textPrimary),
        );
        const line = _DashedLine();

        return GestureDetector(
          // Tapping works too, so the step is not drag-only.
          onTap: () => onChoose(isAbove),
          child: Container(
            width: AppDimensions.tashkeelShapeCardSize,
            height: AppDimensions.tashkeelShapeCardSize,
            padding: const EdgeInsets.all(AppDimensions.spaceMd),
            decoration: BoxDecoration(
              color: isHovered ? AppColors.navBarSelectedSurface : AppColors.surface,
              borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
              border: Border.all(
                color: borderColor,
                width: isSelected
                    ? AppDimensions.neoBorderWidth
                    : AppDimensions.borderWidth,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: isAbove
                  ? [glyph, const SizedBox(height: AppDimensions.spaceSm), line]
                  : [line, const SizedBox(height: AppDimensions.spaceSm), glyph],
            ),
          ),
        );
      },
    );
  }
}

/// The dashed baseline the mark is drawn against.
class _DashedLine extends StatelessWidget {
  const _DashedLine();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const dashWidth = 4.0;
        const dashGap = 4.0;
        final count =
            (constraints.maxWidth / (dashWidth + dashGap)).floor().clamp(0, 100);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            count,
            (_) => Container(
              width: dashWidth,
              height: 1.5,
              margin: const EdgeInsets.only(right: dashGap),
              color: AppColors.textSecondary,
            ),
          ),
        );
      },
    );
  }
}
