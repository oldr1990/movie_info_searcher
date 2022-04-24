
import 'package:equatable/equatable.dart';

class OmdbiResponse {
  List<Search> search;
  String totalResults;
  String response;

  OmdbiResponse({
    this.search = const [],
    this.totalResults = "",
    required this.response,
  });

  factory OmdbiResponse.fromJson(Map<String, dynamic> json) {
    final searchList = <Search>[];
    if (json['Search'] != null) {
      json['Search'].forEach((v) {
        searchList.add(Search.fromJson(v));
      });
    }
    return OmdbiResponse(
        search: searchList,
        totalResults: json['totalResults'] ?? "",
        response: json['Response'] ?? "");
  }
}

class Search {
  String title;
  String year;
  String imdbID;
  String type;
  String poster;

  Search({
    this.title = "",
    this.year = "",
    this.imdbID = "",
    this.type = "",
    this.poster = "",
  });

  factory Search.fromJson(Map<String, dynamic> json) {
    return Search(
    title: json['Title'] ?? "",
    year: json['Year'],
    imdbID: json['imdbID'],
    type: json['Type'],
    poster: json['Poster'],);
  }

}
