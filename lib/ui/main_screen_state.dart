import 'package:movie_info_searcher/data/models/DetailsData.dart';

import '../data/models/omdbi_response.dart';

abstract class MainScreenState {}

class Initial extends MainScreenState {}

class Error extends MainScreenState {
  Exception errorException;

  Error(this.errorException);
}

class SearchDataUpdated extends MainScreenState {}

