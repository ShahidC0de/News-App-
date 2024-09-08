import 'dart:io';

abstract interface class HomeRemoteDatasource {
  Future<String> fetchNewsHeadlines();
  Future<String> fetchNewsEverything();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDatasource {
  final String apikey;
  final HttpClient httpClient;
  const HomeRemoteDataSourceImpl({
    required this.apikey,
    required this.httpClient,
  });
  @override
  Future<String> fetchNewsEverything() {
    // TODO: implement fetchNewsEverything
    throw UnimplementedError();
  }

  @override
  Future<String> fetchNewsHeadlines() {
    // TODO: implement fetchNewsHeadlines
    throw UnimplementedError();
  }
}
