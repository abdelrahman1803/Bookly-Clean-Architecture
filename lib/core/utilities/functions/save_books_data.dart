import 'package:bookly/features/home/domain/entities/book_entity.dart';
import 'package:hive/hive.dart';

void saveBooksData(List<BookEntity> books, String boxName, {int? maxItems}) {
  final box = Hive.box<BookEntity>(boxName);
  // Build a set of existing IDs to avoid duplicates across pages
  final existingIds = box.values.map((b) => b.bookId).toSet();
  final uniqueNew = books
      .where((b) => !existingIds.contains(b.bookId))
      .toList();
  if (uniqueNew.isNotEmpty) {
    box.addAll(uniqueNew);
  }

  if (maxItems != null) {
    while (box.length > maxItems) {
      box.deleteAt(0);
    }
  }
}
