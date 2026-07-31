part of 'splash_cubit.dart';

enum SplashStage { bricks, logo, finished }

class SplashState extends Equatable {
  final SplashStage stage;
  final int frameIndex;

  const SplashState({
    required this.stage,
    required this.frameIndex,
  });

  SplashState copyWith({
    SplashStage? stage,
    int? frameIndex,
  }) {
    return SplashState(
      stage: stage ?? this.stage,
      frameIndex: frameIndex ?? this.frameIndex,
    );
  }

  @override
  List<Object?> get props => [stage, frameIndex];
}
