import 'dart:collection';

import 'package:movie_apps/model/movie.dart';
import 'package:movie_apps/repositories/movie_api_client.dart';

class MovieRepository {
  final MovieApiClient movieApiClient;

  MovieRepository({required this.movieApiClient});

  Future<List<Movie>> getMovieList() async {
    List<Movie> listMovies = [];

    Map<String, dynamic> data = await movieApiClient.getListMovies();

    List<dynamic> listData = data["results"];

    listData.forEach((element) {
      listMovies.add(Movie.fromJson(element));
    });

    return listMovies;
  }

  Future<Map<String, dynamic>> getMovieDetails(int id) async {
    Map<String, dynamic> data = await movieApiClient.getMovieDetails(id);

    return data;
  }
}
