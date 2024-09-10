import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/common/widgets/loader.dart';
import 'package:news_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:news_app/features/home/presentation/widgets/headline_item.dart';

class HeadlinesWidget extends StatefulWidget {
  const HeadlinesWidget({super.key});

  @override
  State<HeadlinesWidget> createState() => _HeadlinesWidgetState();
}

class _HeadlinesWidgetState extends State<HeadlinesWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeTopHeadlinesLoading) {
          return const Loader();
        } else if (state is HomeTopHeadlinesFailure) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is HomeTopHeadlinesSuccess) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.height * 1,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(state.newsList.length, (index) {
                  final news = state.newsList[index];
                  return HeadLineItem(
                    headLinesText: news.title,
                    imageLink: news.urlToImage ??
                        "https://t4.ftcdn.net/jpg/05/24/04/51/360_F_524045110_UXnCx4GEDapddDi5tdlY96s4g0MxHRvt.jpg",
                  );
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
