part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchFailure extends SearchState {
  final String message;
  SearchFailure({
    required this.message,
  });
}

final class SearchedSuccess extends SearchState {
  final List<News> newsList;
  SearchedSuccess({
    required this.newsList,
  });
}
