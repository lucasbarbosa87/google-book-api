import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../theme/theme.dart';
import '../../../shared/widgets/app_scaffold_widget.dart';
import '../controllers/book_detail_controller.dart';
import 'widgets/book_widget.dart';

class BookDetailPage extends StatefulWidget {
  final String bookId;
  const BookDetailPage({
    super.key,
    required this.bookId,
  });

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  final BookDetailController controller = Modular.get();

  @override
  void initState() {
    controller.init(widget.bookId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      title: AppLocalizations.of(context)!.bookDetailTitle,
      page: ValueListenableBuilder(
        valueListenable: controller.book,
        builder: (context, value, _) {
          return value == null
              ? Center(
                  child: LoadingAnimationWidget.waveDots(
                      color: Theme.of(context).colorScheme.secondary,
                      size: AppDimensions.major + AppDimensions.major),
                )
              : BookWidget(
                  book: value,
                  onBuyTap: controller.tryLaunchBookBuy,
                );
        },
      ),
    );
  }
}
