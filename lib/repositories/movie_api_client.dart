import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_apps/util/constant.dart';
import 'package:movie_apps/util/custom_uri.dart';

class MovieApiClient {
  Future<Map<String, dynamic>> getListMovies() async {
    try {
      Uri uri = Uri.https(BASEURL, "/3/movie/popular", {
        "api_key": APIKEY,
        "language": "en-US",
        "page": "1",
      });

      final response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception('error while fetching movie list');
      }

      final json = jsonDecode(response.body);

      return json;
    } catch (error) {
      print("error nih $error");
    }
    return HashMap();
  }

  Future<Map<String, dynamic>> getMovieDetails(int id) async {
    final response = await http.get(
      CustomUri.getUri(
        BASEURL,
        "/3/movie/$id",
        {
          "api_key": APIKEY,
          "language": "en-US",
        },
      ),
    );

    if (response.statusCode != 200) {
      throw Exception('error while fetching movie details');
    }

    final json = jsonDecode(response.body);
    return json;
  }
}
