import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/data/models/top_headlines_model.dart';
import 'package:news_app/features/home/domain/entities/news.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchEveryNews _fetchEveryNews;
  final FetchTopHeadlines _fetchTopHeadlines;

  HomeBloc({
    required FetchEveryNews fetchEveryNews,
    required FetchTopHeadlines fetchTopHeadlines,
  })  : _fetchEveryNews = fetchEveryNews,
        _fetchTopHeadlines = fetchTopHeadlines,
        super(HomeInitial()) {
    on<FetchTopHeadlines>((event, emit) async {
      emit(HomeLoading());
      final response = await _fetchTopHeadlines.call();
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
