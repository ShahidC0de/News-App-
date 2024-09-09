// ignore_for_file: overridden_fields

import 'package:news_app/features/home/domain/entities/news.dart';

class NewsModel extends News {
  @override
  final String? sourceId;
  @override
  final String? author;
  @override
  final String? description;
  @override
  final String? urlToImage;
  @override
  final String? content;

  NewsModel({
    this.sourceId,
    required super.sourceName, // Match the parent class constructor
    this.author,
    required super.title, // Match the parent class constructor
    this.description,
    required super.url, // Match the parent class constructor
    this.urlToImage,
    required super.publishedAt, // Match the parent class constructor
    this.content,
  });

  // From JSON method
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      sourceId: json['source']['id'],
      sourceName: json['source']['name'] ?? '',
      author: json['author'],
      title: json['title'] ?? '',
      description: json['description'],
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'] ?? '',
      content: json['content'],
    );
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    return {
      'source': {
        'id': sourceId,
        'name': sourceName,
      },
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }

  News convertToNews(NewsModel model) {
    return News(
      sourceName: model.sourceName,
      title: model.title,
      url: model.url,
      publishedAt: model.publishedAt,
      sourceId: model.sourceId,
      author: model.author,
      description: model.description,
      urlToImage: model.urlToImage,
      content: model.content,
    );
  }
}
