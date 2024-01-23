import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vl_movies/features/movie_details/domain/entities/movie_details.dart';

class ImageGrid extends StatelessWidget {
  final MovieDetails personImagesPaths;

  ImageGrid({Key? key, required this.personImagesPaths}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 6,
        childAspectRatio: 0.75,
      ),
      itemCount: 12,
      // personImagesPaths.length,
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: () {},
          child: CachedNetworkImage(
            imageUrl: "",
            imageBuilder: (context, image) => Container(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: image,
                  )),
            ),
            placeholder: (context, url) => const Padding(
              padding: EdgeInsets.all(32),
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }
}
