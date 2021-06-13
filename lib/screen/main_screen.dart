import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_apps/bloc/movie/movie_bloc.dart';
import 'package:movie_apps/bloc/movie/movie_event.dart';
import 'package:movie_apps/bloc/movie/movie_state.dart';
import 'package:movie_apps/component/CustomDrawer.dart';
import 'package:movie_apps/component/MovieListView/mobile/movie_list.dart';
import 'package:movie_apps/component/MovieListView/web/movie_grid.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MovieBloc>(context).add(MovieFetchData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie List'),
      ),
      drawer: CustomDrawer(),
      body: BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
        if (state is MovieInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is MovieLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is MovieSuccess) {
          return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth <= 600) {
              return MovieList(listMovies: state.listMovies);
            } else if (constraints.maxWidth <= 1200) {
              return MovieGrid(
                gridCount: 4,
                listMovies: state.listMovies,
              );
            } else {
              return MovieGrid(
                gridCount: 6,
                listMovies: state.listMovies,
              );
            }
          });
        }
        if (state is MovieFailed) {
          return Center(
            child: Text("Oops.. Something Wrong !!"),
          );
        }
        return Container();
      }),
    );
  }
}
