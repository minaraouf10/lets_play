import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/utils/usecase.dart';
import '../../domain/entities/level_entity.dart';
import '../../domain/usecases/get_levels_usecase.dart';

part 'levels_state.dart';

@injectable
class LevelsCubit extends Cubit<LevelsState> {
  LevelsCubit(this._getLevelsUseCase) : super(const LevelsState());

  final GetLevelsUseCase _getLevelsUseCase;

  Future<void> loadLevels() async {
    emit(state.copyWith(status: LevelsStatus.loading));
    final result = await _getLevelsUseCase(const NoParams());
    result.fold(
      (failure) => emit(state.copyWith(
        status: LevelsStatus.error,
        errorMessage: failure.message,
      )),
      (levels) => emit(state.copyWith(
        status: LevelsStatus.loaded,
        levels: levels,
      )),
    );
  }
}
