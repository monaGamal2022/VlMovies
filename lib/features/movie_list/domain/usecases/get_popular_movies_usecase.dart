import 'package:dartz/dartz.dart';
import 'package:vl_movies/core/domain/entities/page.dart';
import 'package:vl_movies/core/domain/entities/page_params.dart';
import 'package:vl_movies/core/domain/failures/failure.dart';
import 'package:vl_movies/core/domain/usecases/abstract_usecase.dart';
import 'package:vl_movies/features/movie_list/data/repository/fetch_movie_list_repo.dart';
import 'package:vl_movies/features/movie_list/domain/entities/popular_movie.dart';

class GetPopularMoviesUseCase
    implements
        UseCase<PageParams,
            Future<Either<AppFailure, Page<PopularMovie>>>> {
  final FetchPopularMovieRepoImpl repository;

  GetPopularMoviesUseCase(this.repository);
  
  @override
  Future<Either<AppFailure, Page<PopularMovie>>> call(PageParams pageParams) async{
    return repository.fetchPopularMovies(pageNumber: pageParams.currentPage) ; 
  }
  


}
