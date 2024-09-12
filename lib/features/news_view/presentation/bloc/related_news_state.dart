part of 'related_news_bloc.dart';

@immutable
sealed class RelatedNewsState {}

final class RelatedNewsInitial extends RelatedNewsState {}

final class RelatedNewsLoading extends RelatedNewsState {}

final class RelatedNewsFailure extends RelatedNewsState {
  final String message;
  RelatedNewsFailure({
    required this.message,
  });
}

final class RelatedNewsSuccess extends RelatedNewsState {
  final List<News> newsList;
  RelatedNewsSuccess({
    required this.newsList,
  });
}
