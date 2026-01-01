import 'package:bookly/features/home/domain/entities/book_entity.dart';
import 'package:bookly/features/search/domain/use%20cases/clear_search_history_use_case.dart';
import 'package:bookly/features/search/domain/use%20cases/fetch_search_history_use_case.dart';
import 'package:bookly/features/search/domain/use%20cases/fetch_searched_books_use_cases.dart';
import 'package:bookly/features/search/domain/use%20cases/save_book_to_history_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'search_books_state.dart';

class SearchBooksCubit extends Cubit<SearchBooksState> {
  final FetchSearchedBooksUseCases fetchSearchedBooksUseCases;
  final FetchSearchHistoryUseCase fetchSearchHistoryUseCase;
  final ClearSearchHistoryUseCase clearSearchHistoryUseCase;
  final SaveBookToHistoryUseCase saveBookToHistoryUseCase;

  SearchBooksCubit(
    this.fetchSearchedBooksUseCases,
    this.fetchSearchHistoryUseCase,
    this.clearSearchHistoryUseCase,
    this.saveBookToHistoryUseCase,
  ) : super(SearchBooksHistoryLoading());
  Future<void> fetchSearchedBooks(String title) async {
    emit(SearchBooksLoading());
    var result = await fetchSearchedBooksUseCases.call(title);
    result.fold(
      (failure) {
        emit(SearchBooksFailure(failure.message));
      },
      (books) {
        emit(SearchBooksSuccess(books));
      },
    );
  }

  Future<void> fetchSearchHistory() async {
    emit(SearchBooksHistoryLoading());
    final result = await fetchSearchHistoryUseCase.call();
    result.fold(
      (failure) {
        emit(SearchBooksFailure(failure.message));
      },
      (books) {
        emit(SearchBooksHistorySuccess(books));
      },
    );
  }

  Future<void> clearSearchHistory() async {
    final result = await clearSearchHistoryUseCase.call();
    result.fold(
      (failure) {
        emit(SearchBooksFailure(failure.message));
      },
      (_) {
        emit(SearchBooksHistorySuccess(const []));
      },
    );
  }

  Future<void> saveBookToHistory(BookEntity book) async {
    await saveBookToHistoryUseCase.call(book);
  }
}
