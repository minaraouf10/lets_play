import 'package:flutter_test/flutter_test.dart';
import 'package:lets_play/modules/home/games/data/datasources/games_local_datasource.dart';
import 'package:lets_play/modules/home/learning/data/datasources/learning_local_datasource.dart';
import 'package:lets_play/modules/home/learning/domain/entities/level_type.dart';

void main() {
  late List<dynamic> levels;

  setUpAll(() async {
    levels = await LearningLocalDataSourceImpl().getLevels();
  });

  dynamic levelOf(LevelType type) =>
      levels.firstWhere((l) => l.type == type);

  group('lesson catalogue', () {
    test('level 1 lists the full alphabet plus the hamza carriers', () {
      final lessons = levelOf(LevelType.letters).lessons;

      // 28 letters + lam-alef + lam-meem + 5 hamza forms.
      expect(lessons, hasLength(35));
      expect(lessons.first.glyph, 'أ');
      expect(
        lessons.map((l) => l.glyph),
        containsAll(['ب', 'ح', 'ر', 'ض', 'ط', 'ف', 'ن', 'ي', 'لا', 'ء']),
      );
    });

    test('level 2 lists every tashkeel mark', () {
      final lessons = levelOf(LevelType.tashkeel).lessons;

      // Three short vowels, sukoon, shadda, three tanween.
      expect(lessons, hasLength(8));
      expect(
        lessons.map((l) => l.id),
        containsAll([
          'l2_fatha',
          'l2_kasra',
          'l2_damma',
          'l2_sukoon',
          'l2_shadda',
          'l2_fathatan',
          'l2_kasratan',
          'l2_dammatan',
        ]),
      );
    });

    test('level 3 lists the digits, the hundreds and one thousand', () {
      final lessons = levelOf(LevelType.numbers).lessons;

      expect(lessons, hasLength(20));
      expect(lessons.first.glyph, '١');
      expect(lessons.last.glyph, '١٠٠٠');
    });

    test('lesson ids are unique across the whole catalogue', () {
      // A duplicate id would make two tiles open the same lesson.
      final ids = [
        for (final level in levels)
          for (final lesson in level.lessons) lesson.id as String,
      ];

      expect(ids.toSet(), hasLength(ids.length));
    });

    test('every lesson has a glyph and a transliteration to show', () {
      for (final level in levels) {
        for (final lesson in level.lessons) {
          expect(lesson.glyph, isNotEmpty, reason: '${lesson.id} has no glyph');
          expect(
            lesson.transliteration,
            isNotEmpty,
            reason: '${lesson.id} has no transliteration',
          );
        }
      }
    });
  });

  group('unlocked lessons are playable', () {
    test('every unlocked lesson has a puzzle behind it', () async {
      // Locked tiles are not tappable, so they may ship without content —
      // but an unlocked one that has no puzzle would crash on open.
      final source = GamesLocalDataSourceImpl();

      for (final level in levels) {
        for (final lesson in level.lessons) {
          if (!(lesson.isUnlocked as bool)) continue;
          if (level.type == LevelType.words ||
              level.type == LevelType.sentences) {
            // Word and sentence lessons run their own flow, not the puzzle.
            continue;
          }

          await expectLater(
            source.getLetterPuzzle(lesson.id as String),
            completes,
            reason: '${lesson.id} is unlocked but has no puzzle',
          );
        }
      }
    });
  });
}
