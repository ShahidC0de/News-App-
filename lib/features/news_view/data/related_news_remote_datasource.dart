import 'dart:convert';

import 'package:news_app/common/models/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/core/errors/exceptions.dart';

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
  Future<List<NewsModel>> fetchrelatedNews(
      String description, String title) async {
    try {
      final uri = Uri.parse(
          'https://newsapi.org/v2/everything?q=$title $description&apiKey=$apiKey');

      final response = await httpClient.get(uri);
      if (response.statusCode == 200) {
        final jsonString = response.body;
        final jsonFormat = await jsonDecode(jsonString);
        final articles = await jsonFormat['article'] as List;
        return articles.map((article) => NewsModel.fromJson(article)).toList();
      } else {
        throw Exception();
      }
    } on ServerException catch (e) {
      throw ServerException(e.toString());
    }
  }
}
