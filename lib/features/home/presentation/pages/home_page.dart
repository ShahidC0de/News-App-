import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:news_app/features/home/presentation/widgets/category_item.dart';
import 'package:news_app/features/home/presentation/widgets/general_news_widget.dart';
import 'package:news_app/features/home/presentation/widgets/headlines_widget.dart';

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

  void _loadData() {
    context.read<HomeBloc>().add(FetchEveryNews());
    context.read<HomeBloc>().add(FetchTopHeadlines());
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'N E W S ',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 6,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  imageList.length,
                  (index) {
                    return CategoryItem(
                      imageLink: imageList[index],
                    );
                  },
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3,
            child: const HeadlinesWidget(),
          ),
          Expanded(
            child: const GeneralNewsWidget(),
          ),
        ],
      ),
    );
  }
}
