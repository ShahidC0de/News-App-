import 'package:fpdart/fpdart.dart';
import 'package:news_app/common/entities/news.dart';
import 'package:news_app/core/errors/failure.dart';

abstract interface class SearchBasedNewsUsecase<SuccessType,
    SearchBasedNewsParmas> {
  Future<Either<Failure, List<News>>> call(SearchBasedNewsParmas params);
}
