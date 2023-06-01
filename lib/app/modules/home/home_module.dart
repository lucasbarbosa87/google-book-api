import 'package:bookapi/app/modules/home/data/datasource/book_datasource.dart';
import 'package:bookapi/app/modules/home/data/datasource/database_context.dart';
import 'package:bookapi/app/modules/home/domain/repository/book_repository.dart';
import 'package:bookapi/app/modules/home/presentation/controllers/detail_controller.dart';
import 'package:bookapi/app/modules/home/presentation/controllers/home_controller.dart';
import 'package:bookapi/app/modules/home/presentation/pages/book_detail_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/pages/home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => Dio()),
    Bind.lazySingleton<BookDatasource>(
      (i) => BookDatasourceImpl(
        dio: i.get(),
        database: i.get<DatabaseContext>(),
      ),
    ),
    Bind.singleton(
      (i) => DatabaseContext(),
    ),
    Bind.lazySingleton<BookRepository>(
      (i) => BookRepositoryImpl(
        bookDatasource: i.get<BookDatasource>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => HomeController(
        bookRepository: i.get<BookRepository>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => DetailController(
        bookRepository: i.get<BookRepository>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomePage()),
    ChildRoute("/detail",
        child: (_, args) => BookDetailPage(bookId: args.data)),
  ];
}
