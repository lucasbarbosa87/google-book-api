import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class CoreModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addLazySingleton(
      () {
        final dio = Dio(
          BaseOptions(contentType: "application/json"),
        );
        dio.interceptors.add(
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
          ),
        );
        return dio;
      },
    );
    super.exportedBinds(i);
  }
}
