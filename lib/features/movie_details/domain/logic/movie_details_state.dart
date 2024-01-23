import 'package:vl_movies/core/domain/failures/failure.dart';
import 'package:vl_movies/features/movie_details/domain/entities/movie_details.dart';

class MovieDetailsState {
  final bool isLoading;
  final MovieDetails? popularMovieList;
  final AppFailure? failure;

  MovieDetailsState({
    this.failure,
    this.isLoading = true,
    this.popularMovieList,
  });
  MovieDetailsState loadingState(bool isLoading) => MovieDetailsState(
        isLoading: isLoading,
      );

  MovieDetailsState paginatingState() => MovieDetailsState(isLoading: false);

  MovieDetailsState failureState(AppFailure failure) => MovieDetailsState(
        failure: failure,
        isLoading: false,
      );

  MovieDetailsState successState({
    required MovieDetails data,
  }) =>
      MovieDetailsState(
        failure: null,
        isLoading: false,
        popularMovieList: data,
      );

  MovieDetailsState copyWith({
    bool? isLoading,
    bool? isPaginating,
    MovieDetails? popularMovieList,
    int? currentPage,
    bool? canLoadMorePages,
    AppFailure? failure,
  }) {
    return MovieDetailsState(
      failure: failure ?? this.failure,
      isLoading: isLoading ?? this.isLoading,
      popularMovieList: popularMovieList ?? this.popularMovieList,
    );
  }
}
