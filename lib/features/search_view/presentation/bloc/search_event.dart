part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

final class SearchingTextEvent extends SearchEvent {
  final String searchText;
  SearchingTextEvent({
    required this.searchText,
  });
}
