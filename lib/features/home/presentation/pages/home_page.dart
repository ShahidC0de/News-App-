// ignore_for_file: unused_local_variable, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/common/widgets/loader.dart';
import 'package:news_app/core/utils/show_snackbar.dart';
import 'package:news_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:news_app/features/home/presentation/widgets/headline_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<HomeBloc>().add(FetchTopHeadlines());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('N E W S'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state is HomeTopHeadlinesFailure) {
                showSnackBar(context, state.message);
              }
            },
            builder: (context, state) {
              if (state is HomeTopHeadlinesLoading) {
                return const Loader();
              }
              if (state is HomeTopHeadlinesSuccess) {
                return SizedBox(
                  height: _height * 0.4, // Adjust height as needed
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.newsList.length,
                    itemBuilder: (context, index) {
                      final news = state.newsList[index];
                      return HeadLineItem(
                        headLinesText: news.title,
                        imageLink: news.urlToImage ?? "",
                      );
                    },
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
