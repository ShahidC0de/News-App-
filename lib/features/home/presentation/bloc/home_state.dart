part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeTopHeadlinesLoading extends HomeState {}

final class HomeTopHeadlinesFailure extends HomeState {
  final String message;
  HomeTopHeadlinesFailure({
    required this.message,
  });
}

final class HomeTopHeadlinesSuccess extends HomeState {
  final List<News> newsList;
  HomeTopHeadlinesSuccess({
    required this.newsList,
  });
}
