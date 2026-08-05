

import '../../../../core/utils/app_imports.dart';
import '../../domain/entities/follower_entry.dart';
import '../../domain/usecases/get_followers_usecase.dart';

part 'followers_state.dart';

@injectable
class FollowersCubit extends Cubit<FollowersState> {
  FollowersCubit(this._getFollowersUseCase) : super(const FollowersState());

  final GetFollowersUseCase _getFollowersUseCase;

  Future<void> load() async {
    emit(state.copyWith(status: FollowersStatus.loading));
    final result = await _getFollowersUseCase(const NoParams());
    result.fold(
      (failure) => emit(state.copyWith(status: FollowersStatus.error, errorMessage: failure.message)),
      (followers) => emit(state.copyWith(status: FollowersStatus.loaded, followers: followers)),
    );
  }

  void search(String q) => emit(state.copyWith(query: q));

  void selectFollower(String id) {
    try {
      final follower = state.followers.firstWhere((f) => f.id == id);
      emit(state.copyWith(selectedFollower: follower));
    } catch (_) {}
  }

  void dismissDetail() => emit(state.copyWith(clearSelection: true));
}

