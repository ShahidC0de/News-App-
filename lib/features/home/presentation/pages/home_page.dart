import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/home/presentation/widgets/category_item.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                  children: List.generate(imageList.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      CustomImageViewer(
                        imageLink: imageList[index],
                      ),
                      const SizedBox(
                        height: 8,
                      )
                    ],
                  ),
                );
              })),
            ),
          )
        ],
      ),
    );
  }
}
