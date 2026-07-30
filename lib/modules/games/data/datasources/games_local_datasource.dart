import 'package:injectable/injectable.dart';

import '../../../../core/errors/exceptions.dart';
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
    'l1_alef': LetterPuzzleModel.fromBitmap(
      lessonId: 'l1_alef',
      glyph: 'ا',
      transliteration: 'aa',
      bitmap: const [
        '..#..',
        '..#..',
        '..#..',
        '..#..',
        '..#..',
        '..#..',
        '..#..',
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
