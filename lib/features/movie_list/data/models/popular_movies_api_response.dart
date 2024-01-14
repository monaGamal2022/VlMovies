
import 'package:vl_movies/features/movie_list/data/models/popular_movie_item.dart';

class PopularMovieListApiResponse {
    int page;
    List<PopularMovieItem> results;
    int totalPages;
    int totalResults;

    PopularMovieListApiResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    factory PopularMovieListApiResponse.fromJson(Map<String, dynamic> json) => PopularMovieListApiResponse(
        page: json["page"],
        results: List<PopularMovieItem>.from(json["results"].map((x) => PopularMovieItem.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}
