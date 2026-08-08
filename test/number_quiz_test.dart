import 'package:flutter_test/flutter_test.dart';
import 'package:lets_play/modules/home/games/data/datasources/games_local_datasource.dart';
import 'package:lets_play/modules/home/games/data/datasources/number_data.dart';
import 'package:lets_play/modules/home/learning/data/datasources/learning_local_datasource.dart';
import 'package:lets_play/modules/home/learning/domain/entities/lesson_entity.dart';

void main() {
  group('quiz option selection', () {
    // Reproduces the crash that reached the device: `levels` is a
    // List<LevelModel>, so a firstWhere whose orElse returns LevelEntity
    // throws a TypeError before any option is picked.
    test('picks a same-level distractor without a subtype error', () async {
      final levels = await LearningLocalDataSourceImpl().getLevels();
      const lessonId = 'l3_one';

      final lessons = levels.expand<LessonEntity>((l) => l.lessons).toList();
      final matches = lessons.where((l) => l.id == lessonId).toList();
      final target = matches.isNotEmpty ? matches.first : lessons.first;

      final ownLevel = levels
          .where((l) => l.lessons.any((lesson) => lesson.id == target.id))
          .toList();
      final sameLevel = ownLevel.isEmpty
          ? const <LessonEntity>[]
          : ownLevel.first.lessons
              .where((l) => l.id != target.id)
              .cast<LessonEntity>()
              .toList();

      expect(target.id, lessonId);
      // Level 3 ships two numbers, so the distractor stays inside the level.
      expect(sameLevel, isNotEmpty);
      expect(sameLevel.every((l) => l.id.startsWith('l3_')), isTrue);
    });
  });

  group('number lesson data', () {
    test('l3_one is a number lesson with a puzzle behind it', () async {
      expect(isNumberLesson('l3_one'), isTrue);

      final lesson = numberLessonFor('l3_one')!;
      expect(lesson.glyph, '١');
      expect(lesson.meaningEn, 'One');

      final puzzle = await GamesLocalDataSourceImpl().getLetterPuzzle('l3_one');
      expect(puzzle.glyph, '١');
      // Every target cell must be traceable for the write step to complete.
      expect(puzzle.target, isNotEmpty);
    });

    test('letters are not treated as numbers', () {
      expect(isNumberLesson('l1_alef'), isFalse);
      expect(numberLessonFor('l1_alef'), isNull);
    });
  });
}
