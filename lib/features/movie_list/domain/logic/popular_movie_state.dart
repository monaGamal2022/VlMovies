import 'package:vl_movies/core/domain/failures/failure.dart';
import 'package:vl_movies/core/utils/nullable.dart';
import 'package:vl_movies/features/movie_list/domain/entities/popular_movie.dart';

class PopularMovieListState {
  final bool isLoading;
  final bool isPaginating;
  final List<PopularMovie>? popularMovieList;
  final int currentPage;
  final bool canLoadMorePages;
  final AppFailure? failure;

  const PopularMovieListState({
    this.failure,
    this.isLoading = true,
    this.isPaginating = false,
    this.popularMovieList,
    this.currentPage = 1,
    this.canLoadMorePages = true,
  });
  PopularMovieListState loadingState(bool isLoading) => copyWith(
        isLoading: isLoading,
      );

  PopularMovieListState paginatingState() =>
      copyWith(isLoading: false, isPaginating: true);

  PopularMovieListState requestFailed(AppFailure failure) => copyWith(
        isLoading: false,
        failure: Nullable(failure),
      );

  PopularMovieListState requestSuccess(List<PopularMovie> data) => copyWith(
        isLoading: false,
        popularMovieList: Nullable(data),
        canLoadMorePages: canLoadMorePages,
      );

  PopularMovieListState copyWith({
     bool? isLoading,
    bool? isPaginating,
    Nullable<List<PopularMovie>>? popularMovieList,
    int? currentPage,
    bool? canLoadMorePages,
    Nullable<AppFailure?>? failure,
  }) {
    return PopularMovieListState(
      isLoading: isLoading ?? this.isLoading,
      failure: failure == null ? this.failure : failure.value,
      popularMovieList: popularMovieList == null ? this.popularMovieList : popularMovieList.value,
      currentPage: currentPage  ?? this.currentPage  ,
      canLoadMorePages: canLoadMorePages ?? this.canLoadMorePages,
    );
  }
}
