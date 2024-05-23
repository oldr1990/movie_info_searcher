import 'dart:async';
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
  final OmdbiRepository repository;
  bool _isLoadingMore = false;
  int _page = 0;
  List<Search> _list = [];

  SearchingBloc({this.repository = const OmdbiRepositoryImpl()})
      : super(SearchingState()) {
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

  Future<void> _onSearchMore(
      SearchMore event, Emitter<SearchingState> emit) async {
    if (_isLoadingMore || state.hasReachedMax) {
      return;
    }
    _page++;
    _isLoadingMore = true;
    final result = await repository.searchMovies(event.data);
    if (result is Success<OmdbiResponse>) {
      final data = result.value;
      _list += data.search;
      emit(state.copyWith(
          list: _list, hasReachedMax: isEnd(data.totalResults ?? '0')));
    } else if (result is Error<OmdbiResponse>) {
      emit(ErrorAction(result.errorMessage));
      emit(state.copyWith(hasReachedMax: true));
    }
    _isLoadingMore = false;
  }

  Future<void> _onInitialSearch(
      SearchInitial event, Emitter<SearchingState> emit) async {
    _page = 1;
    _list = [];
    emit(Loading(true));
    final result = await repository.searchMovies(event.data);
    if (result is Success<OmdbiResponse>) {
      _list = result.value.search;
      emit(state.copyWith(
          list: _list, hasReachedMax: isEnd(result.value.totalResults ?? '0')));
    } else if (result is Error<OmdbiResponse>) {
      emit(ErrorAction(result.errorMessage));
    }
    emit(Loading(false));
  }

  bool isEnd(String pagesStr) {
    int allMovies = int.tryParse(pagesStr) ?? 0;
    int pages = allMovies ~/ 10;
    if (allMovies % 10 != 0) pages++;
    if (pages > 10) pages = 10;
    return pages <= _page;
  }

  FutureOr<void> _getDetails(
      GetDetails event, Emitter<SearchingState> emit) async {
    emit(Loading(true));
    final result = await repository.getDetails(event.movieId);
    if (result is Success<DetailsData>) {
      if (result.value.response == "True") {
        emit(Navigate(route: DetailScreen.route, data: result.value));
      } else {
        emit(ErrorAction("Unexpected error."));
      }
    } else if (result is Error<DetailsData>) {
      emit(ErrorAction(result.errorMessage));
    }
    emit(Loading(false));
  }
}
