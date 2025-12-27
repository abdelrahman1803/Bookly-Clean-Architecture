import 'package:bloc/bloc.dart';
import 'package:bookly/features/home/domain/entities/book_entity.dart';
import 'package:bookly/features/home/domain/use%20cases/fetch_latest_books_use_case.dart';
import 'package:meta/meta.dart';

part 'latest_books_cubit_state.dart';

class LatestBooksCubit extends Cubit<LatestBooksState> {
  LatestBooksCubit(this.fetchLatestBooksUseCase) : super(LatestBooksInitial());

  final FetchLatestBooksUseCase fetchLatestBooksUseCase;

  Future<void> fetchLatestBooks() async {
    emit(LatestBooksLoading());
    var result = await fetchLatestBooksUseCase.call();
    result.fold(
      (failure) {
        emit(LatestBooksFailure(failure.message));
      },
      (books) {
        emit(LatestBooksSuccess(books));
      },
    );
  }
}
