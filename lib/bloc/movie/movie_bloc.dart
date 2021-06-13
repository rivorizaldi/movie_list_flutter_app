import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_apps/bloc/movie/movie_event.dart';
import 'package:movie_apps/bloc/movie/movie_state.dart';
import 'package:movie_apps/model/movie.dart';
import 'package:movie_apps/repositories/movie_repositories.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  MovieBloc({required this.movieRepository}) : super(MovieInitial());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is MovieFetchData) {
      yield MovieLoading();
      try {
        final List<Movie> listMovies = await movieRepository.getMovieList();
        yield MovieSuccess(listMovies: listMovies);
      } catch (_) {
        yield MovieFailed();
      }
    } else if (event is MovieFetchDetailsData) {
      yield MovieLoading();
      try {
        final Map<String, dynamic> movieDetails =
            await movieRepository.getMovieDetails(event.id);
        yield MovieDetailSuccess(movieDetails: movieDetails);
      } catch (_) {
        yield MovieFailed();
      }
    }
  }
}
