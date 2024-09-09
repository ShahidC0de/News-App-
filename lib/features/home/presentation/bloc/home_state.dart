part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeError extends HomeState {
  final String message;
  HomeError({
    required this.message,
  });
}

final class HomeTopHeadtitlesNewsSuccess extends HomeState {
  final List<News> newsList;
  HomeTopHeadtitlesNewsSuccess({
    required this.newsList,
  });
}

final class HomeEveryNewsSuccess extends HomeState {
  final List<News> newsList;
  HomeEveryNewsSuccess({
    required this.newsList,
  });
}
