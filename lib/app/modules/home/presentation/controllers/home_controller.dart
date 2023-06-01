import 'dart:io';

import 'package:bookapi/app/modules/home/data/models/book_response/item.dart';
import 'package:bookapi/app/modules/home/domain/repository/book_repository.dart';
import 'package:flutter/cupertino.dart';

class HomeController extends ChangeNotifier {
  final BookRepository bookRepository;

  HomeController({required this.bookRepository});

  TextEditingController searchController = TextEditingController();

  ValueNotifier<bool> isLoading = ValueNotifier(false);
  ValueNotifier<List<Item>> books = ValueNotifier([]);

  late List<Item> booksFav;

  Future<void> init() async {
    await getBooksFav();
  }

  Future<void> getBooksFav() async {
    booksFav = await bookRepository.getBooksFav();
    List<Item> tempList = [];
    for (var element in booksFav) {
      element.isFav = true;
      tempList.add(element);
    }
    books.value = tempList;
  }

  Future<void> search(String value) async {
    if (isLoading.value == true) {
      return;
    }
    if (value.isEmpty) {
      await getBooksFav();
      return;
    }
    try {
      isLoading.value = true;
      var result = (await bookRepository.searchBook(value)).items ?? [];

      for (var element in booksFav) {
        result.remove(element);
      }
      books.value = result;
      isLoading.value = false;
    } on SocketException catch (_) {
      isLoading.value = false;
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading.value = false;
    }
  }

  Future<void> saveBook(Item book) async {
    try {
      book.isFav = !book.isFav;
      await bookRepository.saveBookFav(book);
      var tempList = books.value;
      var index = tempList.indexOf(book);
      tempList.removeAt(index);
      tempList.insert(index, book);
      books.value = tempList;
      notifyListeners();
    } on Exception catch (_) {}
  }
}
