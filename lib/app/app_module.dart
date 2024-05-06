import 'package:flutter_modular/flutter_modular.dart';

import 'modules/home/home_module.dart';
import 'widgets/app_controller.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addInstance<AppController>(AppControllerImpl());
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.module(Modular.initialRoute, module: HomeModule());
    super.routes(r);
  }
}
