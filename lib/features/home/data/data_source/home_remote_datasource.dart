import 'dart:convert';
import 'dart:io';

import 'package:news_app/core/errors/exceptions.dart';
import 'package:news_app/features/home/data/models/top_headlines_model.dart';

abstract interface class HomeRemoteDatasource {
  Future<List<NewsModel>> fetchTopHeadlines();
  Future<List<NewsModel>> fetchEverything();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDatasource {
  final String apikey;
  final HttpClient httpClient;
  const HomeRemoteDataSourceImpl({
    required this.apikey,
    required this.httpClient,
  });
  @override
  Future<List<NewsModel>> fetchEverything() async {
    try {
      final uri = Uri.parse(
        'https://newsapi.org/v2/everything?language=en&apiKey=$apikey',
      );
      final request = await httpClient.getUrl(uri);
      final response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        final convertingBytesToPlainText = await response
            .transform(utf8.decoder)
            .join(); // convert data in bytes into string data,
        final jsonFormat = jsonDecode(
            convertingBytesToPlainText); // converting into json format,
        final articles = jsonFormat['articles']
            as List; // in json format there are a lot of articles, each article is a map,
        // so it will take all articles as List and return it,
        return articles
            .map((articles) => NewsModel.fromJson(articles))
            .toList();
      } else {
        throw ServerException('Failed to fetch data ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }

  @override
  Future<List<NewsModel>> fetchTopHeadlines() async {
    try {
      final uri = Uri.parse(
        'https://newsapi.org/v2/top-headlines?language=en&apiKey=$apikey',
      );
      final request = await httpClient.getUrl(uri);
      final response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        final convertingBytesToPlainText = await response
            .transform(utf8.decoder)
            .join(); // convert data in bytes into string data,
        final jsonFormat = jsonDecode(
            convertingBytesToPlainText); // converting into json format,
        final articles = jsonFormat['articles']
            as List; // in json format there are a lot of articles, each article is a map,
        // so it will take all articles as List and return it,
        return articles
            .map((articles) => NewsModel.fromJson(articles))
            .toList();
      } else {
        throw ServerException('Failed to fetch data ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException(
        e.toString(),
      );
    }
  }
}
