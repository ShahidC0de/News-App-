// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/common/widgets/loader.dart';
import 'package:news_app/core/theme/app_colors.dart';

class RelatedNewsContainer extends StatelessWidget {
  final String imageUrl;
  final String title;
  const RelatedNewsContainer({
    required this.imageUrl,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.blueColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5), // Shadow position
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // News Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => const Center(
                child: Loader(),
              ),
              errorWidget: (context, url, error) => const Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
              height: _height * 0.2,
              width: _width,
              fit: BoxFit.cover,
            ),
          ),

          // Title with Padding and Styling
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
