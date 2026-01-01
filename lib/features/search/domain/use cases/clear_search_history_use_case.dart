import 'package:bookly/core/errors/error_handler.dart';
import 'package:bookly/core/use%20cases/no_pram_use_case.dart';
import 'package:bookly/features/search/domain/repos/search_repo.dart';
import 'package:dartz/dartz.dart';

class ClearSearchHistoryUseCase extends UseCase<void> {
  final SearchRepo searchRepo;

  ClearSearchHistoryUseCase(this.searchRepo);

  @override
  Future<Either<Failure, void>> call() async {
    return await searchRepo.clearSearchHistory();
  }
}
