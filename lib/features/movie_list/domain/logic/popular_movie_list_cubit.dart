import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vl_movies/features/movie_list/domain/logic/popular_movie_state.dart';
import 'package:vl_movies/features/movie_list/domain/usecases/get_popular_movies_usecase.dart';

import '../../../../core/domain/entities/page_params.dart';

class PopualrMovieListCubit extends Cubit<PopularMovieListState> {
  final GetPopularMoviesUseCase useCase;
  PopualrMovieListCubit(this.useCase) : super(const PopularMovieListState());

  fetchFirstPatchOfPopularPersons() async {
    emit(state.loadingState(true));
    final result = await useCase(const PageParams(1));

    emit(result.fold(
      (l) => state.requestFailed(l),
      (r) => state.requestSuccess(r.data),
    ));
  }

  void loadMorePageOfPopularPeople() {
    emit(state.paginatingState());
    // _fetchPopularPersons();
  }
/*
  Future<void> _fetchPopularPersons() async {
    // if (state.canLoadMorePages) {
    final result = await useCase(PageParams(state.currentPage));
    emit(result.fold((l) {
      final st = state.failureState(l);
      return (st);
    }, (r) {
      log(r.isLastPage.toString());
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
      // emit(state.loadingState(false));
      return (st);
    }));
    // }
  }

*/

}
