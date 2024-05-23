import 'dart:async';
import 'dart:developer';
import 'package:movie_info_searcher/data/models/details_data.dart';
import 'package:movie_info_searcher/data/models/omdbi_response.dart';
import 'package:movie_info_searcher/data/models/search_data.dart';
import 'package:movie_info_searcher/network/mock/request_result.dart';
import 'package:movie_info_searcher/network/model_response.dart';

const String baseUrl = "http://www.omdbapi.com/";
const String apiKey = "830086";

abstract class OmdbiRepository {
  const OmdbiRepository();
  Future<Result<OmdbiResponse>> searchMovies(SearchData data);

  Future<Result<DetailsData>> getDetails(String id);
}

class OmdbiRepositoryImpl extends OmdbiRepository {
  const OmdbiRepositoryImpl();
  @override
  Future<Result<OmdbiResponse>> searchMovies(SearchData data) async {
    String typeString = getType(data.type);
    final request =
        '$baseUrl?apikey=$apiKey&s=${data.search}&y=${data.year}&type=$typeString&page=${data.page.toString()}';
    log(request);
    return await requestResult(request, (p0) => OmdbiResponse.fromJson(p0));
  }

  @override
  Future<Result<DetailsData>> getDetails(String id) async {
    log("$baseUrl?apikey=$apiKey&i=$id");
    return await requestResult(
        "$baseUrl?apikey=$apiKey&i=$id", (i) => DetailsData.fromJson(i));
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
