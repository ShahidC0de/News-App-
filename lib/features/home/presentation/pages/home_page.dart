import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/common/widgets/loader.dart';
import 'package:news_app/core/theme/app_colors.dart';
import 'package:news_app/core/utils/show_snackbar.dart';
import 'package:news_app/features/home/presentation/bloc/general_news_bloc_bloc.dart';
import 'package:news_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:news_app/features/news_view/presentation/pages/news_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Start auto-scrolling headlines
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        int nextPage = (_pageController.page!.toInt() + 1) % 5;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });

    context.read<HomeBloc>().add(FetchTopHeadlines());
    context.read<GeneralNewsBlocBloc>().add(GeneralBlocEvent());
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('N E W S'),
        centerTitle: true,
        backgroundColor: AppColors.borderColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Headline News Section
            _buildHeadlinesSection(context),

            // Explore Section
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              child: Text(
                'Explore',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // General News Section
            _buildGeneralNewsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeadlinesSection(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeTopHeadlinesFailure) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is HomeTopHeadlinesLoading) {
          return const Loader();
        }
        if (state is HomeTopHeadlinesFailure) {
          return Center(
            child: Text(state.message),
          );
        }
        if (state is HomeTopHeadlinesSuccess) {
          return SizedBox(
            height: 250, // Adjust the height to make it prominent
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: state.newsList.length,
                  itemBuilder: (context, index) {
                    final news = state.newsList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NewsView(newsData: news)));
                      },
                      child: Stack(
                        children: [
                          // Background image for the headline
                          Positioned.fill(
                            child: Image.network(
                              news.urlToImage?.isNotEmpty == true
                                  ? news.urlToImage!
                                  : "https://forum.obsidian.md/uploads/default/77a437f63685761db2e78f4049a239f68420197b",
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Gradient overlay to make text readable
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.borderColor.withOpacity(0.5),
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                            ),
                          ),
                          // Headline title overlay
                          Positioned(
                            bottom: 16.0,
                            left: 16.0,
                            right: 16.0,
                            child: Text(
                              news.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10.0,
                                    color: Colors.black,
                                    offset: Offset(2.0, 2.0),
                                  ),
                                ],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                // Add PageView indicator
                Positioned(
                  bottom: 8.0,
                  right: 16.0,
                  child: Row(
                    children: List.generate(
                      state.newsList.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2.0),
                        width: 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _pageController.hasClients &&
                                  _pageController.page!.round() == index
                              ? Colors.white
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox(); // Fallback widget
      },
    );
  }

  Widget _buildGeneralNewsSection(BuildContext context) {
    return BlocConsumer<GeneralNewsBlocBloc, GeneralNewsBlocState>(
      listener: (context, state) {
        if (state is GeneralNewsBlocFailure) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is GeneralNewsBlocLoading) {
          return const Loader();
        }
        if (state is GeneralNewsBlocFailure) {
          return Center(
            child: Text(state.message),
          );
        }
        if (state is GeneralNewsBlocSuccess) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.newsList.length,
            itemBuilder: (context, index) {
              final news = state.newsList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NewsView(newsData: news)));
                },
                child: Card(
                  color: AppColors.borderColor,
                  elevation: 2.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 16.0),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        news.urlToImage?.isNotEmpty == true
                            ? news.urlToImage!
                            : "https://forum.obsidian.md/uploads/default/77a437f63685761db2e78f4049a239f68420197b",
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error);
                        },
                      ),
                    ),
                    title: Text(
                      news.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      news.description ?? "No description available.",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              );
            },
          );
        }
        return const SizedBox(); // Fallback widget
      },
    );
  }
}
