// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_app/common/entities/news.dart';
import 'package:news_app/features/search_view/domain/usecase/searchbased_news_use_case.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUseCase _searchUseCase;
  SearchBloc({
    required SearchUseCase searchUsecase,
  })  : _searchUseCase = searchUsecase,
        super(SearchInitial()) {
    on<SearchingTextEvent>((event, emit) async {
      await Future.delayed(const Duration(milliseconds: 500));
      if (event.searchText.isEmpty) {
        emit(SearchInitial());
        return;
      }
      emit(SearchLoading());
      final response = await _searchUseCase(
          SearchBasedNewsParmas(searchedText: event.searchText));
      response.fold((l) => emit(SearchFailure(message: l.message)),
          (r) => emit(SearchedSuccess(newsList: r)));
    });
  }
}
