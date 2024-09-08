import 'package:fpdart/fpdart.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/features/home/domain/entities/news.dart';

abstract interface class FetchnewsUseCase {
  Future<Either<Failure, List<News>>> call();
}

abstract interface class FetchTopHeadlinesUseCase {
  Future<Either<Failure, List<News>>> call();
}
