import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vl_movies/di/service_locator.dart';
import 'package:vl_movies/features/movie_details/domain/entities/movie_details.dart';
import 'package:vl_movies/features/movie_details/domain/logic/movie_details_cubit.dart';
import 'package:vl_movies/features/movie_details/domain/logic/movie_details_state.dart';
import 'package:vl_movies/features/movie_details/view/widgets/image_grid.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;

  static const id = '/movie_details';

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<PopularMovieDetailsCubit>(),
      child: _Body(
        movieId: movieId,
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final int movieId;

  const _Body({required this.movieId});

  @override
  State<_Body> createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  late final PopularMovieDetailsCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = di<PopularMovieDetailsCubit>();
    cubit.fetchMovieDetails(movieId: widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<PopularMovieDetailsCubit, MovieDetailsState>(
        bloc: cubit,
        buildWhen: (prev, current) => current.popularMovieList != null,
        builder: (context, state) {
          if (state.popularMovieList != null) {
            BlocProvider(
              create: (context) => cubit,
              child: _Details(movieDetails: state.popularMovieList!),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        },
      ),
    );
  }
}

class _Details extends StatelessWidget {
  final MovieDetails movieDetails;

  const _Details({required this.movieDetails});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: movieDetails.posterPath,
              imageBuilder: (context, image) => CircleAvatar(
                backgroundImage: image,
                radius: 80,
              ),
              placeholder: (context, url) => const CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              movieDetails.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                height: 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(movieDetails.name),
            const SizedBox(height: 12),
            Text(movieDetails.title),
            const SizedBox(height: 18),
            BlocBuilder<PopularMovieDetailsCubit, MovieDetailsState>(
              builder: (context, state) {
                if (state.popularMovieList != null) {
                  return ImageGrid(
                    personImagesPaths: state.popularMovieList!,
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
