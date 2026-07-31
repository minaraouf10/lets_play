import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  SplashCubit()
      : super(const SplashState(stage: SplashStage.bricks, frameIndex: 0));

  static const Duration frame1 = Duration(milliseconds: 700);
  static const Duration frame2 = Duration(milliseconds: 700);
  static const Duration frame3 = Duration(milliseconds: 700);
  static const Duration frame4 = Duration(milliseconds: 700);

  Future<void> play() async {
    // Frame 1 is already emitted via initial state (frameIndex: 0).
    await Future.delayed(frame1);
    if (isClosed) return;

    // Frame 2
    emit(state.copyWith(frameIndex: 1));
    await Future.delayed(frame2);
    if (isClosed) return;

    // Frame 3
    emit(state.copyWith(frameIndex: 2));
    await Future.delayed(frame3);
    if (isClosed) return;

    // Frame 4
    emit(state.copyWith(frameIndex: 3));
    await Future.delayed(frame4);
    if (isClosed) return;

    // Logo. The build-up animation ends here — the logo card stays on
    // screen until the user taps it (see continueFromLogo()).
    emit(state.copyWith(stage: SplashStage.logo));
  }

  /// Called when the user taps the logo card. Advances past the splash.
  void continueFromLogo() {
    if (state.stage != SplashStage.logo) return;
    emit(state.copyWith(stage: SplashStage.finished));
  }
}
