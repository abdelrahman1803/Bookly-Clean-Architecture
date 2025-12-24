import 'package:bookly/core/errors/error_handler.dart';
import 'package:bookly/core/use%20cases/no_pram_use_case.dart';
import 'package:bookly/features/home/domain/entities/book_entity.dart';
import 'package:bookly/features/home/domain/repos/home_repo.dart';
import 'package:dartz/dartz.dart';

class FetchLatestBooksUseCase extends UseCase<List<BookEntity>> {
  final HomeRepo homeRepo;

  FetchLatestBooksUseCase(this.homeRepo);

  @override
  // no needn't in this project
  Future<Either<Failure, List<BookEntity>>> call() async {
    //check permissions
    return homeRepo.fetchLatestBooks();
  }
}
