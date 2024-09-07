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
      decoration: const BoxDecoration(shape: BoxShape.rectangle, boxShadow: [
        BoxShadow(
          color: AppColors.borderColor,
          blurRadius: 12,
          spreadRadius: 0.1,
          offset: Offset(2, 2),
        )
      ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
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
