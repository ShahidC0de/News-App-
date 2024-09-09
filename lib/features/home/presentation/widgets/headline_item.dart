import 'package:flutter/material.dart';
import 'package:news_app/core/theme/app_colors.dart';

class HeadLineItem extends StatelessWidget {
  final String imageLink;
  final String headLinesText;
  const HeadLineItem(
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
            height: 250,
            fit: BoxFit.cover,
            imageLink,
          ),
          const Divider(
            color: AppColors.borderColor,
          ),
          Text(headLinesText),
        ],
      ),
    );
  }
}
