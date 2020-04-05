import 'dart:async';
import 'dart:convert' show json, utf8;
import 'dart:io';

import 'package:ghibliparser/film.dart';

class Api {
  static final HttpClient _httpClient = HttpClient();
  static final String _url = "ghibliapi.herokuapp.com";

  static Future<List<Film>> getFilmsList() async {
    final uri = Uri.https(_url, '/films');

    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null) {
      return null;
    }

    return Film.mapJSONStringToList(jsonResponse);
  }

  static Future<dynamic> _getJson(Uri uri) async {
    try {
      final httpRequest = await _httpClient.getUrl(uri);
      final httpResponse = await httpRequest.close();
      if (httpResponse.statusCode != HttpStatus.ok) {
        return null;
      }

      final responseBody = await httpResponse.transform(utf8.decoder).join();
      return json.decode(responseBody);
    } on Exception catch (e) {
      print('$e');
      return null;
    }
  }
}
