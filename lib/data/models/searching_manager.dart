
import 'package:flutter/material.dart';

import 'omdbi_response.dart';

class SearchingManager extends ChangeNotifier{
  Search? _selectedMovie;
  Search? get selectedMovie => _selectedMovie;

  void selectMovie(Search movie){
    _selectedMovie = movie;
    notifyListeners();
  }

}