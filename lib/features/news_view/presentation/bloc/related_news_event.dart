part of 'related_news_bloc.dart';

@immutable
sealed class RelatedNewsEvent {}

final class FetchingRelatedNews extends RelatedNewsEvent {
  final String description;
  final String title;
  FetchingRelatedNews({
    required this.description,
    required this.title,
  });
}
