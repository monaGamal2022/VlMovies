class BaseApiResponseModel<T> {
  final int? statusCode;
  final T data;

  BaseApiResponseModel({required this.statusCode, required this.data});
}
