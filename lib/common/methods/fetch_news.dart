import 'dart:convert';

import 'package:news_app/common/models/news_model.dart';
import 'package:news_app/core/errors/exceptions.dart';
import 'package:http/http.dart' as http;

Future<List<NewsModel>> fetchNews(
  String endPoint,
  http.Client httpClient,
) async {
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
