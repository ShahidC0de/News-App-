class News {
  final String sourceName;
  final String title;
  final String url;
  final String publishedAt;
  final String? sourceId; // Optional field
  final String? author; // Optional field
  final String? description; // Optional field
  final String? urlToImage; // Optional field
  final String? content; // Optional field

  News({
    required this.sourceName,
    required this.title,
    required this.url,
    required this.publishedAt,
    this.sourceId,
    this.author,
    this.description,
    this.urlToImage,
    this.content,
  });
}
