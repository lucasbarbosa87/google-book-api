import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../data/models/book_response/item.dart';
import '../../domain/repository/book_repository.dart';

class DetailController {
  final BookRepository bookRepository;

  DetailController({required this.bookRepository});
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  ValueNotifier<String?> error = ValueNotifier(null);
  ValueNotifier<Item?> book = ValueNotifier(null);

  Future<void> init(String bookId) async {
    try {
      isLoading.value = true;
      book.value = await bookRepository.getBook(bookId);
      isLoading.value = false;
    } on DioError catch (e) {
      error.value = e.message;
      isLoading.value = false;
    } on Exception catch (_) {
      error.value = "Erro desconhecido";
      isLoading.value = false;
    }
  }

  void launchUrl(String? buyLink) {
    if (buyLink == null) {
      return;
    }
    launchUrlString(
      buyLink,
      mode: LaunchMode.externalApplication,
    );
  }
}
