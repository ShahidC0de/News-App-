import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/common/entities/news.dart';
import 'package:news_app/features/categoryview/domain/usecase/category_news_usecase.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryNewsUsecase _categoryNewsUsecase;
  CategoryBloc({
    required CategoryNewsUsecase categoriesNewsUsecase,
  })  : _categoryNewsUsecase = categoriesNewsUsecase,
        super(CategoryInitial()) {
    on<CategoriesNewsEvent>(
      (event, emit) async {
        emit(CategoryLoading());
        final response = await _categoryNewsUsecase(
            UserCategoryInputParams(categoryName: event.categoryName));
        response.fold(
          (failure) => emit(
            CategoryFailure(
              message: failure.message,
            ),
          ),
          (right) => emit(
            CategorySuccess(newsList: right),
          ),
        );
      },
    );
  }
}
