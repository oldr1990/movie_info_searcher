import 'package:movie_info_searcher/data/models/details_data.dart';
import 'package:movie_info_searcher/data/models/omdbi_response.dart';
import 'package:movie_info_searcher/data/models/search_data.dart';
import 'package:movie_info_searcher/network/model_response.dart';
import 'package:movie_info_searcher/network/omdbi_service_impl.dart';

class OmdbiRepositoryTest extends OmdbiRepository {
  final Result<DetailsData> getDetailsData;
  final Result<OmdbiResponse> searchMoviesData;

  OmdbiRepositoryTest(this.getDetailsData, this.searchMoviesData);

  @override
  Future<Result<DetailsData>> getDetails(String id) async {
    return getDetailsData;
  }

  @override
  Future<Result<OmdbiResponse>> searchMovies(SearchData data) async {
    return searchMoviesData;
  }
}
