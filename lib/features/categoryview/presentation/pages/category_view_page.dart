import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/common/widgets/loader.dart';
import 'package:news_app/core/utils/show_snackbar.dart';
import 'package:news_app/features/categoryview/presentation/bloc/category_bloc.dart';
import 'package:news_app/features/news_view/presentation/pages/news_view.dart';
import 'package:news_app/features/news_view/presentation/widgets/related_news_container.dart';

class CategoryViewPage extends StatefulWidget {
  final String categoryName;
  const CategoryViewPage({required this.categoryName, super.key});

  @override
  State<CategoryViewPage> createState() => _CategoryViewPageState();
}

class _CategoryViewPageState extends State<CategoryViewPage> {
  final Map<String, String> categoryMap = {
    'Technology': 'technology',
    'Health': 'health',
    'Sports': 'sports',
    'Business': 'business',
    'Entertainment': 'entertainment'
  };

  String checkTheCategoryName(String categoryName) {
    return categoryMap[categoryName] ?? "";
  }

  @override
  void initState() {
    context.read<CategoryBloc>().add(
          CategoriesNewsEvent(
            categoryName: checkTheCategoryName(widget.categoryName),
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocConsumer<CategoryBloc, CategoryState>(
              listener: (context, state) {
                if (state is CategoryFailure) {
                  showSnackBar(context, state.message);
                }
              },
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return const Center(
                    child: Loader(),
                  );
                }
                if (state is CategorySuccess) {
                  final news = state.newsList;
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: news.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Two items in each row
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 0.75, // Adjust the item aspect ratio
                    ),
                    itemBuilder: (context, index) {
                      final newsItem = news[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  NewsView(newsData: newsItem)));
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
        ),
      ),
    );
  }
}
