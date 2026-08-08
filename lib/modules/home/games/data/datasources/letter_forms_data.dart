import '../../domain/entities/block_position.dart';
import '../../domain/entities/letter_form.dart';
import '../../domain/entities/puzzle_brick.dart';

/// Positional forms per lesson, drawn from the same 1x1 / 1x2 brick set as
/// the puzzles. Keys match `LetterPuzzle.lessonId`.
///
/// The geometry mirrors the أ puzzle in `games_local_datasource.dart` exactly,
/// so the shape a child builds in the game is the shape they are shown here.
/// Same 9x8 grid, same brick sizes, same target origins. The letter sits in
/// the middle columns; the rest of the board is where the loose bricks wait:
///
///   col:    0 1 2 3 4 5 6 7
///   row 0 |         H         hamza top   (1x1)
///   row 1 |       H           hamza step  (1x1, one column left)
///   row 2 |       H H         hamza base  (1x2, widening to the right)
///   row 3 |                   blank: the hamza does not touch the stem
///   row 4 |         S         stem_a      (2x1 vertical)
///   row 5 |         S
///   row 6 |         S         stem_b      (2x1 vertical)
///   row 7 |         S
///   row 8 |         S         stem_c      (1x1, closing the stroke)
///
/// Three positions are taught, in reading order:
///   initial : hamza + stem          (أ at the start of a word)
///   medial  : stem + foot           (ـا joined from the right)
///   final_  : stem + foot           (ـا at the end of a word)
///
/// Alef is a non-connecting letter: it joins to the letter before it but
/// never to the one after, so its medial and final shapes are the same "ـا".
// `final` rather than `const`: the hamza is generated as one brick per stud.
final Map<String, List<LetterForm>> kLetterForms = {
  'l1_alef': [
    LetterForm(
      type: LetterFormType.initial,
      label: 'في أول الكلمة',
      glyph: 'أ',
      rows: _rows,
      cols: _cols,
      bricks: _initialBricks,
    ),
    const LetterForm(
      type: LetterFormType.medial,
      label: 'في وسط الكلمة',
      glyph: 'ا',
      rows: _rows,
      cols: _cols,
      bricks: _medialBricks,
    ),
    const LetterForm(
      type: LetterFormType.final_,
      label: 'في آخر الكلمة',
      glyph: 'ـا',
      rows: _rows,
      cols: _cols,
      bricks: _finalBricks,
    ),
  ],
};

/// Grid size, matching the أ puzzle so both screens draw the letter at the
/// same proportions. Nine rows tall: three for the hamza, a blank row, then
/// the stem — the gap between the two is part of how أ is written.
///
/// Eight columns wide so the board spans the phone screen (8 * 42px pitch
/// ≈ 336px) and the loose bricks have room to scatter around the letter.
/// The letter itself occupies the middle columns; [_stemCol] anchors it.
const int _rows = 9;
const int _cols = 8;

/// The column the alef's stroke runs down. The hamza steps one column left
/// of it, so the letter sits centred in the 8-wide grid.
const int _stemCol = 4;

/// A vertical two-stud brick, covering one column across two rows.
const List<BlockPosition> _vertical = [
  BlockPosition(0, 0),
  BlockPosition(1, 0),
];

/// Every cell the hamza covers: a thin stroke that starts on the stem column,
/// steps down-left, then widens back to the right on its last row. Built from
/// single studs so the child places the hamza one piece at a time.
///
///   col:   3 4 5
///   row 0 |   H
///   row 1 | H
///   row 2 | H H
///
/// Anchored to [_stemCol] so the letter stays centred in the 8-wide grid.
/// Shared with `games_local_datasource.dart` so the letter the child builds
/// and the letter they are shown cannot drift apart.
const List<BlockPosition> kHamzaCells = [
  BlockPosition(0, _stemCol),
  BlockPosition(1, _stemCol - 1),
  BlockPosition(2, _stemCol - 1), BlockPosition(2, _stemCol),
];

/// Builds the hamza as one 1x1 stud per cell. [idPrefix] keeps the game's
/// brick ids distinct from the forms screen's, and [spawnAt] decides where
/// each piece starts — on its target for the static drawing, scattered for
/// the game.
List<PuzzleBrick> buildHamzaStuds({
  required String idPrefix,
  BlockPosition Function(int index, BlockPosition target)? spawnAt,
}) =>
    [
      for (var i = 0; i < kHamzaCells.length; i++)
        PuzzleBrick(
          id: '$idPrefix$i',
          cells: const [BlockPosition(0, 0)],
          colorIndex: 1,
          targetOrigin: kHamzaCells[i],
          spawnOrigin: spawnAt?.call(i, kHamzaCells[i]) ?? kHamzaCells[i],
        ),
    ];

/// The hamza as 4 separate 1x1 studs, drawn in place.
final List<PuzzleBrick> _hamza = buildHamzaStuds(idPrefix: 'f_hamza_');

/// The stem: a 1-stud-wide orange stroke straight down [_stemCol], rows 4..8.
/// It starts one row below the hamza so the two read as separate strokes.
const List<PuzzleBrick> _stem = [
  PuzzleBrick(
    id: 'f_stem_a',
    cells: _vertical,
    colorIndex: 0,
    targetOrigin: BlockPosition(4, _stemCol),
    spawnOrigin: BlockPosition(4, _stemCol),
  ),
  PuzzleBrick(
    id: 'f_stem_b',
    cells: _vertical,
    colorIndex: 0,
    targetOrigin: BlockPosition(6, _stemCol),
    spawnOrigin: BlockPosition(6, _stemCol),
  ),
  PuzzleBrick(
    id: 'f_stem_c',
    cells: [BlockPosition(0, 0)],
    colorIndex: 0,
    targetOrigin: BlockPosition(8, _stemCol),
    spawnOrigin: BlockPosition(8, _stemCol),
  ),
];

/// The connecting foot: a single stud right of the stroke's base, forming the
/// tail that joins alef to the letter before it.
const List<PuzzleBrick> _foot = [
  PuzzleBrick(
    id: 'f_foot',
    cells: [BlockPosition(0, 0)],
    colorIndex: 0,
    targetOrigin: BlockPosition(8, _stemCol + 1),
    spawnOrigin: BlockPosition(8, _stemCol + 1),
  ),
];

/// The bare stroke: the same 1-stud-wide stroke as [_stem], but running the
/// full height of the grid. The joined forms carry no hamza, so nothing sits
/// above them and the stroke starts at row 0.
const List<PuzzleBrick> _fullStem = [
  PuzzleBrick(
    id: 'f_bare_a',
    cells: _vertical,
    colorIndex: 0,
    targetOrigin: BlockPosition(0, _stemCol),
    spawnOrigin: BlockPosition(0, _stemCol),
  ),
  PuzzleBrick(
    id: 'f_bare_b',
    cells: _vertical,
    colorIndex: 0,
    targetOrigin: BlockPosition(2, _stemCol),
    spawnOrigin: BlockPosition(2, _stemCol),
  ),
  PuzzleBrick(
    id: 'f_bare_c',
    cells: _vertical,
    colorIndex: 0,
    targetOrigin: BlockPosition(4, _stemCol),
    spawnOrigin: BlockPosition(4, _stemCol),
  ),
  PuzzleBrick(
    id: 'f_bare_d',
    cells: _vertical,
    colorIndex: 0,
    targetOrigin: BlockPosition(6, _stemCol),
    spawnOrigin: BlockPosition(6, _stemCol),
  ),
  PuzzleBrick(
    id: 'f_bare_e',
    cells: [BlockPosition(0, 0)],
    colorIndex: 0,
    targetOrigin: BlockPosition(8, _stemCol),
    spawnOrigin: BlockPosition(8, _stemCol),
  ),
];

/// أ carries its hamza only at the start of a word. Once joined to a letter
/// before it, alef is written as a bare full-height stroke with a connecting
/// foot — so the medial and final drawings are the same bricks.
// `final` rather than `const`: the hamza's studs are generated by a loop.
final List<PuzzleBrick> _initialBricks = [..._hamza, ..._stem];
const List<PuzzleBrick> _medialBricks = [..._fullStem, ..._foot];
const List<PuzzleBrick> _finalBricks = _medialBricks;
