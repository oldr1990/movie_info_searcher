part of 'searching_bloc.dart';

enum SearchStatus { initial, success, failure }

class SearchingState {
  final SearchStatus status;
  final List<Search> list;
  final bool hasReachedMax;

  const SearchingState(
      {this.status = SearchStatus.initial,
      this.list = const <Search>[],
      this.hasReachedMax = false});

  SearchingState copyWith(
      {SearchStatus? status, List<Search>? list, bool? hasReachedMax}) {
    return SearchingState(
        status: status ?? this.status,
        list: list ?? this.list,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }
}
