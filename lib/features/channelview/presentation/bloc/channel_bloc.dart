// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_app/common/entities/news.dart';
import 'package:news_app/features/channelview/domain/usecase/channel_news.dart';

part 'channel_event.dart';
part 'channel_state.dart';

class ChannelBloc extends Bloc<ChannelEvent, ChannelState> {
  final ChannelNewssUsecase _channelNewssUsecase;
  ChannelBloc({
    required ChannelNewssUsecase channelNewssUsecase,
  })  : _channelNewssUsecase = channelNewssUsecase,
        super(ChannelInitial()) {
    on<FetchChannelNews>((event, emit) async {
      emit(ChannelLoading());
      final response = await _channelNewssUsecase(
          ChannelNewsUserInputParams(channelName: event.channelName));
      response.fold((l) => emit(ChannelFailure(message: l.message)),
          (r) => emit(ChannelSuccess(newsList: r)));
    });
  }
}
