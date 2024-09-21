import 'dart:convert';
import 'dart:async'; // For delay
import 'package:http/http.dart' as http;
import 'package:news_app/common/models/news_model.dart';
import 'package:news_app/core/errors/exceptions.dart';

Future<List<NewsModel>> fetchNews(
  String endPoint,
  http.Client httpClient,
) async {
  int retryCount = 0;
 int maxRetries = 3;

  while (retryCount < maxRetries) {
    try {
      final uri = Uri.parse(endPoint);
      final response = await httpClient.get(uri);

      if (response.statusCode == 200) {
        // Successfully received the data
        final jsonString = response.body;
        final jsonFormat = await jsonDecode(jsonString);
        final articles = jsonFormat['articles'] as List;
        return articles.map((article) => NewsModel.fromJson(article)).toList();
      } else if (response.statusCode == 429) {
        // Handle rate-limiting (Too Many Requests)
        retryCount++;
        final retryAfter = _getRetryAfter(response.headers);
        await Future.delayed(Duration(seconds: retryAfter));
      } else {
        // Any other errors
        throw ServerException("Failed to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      if (retryCount >= maxRetries) {
        throw ServerException('Max retries exceeded. Last error: $e');
      }
      retryCount++;
    }
  }

  throw ServerException('Failed to fetch data after $maxRetries retries.');
}

// Helper function to get the 'retry-after' header value
int _getRetryAfter(Map<String, String> headers) {
  if (headers.containsKey('retry-after')) {
    return int.tryParse(headers['retry-after']!) ?? 2; // Default to 2 seconds if parsing fails
  }
  return 2; // Default retry interval in seconds
}
