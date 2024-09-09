import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/common/widgets/loader.dart';
import 'package:news_app/core/theme/app_colors.dart';
import 'package:news_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:news_app/features/home/presentation/widgets/category_item.dart';
import 'package:news_app/features/home/presentation/widgets/headline_item.dart';
import 'package:news_app/features/home/presentation/widgets/news_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> imageList = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7m1Q6IvOQf2XlBumdYnrFP-1mrbMFmw8Ojg&s", // sports
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfAI_a3tzOjLGgTMN4VFkiMlK_Ol6T7OEffw&s", // general
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbFVMpcql4mrFAGtoch51jntJtOr4CgZq_Zg&s", // entertainment
    "https://cdn.dribbble.com/users/71890/screenshots/2368143/health_news.jpg", // health
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIwooPYm6Jt3_aTPdleOcNPrSlqLiyeEOvVg&s", // business
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6I6CmvD2Wp8DnKfXU3hsskWMyx4cqtN3_NA&s" // technology
  ];
  List<String> channelsNames = [
    "BBC",
    "Al Jazeera",
    "CCN",
    "ESPN",
    "The Washington Post",
    "CBS",
    "ABC",
    "NBC",
    "Bloomberg"
        "Fox",
    "The Guardian ",
    "The New York Times",
    "Reuters "
  ];
  void _loadData() {
    context.read<HomeBloc>().add(FetchEveryNews());
    context.read<HomeBloc>().add(FetchTopHeadlines());
  }

  late PageController _pageController;

  @override
  void initState() {
    _loadData();
    _pageController = PageController(viewportFraction: 0.8); // 80% width
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'N E W S',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: AppColors.borderColor,
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text(
                'AVAILABLE CHANNELS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...channelsNames.map((channel) {
              return ListTile(
                title: Text(channel),
              );
            })
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          // Categories section
          SliverToBoxAdapter(
            child: SizedBox(
              height: 150,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(imageList.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: CategoryItem(imageLink: imageList[index]),
                    );
                  }),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 12),
          ),

          // Headlines section (PageView)
          SliverToBoxAdapter(
            child: SizedBox(
                height: 360,
                child:
                    BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                  if (state is HomeLoading) {
                    return const Loader();
                  } else if (state is HomeError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else if (state is HomeTopHeadtitlesNewsSuccess) {
                    return PageView.builder(
                      controller: _pageController,
                      itemCount: state.newsList.length,
                      itemBuilder: (context, index) {
                        final news = state.newsList[index];
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: HeadLineItem(
                            headLinesText: news.title,
                            imageLink: news.urlToImage ??
                                "https://t4.ftcdn.net/jpg/05/24/04/51/360_F_524045110_UXnCx4GEDapddDi5tdlY96s4g0MxHRvt.jpg",
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox();
                })),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 12),
          ),

          // News section (Scrollable list of items)
          // SliverList(
          //   delegate: SliverChildBuilderDelegate(
          //     (context, index) {
          //       return BlocBuilder<HomeBloc, HomeState>(
          //           builder: (context, state) {
          //         if (state is HomeLoading) {
          //           return const Loader();
          //         } else if (state is HomeError) {
          //           return Center(
          //             child: Text(state.message),
          //           );
          //         } else if (state is HomeEveryNewsSuccess) {
          //           return ListView.builder(
          //               itemCount: state.newsList.length,
          //               itemBuilder: (context, index) {
          //                 final news = state.newsList[index];
          //                 return Padding(
          //                   padding: const EdgeInsets.all(6),
          //                   child: NewsItem(
          //                     headLinesText: news.title,
          //                     imageLink: news.urlToImage ??
          //                         "https://t4.ftcdn.net/jpg/05/24/04/51/360_F_524045110_UXnCx4GEDapddDi5tdlY96s4g0MxHRvt.jpg",
          //                   ),
          //                 );
          //               });
          //         }
          //         return const SizedBox();
          //       });
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
