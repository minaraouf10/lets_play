import 'package:equatable/equatable.dart';

/// What the player earned in a finished lesson, shown on the congratulations
/// screen.
class LessonResult extends Equatable {
  const LessonResult({
    required this.points,
    required this.accuracy,
    required this.elapsed,
  });

  /// Total points after this lesson.
  final int points;

  /// Share of answers got right on the first try, 0..1.
  final double accuracy;

  /// How long the lesson took.
  final Duration elapsed;

  /// Accuracy as a whole percentage, e.g. 82.
  int get accuracyPercent => (accuracy * 100).round();

  /// Elapsed time as "m:ss", e.g. "1:50".
  String get formattedTime {
    final minutes = elapsed.inMinutes;
    final seconds = elapsed.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  List<Object?> get props => [points, accuracy, elapsed];
}
