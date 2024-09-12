import 'package:fpdart/src/either.dart';
import 'package:news_app/common/entities/news.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/core/usecase/fetch_related_news_usecase.dart';
import 'package:news_app/features/news_view/domain/repository/related_news_repository.dart';

class FetchTheRelatedNews
    implements FetchRelatedNewsUsecase<List<News>, RelatedNewsParams> {
  final RelatedNewsRepository relatedNewsRepository;
  FetchTheRelatedNews({
    required this.relatedNewsRepository,
  });

  @override
  Future<Either<Failure, List<News>>> call(RelatedNewsParams params) {
    return relatedNewsRepository.fetchrelatedNews(
        params.description, params.title);
  }
}

class RelatedNewsParams {
  final String description;
  final String title;
  RelatedNewsParams({
    required this.description,
    required this.title,
  });
}
