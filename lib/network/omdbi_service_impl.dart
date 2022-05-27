import 'dart:developer';

import 'package:http/http.dart';
import 'package:movie_info_searcher/data/models/search_data.dart';

const String baseUrl = "http://www.omdbapi.com/";
const String apiKey = "830086";

class OmdbiService {
  Future getData(String url) async {
    final response = await get(Uri.parse(url));
    if (response.statusCode == 200 || response.statusCode == 401) {
      log(response.body);
      return response.body;
    } else {
      log(response.statusCode.toString());
      final map = <String, dynamic>{};
      map['Response'] = "Error";
      map['Error'] = "Unexpected error!";
      return map;
    }
  }

  Future<dynamic> searchMovies(SearchData data) async {
    String typeString = getType(data.type);
    final request =
        '$baseUrl?apikey=$apiKey&s=${data.search}&y=${data.year}&type=$typeString&page=${data.page.toString()}';
    log(request);
    final movies = await getData(request);
    return movies;
  }

  Future<dynamic> getDetails(String id) async {
    log("$baseUrl?apikey=$apiKey&i=$id");
    return await getData("$baseUrl?apikey=$apiKey&i=$id");
  }

  String getType(TypeOfMovie? type) {
    switch (type) {
      case TypeOfMovie.all:
        return '';
      case TypeOfMovie.movies:
        return 'movie';
      case TypeOfMovie.series:
        return 'series';
      case TypeOfMovie.episode:
        return 'episode';
      case null:
        return '';
    }
  }
}
