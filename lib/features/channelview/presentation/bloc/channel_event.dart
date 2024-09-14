part of 'channel_bloc.dart';

@immutable
sealed class ChannelEvent {}

final class FetchChannelNews extends ChannelEvent {
  final String channelName;
  FetchChannelNews({
    required this.channelName,
  });
}
