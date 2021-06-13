import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final double rating;
  final String description;
  final String releaseDate;
  final String imagePath;

  Movie(
      {this.id = 0,
      this.title = "",
      this.rating = 0,
      this.description = "",
      this.releaseDate = "",
      this.imagePath = ""});

  @override
  List<Object?> get props => [id];

  static Movie fromJson(dynamic json) {
    return Movie(
      id: json["id"],
      title: json["title"],
      rating: json["vote_average"],
      description: json["overview"],
      releaseDate: json["release_date"],
      imagePath: json["poster_path"],
    );
  }
}
