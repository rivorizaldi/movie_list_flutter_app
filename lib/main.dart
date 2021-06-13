import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_apps/bloc/movie/movie_bloc.dart';
import 'package:movie_apps/bloc/simple_bloc_observer.dart';
import 'package:movie_apps/repositories/movie_api_client.dart';
import 'package:movie_apps/repositories/movie_repositories.dart';
import 'package:movie_apps/screen/main_screen.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  final MovieRepository movieRepository = MovieRepository(
    movieApiClient: MovieApiClient(),
  );

  runApp(MyApp(
    movieRepository: movieRepository,
  ));
}

class MyApp extends StatelessWidget {
  final MovieRepository movieRepository;

  MyApp({required this.movieRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      home: BlocProvider(
        create: (context) => MovieBloc(movieRepository: movieRepository),
        child: MainScreen(),
      ),
    );
  }
}
