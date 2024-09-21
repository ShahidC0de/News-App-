import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/common/widgets/loader.dart';
import 'package:news_app/core/utils/show_snackbar.dart';
import 'package:news_app/features/channelview/presentation/bloc/channel_bloc.dart';
import 'package:news_app/features/news_view/presentation/pages/news_view.dart';
import 'package:news_app/features/news_view/presentation/widgets/related_news_container.dart';

class ChannelNewsPage extends StatefulWidget {
  final String channelName;
  const ChannelNewsPage({required this.channelName, super.key});

  @override
  State<ChannelNewsPage> createState() => _ChannelNewsPageState();
}

class _ChannelNewsPageState extends State<ChannelNewsPage> {
  final Map<String, String> channelMap = {
    'CNN': 'cnn',
    'BBC': 'bbc-news',
    'Fox News': 'fox-news',
    'Al Jazeera': 'al-jazeera-english',
  };

  String checkTheChannelName(String channelName) {
    return channelMap[channelName] ?? "";
  }

  @override
  void initState() {
    context.read<ChannelBloc>().add(
        FetchChannelNews(channelName: checkTheChannelName(widget.channelName)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.channelName),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocConsumer<ChannelBloc, ChannelState>(
              listener: (context, state) {
                if (state is ChannelFailure) {
                  showSnackBar(context, state.message);
                }
              },
              builder: (context, state) {
                if (state is ChannelLoading) {
                  return const Loader();
                }
                if (state is ChannelSuccess) {
                  final newsList = state.newsList;
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: newsList.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Two items in each row
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 0.75, // Adjust the item aspect ratio
                    ),
                    itemBuilder: (context, index) {
                      final newsItem = newsList[index];
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
