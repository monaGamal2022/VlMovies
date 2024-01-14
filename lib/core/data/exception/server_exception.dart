/// this app handles all types of [Exception] that may happen ex [server, local, network]
abstract class AppException implements Exception {}

class ServerException implements AppException {
  final String message;
  final int? statusCode;

  ServerException({
    required this.message,
    required this.statusCode,
  });
}

class NetworkExcpetion implements AppException {}
