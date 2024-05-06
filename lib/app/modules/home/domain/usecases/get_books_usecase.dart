import '../../../core/domain/usecases/base_usecase.dart';
import '../repositories/book_repository.dart';
import 'package:result_dart/result_dart.dart';

import '../../data/models/book_response.dart';

abstract class GetBooksUsecase extends BaseUsecase<String, BookResponse> {}

class GetBooksUsecaseImpl implements GetBooksUsecase {
  final BookRepository bookRepository;

  GetBooksUsecaseImpl({required this.bookRepository});
  @override
  AsyncResult<BookResponse, Exception> call(String param) async {
    return await bookRepository.getBooks(param);
  }
}
