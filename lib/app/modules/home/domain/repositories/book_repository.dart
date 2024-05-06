import '../../data/models/item.dart';
import 'package:result_dart/result_dart.dart';

import '../../data/models/book_response.dart';

abstract class BookRepository {
  AsyncResult<BookResponse, Exception> getBooks(String bookName);

  AsyncResult<Item, Exception> getBook(String param);

  AsyncResult<Unit, Exception> setBookFav(Item param);
}
