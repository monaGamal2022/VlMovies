import 'package:dartz/dartz.dart';
import 'package:vl_movies/core/domain/failures/failure.dart';
import 'package:vl_movies/features/movie_details/data/datasource/movie_details_datasource.dart';
import 'package:vl_movies/features/movie_details/domain/entities/movie_details.dart';
import 'package:vl_movies/features/movie_details/data/mapper/movie_details_api_response_to_domain.dart';

class FetchMovieDetailsRepoImpl {
  final MovieDetailsDatasource datasource;

  FetchMovieDetailsRepoImpl({required this.datasource});

  @override
  Future<Either<AppFailure, MovieDetails>> fetchMovieDetails(
      {required int id}) async {
    final result = await datasource.fetchMovieDetails(id: id);
    return result!
        .fold((l) => Left(AppFailure()), (r) => Right(r.data.toDomain()));
  }
}
