import 'package:dartz/dartz.dart';
import 'package:vl_movies/core/domain/entities/page.dart';
import 'package:vl_movies/core/domain/failures/failure.dart';
import 'package:vl_movies/features/movie_list/data/data_source/popular_movies_datasource.dart';
import 'package:vl_movies/features/movie_list/domain/entities/popular_movie.dart';
import 'package:vl_movies/features/movie_list/data/mapper/popular_movie_api_response_mapper.dart';
import 'package:vl_movies/core/data/mapper/exception_to_failure_mapper.dart';

class FetchPopularMoviesRepo {
  final PopularMoviesDatasource datasource;

  FetchPopularMoviesRepo({required this.datasource});

  Future<Either<AppFailure, Page<PopularMovie>>> fetchPopularMovies(
      {int pageNumber = 1}) async {
    final result = await datasource.fetchPopularMovies();
    return result!.fold((l) => Left(l.dioExceptionsDecoder(l)),
        (r) => Right(r.data.toDomain()));
  }
}
