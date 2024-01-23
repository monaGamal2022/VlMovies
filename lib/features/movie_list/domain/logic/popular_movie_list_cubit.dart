import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vl_movies/features/movie_list/domain/entities/popular_movie.dart';
import 'package:vl_movies/features/movie_list/domain/logic/popular_movie_state.dart';
import 'package:vl_movies/features/movie_list/domain/usecases/get_popular_movies_usecase.dart';

import '../../../../core/domain/entities/page_params.dart';

class PopualrMovieListCubit extends Cubit<PopularMovieListState> {
  final GetPopularMoviesUseCase useCase;
  PopualrMovieListCubit(this.useCase) : super(const PopularMovieListState());

  fetchFirstPatchOfPopularPersons() {
    emit(state.loadingState(true));
    _fetchPopularPersons();
  }

  void loadMorePageOfPopularPeople() {
    emit(state.paginatingState());
    _fetchPopularPersons();
  }

  void _fetchPopularPersons() async {
    if (state.canLoadMorePages) {
      final result = await useCase(PageParams(state.currentPage));
      result.fold((l) {
        final st = state.failureState(l) ; 
        emit(st);
      }, (r) {
        log(r.isLastPage.toString());
        if (r.isLastPage) {
          state.copyWith(canLoadMorePages: false);
        }
        state.copyWith(currentPage: r.page++);
        final List<PopularMovie> list = [];
        if (state.popularMovieList != null) {
          list.addAll(state.popularMovieList!);
          list.addAll(r.data);
        } else {
          list.addAll(r.data);
        }
        final st = state.successState(
          data: list,
          page: r.page,
          canLoadMore: !r.isLastPage,
        );
        emit(st);
      
      });
    }
  }
}
