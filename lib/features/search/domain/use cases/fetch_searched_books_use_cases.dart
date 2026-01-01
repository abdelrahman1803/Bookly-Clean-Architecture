import 'package:bookly/core/errors/error_handler.dart';
import 'package:bookly/core/use%20cases/use_case.dart';
import 'package:bookly/features/home/domain/entities/book_entity.dart';
import 'package:bookly/features/search/domain/repos/search_repo.dart';
import 'package:dartz/dartz.dart';

class FetchSearchedBooksUseCases extends UseCase<List<BookEntity>, String> {
  final SearchRepo searchRepo;

  FetchSearchedBooksUseCases(this.searchRepo);
  @override
  Future<Either<Failure, List<BookEntity>>> call(String title) async {
    return await searchRepo.fetchSearchedBooks(title);
  }
}
