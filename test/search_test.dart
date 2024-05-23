



import 'package:bloc_test/bloc_test.dart';
import 'package:movie_info_searcher/data/models/details_data.dart';
import 'package:movie_info_searcher/data/models/omdbi_response.dart';
import 'package:movie_info_searcher/data/models/search_data.dart';
import 'package:movie_info_searcher/network/model_response.dart';
import 'package:movie_info_searcher/ui/searching/searching_bloc.dart';
import 'package:test/test.dart';

import 'omdbi_resository.dart';

void main() {
  group('Test searching page', () {
    late SearchingBloc bloc;
    setUp(() => {
          bloc = SearchingBloc(
            repository: OmdbiRepositoryTest(
              Success(DetailsData(response: 'True')),
              Success(
                OmdbiResponse(search: [
                  Search(title: '1'),
                  Search(title: '2'),
                  Search(title: '3')
                ], response: ''),
              ),
            ),
          )
        });
    blocTest<SearchingBloc, SearchingState>(
      'init',
      build: () => bloc,
      verify: (b) {
        expect(b.state.list.isEmpty, same(true));
      },
    );
    blocTest<SearchingBloc, SearchingState>(
      'load list',
      build: () => bloc,
      act: (b) => b.add(SearchInitial(data: const SearchData(search: 'one'))),
      verify: (b) {
        expect(b.list.length, same(3));
      },
    );
  });
}
