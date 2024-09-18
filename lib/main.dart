import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/init_dependencies.dart';
import 'package:news_app/core/theme/app_theme.dart';
import 'package:news_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:news_app/features/auth/presentation/pages/splash_screen.dart';
import 'package:news_app/features/categoryview/presentation/bloc/category_bloc.dart';
import 'package:news_app/features/channelview/presentation/bloc/channel_bloc.dart';
import 'package:news_app/features/home/presentation/bloc/general_news_bloc_bloc.dart';
import 'package:news_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:news_app/features/news_view/presentation/bloc/related_news_bloc.dart';
import 'package:news_app/features/search_view/presentation/bloc/search_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<HomeBloc>(),
      ),
      BlocProvider(create: (_) => serviceLocator<GeneralNewsBlocBloc>()),
      BlocProvider(create: (_) => serviceLocator<RelatedNewsBloc>()),
      BlocProvider(create: (_) => serviceLocator<CategoryBloc>()),
      BlocProvider(create: (_) => serviceLocator<ChannelBloc>()),
      BlocProvider(create: (_) => serviceLocator<SearchBloc>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.darkThemeMode,
      home: const SplashScreen(),
    );
  }
}
