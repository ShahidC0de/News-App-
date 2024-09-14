part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

class CategoriesNewsEvent extends CategoryEvent {
  final String categoryName;
  CategoriesNewsEvent({
    required this.categoryName,
  });
}
