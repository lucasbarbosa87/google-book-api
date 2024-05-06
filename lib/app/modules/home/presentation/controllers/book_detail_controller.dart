import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/item.dart';
import '../../domain/usecases/get_book_usecase.dart';

class BookDetailController extends ChangeNotifier {
  final GetBookUsecase getBookUsecase;

  ValueNotifier<Item?> book = ValueNotifier(null);

  BookDetailController({required this.getBookUsecase});
  Future<void> init(String bookId) async {
    final call = getBookUsecase(bookId);
    call.fold(
      (success) => book.value = success,
      (error) => null,
    );
  }

  void tryLaunchBookBuy(Item book) {
    if (book.saleInfo?.buyLink != null) {
      launchUrl(Uri.parse(book.saleInfo!.buyLink!));
      // launchUrlString(
      //   ,
      //   mode: LaunchMode.externalApplication,
      // );
    }
  }
}
