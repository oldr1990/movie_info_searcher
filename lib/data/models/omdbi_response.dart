
class OmdbiResponse {
  List<Search> search;
  String? totalResults;
  String? response;
  String? error;

  OmdbiResponse({
    this.search = const [],
    this.totalResults = "0",
    required this.response,
    this.error,
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
        totalResults: json['totalResults'] ?? "0",
        response: json['Response'] ?? "",
        error: json['Error']);
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
