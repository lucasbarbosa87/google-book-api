import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../theme/theme.dart';
import '../../../widgets/app_controller.dart';

class AppScaffoldWidget extends StatelessWidget {
  final String title;
  final Widget page;
  const AppScaffoldWidget({super.key, required this.title, required this.page});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(),
      body: page,
    );
  }

  AppBar appBarWidget() {
    return AppBar(
      title: Text(
        title,
      ),
      centerTitle: true,
      elevation: AppDimensions.medium,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: AppDimensions.medium),
          child: InkWell(
            child: const Icon(Icons.contrast),
            onTap: () {
              Modular.get<AppController>().switchThemeMode();
            },
          ),
        ),
      ],
    );
  }
}
