import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'lesson_intro_state.dart';

/// Drives the two-step "lesson intro" flow shown before a puzzle starts:
/// a lesson/level info card, then "tap the blocks" instructions.
@injectable
class LessonIntroCubit extends Cubit<LessonIntroState> {
  LessonIntroCubit() : super(const LessonIntroState());

  void continuePressed() => emit(state.copyWith(step: LessonIntroStep.play));
}
