import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../data/models/DetailsData.dart';
import '../../data/models/omdbi_response.dart';
import '../../data/models/search_data.dart';
import '../../network/omdbi_service_impl.dart';
import 'package:stream_transform/stream_transform.dart';


part 'searching_event.dart';

part 'searching_state.dart';

class SearchingBloc extends Bloc<SearchingEvent, SearchingState> {
  SearchingBloc() : super(const SearchingState()) {
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
      emit(state.copyWith(status: SearchStatus.success, hasReachedMax: true));
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
    int allMovies = int.tryParse(pagesStr) ?? 0;
    int pages = allMovies ~/ 10;
    if (allMovies % 10 != 0) pages++;
    if (pages > 10) pages = 10;
    return pages <= searchData.page;
  }

  Future<DetailsData> _searchDetails(String id) async {
    final json = await OmdbiService().getDetails(id);
    return DetailsData.fromJson(jsonDecode(json));
  }

  FutureOr<void> _getDetails(
      GetDetails event, Emitter<SearchingState> emit) async {
    emit(state.copyWith(status: SearchStatus.loading));
    try {
      final details = await _searchDetails(event.movieId);
      return emit(
          state.copyWith(status: SearchStatus.details, details: details));
    } catch (e) {
      return emit(
          state.copyWith(status: SearchStatus.failure, error: e.toString()));
    }
  }
}
