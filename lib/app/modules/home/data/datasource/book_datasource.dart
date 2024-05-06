import '../models/book_response.dart';
import '../models/item.dart';

abstract class BookDatasource {
  Future<BookResponse> getBooks(String bookName);
  Future<Item> getBookDetail(String bookId);
}
