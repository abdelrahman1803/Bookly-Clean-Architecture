import 'package:bookly/core/helpers/book_model_response.dart';
import 'package:bookly/core/utilities/api_services.dart';
import 'package:bookly/features/home/domain/entities/book_entity.dart';

abstract class SearchRemoteDataSource {
  Future<List<BookEntity>> fetchSearchedBooks(String title);
}

class SearchRemoteDataSourceImpl extends SearchRemoteDataSource {
  final ApiServices apiServices;

  SearchRemoteDataSourceImpl(this.apiServices);
  @override
  Future<List<BookEntity>> fetchSearchedBooks(String title) async {
    var data = await apiServices.get(
      endPoint: 'volumes?Filtering=free-ebooks&sorting=relevance&q=$title',
    );
    List<BookEntity> books = parseBookModel(data);
    return books;
  }
}
