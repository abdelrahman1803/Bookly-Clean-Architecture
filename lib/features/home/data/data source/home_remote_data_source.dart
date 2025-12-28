import 'package:bookly/constants.dart';
import 'package:bookly/core/helpers/book_model_response.dart';
import 'package:bookly/core/utilities/api_services.dart';
import 'package:bookly/core/utilities/functions/save_books_data.dart';
import 'package:bookly/features/home/domain/entities/book_entity.dart';

abstract class HomeRemoteDataSource {
  Future<List<BookEntity>> fetchFeaturedBooks({int pageNumber = 0});
  Future<List<BookEntity>> fetchLatestBooks();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiServices apiServices;

  HomeRemoteDataSourceImpl(this.apiServices);

  @override
  Future<List<BookEntity>> fetchFeaturedBooks({int pageNumber = 0}) async {
    var data = await apiServices.get(
      endPoint:
          'volumes?q=programming&filter=free-ebooks&startIndex=${pageNumber * 10}&maxResults=10',
    );
    List<BookEntity> books = parseBookModel(data);
    saveBooksData(books, kFeaturedBox);
    return books;
  }

  @override
  Future<List<BookEntity>> fetchLatestBooks() async {
    var data = await apiServices.get(
      endPoint: 'volumes?filter=free-ebooks&q=programming&sorting=newest',
    );
    List<BookEntity> books = parseBookModel(data);
    saveBooksData(books, kLatestBox);
    return books;
  }
}
