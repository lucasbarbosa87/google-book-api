import '../models/item.dart';

abstract class BookFavDatasource {
  Future<void> addBook(Item param);

  Future<bool> isBookFav(String id);
}
