import '../../models/item.dart';
import 'package:hive/hive.dart';

import '../book_fav_datasource.dart';

class BookFavDatasourceImpl implements BookFavDatasource {
  @override
  Future<void> addBook(Item param) async {
    (await getHive()).put(param.id, param.isFav);
  }

  Future<Box> getHive() async {
    return await Hive.openBox("bookFav");
  }

  @override
  Future<bool> isBookFav(String id) async {
    return (await getHive()).get(id) != null;
  }
}
