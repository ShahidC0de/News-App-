import 'package:fpdart/fpdart.dart';
import 'package:news_app/common/entities/news.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/core/usecase/search_based_news_usecase.dart';
import 'package:news_app/features/search_view/domain/repository/search_news_repository.dart';

class SearchUseCase
    implements SearchBasedNewsUsecase<List<News>, SearchBasedNewsParmas> {
  final SearchNewsRepository searchNewsRepository;
  SearchUseCase({
    required this.searchNewsRepository,
  });
  @override
  Future<Either<Failure, List<News>>> call(SearchBasedNewsParmas params) {
    return searchNewsRepository.fetchNewsBasedOnSearchText(params.searchedText);
  }
}

class SearchBasedNewsParmas {
  final String searchedText;
  SearchBasedNewsParmas({
    required this.searchedText,
  });
}
