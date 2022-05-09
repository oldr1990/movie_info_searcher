import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movie_info_searcher/data/models/DetailsData.dart';
import 'package:movie_info_searcher/ui/main_screen_state.dart';
import '../data/models/omdbi_response.dart';
import '../data/models/search_data.dart';
import 'omdbi_service_impl.dart';

abstract class Repository {
  void setSearchData(SearchData searchData);

  Future<List<Search>> loadMore();

  Future<DetailsData> getDetails(String id);

  Future init();

  void close();
}

class RepositoryImpl extends Repository with ChangeNotifier {
  MainScreenState state = Initial();
  SearchData currentSearchData = SearchData(search: '');
  double pages = 1;
  int currentPage = 0;
  String? search;
  String? year;
  TypeOfMovie type = TypeOfMovie.all;
  int? page;

  @override
  void close() {}

  @override
  Future<DetailsData> getDetails(String id) async {
    final json = await OmdbiService().getDetails(id);
    return DetailsData.fromJson(jsonDecode(json));
  }

  void setupPages(String pagesStr) {
    pages = double.tryParse(pagesStr) ?? 0;
    pages = pages / 10;
    if (pages % 10 != 0) pages++;
    if (pages > 100) pages = 100;
  }

  @override
  Future init() {
    return Future.value(null);
  }

  @override
  Future<List<Search>> loadMore() async {
    try {
      if (currentPage >= pages) return [];
      currentPage++;
      final searchData = SearchData(
          search: currentSearchData.search,
          year: currentSearchData.year,
          type: currentSearchData.type,
          page: currentPage);
      final json = await OmdbiService().searchMovies(searchData);
      final jsonMap = jsonDecode(json);
      OmdbiResponse response = OmdbiResponse.fromJson(jsonMap);
      if (response.response == "True") {
        setupPages(response.totalResults!);
        return response.search;
      } else {
        state = Error(Exception(response.error ?? "Unexpected error."));
        return [];
      }
    } catch (e) {
      state = Error(Exception("Unexpected error."));
      return [];
    }
  }

  bool isNotSameSearch(SearchData searchData) {
    if (searchData.search != currentSearchData.search ||
        searchData.year != currentSearchData.year ||
        searchData.type != currentSearchData.type) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void setSearchData(SearchData searchData) {
      pages = 1;
      currentPage = 0;
      currentSearchData = searchData;
      state = SearchDataUpdated();
  }
}
