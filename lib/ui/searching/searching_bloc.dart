import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../data/models/omdbi_response.dart';
import '../../data/models/search_data.dart';
import '../../network/omdbi_service_impl.dart';
part 'searching_event.dart';
part 'searching_state.dart';


class SearchingBloc extends Bloc<SearchingEvent, SearchingState> {
  SearchingBloc() : super(const SearchingState()) {
    on<SearchMore>(_onSearchMore);
    on<SearchInitial>(_onInitialSearch);
  }
  SearchData searchData = const SearchData();
  bool isEnd = false;

  Future<void> _onSearchMore(
      SearchMore event, Emitter<SearchingState> emit) async {
    if (state.hasReachedMax) return;
    try {
        final loadedList = await _searchMovies();
        return emit(state.copyWith(
            status: SearchStatus.success,
            list: state.list + loadedList,
            hasReachedMax: isEnd));
    } catch (e) {
      return emit(state.copyWith(status: SearchStatus.failure));
    }
  }


  Future<void> _onInitialSearch(
      SearchInitial event, Emitter<SearchingState> emit) async {
    isEnd = false;
    searchData = event.data;
    try {
      final loadedList = await _searchMovies();
      return emit(state.copyWith(
          status: SearchStatus.success,
          list: loadedList,
          hasReachedMax: isEnd));
    } catch (e) {
      return emit(state.copyWith(status: SearchStatus.failure));
    }
  }

  Future<List<Search>> _searchMovies() async {
    final json = await OmdbiService().searchMovies(searchData);
    final jsonMap = jsonDecode(json);
    OmdbiResponse response = OmdbiResponse.fromJson(jsonMap);
    if (response.response == "True") {
      isEnd = checkEnd(response.totalResults!);
      return response.search;
    } else {
      throw Exception(response.error ?? "Unexpected error.");
    }
  }

  bool checkEnd(String pagesStr) {
    searchData = searchData.copyWith(page: searchData.page + 1);
    int pages = int.tryParse(pagesStr) ?? 0;
    pages = (pages / 10) as int;
    if (pages % 10 != 0) pages++;
    if (pages > 100) pages = 100;
    return pages <= searchData.page;
  }
}
