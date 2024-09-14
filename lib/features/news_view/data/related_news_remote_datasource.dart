import 'package:news_app/common/methods/fetch_news.dart';
import 'package:news_app/common/models/news_model.dart';
import 'package:http/http.dart' as http;

abstract interface class RelatedNewsRemoteDataSource {
  Future<List<NewsModel>> fetchrelatedNews(String description, String title);
}

class RelatedNewsRemoteDataSourceImpl extends RelatedNewsRemoteDataSource {
  final http.Client httpClient;
  final String apiKey;
  RelatedNewsRemoteDataSourceImpl({
    required this.httpClient,
    required this.apiKey,
  });

  @override
  Future<List<NewsModel>> fetchrelatedNews(String description, String title) {
    return fetchNews(
      'https://newsapi.org/v2/everything?q=$title $description&apiKey=$apiKey',
      httpClient,
    );
  }
}
