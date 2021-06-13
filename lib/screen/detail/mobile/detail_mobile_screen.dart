import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_apps/bloc/movie/movie_bloc.dart';
import 'package:movie_apps/bloc/movie/movie_event.dart';
import 'package:movie_apps/bloc/movie/movie_state.dart';
import 'package:movie_apps/component/favorite_button.dart';
import 'package:movie_apps/util/constant.dart';

class DetailMobileScreen extends StatefulWidget {
  final int id;

  const DetailMobileScreen({Key? key, required this.id}) : super(key: key);

  @override
  _DetailMobileScreenState createState() => _DetailMobileScreenState();
}

class _DetailMobileScreenState extends State<DetailMobileScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MovieBloc>(context)
        .add(MovieFetchDetailsData(id: widget.id));
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
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(children: [
                      Center(
                        child: Image.network(
                          "$IMAGEURL${state.movieDetails["poster_path"]}",
                          height: 400,
                        ),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              FavoriteButton(),
                            ],
                          ),
                        ),
                      ),
                    ]),
                    Container(
                      child: Text(
                        state.movieDetails["title"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Icon(Icons.calendar_today),
                              SizedBox(height: 8.0),
                              Text(
                                state.movieDetails["release_date"],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(Icons.access_time),
                              SizedBox(height: 8.0),
                              Text(
                                  "${state.movieDetails["runtime"].toString()} Minutes"),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(Icons.language),
                              SizedBox(height: 8.0),
                              Text(state.movieDetails["spoken_languages"][0]
                                  ["english_name"]),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        state.movieDetails["overview"],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
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
