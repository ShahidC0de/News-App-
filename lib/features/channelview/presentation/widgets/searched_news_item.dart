import 'package:flutter/material.dart';
import 'package:news_app/common/entities/news.dart';
import 'package:news_app/features/news_view/presentation/pages/news_view.dart';
import 'package:news_app/features/news_view/presentation/widgets/related_news_container.dart';

class SearchedNewsItem extends StatelessWidget {
  final List<News> newsList;

  const SearchedNewsItem({
    super.key,
    required this.newsList,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two items in each row
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.75, // Adjust the item aspect ratio
      ),
      itemCount: newsList.length,
      itemBuilder: (context, index) {
        final newsItem = newsList[index];

        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NewsView(newsData: newsItem),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: RelatedNewsContainer(
              imageUrl: newsItem.urlToImage ??
                  "assets/placeholder.png", // Use a placeholder if the image is null
              title: newsItem.title,
            ),
          ),
        );
      },
    );
  }
}
