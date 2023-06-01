import 'package:bookapi/app/modules/home/data/models/book_response/item.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/book_response/book_response.dart';
import 'database_context.dart';

abstract class BookDatasource {
  Future<BookResponse> searchBooks(String search);
  Future<Item> getBook(String bookId);
  Future<List<Item>> getBooksFav();
  Future<void> saveBookFav(Item book);
}

class BookDatasourceImpl implements BookDatasource {
  final Dio dio;
  late Box hive;
  final DatabaseContext database;
  BookDatasourceImpl({required this.dio, required this.database});

  Future<void> initHive() async {
    await database.initDatabase();
  }

  @override
  Future<BookResponse> searchBooks(String search) async {
    var result =
        await dio.get("https://www.googleapis.com/books/v1/volumes?q=$search");

    return BookResponse.fromMap(result.data);
  }

  @override
  Future<Item> getBook(String bookId) async {
    var result =
        await dio.get("https://www.googleapis.com/books/v1/volumes/$bookId");
    return Item.fromMap(result.data);
  }

  @override
  Future<List<Item>> getBooksFav() async {
    try {
      await initHive();
      var teste = await database.database.query('books');

      var bookFav =
          teste.map((e) => Item.fromJson(e['book'].toString())).toList();
      if (bookFav.isEmpty) {
        return [];
      }
      return bookFav;
    } on Exception catch (_) {
      return [];
    }
  }

  @override
  Future<void> saveBookFav(Item book) async {
    await database.database
        .delete('books', where: 'id = ?', whereArgs: [book.id]);
    if (book.isFav) {
      await database.database.insert('books', {
        'id': book.id,
        'book': book.toJson(),
      });
    }
  }
}
