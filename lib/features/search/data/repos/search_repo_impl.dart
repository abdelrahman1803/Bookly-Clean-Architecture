import 'package:bookly/core/errors/error_handler.dart';
import 'package:bookly/features/home/domain/entities/book_entity.dart';
import 'package:bookly/features/search/data/data%20source/search_local_data_source.dart';
import 'package:bookly/features/search/data/data%20source/search_remote_data_source.dart';
import 'package:bookly/features/search/domain/repos/search_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class SearchRepoImpl extends SearchRepo {
  final SearchRemoteDataSource searchRemoteDataSource;
  final SearchLocalDataSource searchLocalDataSource;

  SearchRepoImpl({
    required this.searchRemoteDataSource,
    required this.searchLocalDataSource,
  });
  @override
  Future<Either<Failure, List<BookEntity>>> fetchSearchedBooks(
    String title,
  ) async {
    try {
      if (title.trim().isEmpty) {
        return right(searchLocalDataSource.fetchSearchedBooks());
      }

      final books = await searchRemoteDataSource.fetchSearchedBooks(title);
      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> fetchSearchHistory() async {
    try {
      final books = searchLocalDataSource.fetchSearchedBooks();
      return right(books);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearSearchHistory() async {
    try {
      await searchLocalDataSource.clearSearchHistory();
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveBookToHistory(BookEntity book) async {
    try {
      await searchLocalDataSource.saveSearchedBook(book);
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
