import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/domain/entities/news.dart';
import 'package:news_app/features/home/domain/usecase/fetch_news.dart';

part 'general_news_bloc_event.dart';
part 'general_news_bloc_state.dart';

class GeneralNewsBlocBloc
    extends Bloc<GeneralNewsBlocEvent, GeneralNewsBlocState> {
  final FetchAllEverythingNews _fetchEveryNews;
  GeneralNewsBlocBloc({
    required FetchAllEverythingNews fetchEveryNews,
  })  : _fetchEveryNews = fetchEveryNews,
        super(GeneralNewsBlocInitial()) {
    on<GeneralNewsBlocEvent>((event, emit) async {
      emit(GeneralNewsBlocLoading());
      final response = await _fetchEveryNews();
      response.fold((l) => emit(GeneralNewsBlocFailure(message: l.message)),
          (r) => emit(GeneralNewsBlocSuccess(newsList: r)));
    });
  }
}
