import 'package:dio/dio.dart';

import '../../models/book_response.dart';
import '../../models/item.dart';
import '../book_datasource.dart';

class BookDatasourceImpl extends BookDatasource {
  final Dio dioClient;
  BookDatasourceImpl({required this.dioClient});
  @override
  Future<BookResponse> getBooks(String bookName) async {
    var result = await dioClient
        .get("https://www.googleapis.com/books/v1/volumes?q=$bookName");
    return BookResponse.fromMap(result.data);
  }

  @override
  Future<Item> getBookDetail(String bookId) async {
    var result = await dioClient
        .get("https://www.googleapis.com/books/v1/volumes/$bookId");
    return Item.fromMap(result.data);
  }
}
