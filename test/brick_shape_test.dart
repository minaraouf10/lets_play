import 'dart:ui' show PictureRecorder;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lets_play/core/constants/app_dimensions.dart';
import 'package:lets_play/modules/home/games/domain/entities/block_position.dart';
import 'package:lets_play/modules/home/games/presentation/widgets/puzzle/brick_shape.dart';

void main() {
  const pitch = 42.0;

  Widget host(Widget child) => MaterialApp(
        home: Scaffold(body: Center(child: child)),
      );

  group('BrickShape layout box', () {
    testWidgets('a 1x1 brick measures exactly one cell, studs excluded',
        (tester) async {
      await tester.pumpWidget(
        host(
          const BrickShape(
            cells: [BlockPosition(0, 0)],
            color: Colors.orange,
            cellPitch: pitch,
          ),
        ),
      );

      // The overhanging stud must not inflate the widget's size, or every
      // Positioned on the canvas would be off by the stud height.
      final size = tester.getSize(find.byType(BrickShape));
      expect(size.width, pitch - AppDimensions.gameCellGap);
      expect(size.height, pitch - AppDimensions.gameCellGap);
    });

    testWidgets('a 1x2 horizontal brick spans two cells wide, one tall',
        (tester) async {
      await tester.pumpWidget(
        host(
          const BrickShape(
            cells: [BlockPosition(0, 0), BlockPosition(0, 1)],
            color: Colors.orange,
            cellPitch: pitch,
          ),
        ),
      );

      final size = tester.getSize(find.byType(BrickShape));
      expect(size.width, 2 * pitch - AppDimensions.gameCellGap);
      expect(size.height, pitch - AppDimensions.gameCellGap);
    });

    testWidgets('a 1x2 vertical brick spans one cell wide, two tall',
        (tester) async {
      await tester.pumpWidget(
        host(
          const BrickShape(
            cells: [BlockPosition(0, 0), BlockPosition(1, 0)],
            color: Colors.orange,
            cellPitch: pitch,
          ),
        ),
      );

      final size = tester.getSize(find.byType(BrickShape));
      expect(size.width, pitch - AppDimensions.gameCellGap);
      expect(size.height, 2 * pitch - AppDimensions.gameCellGap);
    });

    testWidgets('an empty brick renders nothing', (tester) async {
      await tester.pumpWidget(
        host(
          const BrickShape(
            cells: [],
            color: Colors.orange,
            cellPitch: pitch,
          ),
        ),
      );

      expect(tester.getSize(find.byType(BrickShape)), Size.zero);
    });
  });

  group('studs', () {
    /// Records what the brick painter draws, so the flat face can be checked
    /// without golden files.
    Future<_Drawn> drawnFor(WidgetTester tester, List<BlockPosition> cells,
        {double cellPitch = pitch}) async {
      await tester.pumpWidget(
        host(
          BrickShape(
            cells: cells,
            color: Colors.orange,
            cellPitch: cellPitch,
          ),
        ),
      );

      final painter = tester
          .widgetList<CustomPaint>(
            find.descendant(
              of: find.byType(BrickShape),
              matching: find.byType(CustomPaint),
            ),
          )
          .firstWhere((p) => p.painter != null)
          .painter!;

      final recorder = PictureRecorder();
      final canvas = _RecordingCanvas(Canvas(recorder));
      painter.paint(canvas, tester.getSize(find.byType(BrickShape)));
      return _Drawn(canvas.circles, canvas.rrects);
    }

    testWidgets('one stud is drawn per cell', (tester) async {
      final drawn = await drawnFor(tester, const [
        BlockPosition(0, 0),
        BlockPosition(0, 1),
        BlockPosition(1, 0),
        BlockPosition(1, 1),
      ]);

      expect(drawn.circles, hasLength(4));
    });

    testWidgets('studs sit inside the brick, not above it', (tester) async {
      final drawn = await drawnFor(tester, const [BlockPosition(0, 0)]);
      final size = tester.getSize(find.byType(BrickShape));
      final radius = pitch * AppDimensions.gameStudDiameterRatio / 2;

      // The reference brick is seen straight-on, so every stud is fully on
      // the face — nothing overhangs the layout box.
      for (final centre in drawn.circles) {
        expect(centre.dy - radius, greaterThanOrEqualTo(0));
        expect(centre.dy + radius, lessThanOrEqualTo(size.height));
        expect(centre.dx - radius, greaterThanOrEqualTo(0));
        expect(centre.dx + radius, lessThanOrEqualTo(size.width));
      }
    });

    testWidgets('each stud is centred in its own cell', (tester) async {
      final drawn = await drawnFor(
        tester,
        const [BlockPosition(0, 0), BlockPosition(0, 1)],
      );

      final half = (pitch - AppDimensions.gameCellGap) / 2;
      expect(drawn.circles[0], Offset(half, half));
      expect(drawn.circles[1], Offset(pitch + half, half));
    });

    testWidgets('studs scale with the cell pitch', (tester) async {
      // Canvases render at different pitches; a fixed stud size would look
      // wrong on the small ones.
      final small = await drawnFor(
        tester,
        const [BlockPosition(0, 0)],
        cellPitch: 20,
      );
      final large = await drawnFor(
        tester,
        const [BlockPosition(0, 0)],
        cellPitch: 60,
      );

      expect(small.circles.single.dx, lessThan(large.circles.single.dx));
    });

    testWidgets('the body is drawn as one rounded square', (tester) async {
      final drawn = await drawnFor(
        tester,
        const [BlockPosition(0, 0), BlockPosition(1, 0)],
      );

      // Fill and outline of a single fused body — never one shape per cell.
      expect(drawn.rrects, hasLength(2));
      for (final r in drawn.rrects) {
        expect(r.tlRadiusX, AppDimensions.gameBrickRadius);
      }
    });
  });
}

/// What a single paint pass put on the canvas.
class _Drawn {
  const _Drawn(this.circles, this.rrects);

  /// Centre of every circle drawn — one per stud.
  final List<Offset> circles;

  /// Every rounded rect drawn — the brick body's fill and outline.
  final List<RRect> rrects;
}

/// A [Canvas] that records the shapes it is asked to draw, so a painter can
/// be asserted on directly instead of through golden images.
class _RecordingCanvas implements Canvas {
  _RecordingCanvas(this._inner);

  final Canvas _inner;
  final List<Offset> circles = [];
  final List<RRect> rrects = [];

  @override
  void drawCircle(Offset c, double radius, Paint paint) {
    circles.add(c);
    _inner.drawCircle(c, radius, paint);
  }

  @override
  void drawRRect(RRect rrect, Paint paint) {
    rrects.add(rrect);
    _inner.drawRRect(rrect, paint);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      // Anything the painter draws beyond circles and rounded rects is not
      // part of what these tests assert on.
      null;
}
