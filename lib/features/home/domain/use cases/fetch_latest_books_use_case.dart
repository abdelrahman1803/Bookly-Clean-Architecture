import 'package:bookly/core/errors/error_handler.dart';
import 'package:bookly/core/use%20cases/use_case.dart';
import 'package:bookly/features/home/domain/entities/book_entity.dart';
import 'package:bookly/features/home/domain/repos/home_repo.dart';
import 'package:dartz/dartz.dart';

class FetchLatestBooksUseCase extends UseCase<List<BookEntity>, int> {
  final HomeRepo homeRepo;

  FetchLatestBooksUseCase(this.homeRepo);

  @override
  // no needn't in this project
  Future<Either<Failure, List<BookEntity>>> call([int pageNumber = 0]) async {
    //check permissions
    return await homeRepo.fetchLatestBooks(pageNumber: pageNumber);
  }
}
