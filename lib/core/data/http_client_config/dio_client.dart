import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';
import 'package:vl_movies/core/data/exception/server_exception.dart';
import 'package:vl_movies/core/enums/request_method_types.dart';

import '../models/base_api_response_model.dart';

class DioClient {
  final List<Interceptor>? interceptors;
  final String baseUrl;
  final Duration? connectTimeout;
  final Duration? receiveTimeout;
  final Duration? sendTimeout;

  Dio _dio;

  DioClient(
    this.connectTimeout,
    this.receiveTimeout,
    this.sendTimeout,
    this._dio, {
    required this.baseUrl,
    this.interceptors,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        sendTimeout: sendTimeout,
        headers: {"accept": "application/json"},
      ),
    );
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        queryParameters: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        showProcessingTime: true,
        showCUrl: true,
        canShowLog: true,
      ),
    );
    if (interceptors != null) _dio.interceptors.addAll(interceptors!);
  }

  Future<Either<AppException, BaseApiResponseModel<T>>?> excute<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    required RequestMethodTypes method,
    Map<String, dynamic>? headers,
    Object? data,
    required T Function(Map<String, dynamic> json) parsingResponse,
  }) async {
    if (headers != null) _dio.options.headers.addAll(headers);
    try {
      switch (method) {
        case RequestMethodTypes.create:
          final result = await _dio.post(
            path,
            queryParameters: queryParameters,
            data: data,
          );

          return Right(BaseApiResponseModel(
              statusCode: result.statusCode,
              data: parsingResponse.call(
                  result.data,
              )));

        case RequestMethodTypes.put:
          final result = await _dio.put(
            path,
            queryParameters: queryParameters,
            data: data,
          );

          return Right(BaseApiResponseModel(
              statusCode: result.statusCode,
              data: parsingResponse.call(
                 result.data,
              )));

        case RequestMethodTypes.delete:
          final result = await _dio.delete(
            path,
            queryParameters: queryParameters,
            data: data,
          );

          return Right(BaseApiResponseModel(
              statusCode: result.statusCode,
              data: parsingResponse.call(
                 result.data,
              )));
        case RequestMethodTypes.patch:
          final result = await _dio.patch(
            path,
            queryParameters: queryParameters,
            data: data,
          );

          return Right(BaseApiResponseModel(
              statusCode: result.statusCode,
              data: parsingResponse.call(
              result.data,
              )));

        case RequestMethodTypes.read:
          final result = await _dio.get(
            path,
            queryParameters: queryParameters,
            data: data,
          );

          return Right(BaseApiResponseModel(
              statusCode: result.statusCode,
              data: parsingResponse.call(
                 result.data,
              )));

        default:
          break;
      }
    } on DioException catch (exception) {
      return Left(_converDioExceptionToAppException(exception));
    }
    return null;
  }
}

AppException _converDioExceptionToAppException(DioException exception) {
  switch (exception.type) {
    case DioExceptionType.connectionError:
      NetworkExcpetion();
      break;
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.badResponse:
      ServerException(
        statusCode: exception.response?.statusCode,
        message: exception.response?.data,
      );
      break;
    default:
  }
  return ServerException(
    message: exception.response?.data,
    statusCode: exception.response?.statusCode,
  );
}
