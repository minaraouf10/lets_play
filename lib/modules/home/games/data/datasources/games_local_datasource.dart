import 'package:injectable/injectable.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../domain/entities/block_position.dart';
import '../../domain/entities/puzzle_brick.dart';
import '../models/letter_puzzle_model.dart';
import 'letter_forms_data.dart';

/// Offline-first puzzle definitions. Each Level 1 letter is a 7x5 grid
/// whose '#' cells outline the letter shape the child must build.
/// Approximate shapes for the prototype; refined with the design team later.
abstract class GamesLocalDataSource {
  Future<LetterPuzzleModel> getLetterPuzzle(String lessonId);
}

@LazySingleton(as: GamesLocalDataSource)
class GamesLocalDataSourceImpl implements GamesLocalDataSource {
  @override
  Future<LetterPuzzleModel> getLetterPuzzle(String lessonId) async {
    final def = _puzzles[lessonId];
    if (def == null) throw CacheException('No puzzle for $lessonId');
    return def;
  }

  static final Map<String, LetterPuzzleModel> _puzzles = {
    'l1_alef': LetterPuzzleModel.fromBricks(
      lessonId: 'l1_alef',
      glyph: 'أ',
      transliteration: 'aa',
      rows: 9,
      cols: 8,
      // Three brick shapes are used project-wide: a 1x1 single stud, a 1x2
      // double stud, and a 2x2 square (four studs fused into one piece).
      //
      // Shape (أ): a red hamza stepping down-left onto a wider base, above a
      // 1-stud-wide orange stem with a blank row between them. The board is
      // 8 columns wide so it spans the screen; the letter sits in the middle
      // and the loose bricks start scattered down the free columns on either
      // side. Must stay identical to the initial form in
      // `letter_forms_data.dart`, so the shape taught is the shape the child
      // builds — a test asserts that.
      //   col:    0 1 2 3 4 5 6 7
      //   row 0 |         H
      //   row 1 |       H
      //   row 2 |       H H
      //   row 3 |
      //   row 4 |         S
      //   row 5 |         S
      //   row 6 |         S
      //   row 7 |         S
      //   row 8 |         S

      bricks: [
        // The hamza is placed one stud at a time, so it is 4 separate 1x1
        // pieces. The cell list is shared with `letter_forms_data.dart` so
        // the game and the forms screen cannot drift apart.
        ...buildHamzaStuds(
          idPrefix: 'hamza_',
          // Spread across the far-left and far-right columns, well away from
          // their targets, so the child has to carry each stud into place.
          spawnAt: (i, _) => BlockPosition(i * 2, i.isEven ? 0 : 7),
        ),
        const PuzzleBrick(
          id: 'stem_a',
          cells: [BlockPosition(0, 0), BlockPosition(1, 0)],
          colorIndex: 0,
          targetOrigin: BlockPosition(4, 4),
          spawnOrigin: BlockPosition(0, 2),
        ),
        const PuzzleBrick(
          id: 'stem_b',
          cells: [BlockPosition(0, 0), BlockPosition(1, 0)],
          colorIndex: 0,
          targetOrigin: BlockPosition(6, 4),
          spawnOrigin: BlockPosition(0, 6),
        ),
        const PuzzleBrick(
          id: 'stem_c',
          cells: [BlockPosition(0, 0)],
          colorIndex: 0,
          targetOrigin: BlockPosition(8, 4),
          spawnOrigin: BlockPosition(7, 1),
        ),
      ],
    ),
    'l1_ba': LetterPuzzleModel.fromBitmap(
      lessonId: 'l1_ba',
      glyph: 'ب',
      transliteration: 'b',
      bitmap: const [
        '.....',
        '.....',
        '#...#',
        '#...#',
        '#####',
        '.....',
        '..#..',
      ],
    ),
    'l1_ta': LetterPuzzleModel.fromBitmap(
      lessonId: 'l1_ta',
      glyph: 'ت',
      transliteration: 't',
      bitmap: const [
        '.#.#.',
        '.....',
        '#...#',
        '#...#',
        '#####',
        '.....',
        '.....',
      ],
    ),
    'l1_tha': LetterPuzzleModel.fromBitmap(
      lessonId: 'l1_tha',
      glyph: 'ث',
      transliteration: 'th',
      bitmap: const [
        '.###.',
        '.....',
        '#...#',
        '#...#',
        '#####',
        '.....',
        '.....',
      ],
    ),
    'l1_jeem': LetterPuzzleModel.fromBitmap(
      lessonId: 'l1_jeem',
      glyph: 'ج',
      transliteration: 'j',
      bitmap: const [
        '#####',
        '....#',
        '...#.',
        '..##.',
        '.....',
        '.....',
        '..#..',
      ],
    ),

    // ── Level 2 (Tashkeel) ────────────────────────────────────────────────
    // The fat-ha is a short diagonal stroke drawn *above* the baseline,
    // built from three single studs climbing left-to-right.
    //   col:    0 1 2
    //   row 0 |     B
    //   row 1 |   B
    //   row 2 | B
    'l2_fatha': LetterPuzzleModel.fromBricks(
      lessonId: 'l2_fatha',
      glyph: 'كَ',
      transliteration: 'ka',
      rows: 3,
      cols: 3,
      bricks: const [
        PuzzleBrick(
          id: 'fatha_top',
          cells: [BlockPosition(0, 0)],
          colorIndex: 0,
          targetOrigin: BlockPosition(0, 2),
          spawnOrigin: BlockPosition(2, 0),
        ),
        PuzzleBrick(
          id: 'fatha_mid',
          cells: [BlockPosition(0, 0)],
          colorIndex: 0,
          targetOrigin: BlockPosition(1, 1),
          spawnOrigin: BlockPosition(0, 0),
        ),
        PuzzleBrick(
          id: 'fatha_base',
          cells: [BlockPosition(0, 0)],
          colorIndex: 0,
          targetOrigin: BlockPosition(2, 0),
          spawnOrigin: BlockPosition(1, 2),
        ),
      ],
    ),

    // ── Level 3 (Numbers) ─────────────────────────────────────────────────
    // The Arabic-Indic one (١) is a plain vertical stroke sitting on the
    // baseline — a single orange column built from four 1x2 bricks.
    //   col:    0 1 2 3
    //   row 0 |     S
    //   ...     (stem continues down column 2)
    //   row 7 |     S
    'l3_one': LetterPuzzleModel.fromBricks(
      lessonId: 'l3_one',
      glyph: '١',
      transliteration: '1',
      rows: 8,
      cols: 4,
      bricks: const [
        PuzzleBrick(
          id: 'one_a',
          cells: [BlockPosition(0, 0), BlockPosition(1, 0)],
          colorIndex: 0,
          targetOrigin: BlockPosition(0, 2),
          spawnOrigin: BlockPosition(2, 0),
        ),
        PuzzleBrick(
          id: 'one_b',
          cells: [BlockPosition(0, 0), BlockPosition(1, 0)],
          colorIndex: 0,
          targetOrigin: BlockPosition(2, 2),
          spawnOrigin: BlockPosition(0, 0),
        ),
        PuzzleBrick(
          id: 'one_c',
          cells: [BlockPosition(0, 0), BlockPosition(1, 0)],
          colorIndex: 0,
          targetOrigin: BlockPosition(4, 2),
          spawnOrigin: BlockPosition(5, 3),
        ),
        PuzzleBrick(
          id: 'one_d',
          cells: [BlockPosition(0, 0), BlockPosition(1, 0)],
          colorIndex: 0,
          targetOrigin: BlockPosition(6, 2),
          spawnOrigin: BlockPosition(6, 0),
        ),
      ],
    ),
  };
}
