import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vl_movies/di/service_locator.dart';
import 'package:vl_movies/features/movie_list/domain/logic/popular_movie_list_cubit.dart';
import 'package:vl_movies/features/movie_list/domain/logic/popular_movie_state.dart';
import 'package:vl_movies/features/movie_list/view/widgets/movie_list.dart';

class PopularMoviesScreen extends StatelessWidget {
  static const id = '/';
  const PopularMoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => di<PopualrMovieListCubit>(),
        child: _Body(),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    di<PopualrMovieListCubit>().fetchFirstPatchOfPopularPersons();
    scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.addListener(() {
        if (di<PopualrMovieListCubit>().state.canLoadMorePages &&
            scrollController.position.pixels >=
                scrollController.position.maxScrollExtent) {
          di<PopualrMovieListCubit>().loadMorePageOfPopularPeople();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopualrMovieListCubit, PopularMovieListState>(
      // buildWhen: (prev, current) =>
      //     (current.popularMovieList != null &&
      //         current.popularMovieList!.isNotEmpty) ||
      //     current.isLoading,
      builder: (context, state) {
        if (state.popularMovieList != null &&
            state.popularMovieList!.isNotEmpty) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                PopularPersonsList(popularMoviesList: state.popularMovieList!),
                BlocBuilder<PopualrMovieListCubit, PopularMovieListState>(
                  buildWhen: (prev, current) => current.isPaginating,
                  builder: (context, state) {
                    if (state.isPaginating) {
                      return const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                )
              ],
            ),
          );
        }
        if (state.failure != null) {
          return Center(child: Text(state.failure!.message));
        } else {
          return const Center(
            child: CircularProgressIndicator(color: Colors.black),
          );
        }
      },
    );
  }
}
