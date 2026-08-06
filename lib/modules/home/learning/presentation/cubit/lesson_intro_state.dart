part of 'lesson_intro_cubit.dart';

/// Ordered steps of the intro flow. [level] only appears for levels that
/// have an objectives card (see [kLevelObjectives]); the cubit skips it
/// otherwise, so the flow starts on [lesson] exactly as it always has.
enum LessonIntroStep { level, lesson, play }

class LessonIntroState extends Equatable {
  const LessonIntroState({this.step = LessonIntroStep.lesson});

  final LessonIntroStep step;

  LessonIntroState copyWith({LessonIntroStep? step}) =>
      LessonIntroState(step: step ?? this.step);

  @override
  List<Object?> get props => [step];
}
