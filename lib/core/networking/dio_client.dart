import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../constants/app_constants.dart';

/// Thin wrapper around [Dio]. Firebase handles auth/db/storage via its own
/// SDKs; Dio is reserved for REST calls to the Azure Speech-to-Text service
/// and the Python NLP pipeline (added in later modules).
@lazySingleton
class DioClient {
  DioClient() : _dio = _build();

  final Dio _dio;

  Dio get instance => _dio;

  static Dio _build() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(
          milliseconds: AppConstants.connectTimeoutMs,
        ),
        receiveTimeout: const Duration(
          milliseconds: AppConstants.receiveTimeoutMs,
        ),
        headers: {'Content-Type': 'application/json'},
      ),
    );
    dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );
    return dio;
  }
}
