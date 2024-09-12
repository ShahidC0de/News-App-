import 'package:fpdart/fpdart.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/core/usecase/fetchnews_use_case.dart';
import 'package:news_app/common/entities/news.dart';
import 'package:news_app/features/home/domain/repository/home_repository.dart';

class FetchAllEverythingNews implements FetchnewsUseCase {
  final HomeRepository homeRepository;
  const FetchAllEverythingNews({
    required this.homeRepository,
  });
  @override
  Future<Either<Failure, List<News>>> call() async {
    return await homeRepository.fetchEveryNews();
  }
}

class FetchTopHeadlinesNews implements FetchTopHeadlinesUseCase {
  final HomeRepository homeRepository;
  const FetchTopHeadlinesNews({
    required this.homeRepository,
  });
  @override
  Future<Either<Failure, List<News>>> call() async {
    return await homeRepository.fetchTopHeadlinesNews();
  }
}
