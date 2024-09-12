import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/common/entities/news.dart';
import 'package:news_app/features/home/domain/usecase/fetch_news.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchTopHeadlinesNews _fetchTopHeadlines;

  HomeBloc({
    required FetchTopHeadlinesNews fetchTopHeadlines,
  })  : _fetchTopHeadlines = fetchTopHeadlines,
        super(HomeInitial()) {
    on<FetchTopHeadlines>((event, emit) async {
      emit(HomeTopHeadlinesLoading());
      final response = await _fetchTopHeadlines();
      response.fold(
        (l) => emit(
          HomeTopHeadlinesFailure(message: l.message),
        ),
        (newsList) => emit(
          HomeTopHeadlinesSuccess(newsList: newsList),
        ),
      );
    });
  }
}
