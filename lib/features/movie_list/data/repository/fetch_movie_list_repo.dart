import 'package:dartz/dartz.dart';
import 'package:vl_movies/core/domain/entities/page.dart';
import 'package:vl_movies/core/domain/failures/failure.dart';
import 'package:vl_movies/features/movie_list/data/data_source/popular_movies_datasource.dart';
import 'package:vl_movies/features/movie_list/domain/entities/popular_movie.dart';
import 'package:vl_movies/features/movie_list/data/mapper/popular_movie_api_response_mapper.dart';

class FetchPopularMovieRepoImpl {
  final PopularDatasource datasource;

  FetchPopularMovieRepoImpl({required this.datasource});

  @override
  Future<Either<AppFailure, Page<PopularMovie>>> fetchPopularMovies(
      {int pageNumber = 1}) async {
    final result = await datasource.fetchPopularMovies();
    return result!
        .fold((l) => Left(AppFailure()), (r) => Right(r.data.toDomain()));
  }
}
