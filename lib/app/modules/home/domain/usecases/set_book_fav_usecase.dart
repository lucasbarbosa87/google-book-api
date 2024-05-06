import '../../../core/domain/usecases/base_usecase.dart';
import '../../data/models/item.dart';
import '../repositories/book_repository.dart';
import 'package:result_dart/result_dart.dart';

abstract class SetBookFavUsecase extends BaseUsecaseParam<Item> {}

class SetBookFavUsecaseImpl implements SetBookFavUsecase {
  final BookRepository bookRepository;

  SetBookFavUsecaseImpl({required this.bookRepository});
  @override
  AsyncResult<Unit, Exception> call(Item param) async {
    return await bookRepository.setBookFav(param);
  }
}
