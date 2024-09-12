import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String imageUrl;

  const ImageWidget({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: _height * 0.4, // 40% of the screen height
      width: _width, // full width of the screen
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(), // Show loader while image loads
        ),
        errorWidget: (context, url, error) => const Center(
          child: Icon(
            Icons.error, // Display error icon when image fails to load
            color: Colors.red,
            size: 50,
          ),
        ),
      ),
    );
  }
}
