part of 'lesson_intro_cubit.dart';

enum LessonIntroStep { lesson, play }

class LessonIntroState extends Equatable {
  const LessonIntroState({this.step = LessonIntroStep.lesson});

  final LessonIntroStep step;

  LessonIntroState copyWith({LessonIntroStep? step}) =>
      LessonIntroState(step: step ?? this.step);

  @override
  List<Object?> get props => [step];
}
