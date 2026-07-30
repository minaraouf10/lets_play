import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// Abstraction over connectivity so datasources/repositories can decide
/// online vs offline behaviour (offline-first).
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

@LazySingleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl(this._checker);

  final InternetConnection _checker;

  @override
  Future<bool> get isConnected => _checker.hasInternetAccess;
}
