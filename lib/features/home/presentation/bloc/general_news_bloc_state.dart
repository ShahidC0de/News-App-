part of 'general_news_bloc_bloc.dart';

@immutable
sealed class GeneralNewsBlocState {}

final class GeneralNewsBlocInitial extends GeneralNewsBlocState {}

final class GeneralNewsBlocLoading extends GeneralNewsBlocState {}

final class GeneralNewsBlocFailure extends GeneralNewsBlocState {
  final String message;
  GeneralNewsBlocFailure({
    required this.message,
  });
}

final class GeneralNewsBlocSuccess extends GeneralNewsBlocState {
  final List<News> newsList;
  GeneralNewsBlocSuccess({
    required this.newsList,
  });
}
