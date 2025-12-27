part of 'latest_books_cubit_cubit.dart';

@immutable
sealed class LatestBooksState {}

final class LatestBooksInitial extends LatestBooksState {}

final class LatestBooksLoading extends LatestBooksState {}

final class LatestBooksSuccess extends LatestBooksState {
  final List<BookEntity> books;

  LatestBooksSuccess(this.books);
}

final class LatestBooksFailure extends LatestBooksState {
  final String message;

  LatestBooksFailure(this.message);
}
