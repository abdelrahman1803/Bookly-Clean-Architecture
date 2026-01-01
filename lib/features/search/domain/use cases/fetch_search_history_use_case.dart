import 'package:bookly/core/errors/error_handler.dart';
import 'package:bookly/core/use%20cases/no_pram_use_case.dart';
import 'package:bookly/features/home/domain/entities/book_entity.dart';
import 'package:bookly/features/search/domain/repos/search_repo.dart';
import 'package:dartz/dartz.dart';

class FetchSearchHistoryUseCase extends UseCase<List<BookEntity>> {
  final SearchRepo searchRepo;

  FetchSearchHistoryUseCase(this.searchRepo);

  @override
  Future<Either<Failure, List<BookEntity>>> call() async {
    return await searchRepo.fetchSearchHistory();
  }
}
