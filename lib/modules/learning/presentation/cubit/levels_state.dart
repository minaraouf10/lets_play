part of 'levels_cubit.dart';

enum LevelsStatus { initial, loading, loaded, error }

class LevelsState extends Equatable {
  const LevelsState({
    this.status = LevelsStatus.initial,
    this.levels = const [],
    this.errorMessage,
  });

  final LevelsStatus status;
  final List<LevelEntity> levels;
  final String? errorMessage;

  LevelsState copyWith({
    LevelsStatus? status,
    List<LevelEntity>? levels,
    String? errorMessage,
  }) {
    return LevelsState(
      status: status ?? this.status,
      levels: levels ?? this.levels,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, levels, errorMessage];
}
