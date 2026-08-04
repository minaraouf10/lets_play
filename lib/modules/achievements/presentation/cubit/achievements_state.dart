part of 'achievements_cubit.dart';

enum AchievementsStatus { initial, loading, loaded, error }

class AchievementsState {
  const AchievementsState({
    this.status = AchievementsStatus.initial,
    this.summary,
    this.errorMessage,
  });

  final AchievementsStatus status;
  final AchievementsSummary? summary;
  final String? errorMessage;

  AchievementsState copyWith({
    AchievementsStatus? status,
    AchievementsSummary? summary,
    String? errorMessage,
  }) =>
      AchievementsState(
        status: status ?? this.status,
        summary: summary ?? this.summary,
        errorMessage: errorMessage,
      );
}
