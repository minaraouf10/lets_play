/// Data-layer exceptions. Thrown by datasources, caught by repository
/// implementations and mapped to [Failure]s.
class ServerException implements Exception {
  ServerException([this.message = 'Server error']);
  final String message;
}

class AuthException implements Exception {
  AuthException([this.message = 'Authentication failed']);
  final String message;
}

class CacheException implements Exception {
  CacheException([this.message = 'Local cache error']);
  final String message;
}
