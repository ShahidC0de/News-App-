part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class FetchTopHeadlines extends HomeEvent {}

class FetchEveryNews extends HomeEvent {}
