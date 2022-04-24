
import '../data/models/omdbi_response.dart';

abstract class MainScreenState{}

class Loading extends MainScreenState{}

class Initial extends MainScreenState{}

class Error extends MainScreenState{
  String? errorMessage;
}

class DataLoaded extends MainScreenState{
   List<Search> data;

   DataLoaded(this.data);
}