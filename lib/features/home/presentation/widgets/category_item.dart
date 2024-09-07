import 'package:flutter/material.dart';

class CustomImageViewer extends StatelessWidget {
  final String imageLink;
  const CustomImageViewer({required this.imageLink, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(shape: BoxShape.circle, boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8,
          spreadRadius: 2,
          offset: Offset(4, 4),
        )
      ]),
      child: ClipOval(
        child: Image.network(
          imageLink,
          fit: BoxFit.cover,
          width: 120,
          height: 120,
        ),
      ),
    );
  }
}
