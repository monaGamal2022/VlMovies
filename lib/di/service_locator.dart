import 'package:get_it/get_it.dart';
import 'package:vl_movies/core/app_flavors.dart';
import 'package:vl_movies/core/data/http_client_config/dio_client.dart';
import 'package:vl_movies/features/movie_details/data/datasource/movie_details_datasource.dart';
import 'package:vl_movies/features/movie_details/data/repo/movie_details_repo.dart';
import 'package:vl_movies/features/movie_details/domain/logic/movie_details_cubit.dart';
import 'package:vl_movies/features/movie_details/domain/usecases/fetch_movie_details_usecase.dart';
import 'package:vl_movies/features/movie_list/data/data_source/popular_movies_datasource.dart';
import 'package:vl_movies/features/movie_list/data/repository/fetch_movie_list_repo.dart';
import 'package:vl_movies/features/movie_list/domain/logic/popular_movie_list_cubit.dart';
import 'package:vl_movies/features/movie_list/domain/usecases/get_popular_movies_usecase.dart';

final di = GetIt.instance;

void setup() {
  di.registerSingleton<AppFlavor>(AppFlavor());
  di.registerLazySingleton<DioClient>(() => DioClient(AppFlavor.baseUrl));

  di.registerFactory<MovieDetailsDatasource>(
      () => MovieDetailsDatasource(di()));
  di.registerFactory<FetchMovieDetailsRepo>(
      () => FetchMovieDetailsRepo(datasource: di()));

  di.registerFactory<PopularMoviesDatasource>(
      () => PopularMoviesDatasource(di()));
  di.registerFactory<FetchPopularMoviesRepo>(
      () => FetchPopularMoviesRepo(datasource: di()));

  di.registerFactory<GetPopularMoviesUseCase>(
      () => GetPopularMoviesUseCase(di()));

  di.registerFactory<PopualrMovieListCubit>(
      () => PopualrMovieListCubit(  di()));

  di.registerFactory<FetchMovieDetailsUseCase>(
      () => FetchMovieDetailsUseCase(di()));

  di.registerFactory<PopularMovieDetailsCubit>(
      () => PopularMovieDetailsCubit(  di()));
}
