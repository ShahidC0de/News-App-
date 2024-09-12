import 'package:fpdart/fpdart.dart';
import 'package:news_app/common/entities/news.dart';
import 'package:news_app/core/errors/exceptions.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/features/news_view/data/related_news_remote_datasource.dart';
import 'package:news_app/features/news_view/domain/repository/related_news_repository.dart';

class RelatedNewsRepositoryImpl implements RelatedNewsRepository {
  final RelatedNewsRemoteDataSource relatedNewsRemoteDataSource;
  RelatedNewsRepositoryImpl({
    required this.relatedNewsRemoteDataSource,
  });
  @override
  Future<Either<Failure, List<News>>> fetchrelatedNews(
      String description, String title) async {
    try {
      final response = await relatedNewsRemoteDataSource.fetchrelatedNews(
          description, title);
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
