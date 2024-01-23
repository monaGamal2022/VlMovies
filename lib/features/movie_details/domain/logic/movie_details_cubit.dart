import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vl_movies/features/movie_details/domain/logic/movie_details_state.dart';

import '../usecases/fetch_movie_details_usecase.dart';

// @injectable
class PopularMovieDetailsCubit extends Cubit<MovieDetailsState> {
  final FetchMovieDetailsUseCase fetchMovieDetailsUseCase;

  PopularMovieDetailsCubit(
    this.fetchMovieDetailsUseCase,
  ) : super(MovieDetailsState());

  Future fetchMovieDetails({required int movieId}) async {
    emit(state.loadingState(true));
    final result =
        await fetchMovieDetailsUseCase(MovieDetailsParam(id: movieId));
    result.fold(
      (l) => emit(state.failureState(l)),
      (data) => emit(
        state.successState(
          data: data,
        ),
      ),
    );
  }
}
