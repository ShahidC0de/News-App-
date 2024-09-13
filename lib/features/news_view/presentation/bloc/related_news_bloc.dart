import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/common/entities/news.dart';
import 'package:news_app/features/news_view/presentation/use_case/use_case.dart';

part 'related_news_event.dart';
part 'related_news_state.dart';

class RelatedNewsBloc extends Bloc<RelatedNewsEvent, RelatedNewsState> {
  final FetchTheRelatedNews _fetchTheRelatedNews;
  RelatedNewsBloc({
    required FetchTheRelatedNews fetchTherelatedNews,
  })  : _fetchTheRelatedNews = fetchTherelatedNews,
        super(RelatedNewsInitial()) {
    on<FetchingRelatedNews>((event, emit) async {
      emit(RelatedNewsLoading());

      final response = await _fetchTheRelatedNews(RelatedNewsParams(
          description: event.description, title: event.title));

      response.fold((failure) {
        emit(RelatedNewsFailure(message: failure.message));
      }, (response) {
        emit(RelatedNewsSuccess(newsList: response));
      });
    });
  }
}
