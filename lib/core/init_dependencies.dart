import 'package:get_it/get_it.dart';
import 'package:news_app/core/app_secrets/secrets.dart';
import 'package:news_app/features/auth/data/auth/data_source/auth_remote_datasource.dart';
import 'package:news_app/features/auth/data/auth/data_source/repositories/auth_repository_impl.dart';
import 'package:news_app/features/auth/domain/repository/auth_repository.dart';
import 'package:news_app/features/auth/domain/usecase/sign_in.dart';
import 'package:news_app/features/auth/domain/usecase/sign_up.dart';
import 'package:news_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:news_app/features/categoryview/data/category_news_data_source_impl.dart';
import 'package:news_app/features/categoryview/data/repository/category_news_repository_impl.dart';
import 'package:news_app/features/categoryview/domain/repository/category_news_repository.dart';
import 'package:news_app/features/categoryview/domain/usecase/category_news_usecase.dart';
import 'package:news_app/features/categoryview/presentation/bloc/category_bloc.dart';
import 'package:news_app/features/home/data/data_source/home_remote_datasource.dart';
import 'package:news_app/features/home/data/data_source/repository/home_repository_impl.dart';
import 'package:news_app/features/home/domain/repository/home_repository.dart';
import 'package:news_app/features/home/domain/usecase/fetch_news.dart';
import 'package:news_app/features/home/presentation/bloc/general_news_bloc_bloc.dart';
import 'package:news_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:news_app/features/news_view/data/related_news_remote_datasource.dart';
import 'package:news_app/features/news_view/data/repository/related_news_repository_impl.dart';
import 'package:news_app/features/news_view/domain/repository/related_news_repository.dart';
import 'package:news_app/features/news_view/presentation/bloc/related_news_bloc.dart';
import 'package:news_app/features/news_view/presentation/use_case/use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  _initAuth();
  _initNewsBloc();
  _initRelatedNewsBloc();
  _initCategoryBloc();
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
      httpClient: serviceLocator<http.Client>(),
    ),
  );
  serviceLocator.registerFactory<HomeRepository>(
    () => HomeRepositoryImpl(
      homeRemoteDatasource: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => FetchAllEverythingNews(
      homeRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => FetchTopHeadlinesNews(
      homeRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<HomeBloc>(
    () => HomeBloc(
      fetchTopHeadlines: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GeneralNewsBlocBloc(
      fetchEveryNews: serviceLocator(),
    ),
  );
}

void _initRelatedNewsBloc() {
  serviceLocator.registerFactory<RelatedNewsRemoteDataSource>(() =>
      RelatedNewsRemoteDataSourceImpl(
          httpClient: serviceLocator(), apiKey: newsAPIKey));
  serviceLocator.registerFactory<RelatedNewsRepository>(() =>
      RelatedNewsRepositoryImpl(relatedNewsRemoteDataSource: serviceLocator()));
  serviceLocator.registerFactory(
      () => FetchTheRelatedNews(relatedNewsRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => RelatedNewsBloc(fetchTherelatedNews: serviceLocator()));
}

void _initCategoryBloc() {
  serviceLocator.registerFactory<CategoryNewsDataSource>(() =>
      CategoryNewsRemoteDataSouceImpl(
          apiKey: newsAPIKey, httpClient: serviceLocator()));
  serviceLocator.registerFactory<CategoryNewsRepository>(() =>
      CategoryNewsRepositoryImpl(categoryNewsDataSource: serviceLocator()));
  serviceLocator.registerFactory(
      () => CategoryNewsUsecase(categoryNewsRepository: serviceLocator()));
  serviceLocator.registerFactory(
      () => CategoryBloc(categoriesNewsUsecase: serviceLocator()));
}
