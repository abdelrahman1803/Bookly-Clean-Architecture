import 'package:bookly/core/helpers/book_model_response.dart';
import 'package:bookly/core/utilities/api_services.dart';
import 'package:bookly/features/home/domain/entities/book_entity.dart';

abstract class HomeRemoteDataSource {
  Future<List<BookEntity>> fetchFeaturedBooks();
  Future<List<BookEntity>> fetchLatestBooks();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiServices apiServices;

  HomeRemoteDataSourceImpl(this.apiServices);

  @override
  Future<List<BookEntity>> fetchFeaturedBooks() async {
    var data = await apiServices.get(
      endPoint: 'volumes?Filtering=free-ebooks&sorting=newest&q=programming',
    );
    return BookModelResponse().parseBookModel(data);
  }

  @override
  Future<List<BookEntity>> fetchLatestBooks() {
    // TODO: implement fetchLatestBooks
    throw UnimplementedError();
  }
}
