import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_apps/bloc/movie/movie_bloc.dart';
import 'package:movie_apps/bloc/movie/movie_event.dart';
import 'package:movie_apps/bloc/movie/movie_state.dart';
import 'package:movie_apps/component/favorite_button.dart';
import 'package:movie_apps/util/constant.dart';

class DetailWebScreen extends StatefulWidget {
  final int id;

  DetailWebScreen({Key? key, required this.id}) : super(key: key);

  @override
  _DetailWebScreenState createState() => _DetailWebScreenState();
}

class _DetailWebScreenState extends State<DetailWebScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MovieBloc>(context)
        .add(MovieFetchDetailsData(id: widget.id));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
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
          if (state is MovieDetailSuccess) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 64,
              ),
              child: Center(
                child: Container(
                  width: 1200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.arrow_back_outlined)),
                          FavoriteButton(),
                        ],
                      ),
                      SizedBox(height: 32),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                ClipRRect(
                                  child: Image.network(
                                      "$IMAGEURL${state.movieDetails["poster_path"]}"),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                SizedBox(height: 16),
                              ],
                            ),
                          ),
                          SizedBox(width: 32),
                          Expanded(
                            flex: 2,
                            child: Card(
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        state.movieDetails["title"],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 30.0,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.calendar_today),
                                        SizedBox(width: 8.0),
                                        Text(
                                          state.movieDetails["release_date"],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.access_time),
                                        SizedBox(width: 8.0),
                                        Text(
                                            "${state.movieDetails["runtime"].toString()} Minutes"),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.language),
                                        SizedBox(width: 8.0),
                                        Text(
                                          state.movieDetails["spoken_languages"]
                                              [0]["english_name"],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Overview',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                            color: state.movieDetails[
                                                        "vote_average"] <=
                                                    5
                                                ? Colors.blue
                                                : state.movieDetails[
                                                                "vote_average"] >=
                                                            6 &&
                                                        state.movieDetails[
                                                                "vote_average"] <
                                                            7
                                                    ? Colors.yellow
                                                    : Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Text(state
                                              .movieDetails["vote_average"]
                                              .toString()),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5.0),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16.0),
                                      child: Text(
                                        state.movieDetails["overview"],
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          if (state is MovieFailed) {
            return Center(
              child: Text("Oops.. Something Wrong !!"),
            );
          }
          return Container();
        },
      ),
    );
  }
}
