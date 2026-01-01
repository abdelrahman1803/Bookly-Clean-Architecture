import 'package:bookly/core/utilities/api_services.dart';
import 'package:bookly/features/home/data/data%20source/home_local_data_source.dart';
import 'package:bookly/features/home/data/data%20source/home_remote_data_source.dart';
import 'package:bookly/features/home/data/repos/home_repo_impl.dart';
import 'package:bookly/features/search/data/data%20source/search_local_data_source.dart';
import 'package:bookly/features/search/data/data%20source/search_remote_data_source.dart';
import 'package:bookly/features/search/data/repos/search_repo_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setUpGetIt() {
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<ApiServices>(ApiServices(getIt<Dio>()));
  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
      homeRemoteDataSource: HomeRemoteDataSourceImpl(getIt<ApiServices>()),
      homeLocalDataSource: HomeLocalDataSourceImpl(),
    ),
  );
  getIt.registerSingleton<SearchRepoImpl>(
    SearchRepoImpl(
      searchRemoteDataSource: SearchRemoteDataSourceImpl(getIt<ApiServices>()),
      searchLocalDataSource: SearchLocalDataSourceImpl(),
    ),
  );
}
