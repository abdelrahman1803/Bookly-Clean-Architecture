import 'package:bookly/constants.dart';
import 'package:bookly/features/home/domain/entities/book_entity.dart';
import 'package:hive/hive.dart';

abstract class SearchLocalDataSource {
  Future<void> saveSearchedBook(BookEntity book);
  List<BookEntity> fetchSearchedBooks();
  Future<void> clearSearchHistory();
}

class SearchLocalDataSourceImpl extends SearchLocalDataSource {
  final Box<BookEntity> box = Hive.box<BookEntity>(kSearchHistoryBox);

  @override
  Future<void> saveSearchedBook(BookEntity book) async {
    final exists = box.values.any((b) => b.bookId == book.bookId);
    if (!exists) {
      await box.add(book);
    }

    while (box.length > 20) {
      await box.deleteAt(0);
    }
  }

  @override
  List<BookEntity> fetchSearchedBooks() {
    return box.values.toList().reversed.toList();
  }

  @override
  Future<void> clearSearchHistory() async {
    await box.clear();
  }
}
