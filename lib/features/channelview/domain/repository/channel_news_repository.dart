import 'package:fpdart/fpdart.dart';
import 'package:news_app/common/models/news_model.dart';
import 'package:news_app/core/errors/failure.dart';

abstract interface class ChannelNewsRepository {
  Future<Either<Failure, List<NewsModel>>> fetchNewsBasedOnChannel(
      String channelName);
}
