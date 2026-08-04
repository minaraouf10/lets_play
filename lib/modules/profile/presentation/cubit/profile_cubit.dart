import '../../domain/entities/profile_link.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../../../core/utils/app_imports.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._repository) : super(const ProfileState());

  final ProfileRepository _repository;

  Future<void> loadProfile() async {
    emit(const ProfileState(status: ProfileStatus.loading));
    final result = await _repository.getUserProfile();
    result.fold(
      (failure) => emit(ProfileState(
        status: ProfileStatus.error,
        errorMessage: failure.message,
      )),
      (profile) => emit(ProfileState(
        status: ProfileStatus.loaded,
        profile: profile,
        reviewLinks: [],
        friendLinks: [],
      )),
    );
  }
}
