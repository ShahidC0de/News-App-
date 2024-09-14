import 'package:news_app/common/entities/news.dart';
import 'package:news_app/common/methods/fetch_news.dart';
import 'package:http/http.dart' as http;

abstract interface class CategoryNewsDataSource {
  Future<List<News>> fetchCategoryNews(String categoryName);
}

class CategoryNewsRemoteDataSouceImpl implements CategoryNewsDataSource {
  final String apiKey;
  final http.Client httpClient;
  CategoryNewsRemoteDataSouceImpl({
    required this.apiKey,
    required this.httpClient,
  });
  @override
  Future<List<News>> fetchCategoryNews(String categoryName) async {
    final response = await fetchNews(
        'https://newsapi.org/v2/top-headlines?category=$categoryName&apiKey=$apiKey',
        httpClient);
    return response;
  }
}
