import 'package:flutter/material.dart';
import 'package:movie_apps/model/movie.dart';
import 'package:movie_apps/screen/detail/detail_screen.dart';
import 'package:movie_apps/util/constant.dart';

class MovieGrid extends StatelessWidget {
  final gridCount;
  final List<Movie> listMovies;

  const MovieGrid({
    Key? key,
    required this.gridCount,
    required this.listMovies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.all(24),
      crossAxisCount: gridCount,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: (1 / 1.5),
      children: listMovies.map((movie) {
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailScreen(id: movie.id);
            }));
          },
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            semanticContainer: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image.network(
                    "$IMAGEURL${movie.imagePath}",
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                          child: Text(
                            movie.title,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(2),
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
