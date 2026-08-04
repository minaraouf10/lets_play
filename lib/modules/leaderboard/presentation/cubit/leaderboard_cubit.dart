import '../../domain/entities/leaderboard_tab.dart';
import '../../domain/entities/leaderboard_data.dart';
import '../../domain/usecases/get_leaderboard_usecase.dart';
import '../../../../core/utils/app_imports.dart';

part 'leaderboard_state.dart';

@injectable
class LeaderboardCubit extends Cubit<LeaderboardState> {
  LeaderboardCubit(this._getLeaderboardUseCase)
      : super(const LeaderboardState());

  final GetLeaderboardUseCase _getLeaderboardUseCase;

  Future<void> load() async {
    emit(state.copyWith(status: LeaderboardStatus.loading));
    final result = await _getLeaderboardUseCase(
      GetLeaderboardParams(tab: state.tab),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: LeaderboardStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (data) => emit(
        state.copyWith(status: LeaderboardStatus.loaded, data: data),
      ),
    );
  }

  void selectTab(LeaderboardTab tab) {
    if (tab == LeaderboardTab.tournaments) return;
    emit(state.copyWith(tab: tab));
    load();
  }
}
