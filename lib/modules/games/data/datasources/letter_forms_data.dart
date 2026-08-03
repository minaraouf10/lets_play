import '../../domain/entities/block_position.dart';
import '../../domain/entities/letter_form.dart';
import '../../domain/entities/puzzle_brick.dart';

/// Positional forms per lesson, drawn from the same 1x1 / 1x2 brick set as
/// the puzzles. Keys match `LetterPuzzle.lessonId`.
///
/// Alef (أ) shapes, on a 7x4 grid:
///   initial  : stepped hamza + short stem
///   isolated : bare stem
///   final_   : hamza + stem + horizontal foot (└)
///   medial   : stem + horizontal foot (└)
const Map<String, List<LetterForm>> kLetterForms = {
  'l1_alef': [
    LetterForm(
      type: LetterFormType.initial,
      label: 'Initial',
      rows: 7,
      cols: 4,
      bricks: _initialBricks,
    ),
    LetterForm(
      type: LetterFormType.isolated,
      label: 'Isolated',
      rows: 7,
      cols: 4,
      bricks: _isolatedBricks,
    ),
    LetterForm(
      type: LetterFormType.final_,
      label: 'Final',
      rows: 7,
      cols: 4,
      bricks: _finalBricks,
    ),
    LetterForm(
      type: LetterFormType.medial,
      label: 'Medial',
      rows: 7,
      cols: 4,
      bricks: _medialBricks,
    ),
  ],
};

/// Stepped red hamza: 1x2 at (0,2) with a 1x2 stepped left below at (1,1).
const List<PuzzleBrick> _hamza = [
  PuzzleBrick(
    id: 'f_hamza_top',
    cells: [BlockPosition(0, 0), BlockPosition(0, 1)],
    colorIndex: 1,
    targetOrigin: BlockPosition(0, 2),
    spawnOrigin: BlockPosition(0, 2),
  ),
  PuzzleBrick(
    id: 'f_hamza_step',
    cells: [BlockPosition(0, 0), BlockPosition(0, 1)],
    colorIndex: 1,
    targetOrigin: BlockPosition(1, 1),
    spawnOrigin: BlockPosition(1, 1),
  ),
];

/// Orange stem down column 2, rows 2..5.
const List<PuzzleBrick> _stem = [
  PuzzleBrick(
    id: 'f_stem_a',
    cells: [BlockPosition(0, 0), BlockPosition(1, 0)],
    colorIndex: 0,
    targetOrigin: BlockPosition(2, 2),
    spawnOrigin: BlockPosition(2, 2),
  ),
  PuzzleBrick(
    id: 'f_stem_b',
    cells: [BlockPosition(0, 0), BlockPosition(1, 0)],
    colorIndex: 0,
    targetOrigin: BlockPosition(4, 2),
    spawnOrigin: BlockPosition(4, 2),
  ),
];

/// Horizontal foot at the stem's base, extending right: └
const List<PuzzleBrick> _foot = [
  PuzzleBrick(
    id: 'f_foot',
    cells: [BlockPosition(0, 0), BlockPosition(0, 1)],
    colorIndex: 0,
    targetOrigin: BlockPosition(6, 2),
    spawnOrigin: BlockPosition(6, 2),
  ),
];

const List<PuzzleBrick> _initialBricks = [..._hamza, ..._stem];
const List<PuzzleBrick> _isolatedBricks = _stem;
const List<PuzzleBrick> _finalBricks = [..._hamza, ..._stem, ..._foot];
const List<PuzzleBrick> _medialBricks = [..._stem, ..._foot];
