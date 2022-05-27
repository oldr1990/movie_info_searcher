part of 'searching_bloc.dart';

enum SearchStatus { initial, success, failure, loading }

class SearchingState {
  final SearchStatus status;
  final List<Search> list;
  final bool hasReachedMax;
  final DetailsData? details;
  final String error;

  const SearchingState(
      {this.status = SearchStatus.initial,
      this.list = const <Search>[],
      this.hasReachedMax = false,
      this.details,
      this.error = ''});

  SearchingState copyWith(
      {SearchStatus? status,
      List<Search>? list,
      bool? hasReachedMax,
      DetailsData? details,
      String? error}) {
    return SearchingState(
        status: status ?? this.status,
        list: list ?? this.list,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        details: details ?? this.details,
        error: error ?? this.error);
  }
}
