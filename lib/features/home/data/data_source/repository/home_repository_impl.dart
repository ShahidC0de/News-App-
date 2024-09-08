import 'package:fpdart/fpdart.dart';
import 'package:news_app/core/errors/exceptions.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/features/home/data/data_source/home_remote_datasource.dart';
import 'package:news_app/features/home/domain/entities/news.dart';
import 'package:news_app/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource homeRemoteDatasource;
  const HomeRepositoryImpl({
    required this.homeRemoteDatasource,
  });
  @override
  Future<Either<Failure, List<News>>> fetchEveryNews() async {
    try {
      final response = await homeRemoteDatasource.fetchEverything();
      return right(response);
    } on ServerException catch (e) {
      return left(
        Failure(message: e.message),
      );
    }
  }

  @override
  Future<Either<Failure, List<News>>> fetchTopHeadlinesNews() async {
    try {
      final response = await homeRemoteDatasource.fetchTopHeadlines();
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
