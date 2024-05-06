import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../theme/theme.dart';
import '../../../core/components/double_value_listenable_builder.dart';
import '../../../shared/widgets/app_scaffold_widget.dart';
import '../controllers/home_controller.dart';
import 'widgets/app_skeleton_widget.dart';
import 'widgets/home_empty_list_widget.dart';
import 'widgets/list_book_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Modular.get();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      title: AppLocalizations.of(context)!.homeTitle,
      page: Padding(
        padding: const EdgeInsets.all(AppDimensions.medium),
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, _) => Column(
            children: [
              const Height(AppDimensions.medium),
              TextFormField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: AppLocalizations.of(context)!.searchHint,
                ),
                controller: controller.searchController,
                focusNode: controller.searchFocus,
                onChanged: (value) => controller.searchBook(),
              ),
              const Height(AppDimensions.large),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: controller.homeState,
                  builder: (context, value, _) => switch (value) {
                    HomeStates.searchEmpty => const HomeEmptyListWidget(),
                    HomeStates.haveList => DoubleValueListenableBuilder(
                        first: controller.isLoading,
                        second: controller.books,
                        builder: (context, valueA, valueB, _) {
                          if (valueA) {
                            return ListView.separated(
                              itemBuilder: (context, index) =>
                                  const LoadingWidget(
                                height: AppDimensions.huge,
                                width: double.maxFinite,
                              ),
                              separatorBuilder: (context, index) => Container(
                                padding:
                                    const EdgeInsets.all(AppDimensions.medium),
                              ),
                              itemCount: 10,
                            );
                          }
                          return ListBookWidget(
                            books: valueB,
                            onSetFav: (book) => controller.updateBookFav(book),
                          );
                        },
                      ),
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
