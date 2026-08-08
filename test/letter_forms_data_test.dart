import 'package:flutter_test/flutter_test.dart';
import 'package:lets_play/modules/home/games/data/datasources/games_local_datasource.dart';
import 'package:lets_play/modules/home/games/data/datasources/letter_forms_data.dart';
import 'package:lets_play/modules/home/games/domain/entities/letter_form.dart';
import 'package:lets_play/modules/home/games/domain/entities/puzzle_brick.dart';

void main() {
  group('kLetterForms', () {
    test('alef teaches the three word positions, in reading order', () {
      final forms = kLetterForms['l1_alef']!;

      expect(
        forms.map((f) => f.type).toList(),
        [
          LetterFormType.initial,
          LetterFormType.medial,
          LetterFormType.final_,
        ],
      );
    });

    test('every form names its position and shows how it is written', () {
      for (final form in kLetterForms.values.expand((f) => f)) {
        expect(form.label, isNotEmpty);
        expect(
          form.glyph,
          isNotEmpty,
          reason: '${form.label} must show the written letter',
        );
      }
    });

    test('every brick is a 1x1, 1x2 or 2x2 — no other shape is in the set', () {
      // The game only ever hands the child a single stud, a fused double
      // stud, or a 2x2 square, so a form drawn from any other footprint
      // would show a piece the child cannot actually build.
      for (final form in kLetterForms.values.expand((f) => f)) {
        for (final brick in form.bricks) {
          expect(
            brick.cells.length,
            anyOf(1, 2, 4),
            reason: '${brick.id} has ${brick.cells.length} cells',
          );
          expect(
            brick.width * brick.height,
            brick.cells.length,
            reason: '${brick.id} is not a solid rectangle',
          );
          expect(
            brick.width <= 2 && brick.height <= 2,
            isTrue,
            reason: '${brick.id} is larger than 2x2',
          );
        }
      }
    });

    test('no two bricks in a form overlap', () {
      for (final form in kLetterForms.values.expand((f) => f)) {
        final occupied = <String, String>{};

        for (final brick in form.bricks) {
          for (final cell in brick.cells) {
            final row = brick.targetOrigin.row + cell.row;
            final col = brick.targetOrigin.col + cell.col;
            final key = '$row:$col';

            expect(
              occupied.containsKey(key),
              isFalse,
              reason: '${form.label}: ${brick.id} overlaps '
                  '${occupied[key]} at ($row,$col)',
            );
            occupied[key] = brick.id;
          }
        }
      }
    });

    test('every brick lands inside its form grid', () {
      for (final form in kLetterForms.values.expand((f) => f)) {
        for (final brick in form.bricks) {
          final maxRow = brick.targetOrigin.row + brick.height - 1;
          final maxCol = brick.targetOrigin.col + brick.width - 1;

          expect(
            maxRow,
            lessThan(form.rows),
            reason: '${form.label}: ${brick.id} runs past the last row',
          );
          expect(
            maxCol,
            lessThan(form.cols),
            reason: '${form.label}: ${brick.id} runs past the last column',
          );
        }
      }
    });

    test('only the initial form carries the hamza', () {
      final byType = {
        for (final form in kLetterForms['l1_alef']!) form.type: form,
      };

      bool hasHamza(LetterForm form) =>
          form.bricks.any((b) => b.id.contains('hamza'));

      // أ carries its hamza at the start of a word. Once joined to a letter
      // before it, alef is written as the bare stem "ـا".
      expect(hasHamza(byType[LetterFormType.initial]!), isTrue);
      expect(hasHamza(byType[LetterFormType.medial]!), isFalse);
      expect(hasHamza(byType[LetterFormType.final_]!), isFalse);
    });

    test('the hamza steps down-left onto a wider base', () {
      final initial = kLetterForms['l1_alef']!
          .firstWhere((f) => f.type == LetterFormType.initial);

      final hamza =
          initial.bricks.where((b) => b.id.contains('hamza')).toList();

      final cells = {
        for (final brick in hamza)
          for (final cell in brick.cells)
            '${brick.targetOrigin.row + cell.row}:'
                '${brick.targetOrigin.col + cell.col}',
      };

      // Top stud at col 4, stepping left to col 3, then a base that widens
      // back to the right — the step is what makes it read as a hamza
      // rather than a plain vertical tick.
      expect(cells, {
        '0:4',
        '1:3',
        '2:3', '2:4',
      });
    });

    test('the hamza is built from single studs', () {
      final initial = kLetterForms['l1_alef']!
          .firstWhere((f) => f.type == LetterFormType.initial);

      final hamza =
          initial.bricks.where((b) => b.id.contains('hamza')).toList();

      // The child places the hamza one stud at a time, so every piece of it
      // must be 1x1 — a fused brick would place several cells at once.
      expect(hamza, hasLength(4));
      for (final brick in hamza) {
        expect(
          brick.cells,
          hasLength(1),
          reason: '${brick.id} is not a single stud',
        );
      }
    });

    test('the hamza never touches the stem', () {
      final initial = kLetterForms['l1_alef']!
          .firstWhere((f) => f.type == LetterFormType.initial);

      int lowestOf(bool Function(String) match) => initial.bricks
          .where((b) => match(b.id))
          .expand((b) => b.cells.map((c) => b.targetOrigin.row + c.row))
          .reduce((a, b) => a > b ? a : b);

      int highestOf(bool Function(String) match) => initial.bricks
          .where((b) => match(b.id))
          .expand((b) => b.cells.map((c) => b.targetOrigin.row + c.row))
          .reduce((a, b) => a < b ? a : b);

      final hamzaBottom = lowestOf((id) => id.contains('hamza'));
      final stemTop = highestOf((id) => id.contains('stem'));

      // أ is written as two separate strokes; a gap of at least one row
      // keeps them from reading as one joined piece.
      expect(stemTop - hamzaBottom, greaterThan(1));
    });

    test('alef is drawn the same in the middle and at the end', () {
      // A non-connecting letter joins to its right only, so both positions
      // resolve to the same bricks. The written glyph may still differ in
      // how much tatweel it shows.
      final byType = {
        for (final form in kLetterForms['l1_alef']!) form.type: form,
      };

      expect(
        byType[LetterFormType.medial]!.bricks,
        byType[LetterFormType.final_]!.bricks,
      );
    });

    test('the stem is connected — no gap down the column', () {
      for (final form in kLetterForms.values.expand((f) => f)) {
        final stemRows = <int>{};

        for (final brick in form.bricks) {
          if (brick.id.contains('hamza')) continue;
          for (final cell in brick.cells) {
            // The stroke runs down column 4; the connecting foot sits beside
            // it on the last row and is not part of the vertical run.
            if (brick.targetOrigin.col + cell.col == 4) {
              stemRows.add(brick.targetOrigin.row + cell.row);
            }
          }
        }

        final sorted = stemRows.toList()..sort();
        for (var i = 1; i < sorted.length; i++) {
          expect(
            sorted[i] - sorted[i - 1],
            1,
            reason: '${form.label}: the stem breaks between '
                'row ${sorted[i - 1]} and row ${sorted[i]}',
          );
        }
      }
    });
  });

  group('forms match the puzzle geometry', () {
    test('every form uses the puzzle grid', () {
      // The forms screen and the game must draw أ at the same proportions,
      // otherwise the shape the child builds looks unlike the one taught.
      for (final form in kLetterForms['l1_alef']!) {
        expect(form.rows, 9);
        expect(form.cols, 8);
      }
    });

    test('the initial form is the full puzzle shape', () {
      final initial = kLetterForms['l1_alef']!
          .firstWhere((f) => f.type == LetterFormType.initial);

      Set<String> cellsOf(List<PuzzleBrick> bricks) => {
            for (final brick in bricks)
              for (final cell in brick.cells)
                '${brick.targetOrigin.row + cell.row}:'
                    '${brick.targetOrigin.col + cell.col}',
          };

      // Hamza across rows 0..2, blank row 3, then the 1-wide stroke running
      // straight down column 4 to row 8.
      expect(
        cellsOf(initial.bricks),
        {
          '0:4',
          '1:3',
          '2:3', '2:4',
          for (var row = 4; row <= 8; row++) '$row:4',
        },
      );
    });

    test('the game builds exactly the shape the forms screen teaches',
        () async {
      // The two live in separate files and drifted apart once already: the
      // forms screen showed the staircase hamza while the game still handed
      // out the old two-brick hook.
      final puzzle =
          await GamesLocalDataSourceImpl().getLetterPuzzle('l1_alef');
      final initial = kLetterForms['l1_alef']!
          .firstWhere((f) => f.type == LetterFormType.initial);

      Set<String> cellsOf(List<PuzzleBrick> bricks) => {
            for (final brick in bricks)
              for (final cell in brick.cells)
                '${brick.targetOrigin.row + cell.row}:'
                    '${brick.targetOrigin.col + cell.col}',
          };

      expect(puzzle.rows, initial.rows);
      expect(puzzle.cols, initial.cols);
      expect(cellsOf(puzzle.bricks), cellsOf(initial.bricks));
    });
  });
}
