import 'package:bookly/constants.dart';
import 'package:bookly/features/home/domain/entities/book_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class HomeLocalDataSource {
  List<BookEntity> fetchFeaturedBooks({int pageNumber = 0});
  List<BookEntity> fetchLatestBooks({int pageNumber = 0});
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  @override
  List<BookEntity> fetchFeaturedBooks({int pageNumber = 0}) {
    int startIndex = pageNumber * 10;
    int endIndex = (pageNumber + 1) * 10;
    var box = Hive.box<BookEntity>(kFeaturedBox);
    int length = box.length;
    if (startIndex >= length) {
      return [];
    }
    if (endIndex > length) {
      endIndex = length;
    }
    return box.values.toList().sublist(startIndex, endIndex);
  }

  @override
  List<BookEntity> fetchLatestBooks({int pageNumber = 0}) {
    var box = Hive.box<BookEntity>(kLatestBox);
    int startIndex = pageNumber * 10;
    int endIndex = (pageNumber + 1) * 10;
    int length = box.length;
    if (startIndex >= length) {
      return [];
    }
    if (endIndex > length) {
      endIndex = length;
    }
    return box.values.toList().sublist(startIndex, endIndex);
  }
}
