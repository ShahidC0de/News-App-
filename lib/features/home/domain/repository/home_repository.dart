import 'package:fpdart/fpdart.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/common/entities/news.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, List<News>>> fetchEveryNews();
  Future<Either<Failure, List<News>>> fetchTopHeadlinesNews();
}
