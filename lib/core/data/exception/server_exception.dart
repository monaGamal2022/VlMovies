/// this app handles all types of [Exception] that may happen ex [server, local, network]
abstract class AppException implements Exception {
  final String message;
  final int? statusCode;

  AppException({required this.message, required this.statusCode});
}

class ServerException extends AppException {
  ServerException({
    required super.message,
    required super.statusCode,
  });
}

class NetworkExcpetion extends AppException {
  NetworkExcpetion({
    required super.message,
    required super.statusCode,
  });
}

class ClientException extends AppException {
  ClientException({
    required super.message,
    required super.statusCode,
  });
}

class ResourceNotFound extends ClientException {
  ResourceNotFound({
    required super.message,
    required super.statusCode,
  });
}

class UnauthorizedAccess extends ClientException {
  UnauthorizedAccess({
    required super.message,
    required super.statusCode,
  });
}



class BadRequest extends ClientException {
  BadRequest({
    required super.message,
    required super.statusCode,
  });
}

