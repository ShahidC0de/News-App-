import 'package:get_it/get_it.dart';
import 'package:news_app/core/app_secrets/secrets.dart';
import 'package:news_app/core/usecase/fetchnews_use_case.dart';
import 'package:news_app/features/auth/data/auth/data_source/auth_remote_datasource.dart';
import 'package:news_app/features/auth/data/auth/data_source/repositories/auth_repository_impl.dart';
import 'package:news_app/features/auth/domain/repository/auth_repository.dart';
import 'package:news_app/features/auth/domain/usecase/sign_in.dart';
import 'package:news_app/features/auth/domain/usecase/sign_up.dart';
import 'package:news_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:news_app/features/home/data/data_source/home_remote_datasource.dart';
import 'package:news_app/features/home/data/data_source/repository/home_repository_impl.dart';
import 'package:news_app/features/home/domain/repository/home_repository.dart';
import 'package:news_app/features/home/domain/usecase/fetch_news.dart';
import 'package:news_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  _initAuth();
  _initNewsBloc();
  final supabase = await Supabase.initialize(
    anonKey: annonKey,
    url: url,
  );
  serviceLocator.registerLazySingleton(
    () => supabase.client,
  );
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDataSourceImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserSignUp(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserSignIn(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userSignIn: serviceLocator(),
    ),
  );
}

void _initNewsBloc() {
  serviceLocator.registerLazySingleton(() => http.Client());
  serviceLocator.registerFactory<HomeRemoteDatasource>(
    () => HomeRemoteDataSourceImpl(
      apikey: newsAPIKey,
      httpClient: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<HomeRepository>(
    () => HomeRepositoryImpl(
      homeRemoteDatasource: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<FetchnewsUseCase>(
    () => FetchAllEverythingNews(
      homeRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<FetchTopHeadlinesUseCase>(
    () => FetchTopHeadlinesNews(
      homeRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<HomeBloc>(
    () => HomeBloc(
      fetchEveryNews: serviceLocator(),
      fetchTopHeadlines: serviceLocator(),
    ),
  );
}
