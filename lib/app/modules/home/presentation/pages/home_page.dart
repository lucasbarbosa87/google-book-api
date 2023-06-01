import 'package:bookapi/app/modules/home/data/models/book_response/authors.dart';
import 'package:bookapi/app/modules/home/data/models/book_response/item.dart';
import 'package:bookapi/app/modules/home/presentation/controllers/home_controller.dart';
import 'package:bookapi/app/modules/shared/ui/components/double_value_listenable_builder.dart';
import 'package:bookapi/app/modules/shared/ui/widgets/app_skeleton_widget.dart';
import 'package:bookapi/app/modules/shared/ui/widgets/app_spaces_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/ui/widgets/app_loading_animation_widget.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final HomeController controller = Modular.get();

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google book API'),
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Height(50),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a search term',
                  ),
                  controller: controller.searchController,
                  onChanged: controller.search,
                ),
                const Height(16),
                Expanded(
                  child: DoubleValueListenableBuilder(
                    first: controller.isLoading,
                    second: controller.books,
                    builder: (context, valueA, valueB, _) {
                      if (valueA) {
                        return showLoading();
                      }
                      return showListBooks(valueB);
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget showListBooks(List<Item> valueB) {
    return ListView.separated(
      itemBuilder: (context, index) => listItem(valueB[index]),
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(),
      ),
      itemCount: valueB.length,
    );
  }

  Widget showLoading() {
    return ListView.separated(
      itemBuilder: (context, index) =>
          const AppSkeletonWidget(height: 50, width: double.maxFinite),
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(),
      ),
      itemCount: 10,
    );
  }

  Widget listItem(Item book) {
    return InkWell(
      onTap: () {
        Modular.to.pushNamed("/detail", arguments: book.id);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                height: 64,
                width: 64,
                placeholder: (context, url) => const AppLoadinAnimationWidget(),
                imageUrl: book.volumeInfo?.imageLinks?.smallThumbnail ?? "",
              ),
              const Width(8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Título: ${book.volumeInfo?.title ?? ""}",
                      softWrap: true,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (book.volumeInfo?.publisher != null)
                      Text(
                        "Editora: ${book.volumeInfo?.publisher ?? ""}",
                        softWrap: true,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (book.volumeInfo!.authors != null)
                      buildAuthorsWidget(book.volumeInfo!.authors!),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  controller.saveBook(book);
                },
                child: Icon(
                  book.isFav ? Icons.star_rounded : Icons.star_outline_rounded,
                  color: Colors.yellow,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAuthorsWidget(Authors authors) {
    String temp = "";
    for (var element in authors.authors) {
      temp = "$element / $temp";
    }
    if (temp.isEmpty) {
      return Container();
    }
    return Text("Autor(es): ${temp.substring(0, temp.length - 3)}");
  }
}
