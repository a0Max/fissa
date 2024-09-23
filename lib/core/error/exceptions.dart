class ServerException implements Exception {}

class CacheException implements Exception {}

class MessageException implements Exception {
  final String message;

  MessageException({required this.message});
}
