import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../theme/theme.dart';
import 'app_controller.dart';

class AppGlobalKeys {
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  static final globalKey = GlobalKey();
  static final navigatorKey = GlobalKey<NavigatorState>();
}

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final AppController controller = Modular.get();
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    Modular.setNavigatorKey(AppGlobalKeys.navigatorKey);
    controller.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.themeMode,
      builder: (context, value, _) => MaterialApp.router(
        key: AppGlobalKeys.globalKey,
        scaffoldMessengerKey: AppGlobalKeys.scaffoldMessengerKey,
        title: "Google Books",
        themeMode: value,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
      ),
    );
  }
}
