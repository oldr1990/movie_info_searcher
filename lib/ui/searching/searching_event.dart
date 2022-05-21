part of 'searching_bloc.dart';

@immutable
abstract class SearchingEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class SearchMore extends SearchingEvent{}
class SearchInitial extends SearchingEvent{
  final SearchData data;
  SearchInitial({required this.data});
}