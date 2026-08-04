import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/achievements_summary.dart';

abstract class AchievementsRepository {
  Future<Either<Failure, AchievementsSummary>> getSummary();
}
