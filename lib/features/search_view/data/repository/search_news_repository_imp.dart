import 'package:fpdart/src/either.dart';
import 'package:news_app/common/entities/news.dart';
import 'package:news_app/core/errors/exceptions.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/features/search_view/data/search_news_remote_data_impl.dart';
import 'package:news_app/features/search_view/domain/repository/search_news_repository.dart';

class SearchNewsRepositoryImp implements SearchNewsRepository {
  final SearchNewsRemoteData searchNewsRemoteData;
  SearchNewsRepositoryImp({
    required this.searchNewsRemoteData,
  });

  @override
  Future<Either<Failure, List<News>>> fetchNewsBasedOnSearchText(
      String searchedText) async {
    try {
      final response =
          await searchNewsRemoteData.fetchsearchTextNews(searchedText);
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
