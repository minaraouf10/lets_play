part of 'splash_cubit.dart';

enum SplashStage { gif, logo, finished }

class SplashState extends Equatable {
  const SplashState({required this.stage});

  final SplashStage stage;

  SplashState copyWith({SplashStage? stage}) {
    return SplashState(stage: stage ?? this.stage);
  }

  @override
  List<Object?> get props => [stage];
}
