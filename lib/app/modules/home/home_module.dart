import 'package:flutter_modular/flutter_modular.dart';

import '../core/core_module.dart';
import 'data/datasource/book_datasource.dart';
import 'data/datasource/book_fav_datasource.dart';
import 'data/datasource/local/book_fav_datasource_impl.dart';
import 'data/datasource/remote/book_datasource_impl.dart';
import 'data/repositories/book_repository_impl.dart';
import 'domain/repositories/book_repository.dart';
import 'domain/usecases/get_book_usecase.dart';
import 'domain/usecases/get_books_usecase.dart';
import 'domain/usecases/set_book_fav_usecase.dart';
import 'presentation/controllers/book_detail_controller.dart';
import 'presentation/controllers/home_controller.dart';
import 'presentation/pages/book_detail_page.dart';
import 'presentation/pages/home_page.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void binds(Injector i) {
    i.addLazySingleton<BookDatasource>(BookDatasourceImpl.new);
    i.addLazySingleton<BookFavDatasource>(BookFavDatasourceImpl.new);
    i.addLazySingleton<BookRepository>(BookRepositoryImpl.new);
    i.addLazySingleton<GetBooksUsecase>(GetBooksUsecaseImpl.new);
    i.addLazySingleton<GetBookUsecase>(GetBookUsecaseImpl.new);
    i.addLazySingleton<SetBookFavUsecase>(SetBookFavUsecaseImpl.new);
    i.addSingleton(HomeController.new);
    i.add(BookDetailController.new);
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (context) => const HomePage());
    r.child("/detail", child: (context) => BookDetailPage(bookId: r.args.data));
    super.routes(r);
  }
}
