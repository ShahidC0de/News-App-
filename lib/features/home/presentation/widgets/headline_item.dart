// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/common/widgets/loader.dart';

class HeadLineItem extends StatelessWidget {
  final String imageLink;
  final String headLinesText;

  const HeadLineItem({
    required this.headLinesText,
    required this.imageLink,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: _width, // Full width of the screen
      height: _height * 0.4, // 40% of the screen height
      child: Stack(
        children: [
          CachedNetworkImage(
            width: _width,
            height: _height * 0.4, // Adjust image height
            imageUrl: imageLink,
            fit: BoxFit.cover, // Ensures the image covers the space
            placeholder: (context, url) => const Loader(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Container(
              color: Colors.black54, // Semi-transparent background for text
              padding: const EdgeInsets.all(8.0),
              child: Text(
                headLinesText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
