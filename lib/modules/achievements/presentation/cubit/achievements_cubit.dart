import '../../domain/entities/achievements_summary.dart';
import '../../domain/usecases/get_achievements_usecase.dart';
import '../../../../core/utils/app_imports.dart';

part 'achievements_state.dart';

@injectable
class AchievementsCubit extends Cubit<AchievementsState> {
  AchievementsCubit(this._getAchievementsUseCase) : super(const AchievementsState());

  final GetAchievementsUseCase _getAchievementsUseCase;

  Future<void> load() async {
    emit(state.copyWith(status: AchievementsStatus.loading));
    final result = await _getAchievementsUseCase(const NoParams());
    result.fold(
      (failure) => emit(state.copyWith(status: AchievementsStatus.error, errorMessage: failure.message)),
      (summary) => emit(state.copyWith(status: AchievementsStatus.loaded, summary: summary)),
    );
  }
}
