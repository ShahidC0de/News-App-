import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/common/entities/news.dart';
import 'package:news_app/core/theme/app_colors.dart';
import 'package:news_app/features/news_view/presentation/widgets/image_widget.dart';

class NewsView extends StatefulWidget {
  final News newsData;
  const NewsView({required this.newsData, super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
            decoration: BoxDecoration(
                color: AppColors.blueColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10)),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(CupertinoIcons.back))),
        centerTitle: true,
        title: const Text(
          'News Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: ImageWidget(imageUrl: widget.newsData.urlToImage ?? ""),
              ),
              const SizedBox(height: 20),

              // Published Date
              Text(
                widget.newsData.publishedAt,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),

              // News Title
              Text(
                widget.newsData.title,
                style: const TextStyle(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 10),

              // Divider
              const Divider(
                color: AppColors.blueColor,
                thickness: 1.5,
              ),
              const SizedBox(height: 10),

              // News Description
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: AppColors.blueColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.newsData.description ?? 'No description available.',
                  style: const TextStyle(
                    color: AppColors.textColor,
                    fontSize: 18,
                    height:
                        1.5, // Increased line spacing for better readability
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Related News Button (example for future enhancements)
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.borderColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Placeholder for related news logic
                  },
                  child: const Text('View Related News'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
