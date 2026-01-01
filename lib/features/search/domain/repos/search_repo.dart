import 'package:bookly/core/errors/error_handler.dart';
import 'package:bookly/features/home/domain/entities/book_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SearchRepo {
  Future<Either<Failure, List<BookEntity>>> fetchSearchedBooks(String text);

  Future<Either<Failure, List<BookEntity>>> fetchSearchHistory();

  Future<Either<Failure, void>> clearSearchHistory();

  Future<Either<Failure, void>> saveBookToHistory(BookEntity book);
}
