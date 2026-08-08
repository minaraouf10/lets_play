import '../../../../../../core/utils/app_imports.dart';
import '../../cubit/tashkeel_lesson_cubit.dart';

/// Step 4: "Place the [mark] in the correct location" — the bare carrier
/// letter with three dotted slots, one above the baseline and two below.
/// Only the slot above is correct for a fatha.
class TashkeelPlaceStep extends StatelessWidget {
  const TashkeelPlaceStep({
    super.key,
    required this.markName,
    required this.carrierGlyph,
    required this.markGlyph,
    required this.selected,
    required this.onSelect,
  });

  final String markName;

  /// The carrier without the mark, e.g. "ك".
  final String carrierGlyph;

  /// The mark on its own, e.g. "َ".
  final String markGlyph;

  final TashkeelPlacement? selected;
  final ValueChanged<TashkeelPlacement> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppDimensions.spaceLg),
        Text(
          'Place the $markName in the\ncorrect location',
          textAlign: TextAlign.center,
          style: AppTextStyles.headingMedium,
        ),
        const SizedBox(height: AppDimensions.spaceXl),
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            padding: const EdgeInsets.all(AppDimensions.spaceLg),
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
              children: [
                // Slot above the letter — the correct one for a fatha.
                _Slot(
                  placement: TashkeelPlacement.above,
                  markGlyph: markGlyph,
                  selected: selected,
                  onSelect: onSelect,
                ),
                Expanded(
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        carrierGlyph,
                        style: const TextStyle(
                          fontSize: 120,
                          color: AppColors.textOnColor,
                        ),
                      ),
                    ),
                  ),
                ),
                // Two decoy slots below the baseline.
                Row(
                  children: [
                    Expanded(
                      child: _Slot(
                        placement: TashkeelPlacement.belowRight,
                        markGlyph: markGlyph,
                        selected: selected,
                        onSelect: onSelect,
                      ),
                    ),
                    const SizedBox(width: AppDimensions.spaceLg),
                    Expanded(
                      child: _Slot(
                        placement: TashkeelPlacement.belowLeft,
                        markGlyph: markGlyph,
                        selected: selected,
                        onSelect: onSelect,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// One tappable dotted slot. Shows the mark once chosen, and turns green or
/// red to report whether the choice was right.
class _Slot extends StatelessWidget {
  const _Slot({
    required this.placement,
    required this.markGlyph,
    required this.selected,
    required this.onSelect,
  });

  final TashkeelPlacement placement;
  final String markGlyph;
  final TashkeelPlacement? selected;
  final ValueChanged<TashkeelPlacement> onSelect;

  @override
  Widget build(BuildContext context) {
    final isSelected = selected == placement;
    final isCorrect = placement == TashkeelPlacement.above;
    final color = !isSelected
        ? AppColors.textOnColor
        : isCorrect
            ? AppColors.success
            : AppColors.error;

    return GestureDetector(
      onTap: () => onSelect(placement),
      child: SizedBox(
        height: AppDimensions.spaceXxl,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (isSelected)
                Text(
                  markGlyph,
                  style: TextStyle(fontSize: 100, color: color),
                ),
              const SizedBox(height: AppDimensions.spaceXs),
              _DottedLine(color: color),
            ],
          ),
        ),
      ),
    );
  }
}

/// The dashed underline marking a droppable slot.
class _DottedLine extends StatelessWidget {
  const _DottedLine({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const dashWidth = 4.0;
        const dashGap = 4.0;
        final count =
            (constraints.maxWidth / (dashWidth + dashGap)).floor().clamp(0, 200);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            count,
            (_) => Container(
              width: dashWidth,
              height: 2,
              margin: const EdgeInsets.only(right: dashGap),
              color: color,
            ),
          ),
        );
      },
    );
  }
}
