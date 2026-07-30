import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/block_position.dart';
import '../../domain/entities/letter_puzzle.dart';

/// The building surface. Target cells show a faint outline; filled cells
/// render as bricks in [brickColor].
class BlockGrid extends StatelessWidget {
  const BlockGrid({
    super.key,
    required this.puzzle,
    required this.filled,
    required this.brickColor,
    required this.onTapCell,
  });

  final LetterPuzzle puzzle;
  final Set<BlockPosition> filled;
  final Color brickColor;
  final void Function(BlockPosition) onTapCell;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: puzzle.cols / puzzle.rows,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: puzzle.rows * puzzle.cols,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: puzzle.cols,
          mainAxisSpacing: AppDimensions.letterGridSpacing / 2,
          crossAxisSpacing: AppDimensions.letterGridSpacing / 2,
        ),
        itemBuilder: (context, index) {
          final pos = BlockPosition(index ~/ puzzle.cols, index % puzzle.cols);
          final isTarget = puzzle.target.contains(pos);
          final isFilled = filled.contains(pos);
          return GestureDetector(
            onTap: () => onTapCell(pos),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: isFilled
                    ? brickColor
                    : (isTarget
                        ? brickColor.withValues(alpha: 0.15)
                        : AppColors.surface),
                borderRadius: BorderRadius.circular(AppDimensions.radiusSm / 2),
                border: Border.all(
                  color: isTarget ? brickColor : AppColors.border,
                  width: isTarget ? 1.5 : 0.5,
                ),
              ),
              child: isFilled ? const _BrickStuds() : null,
            ),
          );
        },
      ),
    );
  }
}

/// The little LEGO studs on a placed brick.
class _BrickStuds extends StatelessWidget {
  const _BrickStuds();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: AppDimensions.spaceSm,
        height: AppDimensions.spaceSm,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.35),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
