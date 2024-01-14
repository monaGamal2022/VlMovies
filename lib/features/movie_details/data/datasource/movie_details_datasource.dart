import 'package:dartz/dartz.dart';
import 'package:vl_movies/core/constants/end_points.dart';
import 'package:vl_movies/core/data/exception/server_exception.dart';
import 'package:vl_movies/core/data/http_client_config/dio_client.dart';
import 'package:vl_movies/core/data/models/base_api_response_model.dart';
import 'package:vl_movies/core/enums/request_method_types.dart';
import 'package:vl_movies/features/movie_details/data/models/movie_details_api_response.dart';

class MovieDetailsDatasource {
  final DioClient client;

  MovieDetailsDatasource(this.client);

  @override
  Future<Either<AppException, BaseApiResponseModel<MovieDetailsApiResponse>>?>
      fetchMovieDetails({required int id}) async {
    final result = await client.excute(
        path: popularMovieList,
        method: RequestMethodTypes.read,
        parsingResponse: (json) => MovieDetailsApiResponse.fromJson(json));
    return result;
  }
}
