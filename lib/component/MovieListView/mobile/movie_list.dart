import 'package:flutter/material.dart';
import 'package:movie_apps/model/movie.dart';
import 'package:movie_apps/screen/detail/detail_screen.dart';
import 'package:movie_apps/util/constant.dart';

class MovieList extends StatelessWidget {
  final List<Movie> listMovies;

  MovieList({Key? key, required this.listMovies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listMovies.length,
        itemBuilder: (context, index) {
          final Movie movie = listMovies[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return DetailScreen(id: movie.id);
                }),
              );
            },
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Image.network(
                        "$IMAGEURL${movie.imagePath}",
                        // fit: BoxFit.fill,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    movie.title,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: movie.rating <= 5
                                        ? Colors.blue
                                        : movie.rating >= 6 && movie.rating < 7
                                            ? Colors.yellow
                                            : Colors.green,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    "${movie.rating.toString()}",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 50,
                              child: Text(
                                "${movie.description}",
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
