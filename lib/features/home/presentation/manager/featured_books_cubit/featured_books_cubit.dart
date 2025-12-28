import 'package:bookly/features/home/domain/entities/book_entity.dart';
import 'package:bookly/features/home/domain/use%20cases/fetch_featured_books_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'featured_books_state.dart';

class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  FeaturedBooksCubit(this.fetchFeaturedBooksUseCase)
    : super(FeaturedBooksInitial());

  final FetchFeaturedBooksUseCase fetchFeaturedBooksUseCase;
  final List<BookEntity> _books = [];
  bool _hasReachedEnd = false;
  int _lastLoadedPage = -1;
  Future<void> fetchFeaturedBooks({int pageNumber = 0}) async {
    if (_hasReachedEnd || pageNumber == _lastLoadedPage) {
      // Prevent duplicate or unnecessary requests
      return;
    }
    if (pageNumber == 0) {
      emit(FeaturedBooksLoading());
      _books.clear();
      _hasReachedEnd = false;
    } else {
      // Show loading state for pagination (not initial load)
      if (state is FeaturedBooksSuccess) {
        emit(
          FeaturedBooksSuccess(
            List<BookEntity>.unmodifiable(_books),
            isLoadingMore: true,
          ),
        );
      }
    }
    var result = await fetchFeaturedBooksUseCase.call(pageNumber);

    result.fold(
      (failure) {
        emit(FeaturedBooksFailure(failure.message));
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
          FeaturedBooksSuccess(
            List<BookEntity>.unmodifiable(_books),
            isLoadingMore: false,
          ),
        );
      },
    );
  }
}
