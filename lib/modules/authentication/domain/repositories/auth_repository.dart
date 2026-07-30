import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';

/// Domain contract. The data layer provides the implementation; the
/// presentation layer depends only on this abstraction (DIP).
abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String password,
  });

  Future<Either<Failure, Unit>> logout();

  /// Emits the current user, or null when signed out.
  Stream<UserEntity?> authStateChanges();

  UserEntity? get currentUser;
}
