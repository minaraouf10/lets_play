import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../models/app_settings_model.dart';
import '../models/help_topic_model.dart';
import '../models/help_topics_data.dart';
import '../models/profile_link_model.dart';
import '../models/user_profile_model.dart';
import 'profile_seed_data.dart';

abstract class ProfileLocalDataSource {
  Future<UserProfileModel> getUserProfile();
  Future<List<ProfileLinkModel>> getReviewLinks();
  Future<List<ProfileLinkModel>> getFriendLinks();
  Future<AppSettingsModel> getAppSettings();
  Future<void> saveAppSettings(AppSettingsModel settings);
  Future<List<HelpTopicModel>> getHelpTopics();
}

@LazySingleton(as: ProfileLocalDataSource)
class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  static const String _boxName = 'profile_settings';

  @override
  Future<UserProfileModel> getUserProfile() async {
    return ProfileSeedData.seedProfile;
  }

  @override
  Future<List<ProfileLinkModel>> getReviewLinks() async {
    return ProfileSeedData.seedReviewLinks;
  }

  @override
  Future<List<ProfileLinkModel>> getFriendLinks() async {
    return ProfileSeedData.seedFriendLinks;
  }

  @override
  Future<AppSettingsModel> getAppSettings() async {
    final box = await Hive.openBox(_boxName);
    final stored = box.get('settings');
    if (stored is Map) {
      return AppSettingsModel.fromMap(stored.cast<String, dynamic>());
    }
    return const AppSettingsModel(
      displayName: 'Malak',
      username: 'malak_user',
      password: '••••••••',
      email: 'malak@example.com',
      soundEffects: true,
      motivationalReminders: true,
      friendRequests: true,
      newsletterEmails: false,
    );
  }

  @override
  Future<void> saveAppSettings(AppSettingsModel settings) async {
    final box = await Hive.openBox(_boxName);
    await box.put('settings', settings.toMap());
  }

  @override
  Future<List<HelpTopicModel>> getHelpTopics() async {
    return HelpTopicsData.seed;
  }
}
