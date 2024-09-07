import 'package:flutter/material.dart';
import 'package:news_app/features/home/presentation/widgets/category_item.dart';
import 'package:news_app/features/home/presentation/widgets/headline_Item.dart';
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

  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.8); // 80% width
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(
              Icons.menu,
              size: 30,
            ),
          ),
        ],
        centerTitle: true,
        title: const Text(
          'N E W S',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
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
              child: PageView.builder(
                controller: _pageController,
                itemCount: imageList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: HeadLineItem(
                      headLinesText: "headLinesText",
                      imageLink: imageList[index],
                    ),
                  );
                },
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 12),
          ),

          // News section (Scrollable list of items)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: NewsItem(
                    headLinesText: "headLinesText",
                    imageLink: imageList[index],
                  ),
                );
              },
              childCount: imageList.length,
            ),
          ),
        ],
      ),
    );
  }
}
