import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movie_info_searcher/data/models/DetailsData.dart';
import 'package:movie_info_searcher/ui/main_screen_state.dart';
import '../data/models/omdbi_response.dart';
import '../data/models/search_data.dart';
import 'omdbi_service_impl.dart';

abstract class Repository{
  void getMovies(SearchData searchData);
  void getDetails(String id);
  Future init();
  void close();
}

class RepositoryImpl extends Repository with ChangeNotifier{

  final List<Search> list = <Search>[];
   DetailsData details  = DetailsData();
   MainScreenState state = Initial();

  @override
  void close() {}

  @override
  void getDetails(String id)  async {
      final json = await OmdbiService().getDetails(id);
      details =  DetailsData.fromJson(jsonDecode(json));
      notifyListeners();
  }

  @override
  void getMovies(SearchData searchData) async {
    if (list.isEmpty){
      state = Loading();
      notifyListeners();
    }
      final json = await OmdbiService()
          .searchMovies(searchData.search, searchData.type, searchData.year);
      final jsonMap = jsonDecode(json);
      state = DataLoaded(OmdbiResponse.fromJson(jsonMap).search);
    notifyListeners();
  }

  @override
  Future init() {
    return Future.value(null);
  }
}