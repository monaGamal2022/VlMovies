// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:vl_movies/core/domain/entities/page.dart';
import 'package:vl_movies/core/domain/entities/page_params.dart';
import 'package:vl_movies/core/domain/failures/failure.dart';
import 'package:vl_movies/core/domain/usecases/abstract_usecase.dart';
import 'package:vl_movies/features/movie_details/data/repo/movie_details_repo.dart';
import 'package:vl_movies/features/movie_details/domain/entities/movie_details.dart';
import 'package:vl_movies/features/movie_list/data/repository/fetch_movie_list_repo.dart';
import 'package:vl_movies/features/movie_list/domain/entities/popular_movie.dart';

class FetchMovieDetailsUseCase
    implements
        UseCase<MovieDetailsParam, Future<Either<AppFailure, MovieDetails>>> {
  final FetchMovieDetailsRepo repository;

  FetchMovieDetailsUseCase(this.repository);

  @override
  Future<Either<AppFailure, MovieDetails>> call(
      MovieDetailsParam params) async {
    return repository.fetchMovieDetails(id: params.id);
  }
}

class MovieDetailsParam {
  int id;
  MovieDetailsParam({
    required this.id,
  });
}
