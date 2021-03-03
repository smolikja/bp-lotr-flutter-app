import 'dart:convert';
import 'package:bp_flutter_app/models/characters_model.dart';
import 'package:bp_flutter_app/models/movies_model.dart';
import 'package:bp_flutter_app/models/quotes_model.dart';

class JsonParseHelper {
  JsonParseHelper._privateConstructor();
  static final JsonParseHelper _instance = JsonParseHelper._privateConstructor();

  factory JsonParseHelper() {
    return _instance;
  }

  CharactersModel getCharacters(String response) {
    if (response == null) {
      return null;
    }

    Map<String, dynamic> map = jsonDecode(response);
    return CharactersModel.fromJson(map);
  }

  MoviesModel getMovies(String response) {
    if (response == null) {
      return null;
    }

    Map<String, dynamic> map = jsonDecode(response);
    return MoviesModel.fromJson(map);
  }

  QuotesModel getQuotes(String response) {
    if (response == null) {
      return null;
    }

    Map<String, dynamic> map = jsonDecode(response);
    return QuotesModel.fromJson(map);
  }
}
