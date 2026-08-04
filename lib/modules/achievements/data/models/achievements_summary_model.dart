import '../../domain/entities/achievements_summary.dart';
import 'reward_card_model.dart';

class AchievementsSummaryModel extends AchievementsSummary {
  const AchievementsSummaryModel({
    required super.totalPoints,
    required super.energy,
    required super.hearts,
    required super.bannerText,
    required super.rewards,
  });

  factory AchievementsSummaryModel.fromMap(Map<String, dynamic> map) {
    final rewardsList = (map['rewards'] as List<dynamic>?)
        ?.map((e) => RewardCardModel.fromMap(e as Map<String, dynamic>))
        .toList() ?? [];

    return AchievementsSummaryModel(
      totalPoints: map['totalPoints'] ?? 0,
      energy: map['energy'] ?? 0,
      hearts: map['hearts'] ?? 0,
      bannerText: map['bannerText'] ?? '',
      rewards: rewardsList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalPoints': totalPoints,
      'energy': energy,
      'hearts': hearts,
      'bannerText': bannerText,
      'rewards': rewards.map((r) => (r as RewardCardModel).toMap()).toList(),
    };
  }
}
