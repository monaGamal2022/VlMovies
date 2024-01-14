import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vl_movies/features/movie_list/domain/logic/popular_movie_list_cubit.dart';
import 'package:vl_movies/features/movie_list/domain/logic/popular_movie_state.dart';
import 'package:vl_movies/features/movie_list/view/widgets/movie_list.dart';

class PopularPersonsPage extends StatelessWidget {
  const PopularPersonsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late PopualrMovieListCubit popularPersonsCubit;
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    popularPersonsCubit = getIt<PopualrMovieListCubit>();
    popularPersonsCubit.fetchFirstPatchOfPopularPersons();
    scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.addListener(() {
        if (popularPersonsCubit.state.canLoadMorePages &&
            scrollController.position.pixels >=
                scrollController.position.maxScrollExtent) {
          popularPersonsCubit.loadMorePageOfPopularPeople();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopualrMovieListCubit, PopularMovieListState>(
      bloc: popularPersonsCubit,
      buildWhen: (prev, current) =>
          current is PopularPersonsLoaded || current is Loading,
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const Center(
              child: CircularProgressIndicator(color: Colors.black)),
          popularPersonsLoaded: (data) => RefreshIndicator(
            color: Colors.black,
            onRefresh: () async {
              popularPersonsCubit.fetchFirstPatchOfPopularPersons();
            },
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  PopularPersonsList(popularPersons: data),
                  BlocBuilder<PopualrMovieListCubit, PopularMovieListState>(
                    bloc: popularPersonsCubit,
                    buildWhen: (prev, current) => current.isPaginating,
                    builder: (context, state) => state.maybeWhen(
                      orElse: () => const SizedBox.shrink(),
                      paginating: () => const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
