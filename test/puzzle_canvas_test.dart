import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_play/modules/home/games/data/datasources/games_local_datasource.dart';
import 'package:lets_play/modules/home/games/domain/entities/letter_puzzle.dart';
import 'package:lets_play/modules/home/games/presentation/cubit/letter_game_cubit.dart';
import 'package:lets_play/modules/home/games/presentation/widgets/puzzle/puzzle_canvas.dart';

/// The canvas reads a cubit from the tree but never drives it in these tests,
/// so a bare state holder is enough.
class _StubCubit extends Cubit<LetterGameState> implements LetterGameCubit {
  _StubCubit(super.initialState);

  @override
  noSuchMethod(Invocation invocation) => null;
}

void main() {
  late LetterPuzzle puzzle;

  setUpAll(() async {
    puzzle = await GamesLocalDataSourceImpl().getLetterPuzzle('l1_alef');
  });

  Future<void> pumpCanvas(WidgetTester tester, Size screen) async {
    tester.view.physicalSize = screen;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    final state = LetterGameState(
      status: GameStatus.playing,
      puzzle: puzzle,
      positions: {
        for (final brick in puzzle.bricks)
          brick.id: Offset(
            brick.spawnOrigin.col.toDouble(),
            brick.spawnOrigin.row.toDouble(),
          ),
      },
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlocProvider<LetterGameCubit>.value(
            value: _StubCubit(state),
            child: PuzzleCanvas(puzzle: puzzle, state: state),
          ),
        ),
      ),
    );
  }

  group('PuzzleCanvas sizing', () {
    testWidgets('the background fills the space it is given', (tester) async {
      const screen = Size(400, 900);
      await pumpCanvas(tester, screen);

      // The dot-grid background is the page background, not a panel sized to
      // the letter, so it takes the full width and remaining height.
      final size = tester.getSize(find.byType(PuzzleCanvas));
      expect(size.width, screen.width);
      expect(size.height, screen.height);
    });

    testWidgets('the background still fills a much wider screen',
        (tester) async {
      const screen = Size(1200, 700);
      await pumpCanvas(tester, screen);

      final size = tester.getSize(find.byType(PuzzleCanvas));
      expect(size.width, screen.width);
      expect(size.height, screen.height);
    });

    testWidgets('the letter is centred inside the canvas', (tester) async {
      const screen = Size(400, 900);
      await pumpCanvas(tester, screen);

      final canvas = tester.getRect(find.byType(PuzzleCanvas));
      // The Stack holding the letter is the canvas' innermost sized box.
      final letter = tester.getRect(
        find
            .descendant(
              of: find.byType(PuzzleCanvas),
              matching: find.byType(Stack),
            )
            .first,
      );

      expect(
        letter.center.dx,
        closeTo(canvas.center.dx, 0.5),
        reason: 'the letter should sit in the middle horizontally',
      );
      expect(
        letter.center.dy,
        closeTo(canvas.center.dy, 0.5),
        reason: 'the letter should sit in the middle vertically',
      );
    });
  });
}
