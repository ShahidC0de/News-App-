import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/common/widgets/loader.dart';
import 'package:news_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:news_app/features/home/presentation/widgets/news_item.dart';

class GeneralNewsWidget extends StatefulWidget {
  const GeneralNewsWidget({super.key});

  @override
  State<GeneralNewsWidget> createState() => _GeneralNewsWidgetState();
}

class _GeneralNewsWidgetState extends State<GeneralNewsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Loader();
        } else if (state is HomeFailure) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is HomeGeneralNewsSuccess) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.height * 1,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: List.generate(state.newsList.length, (index) {
                  final news = state.newsList[index];
                  return NewsItem(
                      headLinesText: news.title,
                      imageLink: news.urlToImage ??
                          "https://t4.ftcdn.net/jpg/05/24/04/51/360_F_524045110_UXnCx4GEDapddDi5tdlY96s4g0MxHRvt.jpg");
                }),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
