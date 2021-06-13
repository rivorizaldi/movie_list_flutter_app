import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_apps/bloc/movie/movie_bloc.dart';
import 'package:movie_apps/repositories/movie_api_client.dart';
import 'package:movie_apps/repositories/movie_repositories.dart';
import 'package:movie_apps/screen/detail/mobile/detail_mobile_screen.dart';
import 'package:movie_apps/screen/detail/web/detail_web_screen.dart';

class DetailScreen extends StatelessWidget {
  final int id;
  DetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieBloc(
          movieRepository: MovieRepository(
        movieApiClient: MovieApiClient(),
      )),
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 800) {
          return DetailWebScreen(id: id);
        } else {
          return DetailMobileScreen(id: id);
        }
      }),
    );
  }
}
