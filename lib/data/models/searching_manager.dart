
import 'package:flutter/material.dart';
import 'package:movie_info_searcher/data/models/details_data.dart';


class SearchingManager extends ChangeNotifier{
  DetailsData? _selectedMovie;
  DetailsData? get selectedMovie => _selectedMovie;

  void showMovieDetails(DetailsData movie){
    _selectedMovie = movie;
    notifyListeners();
  }

}