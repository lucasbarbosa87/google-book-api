import 'package:bookapi/app/modules/home/data/models/book_response/categories.dart';
import 'package:bookapi/app/modules/home/data/models/book_response/item.dart';
import 'package:bookapi/app/modules/home/presentation/controllers/detail_controller.dart';
import 'package:bookapi/app/modules/shared/ui/components/double_value_listenable_builder.dart';
import 'package:bookapi/app/modules/shared/ui/widgets/app_loading_animation_widget.dart';
import 'package:bookapi/app/modules/shared/ui/widgets/app_spaces_widget.dart'
    as app_spaces;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/utils/app_utils.dart';
import '../../data/models/book_response/authors.dart';

class BookDetailPage extends StatefulWidget {
  final String bookId;
  const BookDetailPage({super.key, required this.bookId});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  DetailController controller = Modular.get();

  @override
  void initState() {
    controller.init(widget.bookId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhe do livro'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: DoubleValueListenableBuilder(
          first: controller.isLoading,
          second: controller.error,
          builder: (context, valuA, valueB, _) {
            if (valuA) {
              return Column(
                children: [
                  app_spaces.Height(MediaQuery.of(context).size.height * 0.4),
                  const Center(
                    child: AppLoadinAnimationWidget(),
                  ),
                ],
              );
            }
            if (valueB != null) {
              return Column(
                children: [
                  app_spaces.Height(MediaQuery.of(context).size.height * 0.4),
                  Center(
                    child: Text(
                      valueB,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            }
            return buildBook(controller.book.value!);
          },
        ),
      ),
    );
  }

  Widget buildBook(Item item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const app_spaces.Height(8),
        Center(
          child: CachedNetworkImage(
            placeholder: (context, url) => const AppLoadinAnimationWidget(),
            imageUrl: item.volumeInfo?.imageLinks?.thumbnail ?? "",
          ),
        ),
        const app_spaces.Height(8),
        Center(
          child: Text(
            item.volumeInfo?.title ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const app_spaces.Height(8),
        if (item.volumeInfo!.authors != null)
          buildAuthorsWidget(item.volumeInfo!.authors!),
        const app_spaces.Height(8),
        if (item.volumeInfo?.publisher != null)
          Text(
            "Editora: ${item.volumeInfo?.publisher ?? ""}",
            softWrap: true,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        const app_spaces.Height(8),
        if (item.volumeInfo?.categories != null)
          buildCategoriesWidget(item.volumeInfo!.categories!),
        const app_spaces.Height(8),
        if (item.volumeInfo?.publishedDate != null)
          Text(
            "Publicação: ${AppUtils.formatDate(item.volumeInfo!.publishedDate!)}",
            softWrap: true,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        const app_spaces.Height(8),
        if (item.volumeInfo?.description != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Descrição: "),
              Html(data: item.volumeInfo?.description!),
            ],
          ),
        if (item.saleInfo?.buyLink != null)
          Center(
            child: ElevatedButton(
              onPressed: () {
                controller.launchUrl(item.saleInfo!.buyLink);
              },
              child: Text("Compre agora"),
            ),
          ),
      ],
    );
  }

  Widget buildAuthorsWidget(Authors authors) {
    String temp = "";
    for (var element in authors.authors) {
      temp = "$element / $temp";
    }
    return Text("Autor(es): ${temp.substring(0, temp.length - 3)}");
  }

  Widget buildCategoriesWidget(Categories authors) {
    String temp = "";
    for (var element in authors.categories) {
      temp = "$element / $temp";
    }
    return Text("Categorias: ${temp.substring(0, temp.length - 3)}");
  }
}
