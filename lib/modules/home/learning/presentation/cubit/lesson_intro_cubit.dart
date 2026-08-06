import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/datasources/level_objectives_data.dart';
import '../../domain/entities/level_type.dart';

part 'lesson_intro_state.dart';

/// Drives the "lesson intro" flow shown before a puzzle starts: an optional
/// level objectives card, then a lesson/level info card, then the "tap the
/// blocks" instructions.
@injectable
class LessonIntroCubit extends Cubit<LessonIntroState> {
  LessonIntroCubit() : super(const LessonIntroState());

  /// Starts on the objectives card when [levelType] has one, otherwise on the
  /// lesson card — which is where every level began before Level 3.
  void start(LevelType levelType) {
    if (!hasObjectives(levelType)) return;
    emit(const LessonIntroState(step: LessonIntroStep.level));
  }

  void continuePressed() {
    final next = LessonIntroStep.values[
        (state.step.index + 1).clamp(0, LessonIntroStep.values.length - 1)];
    emit(state.copyWith(step: next));
  }
}
