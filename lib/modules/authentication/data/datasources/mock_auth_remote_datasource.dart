import 'dart:async';
import 'package:injectable/injectable.dart';

import '../models/user_model.dart';
import 'auth_remote_datasource.dart';

/// Mock implementation of [AuthRemoteDataSource] to run offline without Firebase.
@LazySingleton(as: AuthRemoteDataSource)
class MockAuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  /// Starts signed out so the app always opens on the Login screen.
  UserModel? _user;
  final StreamController<UserModel?> _controller = StreamController<UserModel?>.broadcast();

  MockAuthRemoteDataSourceImpl() {
    scheduleMicrotask(() => _controller.add(_user));
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    _user = UserModel(
      id: 'mock_user_123',
      email: email,
      displayName: email.split('@').first,
    );
    _controller.add(_user);
    return _user!;
  }

  @override
  Future<UserModel> register({
    required String email,
    required String password,
  }) async {
    _user = UserModel(
      id: 'mock_user_123',
      email: email,
      displayName: email.split('@').first,
    );
    _controller.add(_user);
    return _user!;
  }

  @override
  Future<void> logout() async {
    _user = null;
    _controller.add(null);
  }

  @override
  Stream<UserModel?> authStateChanges() => _controller.stream;

  @override
  UserModel? get currentUser => _user;
}
