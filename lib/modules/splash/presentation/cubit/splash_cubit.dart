import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState(stage: SplashStage.gif));

  /// Must match splash.gif's real playback length (4 frames x 300ms).
  /// Update this if the GIF file is replaced with a different-length one.
  static const Duration gifDuration = Duration(milliseconds: 1800);

  /// How long the logo card stays on screen before auto-advancing.
  static const Duration logoDuration = Duration(milliseconds: 500);

  Future<void> play() async {
    await Future.delayed(gifDuration);
    if (isClosed) return;

    emit(state.copyWith(stage: SplashStage.logo));
    await Future.delayed(logoDuration);
    if (isClosed) return;

    emit(state.copyWith(stage: SplashStage.finished));
  }
}
