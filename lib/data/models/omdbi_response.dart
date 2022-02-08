
class Omdbi_response {
  List<Search> search;
  String totalResults;
  String response;

  Omdbi_response({
    this.search = const [],
    this.totalResults = "",
    required this.response,
  });

  factory Omdbi_response.fromJson(Map<String, dynamic> json) {
    final searchList = <Search>[];
    if (json['Search'] != null) {
      json['Search'].forEach((v) {
        searchList.add(Search.fromJson(v));
      });
    }
    return Omdbi_response(
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
