import 'package:http/http.dart' as http;
import 'package:news_app/common/methods/fetch_news.dart';
import 'package:news_app/common/models/news_model.dart';
import 'package:news_app/core/errors/exceptions.dart';

abstract interface class SearchNewsRemoteData {
  Future<List<NewsModel>> fetchsearchTextNews(String searchText);
}

class SearchNewsRemoteDataImpl implements SearchNewsRemoteData {
  final http.Client httpClient;
  final String apiKey;
  SearchNewsRemoteDataImpl({
    required this.httpClient,
    required this.apiKey,
  });
  @override
  Future<List<NewsModel>> fetchsearchTextNews(String searchText) async {
    try {
      final response = await fetchNews(
          'https://newsapi.org/v2/everything?q=$searchText&apiKey=$apiKey',
          httpClient);
      return response;
    } on ServerException catch (e) {
      throw Exception(e.toString());
    }
  }
}
