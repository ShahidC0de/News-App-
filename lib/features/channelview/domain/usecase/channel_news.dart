import 'package:fpdart/fpdart.dart';
import 'package:news_app/common/entities/news.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/core/usecase/channel_news_use_case.dart';
import 'package:news_app/features/channelview/domain/repository/channel_news_repository.dart';

class ChannelNewssUsecase
    implements ChannelNewsUseCase<List<News>, ChannelNewsUserInputParams> {
  final ChannelNewsRepository channelNewsRepository;
  ChannelNewssUsecase({
    required this.channelNewsRepository,
  });
  @override
  Future<Either<Failure, List<News>>> call(
      ChannelNewsUserInputParams params) async {
    return channelNewsRepository.fetchNewsBasedOnChannel(params.channelName);
  }
}

class ChannelNewsUserInputParams {
  final String channelName;
  ChannelNewsUserInputParams({
    required this.channelName,
  });
}
