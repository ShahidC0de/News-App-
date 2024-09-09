import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/common/widgets/loader.dart';
import 'package:news_app/core/theme/app_colors.dart';

class HeadLineItem extends StatelessWidget {
  final String imageLink;
  final String headLinesText;
  const HeadLineItem(
      {required this.headLinesText, required this.imageLink, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2, left: 8, right: 8),
            child: CachedNetworkImage(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.2,
              imageUrl: imageLink,
              placeholder: (context, url) => const Loader(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
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
