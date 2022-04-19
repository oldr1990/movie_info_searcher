

import 'package:flutter/material.dart';
import 'package:movie_info_searcher/data/models/search_data.dart';

import 'mis_pages.dart';

class AppStateManager extends ChangeNotifier{
  final _searchList = <SearchData>[];
  MovieInfoSearcherPage _currentPage = MovieInfoSearcherPage.search;
  List<SearchData> get searchList => List.unmodifiable(_searchList);

  void addSearching(List<SearchData> list){
    _searchList.addAll(list);
    notifyListeners();
  }

  void goToPage(MovieInfoSearcherPage page){
      _currentPage = page;
      notifyListeners();
  }

}