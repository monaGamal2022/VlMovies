import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vl_movies/features/movie_details/view/screens/movie_details_screen.dart';
import 'package:vl_movies/features/movie_list/domain/entities/popular_movie.dart';

class PopularPersonItem extends StatelessWidget {
  final PopularMovie movieItem;

  PopularPersonItem({super.key, required this.movieItem});

  // final imageConfiguration = getIt<AppConfiguration>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MovieDetailsScreen(
              id: movieItem.id,
            ),
          ),
        );
      },
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: movieItem.posterPath,
            height: 45,
            width: 45,
            imageBuilder: (context, image) => CircleAvatar(
              backgroundImage: image,
              radius: 150,
            ),
            errorWidget: (_, __, ____) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                borderRadius: BorderRadius.circular(150),
              ),
              child: const Icon(Icons.move_down)
              // SvgPicture.asset('assets/svg/user.svg'),
            ),
            placeholder: (context, url) => const CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(movieItem.name),
              Text(movieItem.originalTitle),
            ],
          ),
          const Expanded(child: SizedBox()),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}
