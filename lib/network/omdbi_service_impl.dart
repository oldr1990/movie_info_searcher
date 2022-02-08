import 'package:http/http.dart';

const String baseUrl = "http://www.omdbi.com/";
const String apiKey = "830086";

class OmdbiService{

  Future getData(String url) async{
    final response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
    }
  }

  Future<dynamic> searchMovies(String search, String? type, String? year) async{
    final movies = await getData("$baseUrl?apikey=$apiKey&s=$search&year=$year&type=$type");
    return movies;
  }

}