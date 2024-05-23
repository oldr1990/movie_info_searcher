part of 'searching_bloc.dart';

@immutable
abstract class SearchingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchMore extends SearchingEvent {
  final SearchData data;

  SearchMore(this.data);
}

class SearchInitial extends SearchingEvent {
  final SearchData data;

  SearchInitial({required this.data});
}

class GetDetails extends SearchingEvent {
  final String movieId;

  GetDetails({required this.movieId});
}
