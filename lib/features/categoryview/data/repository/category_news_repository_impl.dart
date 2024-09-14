import 'package:fpdart/fpdart.dart';
import 'package:news_app/common/entities/news.dart';
import 'package:news_app/core/errors/exceptions.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/features/categoryview/data/category_news_data_source_impl.dart';
import 'package:news_app/features/categoryview/domain/repository/category_news_repository.dart';

class CategoryNewsRepositoryImpl implements CategoryNewsRepository {
  final CategoryNewsDataSource categoryNewsDataSource;
  CategoryNewsRepositoryImpl({
    required this.categoryNewsDataSource,
  });

  @override
  Future<Either<Failure, List<News>>> fetchCateogoryNews(
      String cateogoryName) async {
    try {
      final response =
          await categoryNewsDataSource.fetchCategoryNews(cateogoryName);
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
