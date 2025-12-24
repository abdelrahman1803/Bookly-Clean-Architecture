import 'package:dio/dio.dart';

class ApiServices {
  final Dio _dio;
  final String _baseUrl = 'https://www.googleapis.com/books/v1/';

  ApiServices(this._dio);

  Future<Map<String, dynamic>> get({required String endPoint}) async {
    Response response = await _dio.get('$_baseUrl$endPoint');
    return response.data;
  }
}
