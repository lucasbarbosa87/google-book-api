import 'package:result_dart/result_dart.dart';

import '../../domain/repositories/book_repository.dart';
import '../datasource/book_datasource.dart';
import '../datasource/book_fav_datasource.dart';
import '../models/book_response.dart';
import '../models/item.dart';

class BookRepositoryImpl implements BookRepository {
  final BookDatasource bookDatasource;
  final BookFavDatasource bookFavDatasource;

  BookRepositoryImpl(
      {required this.bookDatasource, required this.bookFavDatasource});

  @override
  AsyncResult<BookResponse, Exception> getBooks(String bookName) async {
    try {
      final data = await bookDatasource.getBooks(bookName);
      if (data.items != null) {
        List<Item> tempItemList = List.empty(growable: true);
        for (var element in data.items!) {
          final isFav = await bookFavDatasource.isBookFav(element.id ?? "");
          element.isFav = isFav;
          tempItemList.add(element);
        }
        data.items = tempItemList;
      }
      return data.toSuccess();
    } on Exception catch (e) {
      return e.toFailure();
    }
  }

  @override
  AsyncResult<Item, Exception> getBook(String param) async {
    try {
      final data = await bookDatasource.getBookDetail(param);
      return data.toSuccess();
    } on Exception catch (e) {
      return e.toFailure();
    }
  }

  @override
  AsyncResult<Unit, Exception> setBookFav(Item param) async {
    try {
      await bookFavDatasource.addBook(param);
      return unit.toSuccess();
    } on Exception catch (e) {
      return e.toFailure();
    }
  }
}
