// import 'package:vl_movies/core/domain/failures/failure.dart';

import 'package:vl_movies/core/data/exception/server_exception.dart';
import 'package:vl_movies/core/domain/failures/failure.dart';

extension ExceptionsDecoder on AppException {
  AppFailure dioExceptionsDecoder(AppException exception) {
    if (exception is BadResponseException) {
      return BadRequestFailure(message: exception.message);
    }
    if (exception is UnauthorizedAccess) {
      return UnauthorizedAccessFailure(message: exception.message);
    }
    if (exception is ResourceNotFound) {
      return ResourceNotFoundFailure(message: exception.message);
    }
    if (exception is NetworkExcpetion) {
      return NetworkFailure(message: exception.message);
    }
    if (exception is ServerException) {
      return ServerFailure(message: exception.message);
    }

    return GenericFailure(message: exception.message);
  }
}
