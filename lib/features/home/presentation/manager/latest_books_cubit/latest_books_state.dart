part of 'latest_books_cubit.dart';

@immutable
sealed class LatestBooksState {}

final class LatestBooksInitial extends LatestBooksState {}

final class LatestBooksLoading extends LatestBooksState {}

final class LatestBooksSuccess extends LatestBooksState {
  final List<BookEntity> books;
  final bool isLoadingMore;

  LatestBooksSuccess(this.books, {this.isLoadingMore = false});
}

final class LatestBooksFailure extends LatestBooksState {
  final String message;

  LatestBooksFailure(this.message);
}
