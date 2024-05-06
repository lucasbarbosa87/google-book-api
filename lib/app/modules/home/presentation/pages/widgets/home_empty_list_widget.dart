import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeEmptyListWidget extends StatelessWidget {
  const HomeEmptyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(AppLocalizations.of(context)!.emptyList),
    );
  }
}
