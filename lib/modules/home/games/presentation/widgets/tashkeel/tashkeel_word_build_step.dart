import '../../../../../../core/utils/app_imports.dart';
import '../../../domain/entities/tashkeel_word.dart';
import '../word/word_speaker_button.dart';

/// Step 6: the word with one piece missing. The player drags the right piece
/// from the tray into the blank.
class TashkeelWordBuildStep extends StatelessWidget {
  const TashkeelWordBuildStep({
    super.key,
    required this.word,
    required this.options,
    required this.droppedPiece,
    required this.isCorrect,
    required this.onPlay,
    required this.onDrop,
  });

  final TashkeelWord word;
  final List<String> options;
  final String? droppedPiece;
  final bool isCorrect;
  final VoidCallback onPlay;
  final ValueChanged<String> onDrop;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: AppDimensions.spaceLg),
        Text('Repeat what you heard', style: AppTextStyles.headingMedium),
        const SizedBox(height: AppDimensions.spaceXl),
        _WordCard(
          word: word,
          droppedPiece: droppedPiece,
          isCorrect: isCorrect,
          onPlay: onPlay,
          onDrop: onDrop,
        ),
        const SizedBox(height: AppDimensions.spaceLg),
        // The tray of draggable pieces. Once the right one is placed there is
        // nothing left to drag, so the tray empties.
        if (!isCorrect)
          Wrap(
            alignment: WrapAlignment.center,
            spacing: AppDimensions.spaceMd,
            runSpacing: AppDimensions.spaceMd,
            children: [
              for (final piece in options)
                _DraggablePiece(piece: piece, onDropped: onDrop),
            ],
          ),
        const SizedBox(height: AppDimensions.spaceLg),
        SizedBox(
          height: AppDimensions.wordIllustrationHeight / 2,
          child: SvgPicture.asset(word.illustration, fit: BoxFit.contain),
        ),
        const SizedBox(height: AppDimensions.spaceSm),
        Text(
          word.meaning,
          style: AppTextStyles.bodyLarge,
        ),
      ],
    );
  }
}

/// The word laid out right-to-left with a drop target where the blank is.
class _WordCard extends StatelessWidget {
  const _WordCard({
    required this.word,
    required this.droppedPiece,
    required this.isCorrect,
    required this.onPlay,
    required this.onDrop,
  });

  final TashkeelWord word;
  final String? droppedPiece;
  final bool isCorrect;
  final VoidCallback onPlay;
  final ValueChanged<String> onDrop;

  @override
  Widget build(BuildContext context) {
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
          // Arabic reads right-to-left, so the first piece sits rightmost.
          for (final entry in word.pieces.asMap().entries.toList().reversed)
            if (entry.key == word.missingIndex)
              _BlankSlot(
                droppedPiece: droppedPiece,
                isCorrect: isCorrect,
                onDrop: onDrop,
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spaceXs,
                ),
                child: Text(entry.value, style: AppTextStyles.wordGlyph),
              ),
          const SizedBox(width: AppDimensions.spaceMd),
          WordSpeakerButton(onPressed: onPlay),
        ],
      ),
    );
  }
}

/// The dashed blank the piece is dropped into.
class _BlankSlot extends StatelessWidget {
  const _BlankSlot({
    required this.droppedPiece,
    required this.isCorrect,
    required this.onDrop,
  });

  final String? droppedPiece;
  final bool isCorrect;
  final ValueChanged<String> onDrop;

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onAcceptWithDetails: (details) => onDrop(details.data),
      builder: (context, candidate, rejected) {
        final isHovered = candidate.isNotEmpty;
        final borderColor = droppedPiece == null
            ? (isHovered ? AppColors.primary : AppColors.border)
            : isCorrect
                ? AppColors.success
                : AppColors.error;

        return Container(
          width: AppDimensions.tashkeelPieceSize,
          height: AppDimensions.tashkeelPieceSize,
          margin: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spaceXs,
          ),
          decoration: BoxDecoration(
            color: isHovered ? AppColors.navBarSelectedSurface : null,
            borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
            border: Border.all(
              color: borderColor,
              width: AppDimensions.neoBorderWidthSm,
            ),
          ),
          child: Center(
            child: Text(
              droppedPiece ?? '',
              style: AppTextStyles.wordGlyph,
            ),
          ),
        );
      },
    );
  }
}

/// One draggable word piece in the tray.
class _DraggablePiece extends StatelessWidget {
  const _DraggablePiece({required this.piece, required this.onDropped});

  final String piece;
  final ValueChanged<String> onDropped;

  @override
  Widget build(BuildContext context) {
    final chip = _PieceChip(piece: piece);

    return Draggable<String>(
      data: piece,
      feedback: Material(color: Colors.transparent, child: chip),
      childWhenDragging: Opacity(opacity: 0.3, child: chip),
      child: chip,
    );
  }
}

class _PieceChip extends StatelessWidget {
  const _PieceChip({required this.piece});

  final String piece;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.tashkeelPieceSize,
      height: AppDimensions.tashkeelPieceSize,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
        border: Border.all(
          color: AppColors.ink,
          width: AppDimensions.neoBorderWidthSm,
        ),
      ),
      child: Center(
        child: Text(piece, style: AppTextStyles.wordGlyph),
      ),
    );
  }
}
