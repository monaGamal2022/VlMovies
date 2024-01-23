import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vl_movies/features/movie_details/view/screens/movie_details_screen.dart';
import 'package:vl_movies/features/movie_list/view/screens/popular_movies_screen.dart';

class AppRouter {
  static bool flag = true;

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: PopularMoviesScreen.id,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const PopularMoviesScreen(),
        ),
      ),
      GoRoute(
        path: MovieDetailsScreen.id,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: MovieDetailsScreen(
            movieId: state.extra as int,
          ),
        ),
      ),
    ],
    debugLogDiagnostics: true,
    initialLocation: PopularMoviesScreen.id,
    errorBuilder: (context, state) {
      return const Center(
        child: Text('Error 404'),
      );
    },
  );
}
