import 'package:equatable/equatable.dart';
import 'reward_card.dart';

class AchievementsSummary extends Equatable {
  final int totalPoints;
  final int energy;
  final int hearts;
  final String bannerText;
  final List<RewardCard> rewards;

  const AchievementsSummary({
    required this.totalPoints,
    required this.energy,
    required this.hearts,
    required this.bannerText,
    required this.rewards,
  });

  @override
  List<Object?> get props => [totalPoints, energy, hearts, bannerText, rewards];
}
