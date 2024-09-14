part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategoryFailure extends CategoryState {
  final String message;
  CategoryFailure({
    required this.message,
  });
}

final class CategorySuccess extends CategoryState {
  final List<News> newsList;
  CategorySuccess({
    required this.newsList,
  });
}
