import 'package:vl_movies/features/movie_details/data/models/movie_details_api_response.dart';
import 'package:vl_movies/features/movie_details/domain/entities/movie_details.dart';

extension PopularMovieMapper on MovieDetailsApiResponse {
  MovieDetails toDomain() {
    return MovieDetails(
      name: title,
      adult:  adult,
      backdropPath:  backdropPath,
      id:  id,
      originalLanguage:  originalLanguage,
      originalTitle:  originalTitle,
      overview:  overview,
      popularity:  popularity,
      posterPath:  posterPath,
      releaseDate:  releaseDate,
      title:  title,
      video:  video,
      voteAverage:  voteAverage,
      voteCount:  voteCount,
    );
  }
}
