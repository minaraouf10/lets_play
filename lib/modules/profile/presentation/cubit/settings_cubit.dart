import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../../../core/utils/app_imports.dart';

part 'settings_state.dart';

@injectable
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._repository)
      : super(SettingsState(
          settings: AppSettings(
            displayName: '',
            username: '',
            password: '',
            email: '',
            soundEffects: true,
            motivationalReminders: true,
            friendRequests: true,
            newsletterEmails: true,
          ),
        ));

  final ProfileRepository _repository;

  Future<void> loadSettings() async {
    emit(state.copyWith(status: SettingsStatus.loading));
    final result = await _repository.getAppSettings();
    result.fold(
      (failure) => emit(state.copyWith(
        status: SettingsStatus.error,
        errorMessage: failure.message,
      )),
      (settings) => emit(state.copyWith(
        status: SettingsStatus.loaded,
        settings: settings,
      )),
    );
  }

  void updateDisplayName(String name) {
    final updated = state.settings.copyWith(displayName: name);
    emit(state.copyWith(settings: updated));
  }

  void updateUsername(String username) {
    final updated = state.settings.copyWith(username: username);
    emit(state.copyWith(settings: updated));
  }

  void updatePassword(String password) {
    final updated = state.settings.copyWith(password: password);
    emit(state.copyWith(settings: updated));
  }

  void updateEmail(String email) {
    final updated = state.settings.copyWith(email: email);
    emit(state.copyWith(settings: updated));
  }

  void _setFlag({bool? sound, bool? motivational, bool? friendRequests, bool? announcements}) {
    final updated = state.settings.copyWith(
      soundEffects: sound ?? state.settings.soundEffects,
      motivationalReminders: motivational ?? state.settings.motivationalReminders,
      friendRequests: friendRequests ?? state.settings.friendRequests,
      newsletterEmails: announcements ?? state.settings.newsletterEmails,
    );
    emit(state.copyWith(settings: updated, status: SettingsStatus.saving));
    _persist();
  }

  void toggleSoundEffects(bool value) {
    _setFlag(sound: value);
  }

  void toggleMotivationalMessages(bool value) {
    _setFlag(motivational: value);
  }

  void toggleDailyPractice(bool value) {
    _setFlag(friendRequests: value);
  }

  void toggleAnnouncements(bool value) {
    _setFlag(announcements: value);
  }

  Future<void> _persist() async {
    final result = await _repository.saveAppSettings(state.settings);
    result.fold(
      (failure) => emit(state.copyWith(
        status: SettingsStatus.error,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(status: SettingsStatus.loaded)),
    );
  }

  Future<void> save() async {
    await _persist();
  }
}
