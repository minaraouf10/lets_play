import 'package:injectable/injectable.dart';
import '../models/achievements_summary_model.dart';
import '../models/reward_card_model.dart';

abstract class AchievementsLocalDataSource {
  Future<AchievementsSummaryModel> getSummary();
}

@LazySingleton(as: AchievementsLocalDataSource)
class AchievementsLocalDataSourceImpl implements AchievementsLocalDataSource {
  static const String bannerText = 'Look what your points got you!';

  static final _seedData = AchievementsSummaryModel(
    totalPoints: 13500,
    energy: 3,
    hearts: 6,
    bannerText: bannerText,
    rewards: [
      const RewardCardModel(
        id: '1',
        title: 'First Achievement',
        subtitle: 'Unlock your journey',
        progress: 0.7,
        isLocked: false,
      ),
      const RewardCardModel(
        id: '2',
        title: 'Secret Reward',
        subtitle: 'Complete more lessons',
        progress: 0.3,
        isLocked: true,
      ),
    ],
  );

  @override
  Future<AchievementsSummaryModel> getSummary() async {
    return _seedData;
  }
}
