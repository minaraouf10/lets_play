import 'package:injectable/injectable.dart';

import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/block_position.dart';
import '../../domain/entities/puzzle_brick.dart';
import '../models/letter_puzzle_model.dart';

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
      cols: 4,
      // Only two brick shapes are used project-wide: a 1x1 single stud and
      // a 1x2 double stud (two studs fused into one physical piece).
      //
      // Shape (أ): a stepped red hamza hook sitting on an orange stem.
      //   col:    0 1 2 3
      //   row 0 |     H H
      //   row 1 |   H H
      //   row 2 |     S
      //   ...     (stem continues down column 2)
      //   row 8 |     S
      bricks: const [
        PuzzleBrick(
          id: 'hamza_top',
          cells: [BlockPosition(0, 0), BlockPosition(0, 1)],
          colorIndex: 1,
          targetOrigin: BlockPosition(0, 2),
          spawnOrigin: BlockPosition(3, 0),
        ),
        PuzzleBrick(
          id: 'hamza_step',
          cells: [BlockPosition(0, 0), BlockPosition(0, 1)],
          colorIndex: 1,
          targetOrigin: BlockPosition(1, 1),
          spawnOrigin: BlockPosition(6, 0),
        ),
        PuzzleBrick(
          id: 'stem_a',
          cells: [BlockPosition(0, 0), BlockPosition(1, 0)],
          colorIndex: 0,
          targetOrigin: BlockPosition(2, 2),
          spawnOrigin: BlockPosition(1, 0),
        ),
        PuzzleBrick(
          id: 'stem_b',
          cells: [BlockPosition(0, 0), BlockPosition(1, 0)],
          colorIndex: 0,
          targetOrigin: BlockPosition(4, 2),
          spawnOrigin: BlockPosition(4, 0),
        ),
        PuzzleBrick(
          id: 'stem_c',
          cells: [BlockPosition(0, 0), BlockPosition(1, 0)],
          colorIndex: 0,
          targetOrigin: BlockPosition(6, 2),
          spawnOrigin: BlockPosition(7, 3),
        ),
        PuzzleBrick(
          id: 'stem_foot',
          cells: [BlockPosition(0, 0)],
          colorIndex: 0,
          targetOrigin: BlockPosition(8, 2),
          spawnOrigin: BlockPosition(0, 0),
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
  };
}
