import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/common/entities/news.dart';
import 'package:news_app/common/widgets/loader.dart';
import 'package:news_app/core/theme/app_colors.dart';
import 'package:news_app/core/utils/show_snackbar.dart';
import 'package:news_app/features/news_view/presentation/bloc/related_news_bloc.dart';
import 'package:news_app/features/news_view/presentation/widgets/image_widget.dart';
import 'package:news_app/features/news_view/presentation/widgets/related_news_container.dart';

class NewsView extends StatefulWidget {
  final News newsData;
  const NewsView({required this.newsData, super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  @override
  void initState() {
    context.read<RelatedNewsBloc>().add(FetchingRelatedNews(
          description: getKeyWords(widget.newsData.description ?? ""),
          title: getKeyWords(widget.newsData.title),
        ));
    super.initState();
  }

  String getKeyWords(String text) {
    return text.split(" ").take(3).join(" ");
  }

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
                icon: const Icon(CupertinoIcons.back))),
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

              // Related News Section
              const RelatedNewsSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class RelatedNewsSection extends StatelessWidget {
  const RelatedNewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title for the Related News section
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Related News',
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Related News content with BlocConsumer
        BlocConsumer<RelatedNewsBloc, RelatedNewsState>(
          listener: (context, state) {
            if (state is RelatedNewsFailure) {
              return showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is RelatedNewsLoading) {
              return const Loader();
            }

            if (state is RelatedNewsSuccess) {
              final relatedNews = state.newsList;

              // If no related news, show a message
              if (relatedNews.isEmpty) {
                return const Center(
                  child: Text(
                    'No related news found',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              }

              // Display the related news articles in a grid
              return GridView.builder(
                itemCount: relatedNews.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two items in each row
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.75, // Adjust the item aspect ratio
                ),
                itemBuilder: (context, index) {
                  final newsItem = relatedNews[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NewsView(newsData: newsItem)));
                    },
                    child: RelatedNewsContainer(
                      imageUrl: newsItem.urlToImage ?? "",
                      title: newsItem.title,
                    ),
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ],
    );
  }
}
