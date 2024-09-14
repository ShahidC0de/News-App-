part of 'channel_bloc.dart';

@immutable
sealed class ChannelState {}

final class ChannelInitial extends ChannelState {}

final class ChannelLoading extends ChannelState {}

final class ChannelFailure extends ChannelState {
  final String message;
  ChannelFailure({
    required this.message,
  });
}

final class ChannelSuccess extends ChannelState {
  final List<News> newsList;
  ChannelSuccess({
    required this.newsList,
  });
}
