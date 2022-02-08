

import 'package:flutter/material.dart';
import 'package:movie_info_searcher/data/models/search_data.dart';

class AppStateManager extends ChangeNotifier{
  final _searchList = <SearchData>[];
  List<SearchData> get searchList => List.unmodifiable(_searchList);

  void addSearching(List<SearchData> list){
    _searchList.addAll(list);
    notifyListeners();
  }

}