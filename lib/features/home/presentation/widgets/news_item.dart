import 'package:flutter/material.dart';
import 'package:news_app/core/theme/app_colors.dart';

class NewsItem extends StatelessWidget {
  final String imageLink;
  final String headLinesText;
  const NewsItem(
      {required this.headLinesText, required this.imageLink, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            fit: BoxFit.cover,
            imageLink,
          ),
          Text(headLinesText),
          const Divider(
            color: AppColors.borderColor,
          ),
        ],
      ),
    );
  }
}
