import 'package:flutter/material.dart';
import 'package:vl_movies/features/movie_list/domain/entities/popular_movie.dart';
import 'package:vl_movies/features/movie_list/view/widgets/popualr_movie_list_item.dart';

class PopularPersonsList extends StatelessWidget {
  final List<PopularMovie> popularPersons;

  const PopularPersonsList({Key? key, required this.popularPersons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      separatorBuilder: (_, index) => const Divider(),
      itemCount: popularPersons.length,
      itemBuilder: (_, index) => PopularPersonItem(
        movieItem: popularPersons[index],
      ),
    );
  }
}
