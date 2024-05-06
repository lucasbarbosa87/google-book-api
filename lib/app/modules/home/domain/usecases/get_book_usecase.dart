import 'package:result_dart/result_dart.dart';

import '../../../core/domain/usecases/base_usecase.dart';
import '../../data/models/item.dart';
import '../repositories/book_repository.dart';

abstract class GetBookUsecase extends BaseUsecase<String, Item> {}

class GetBookUsecaseImpl implements GetBookUsecase {
  final BookRepository bookRepository;

  GetBookUsecaseImpl({required this.bookRepository});
  @override
  AsyncResult<Item, Exception> call(String param) async {
    return bookRepository.getBook(param);
  }
}
