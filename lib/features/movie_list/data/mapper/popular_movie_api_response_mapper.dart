import 'package:vl_movies/core/domain/entities/page.dart';
import 'package:vl_movies/features/movie_list/data/models/popular_movies_api_response.dart';
import 'package:vl_movies/features/movie_list/domain/entities/popular_movie.dart';

extension PopularMovieMapper on PopularMovieListApiResponse {
  Page<PopularMovie> toDomain() {
    return Page(
      data: results
          .map(
            (e) => PopularMovie(
              name: e.title,
              adult: e.adult,
              backdropPath: e.backdropPath,
              genreIds: e.genreIds,
              id: e.id,
              originalLanguage: e.originalLanguage,
              originalTitle: e.originalTitle,
              overview: e.overview,
              popularity: e.popularity,
              posterPath: e.posterPath,
              releaseDate: e.releaseDate,
              title: e.title,
              video: e.video,
              voteAverage: e.voteAverage,
              voteCount: e.voteCount,
            ),
          )
          .toList(growable: true),
      isLastPage: page == totalPages,
      page: page,
    );
  }
}
