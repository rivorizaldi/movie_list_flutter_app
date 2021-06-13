import 'package:movie_apps/model/movie.dart';

abstract class MovieState {
  MovieState();
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieSuccess extends MovieState {
  final List<Movie> listMovies;

  MovieSuccess({required this.listMovies});
}

class MovieDetailSuccess extends MovieState {
  final Map<String, dynamic> movieDetails;

  MovieDetailSuccess({required this.movieDetails});
}

class MovieFailed extends MovieState {}
