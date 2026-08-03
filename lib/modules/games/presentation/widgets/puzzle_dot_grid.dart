import '../../../../core/utils/app_imports.dart';

/// Faint dot grid background for the puzzle canvas.
class PuzzleDotGrid extends CustomPainter {
  const PuzzleDotGrid();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.gameDot
      ..style = PaintingStyle.fill;

    final spacing = AppDimensions.gameDotSpacing;
    final radius = AppDimensions.gameDotRadius;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(PuzzleDotGrid oldDelegate) => false;
}
