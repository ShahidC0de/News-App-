import 'package:fpdart/fpdart.dart';
import 'package:news_app/common/entities/news.dart';
import 'package:news_app/core/errors/failure.dart';
import 'package:news_app/core/usecase/category_based_news_usecase.dart';
import 'package:news_app/features/categoryview/domain/repository/category_news_repository.dart';

class CategoryNewsUsecase
    implements CategoryBasedNewsUsecase<List<News>, UserCategoryInputParams> {
  final CategoryNewsRepository categoryNewsRepository;
  CategoryNewsUsecase({
    required this.categoryNewsRepository,
  });
  @override
  Future<Either<Failure, List<News>>> call(params) async {
    return categoryNewsRepository.fetchCateogoryNews(params.categoryName);
  }
}

class UserCategoryInputParams {
  final String categoryName;
  UserCategoryInputParams({
    required this.categoryName,
  });
}
