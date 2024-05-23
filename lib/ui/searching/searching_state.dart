part of 'searching_bloc.dart';

enum SearchStatus { initial, success, failure }

class SearchingState {
  final List<Search> list;
  final bool hasReachedMax;

  SearchingState({this.list = const <Search>[], this.hasReachedMax = false});

  SearchingState copyWith({
    List<Search>? list,
    bool? hasReachedMax,
  }) {
    return SearchingState(
      list: list ?? this.list,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

sealed class NotifAction extends SearchingState {}

class Loading extends NotifAction {
  final bool isLoading;

  Loading(this.isLoading);
}

class Navigate extends NotifAction {
  final String route;
  final Object? data;

  Navigate({required this.route, this.data});
}

class ErrorAction extends NotifAction {
  final String message;

  ErrorAction(this.message);
}
