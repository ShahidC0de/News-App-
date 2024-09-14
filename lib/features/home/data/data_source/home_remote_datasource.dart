import 'package:http/http.dart' as http;
import 'package:news_app/common/methods/fetch_news.dart';

import 'package:news_app/common/models/news_model.dart';

abstract interface class HomeRemoteDatasource {
  Future<List<NewsModel>> fetchTopHeadlines();
  Future<List<NewsModel>> fetchEverything();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDatasource {
  final String apikey;
  final http.Client httpClient;
  const HomeRemoteDataSourceImpl({
    required this.apikey,
    required this.httpClient,
  });

  @override
  Future<List<NewsModel>> fetchEverything() async {
    return fetchNews(
        'https://newsapi.org/v2/everything?q=general&apiKey=$apikey',
        httpClient);
  }

  @override
  Future<List<NewsModel>> fetchTopHeadlines() async {
    return fetchNews(
        'https://newsapi.org/v2/top-headlines?language=en&apiKey=$apikey',
        httpClient);
  }
}
