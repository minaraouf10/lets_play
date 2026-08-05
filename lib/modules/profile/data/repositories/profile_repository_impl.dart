import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/entities/feedback_draft.dart';
import '../../domain/entities/help_topic.dart';
import '../../domain/entities/profile_link.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_datasource.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._local);

  final ProfileLocalDataSource _local;

  @override
  Future<Either<Failure, UserProfile>> getUserProfile() async {
    try {
      final profile = await _local.getUserProfile();
      return Right(profile);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (_) {
      return const Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProfileLink>>> getReviewLinks() async {
    try {
      final links = await _local.getReviewLinks();
      return Right(links);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (_) {
      return const Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProfileLink>>> getFriendLinks() async {
    try {
      final links = await _local.getFriendLinks();
      return Right(links);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (_) {
      return const Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, AppSettings>> getAppSettings() async {
    try {
      final settings = await _local.getAppSettings();
      return Right(settings);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (_) {
      return const Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveAppSettings(AppSettings settings) async {
    try {
      final model = _convertToModel(settings);
      await _local.saveAppSettings(model);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (_) {
      return const Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, List<HelpTopic>>> getHelpTopics() async {
    try {
      final topics = await _local.getHelpTopics();
      return Right(topics);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (_) {
      return const Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, void>> sendFeedback(FeedbackDraft feedback) async {
    try {
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (_) {
      return const Left(UnexpectedFailure());
    }
  }

  dynamic _convertToModel(AppSettings settings) {
    return settings;
  }
}
