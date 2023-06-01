import 'package:bookapi/app/modules/home/data/datasource/book_datasource.dart';

import '../../data/models/book_response/book_response.dart';
import '../../data/models/book_response/item.dart';

abstract class BookRepository {
  Future<BookResponse> searchBook(String search);
  Future<Item> getBook(String bookId);
  Future<List<Item>> getBooksFav();
  Future<void> saveBookFav(Item book);
}

class BookRepositoryImpl implements BookRepository {
  BookDatasource bookDatasource;

  BookRepositoryImpl({required this.bookDatasource});

  @override
  Future<BookResponse> searchBook(String search) async {
    return await bookDatasource.searchBooks(search);
  }

  @override
  Future<Item> getBook(String bookId) async {
    return await bookDatasource.getBook(bookId);
  }

  @override
  Future<List<Item>> getBooksFav() async {
    return await bookDatasource.getBooksFav();
  }

  @override
  Future<void> saveBookFav(Item book) async {
    return await bookDatasource.saveBookFav(book);
  }
}
