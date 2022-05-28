import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';
import 'package:movie_info_searcher/data/models/search_data.dart';
import 'package:movie_info_searcher/network/model_response.dart';


const String baseUrl = "http://www.omdbapi.com/";
const String apiKey = "830086";

class OmdbiService {
  Future<Result<String>> getData(String url) async {
    try {
      final response = await get(Uri.parse(url));
      if (response.statusCode == 200 || response.statusCode == 401) {
        log(response.body);
        return Success(response.body);
      } else {
        log(response.statusCode.toString());
        return Error("Unexpected error!");
      }
    } on SocketException {
      return Error("Please, check your internet connection and try again.");
    }  on TimeoutException {
      return Error( "Server not responding!");
    } catch (e) {
      return Error("Unknown error occupied!");
    }
  }

  Future<Result<String>> searchMovies(SearchData data) async {
    String typeString = getType(data.type);
    final request =
        '$baseUrl?apikey=$apiKey&s=${data.search}&y=${data.year}&type=$typeString&page=${data.page.toString()}';
    log(request);
    final movies = await getData(request);
    return movies;
  }

  Future<Result<String>> getDetails(String id) async {
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
