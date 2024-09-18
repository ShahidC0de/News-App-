import 'package:fpdart/fpdart.dart';
import 'package:news_app/common/entities/news.dart';
import 'package:news_app/core/errors/failure.dart';

abstract interface class SearchNewsRepository {
  Future<Either<Failure, List<News>>> fetchNewsBasedOnSearchText(
      String searchedText);
}
