import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/utils/app_imports.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> register({
    required String email,
    required String password,
  });
  Future<void> logout();
  Stream<UserModel?> authStateChanges();
  UserModel? get currentUser;
}

// @LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._auth, this._firestore);

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = cred.user;
      if (user == null) throw AuthException('No user returned');
      return UserModel.fromFirebase(user);
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Login failed');
    } catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> register({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = cred.user;
      if (user == null) throw AuthException('No user returned');
      final model = UserModel.fromFirebase(user);
      // Create the user profile document in Firestore.
      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(model.id)
          .set(model.toMap());
      return model;
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.message ?? 'Registration failed');
    } catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<void> logout() => _auth.signOut();

  @override
  Stream<UserModel?> authStateChanges() {
    return _auth.authStateChanges().map(
          (user) => user == null ? null : UserModel.fromFirebase(user),
        );
  }

  @override
  UserModel? get currentUser {
    final user = _auth.currentUser;
    return user == null ? null : UserModel.fromFirebase(user);
  }
}

