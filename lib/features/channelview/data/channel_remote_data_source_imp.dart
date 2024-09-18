import 'package:http/http.dart' as http;
import 'package:news_app/common/methods/fetch_news.dart';
import 'package:news_app/common/models/news_model.dart';

abstract interface class ChannelRemoteDataSource {
  Future<List<NewsModel>> fetchNewsBasedOnChannelName(String channelName);
}

class ChannelRemoteDataSourceImp implements ChannelRemoteDataSource {
  final String apiKey;
  final http.Client httpClient;
  ChannelRemoteDataSourceImp({
    required this.httpClient,
    required this.apiKey,
  });

  @override
  Future<List<NewsModel>> fetchNewsBasedOnChannelName(
      String channelName) async {
    String apiKeyy =
        'https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=$apiKey';
    final response = await fetchNews(apiKeyy, httpClient);

    return response;
  }
}
