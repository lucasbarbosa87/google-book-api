import 'package:flutter/material.dart';

import '../../data/models/item.dart';
import '../../domain/usecases/get_books_usecase.dart';
import '../../domain/usecases/set_book_fav_usecase.dart';

class HomeController extends ChangeNotifier {
  final GetBooksUsecase getBooksUsecase;
  final SetBookFavUsecase setBookFavUsecase;
  HomeController({
    required this.getBooksUsecase,
    required this.setBookFavUsecase,
  });

  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocus = FocusNode();
  final ValueNotifier<HomeStates> homeState =
      ValueNotifier(HomeStates.searchEmpty);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<List<Item>> books = ValueNotifier([]);

  Future<void> searchBook() async {
    if (searchController.text.isEmpty) {
      changeHomeState(HomeStates.searchEmpty);
      books.value = [];
      return;
    }
    changeHomeState(HomeStates.haveList);
    isLoading.value = true;
    final call = await getBooksUsecase(searchController.text);
    isLoading.value = false;
    call.fold(
      (success) {
        if (success.items?.isEmpty == true) {
          return;
        }
        changeHomeState(HomeStates.haveList);
        books.value = success.items ?? [];
      },
      (failure) => null,
    );
  }

  void changeHomeState(HomeStates state) {
    homeState.value = state;
  }

  Future<void> updateBookFav(Item book) async {
    book.isFav = !book.isFav;
    await setBookFavUsecase(book);
    notifyListeners();
  }
}

enum HomeStates { searchEmpty, haveList }
