import 'package:vl_movies/core/domain/failures/failure.dart';
import 'package:vl_movies/features/movie_list/domain/entities/popular_movie.dart';

class PopularMovieListState {
  final bool isLoading;
  final bool isPaginating;
  final List<PopularMovie>? popularMovieList;
  final int currentPage;
  final bool canLoadMorePages;
  final AppFailure? failure;

  PopularMovieListState({
    this.failure,
    this.isLoading = true,
    this.isPaginating = false,
    this.popularMovieList,
    this.currentPage = 1,
    this.canLoadMorePages = true,
  });
  PopularMovieListState loadingState(bool isLoading) => PopularMovieListState(
        isLoading: isLoading,
      );
      
  PopularMovieListState paginatingState() =>
      PopularMovieListState(isLoading: false, isPaginating: true);

  PopularMovieListState failureState(AppFailure failure) =>
      PopularMovieListState(
        failure: failure,
        isLoading: false,
      );

  PopularMovieListState successState({
    required List<PopularMovie> data,
    required int page,
    required bool canLoadMore,
  }) =>
      PopularMovieListState(
        failure: null,
        isLoading: false,
        popularMovieList: data,
        canLoadMorePages: canLoadMorePages,
      );

  PopularMovieListState copyWith({
    bool? isLoading,
    bool? isPaginating,
    List<PopularMovie>? popularMovieList,
    int? currentPage,
    bool? canLoadMorePages,
    AppFailure? failure,
  }) {
    return PopularMovieListState(
      failure: failure ?? this.failure,
      isLoading: isLoading ?? this.isLoading,
      isPaginating: isPaginating ?? this.isPaginating,
      popularMovieList: popularMovieList ?? this.popularMovieList,
      currentPage: currentPage ?? this.currentPage,
      canLoadMorePages: canLoadMorePages ?? this.canLoadMorePages,
    );
  }
}
