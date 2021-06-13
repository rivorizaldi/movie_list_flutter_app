import 'dart:collection';

class CustomUri {
  static Uri getUri(
      String baseUrl, String path, Map<String, dynamic> queryParameters) {
    return Uri.https(baseUrl, path, queryParameters);
  }
}
