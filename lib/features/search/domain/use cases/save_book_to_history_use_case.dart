import 'package:bookly/core/errors/error_handler.dart';
import 'package:bookly/core/use%20cases/use_case.dart';
import 'package:bookly/features/home/domain/entities/book_entity.dart';
import 'package:bookly/features/search/domain/repos/search_repo.dart';
import 'package:dartz/dartz.dart';

class SaveBookToHistoryUseCase extends UseCase<void, BookEntity> {
  final SearchRepo searchRepo;

  SaveBookToHistoryUseCase(this.searchRepo);

  @override
  Future<Either<Failure, void>> call(BookEntity book) async {
    return await searchRepo.saveBookToHistory(book);
  }
}
