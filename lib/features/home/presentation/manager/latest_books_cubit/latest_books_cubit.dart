import 'package:bookly/features/home/domain/entities/book_entity.dart';
import 'package:bookly/features/home/domain/use%20cases/fetch_latest_books_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'latest_books_state.dart';

class LatestBooksCubit extends Cubit<LatestBooksState> {
  LatestBooksCubit(this.fetchLatestBooksUseCase) : super(LatestBooksInitial());

  final FetchLatestBooksUseCase fetchLatestBooksUseCase;
  final List<BookEntity> _books = [];
  bool _hasReachedEnd = false;
  int _lastLoadedPage = -1;

  Future<void> fetchLatestBooks({int pageNumber = 0}) async {
    if (_hasReachedEnd || pageNumber == _lastLoadedPage) {
      // Prevent duplicate or unnecessary requests
      return;
    }
    if (pageNumber == 0) {
      emit(LatestBooksLoading());
      _books.clear();
      _hasReachedEnd = false;
    } else {
      // Show loading state for pagination (not initial load)
      if (state is LatestBooksSuccess) {
        emit(
          LatestBooksSuccess(
            List<BookEntity>.unmodifiable(_books),
            isLoadingMore: true,
          ),
        );
      }
    }
    var result = await fetchLatestBooksUseCase.call(pageNumber);
    result.fold(
      (failure) {
        emit(LatestBooksFailure(failure.message));
      },
      (books) {
        if (books.isEmpty) {
          _hasReachedEnd = true;
        } else {
          // Dedupe by bookId to avoid overlaps across pages
          final existingIds = _books.map((b) => b.bookId).toSet();
          final uniqueNew = books.where((b) => !existingIds.contains(b.bookId));
          _books.addAll(uniqueNew);
          _lastLoadedPage = pageNumber;
        }
        emit(
          LatestBooksSuccess(
            List<BookEntity>.unmodifiable(_books),
            isLoadingMore: false,
          ),
        );
      },
    );
  }
}
