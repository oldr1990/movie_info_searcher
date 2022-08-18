// ignore: file_names
import 'dart:convert';

DetailsData detailsDataFromJson(String str) =>
    DetailsData.fromJson(json.decode(str));
String detailsDataToJson(DetailsData data) => json.encode(data.toJson());

class DetailsData {
  DetailsData(
      {String? title,
      String? year,
      String? rated,
      String? released,
      String? runtime,
      String? genre,
      String? director,
      String? writer,
      String? actors,
      String? plot,
      String? language,
      String? country,
      String? awards,
      String? poster,
      List<Ratings>? ratings,
      String? metascore,
      String? imdbRating,
      String? imdbVotes,
      String? imdbID,
      String? type,
      String? totalSeasons,
      String? response,
      String? error}) {
    _title = title;
    _year = year;
    _rated = rated;
    _released = released;
    _runtime = runtime;
    _genre = genre;
    _director = director;
    _writer = writer;
    _actors = actors;
    _plot = plot;
    _language = language;
    _country = country;
    _awards = awards;
    _poster = poster;
    _ratings = ratings;
    _metascore = metascore;
    _imdbRating = imdbRating;
    _imdbVotes = imdbVotes;
    _imdbID = imdbID;
    _type = type;
    _totalSeasons = totalSeasons;
    _response = response;
    _error = error;
  }

  DetailsData.fromJson(dynamic json) {
    _title = json['Title'];
    _year = json['Year'];
    _rated = json['Rated'];
    _released = json['Released'];
    _runtime = json['Runtime'];
    _genre = json['Genre'];
    _director = json['Director'];
    _writer = json['Writer'];
    _actors = json['Actors'];
    _plot = json['Plot'];
    _language = json['Language'];
    _country = json['Country'];
    _awards = json['Awards'];
    _poster = json['Poster'];
    if (json['Ratings'] != null) {
      _ratings = [];
      json['Ratings'].forEach((v) {
        _ratings?.add(Ratings.fromJson(v));
      });
    }
    _metascore = json['Metascore'];
    _imdbRating = json['imdbRating'];
    _imdbVotes = json['imdbVotes'];
    _imdbID = json['imdbID'];
    _type = json['Type'];
    _totalSeasons = json['totalSeasons'];
    _response = json['Response'];
    _error = json['Error'];
  }

  String? _title;
  String? _year;
  String? _rated;
  String? _released;
  String? _runtime;
  String? _genre;
  String? _director;
  String? _writer;
  String? _actors;
  String? _plot;
  String? _language;
  String? _country;
  String? _awards;
  String? _poster;
  List<Ratings>? _ratings;
  String? _metascore;
  String? _imdbRating;
  String? _imdbVotes;
  String? _imdbID;
  String? _type;
  String? _totalSeasons;
  String? _response;
  String? _error;

  DetailsData copyWith({
    String? title,
    String? year,
    String? rated,
    String? released,
    String? runtime,
    String? genre,
    String? director,
    String? writer,
    String? actors,
    String? plot,
    String? language,
    String? country,
    String? awards,
    String? poster,
    List<Ratings>? ratings,
    String? metascore,
    String? imdbRating,
    String? imdbVotes,
    String? imdbID,
    String? type,
    String? totalSeasons,
    String? response,
    String? error,
  }) =>
      DetailsData(
        title: title ?? _title,
        year: year ?? _year,
        rated: rated ?? _rated,
        released: released ?? _released,
        runtime: runtime ?? _runtime,
        genre: genre ?? _genre,
        director: director ?? _director,
        writer: writer ?? _writer,
        actors: actors ?? _actors,
        plot: plot ?? _plot,
        language: language ?? _language,
        country: country ?? _country,
        awards: awards ?? _awards,
        poster: poster ?? _poster,
        ratings: ratings ?? _ratings,
        metascore: metascore ?? _metascore,
        imdbRating: imdbRating ?? _imdbRating,
        imdbVotes: imdbVotes ?? _imdbVotes,
        imdbID: imdbID ?? _imdbID,
        type: type ?? _type,
        totalSeasons: totalSeasons ?? _totalSeasons,
        response: response ?? _response,
        error: error ?? _error,
      );
  String? get title => _title;
  String? get year => _year;
  String? get rated => _rated;
  String? get released => _released;
  String? get runtime => _runtime;
  String? get genre => _genre;
  String? get director => _director;
  String? get writer => _writer;
  String? get actors => _actors;
  String? get plot => _plot;
  String? get language => _language;
  String? get country => _country;
  String? get awards => _awards;
  String? get poster => _poster;
  List<Ratings>? get ratings => _ratings;
  String? get metascore => _metascore;
  String? get imdbRating => _imdbRating;
  String? get imdbVotes => _imdbVotes;
  String? get imdbID => _imdbID;
  String? get type => _type;
  String? get totalSeasons => _totalSeasons;
  String? get response => _response;
  String? get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Title'] = _title;
    map['Year'] = _year;
    map['Rated'] = _rated;
    map['Released'] = _released;
    map['Runtime'] = _runtime;
    map['Genre'] = _genre;
    map['Director'] = _director;
    map['Writer'] = _writer;
    map['Actors'] = _actors;
    map['Plot'] = _plot;
    map['Language'] = _language;
    map['Country'] = _country;
    map['Awards'] = _awards;
    map['Poster'] = _poster;
    if (_ratings != null) {
      map['Ratings'] = _ratings?.map((v) => v.toJson()).toList();
    }
    map['Metascore'] = _metascore;
    map['imdbRating'] = _imdbRating;
    map['imdbVotes'] = _imdbVotes;
    map['imdbID'] = _imdbID;
    map['Type'] = _type;
    map['totalSeasons'] = _totalSeasons;
    map['Response'] = _response;
    map['Error'] = _error;
    return map;
  }
}

Ratings ratingsFromJson(String str) => Ratings.fromJson(json.decode(str));
String ratingsToJson(Ratings data) => json.encode(data.toJson());

class Ratings {
  Ratings({
    String? source,
    String? value,
  }) {
    _source = source;
    _value = value;
  }

  Ratings.fromJson(dynamic json) {
    _source = json['Source'];
    _value = json['Value'];
  }
  String? _source;
  String? _value;
  Ratings copyWith({
    String? source,
    String? value,
  }) =>
      Ratings(
        source: source ?? _source,
        value: value ?? _value,
      );
  String? get source => _source;
  String? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Source'] = _source;
    map['Value'] = _value;
    return map;
  }
}
