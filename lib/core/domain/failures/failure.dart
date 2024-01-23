class AppFailure {
  final String message;

  AppFailure({required this.message});
}

class GenericFailure extends AppFailure {
  GenericFailure({required super.message});
}

class NetworkFailure extends AppFailure {
  NetworkFailure({required super.message});
}

class ServerFailure extends AppFailure {
  ServerFailure({required super.message});
}

class UnauthorizedAccessFailure extends AppFailure {
  UnauthorizedAccessFailure({required super.message});
}


class ResourceNotFoundFailure extends AppFailure {
  ResourceNotFoundFailure({required super.message});
}

class BadRequestFailure extends AppFailure {
  BadRequestFailure({required super.message});
}
