import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vl_movies/features/movie_list/domain/logic/popular_movie_state.dart';
import 'package:vl_movies/features/movie_list/domain/usecases/get_popular_movies_usecase.dart';

import '../../../../core/domain/entities/page_params.dart';

class PopualrMovieListCubit extends Cubit<PopularMovieListState> {
  final GetPopularMoviesUseCase useCase;
  PopualrMovieListCubit(super.initialState, this.useCase);

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
        emit(state.failureState(l));
      }, (r) {
        log(r.isLastPage.toString());
        if (r.isLastPage) {
          state.copyWith(canLoadMorePages: false);
        }
        state.copyWith(currentPage: r.page++);
        final list = state.popularMovieList;
        list != null ? list.addAll(r.data) : List.from(r.data);

        emit(
          state.successState(
            data: list!,
            page: r.page,
            canLoadMore: !r.isLastPage,
          ),
        );
        return;
      });
    }
  }
}
