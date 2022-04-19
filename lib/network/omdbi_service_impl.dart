import 'dart:developer';

import 'package:http/http.dart';
import 'package:movie_info_searcher/data/models/search_data.dart';

const String baseUrl = "http://www.omdbapi.com/";
const String apiKey = "830086";

class OmdbiService{

  Future getData(String url) async{
    final response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
    }
  }

  Future<dynamic> searchMovies(String search, TypeOfMovie? type, String? year) async{
    String typeString = getType(type);
    log("$baseUrl?apikey=$apiKey&s=$search&year=$year&type=$typeString");
    final movies = await getData("$baseUrl?apikey=$apiKey&s=$search&y=$year&type=$typeString");
    return movies;
  }

  String getType(TypeOfMovie? type){
      switch(type){
        case TypeOfMovie.all: return '';
        case TypeOfMovie.movies: return 'movie';
        case TypeOfMovie.series: return 'series';
        case TypeOfMovie.episode: return 'episode';
        case null: return '';
      }
  }
}