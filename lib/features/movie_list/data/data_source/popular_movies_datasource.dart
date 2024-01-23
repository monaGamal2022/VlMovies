import 'package:dartz/dartz.dart';
import 'package:vl_movies/core/constants/constants.dart';
import 'package:vl_movies/core/constants/end_points.dart';
import 'package:vl_movies/core/data/exception/server_exception.dart';
import 'package:vl_movies/core/data/http_client_config/dio_client.dart';
import 'package:vl_movies/core/data/models/base_api_response_model.dart';
import 'package:vl_movies/core/enums/request_method_types.dart';
import 'package:vl_movies/features/movie_list/data/models/popular_movies_api_response.dart';

class PopularMoviesDatasource {
  final DioClient client;

  PopularMoviesDatasource(this.client);

  Future<
          Either<AppException,
              BaseApiResponseModel<PopularMovieListApiResponse>>?>
      fetchPopularMovies({int page = 1}) async {
    final result = await client.excute(
        path: popularMovieList,
        method: RequestMethodTypes.read,
        queryParameters: {"api_key": apiKey},
        parsingResponse: (json) => PopularMovieListApiResponse.fromJson(json));
    return result;
  }
}
