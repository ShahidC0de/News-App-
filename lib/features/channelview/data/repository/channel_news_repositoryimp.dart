import 'package:fpdart/src/either.dart';
import 'package:news_app/common/entities/news.dart';
import 'package:news_app/common/models/news_model.dart';
import 'package:news_app/core/errors/exceptions.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/features/channelview/data/channel_remote_data_source_imp.dart';
import 'package:news_app/features/channelview/domain/repository/channel_news_repository.dart';

class ChannelNewsRepositoryimp implements ChannelNewsRepository {
  final ChannelRemoteDataSource channelRemoteDataSource;
  ChannelNewsRepositoryimp({
    required this.channelRemoteDataSource,
  });
  @override
  Future<Either<Failure, List<NewsModel>>> fetchNewsBasedOnChannel(
      String channelName) async {
    try {
      final response = await channelRemoteDataSource
          .fetchNewsBasedOnChannelName(channelName);
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
