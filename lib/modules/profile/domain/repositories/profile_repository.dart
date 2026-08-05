import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/app_settings.dart';
import '../entities/feedback_draft.dart';
import '../entities/help_topic.dart';
import '../entities/profile_link.dart';
import '../entities/user_profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserProfile>> getUserProfile();
  Future<Either<Failure, List<ProfileLink>>> getReviewLinks();
  Future<Either<Failure, List<ProfileLink>>> getFriendLinks();
  Future<Either<Failure, AppSettings>> getAppSettings();
  Future<Either<Failure, void>> saveAppSettings(AppSettings settings);
  Future<Either<Failure, List<HelpTopic>>> getHelpTopics();
  Future<Either<Failure, void>> sendFeedback(FeedbackDraft feedback);
}
