import 'package:bookly/core/errors/error_handler.dart';
import 'package:bookly/features/home/data/data%20source/home_local_data_source.dart';
import 'package:bookly/features/home/data/data%20source/home_remote_data_source.dart';
import 'package:bookly/features/home/domain/entities/book_entity.dart';
import 'package:bookly/features/home/domain/repos/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;

  HomeRepoImpl({
    required this.homeRemoteDataSource,
    required this.homeLocalDataSource,
  });
  @override
  Future<Either<Failure, List<BookEntity>>> fetchFeaturedBooks({
    int pageNumber = 0,
  }) async {
    try {
      List<BookEntity> books;
      books = homeLocalDataSource.fetchFeaturedBooks(pageNumber: pageNumber);
      if (books.isNotEmpty) {
        return right(books);
      }
      books = await homeRemoteDataSource.fetchFeaturedBooks(
        pageNumber: pageNumber,
      );
      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> fetchLatestBooks({
    int pageNumber = 0,
  }) async {
    try {
      List<BookEntity> books;
      books = homeLocalDataSource.fetchLatestBooks(pageNumber: pageNumber);
      if (books.isNotEmpty) {
        return right(books);
      }

      books = await homeRemoteDataSource.fetchLatestBooks(
        pageNumber: pageNumber,
      );
      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
