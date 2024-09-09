part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeFailure extends HomeState {
  final String message;
  HomeFailure({
    required this.message,
  });
}

final class HomeTopTitlesSuccess extends HomeState {
  final List<News> newsList;
  HomeTopTitlesSuccess({
    required this.newsList,
  });
}

final class HomeGeneralNewsSuccess extends HomeState {
  final List<News> newsList;
  HomeGeneralNewsSuccess({
    required this.newsList,
  });
}
