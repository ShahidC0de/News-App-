import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:news_app/core/errors/exceptions.dart';
import 'package:news_app/features/home/data/models/top_headlines_model.dart';

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
  Future<List<NewsModel>> _fetchNews(String endPoint) async {
    try {
      final uri = Uri.parse(endPoint);
      final response = await httpClient.get(uri);

      if (response.statusCode == 200) {
        final jsonString = response.body;
        final jsonFormat = await jsonDecode(jsonString);
        final articles = jsonFormat['articles'] as List;
        return articles.map((article) => NewsModel.fromJson(article)).toList();
      } else {
        throw ServerException("failed to fetch Data: ${response.statusCode}");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<NewsModel>> fetchEverything() async {
    return _fetchNews(
        'https://newsapi.org/v2/everything?q=general&apiKey=$apikey');
  }

  @override
  Future<List<NewsModel>> fetchTopHeadlines() async {
    return _fetchNews(
        'https://newsapi.org/v2/top-headlines?language=en&apiKey=$apikey');
  }
}
