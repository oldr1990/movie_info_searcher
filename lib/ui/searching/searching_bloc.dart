import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_info_searcher/network/model_response.dart';
import '../../data/models/details_data.dart';
import '../../data/models/omdbi_response.dart';
import '../../data/models/search_data.dart';
import '../../network/omdbi_service_impl.dart';
import 'package:stream_transform/stream_transform.dart';

import '../details_screen.dart';

part 'searching_event.dart';

part 'searching_state.dart';

class SearchingBloc extends Bloc<SearchingEvent, SearchingState> {
  final BuildContext context;
  SearchingBloc({required this.context}) : super(const SearchingState()) {
    on<SearchMore>(_onSearchMore, transformer: (events, mapper) {
      return events
          .debounce(const Duration(milliseconds: 300))
          .asyncExpand(mapper);
    });
    on<SearchInitial>(_onInitialSearch);
    on<GetDetails>(_getDetails, transformer: (events, mapper) {
      return events
          .debounce(const Duration(milliseconds: 300))
          .asyncExpand(mapper);
    });
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
       searchData = const SearchData();
       emit(state.copyWith(status: SearchStatus.failure, error: e.toString()));
       emit(state.copyWith(status: SearchStatus.success, hasReachedMax: true));
    }
  }

  Future<void> _onInitialSearch(
      SearchInitial event, Emitter<SearchingState> emit) async {
    emit(state.copyWith(status: SearchStatus.loading));
    isEnd = false;
    searchData = event.data;
    try {
      final loadedList = await _searchMovies();
      return emit(state.copyWith(
          status: SearchStatus.success,
          list: loadedList,
          hasReachedMax: isEnd));
    } catch (e) {
      searchData = const SearchData();
      emit(state.copyWith(status: SearchStatus.failure, error: e.toString()));
    }
  }

  Future<List<Search>> _searchMovies() async {
    final result = await OmdbiService().searchMovies(searchData);
    if (result is Error<String>) {
      throw result.errorMessage;
    }
    result as Success<String>;
    final jsonMap = jsonDecode(result.value);
    OmdbiResponse response = OmdbiResponse.fromJson(jsonMap);
    if (response.response == "True") {
      isEnd = checkEnd(response.totalResults!);
      return response.search;
    } else {
      throw response.error ?? "Unexpected error.";
    }
  }

  bool checkEnd(String pagesStr) {
    searchData = searchData.copyWith(page: searchData.page + 1);
    int allMovies = int.tryParse(pagesStr) ?? 0;
    int pages = allMovies ~/ 10;
    if (allMovies % 10 != 0) pages++;
    if (pages > 10) pages = 10;
    return pages <= searchData.page;
  }

  Future<DetailsData> _searchDetails(String id) async {
    final result = await OmdbiService().getDetails(id);
    if (result is Error<String>) {
      throw result.errorMessage;
    }
    result as Success<String>;
    final details = DetailsData.fromJson(jsonDecode(result.value));
    if (details.response == "True") {
      return details;
    } else {
      throw details.error ?? "Unexpected error.";
    }
  }

  FutureOr<void> _getDetails(
      GetDetails event, Emitter<SearchingState> emit) async {
    emit(state.copyWith(status: SearchStatus.loading));
    try {
      final details = await _searchDetails(event.movieId);
      Navigator.pushNamed(context, DetailScreen.route, arguments: details);
      emit(state.copyWith(status: SearchStatus.success));
    } catch (e) {
      emit(state.copyWith(status: SearchStatus.failure, error: e.toString()));
    }
  }
}
