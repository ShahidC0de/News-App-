import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/domain/entities/news.dart';
import 'package:news_app/features/home/domain/usecase/fetch_news.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchAllEverythingNews _fetchEveryNews;
  final FetchTopHeadlinesNews _fetchTopHeadlines;

  HomeBloc({
    required FetchAllEverythingNews fetchEveryNews,
    required FetchTopHeadlinesNews fetchTopHeadlines,
  })  : _fetchEveryNews = fetchEveryNews,
        _fetchTopHeadlines = fetchTopHeadlines,
        super(HomeInitial()) {
    on<FetchEveryNews>((event, emit) async {
      final response = await _fetchEveryNews();
      response.fold(
        (l) => emit(HomeError(message: l.message)),
        (newslist) => emit(
          HomeSuccess(newsList: newslist),
        ),
      );
    });
    on<FetchTopHeadlines>((event, emit) async {
      emit(HomeLoading());
      final response = await _fetchTopHeadlines();
      response.fold(
        (l) => emit(
          HomeError(message: l.message),
        ),
        (newsList) => emit(
          HomeSuccess(newsList: newsList),
        ),
      );
    });
  }
}
