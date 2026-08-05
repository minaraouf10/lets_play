import '../../domain/repositories/profile_repository.dart';
import '../../../../core/utils/app_imports.dart';

part 'help_center_state.dart';

@injectable
class HelpCenterCubit extends Cubit<HelpCenterState> {
  HelpCenterCubit(this._repository) : super(const HelpCenterState());

  final ProfileRepository _repository;

  Future<void> load() async {
    emit(const HelpCenterState(status: HelpCenterStatus.loading));
    final result = await _repository.getHelpTopics();
    result.fold(
      (failure) => emit(HelpCenterState(
        status: HelpCenterStatus.error,
        errorMessage: failure.message,
      )),
      (topics) {
        final initiallyExpanded = topics
            .where((t) => t.isInitiallyExpanded)
            .map((t) => t.id)
            .firstOrNull;
        emit(HelpCenterState(
          status: HelpCenterStatus.loaded,
          topics: topics,
          expandedId: initiallyExpanded,
        ));
      },
    );
  }

  void toggleTopic(String id) {
    final newExpandedId = state.expandedId == id ? null : id;
    emit(state.copyWith(expandedId: newExpandedId));
  }

  void search(String query) {
    emit(state.copyWith(query: query));
  }
}
