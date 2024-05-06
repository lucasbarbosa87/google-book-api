import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart' show Html;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../data/models/categories.dart';
import '../../../../../theme/theme.dart';
import '../../../data/models/authors.dart';
import '../../../data/models/item.dart';

class BookWidget extends StatelessWidget {
  final Item book;
  final Function(Item book) onBuyTap;
  const BookWidget({
    super.key,
    required this.book,
    required this.onBuyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Height(AppDimensions.small),
        Center(
          child: CachedNetworkImage(
            placeholder: (context, url) =>
                LoadingAnimationWidget.threeArchedCircle(
                    color: Theme.of(context).colorScheme.secondary,
                    size: AppDimensions.major),
            imageUrl: book.volumeInfo?.imageLinks?.thumbnail ?? "",
          ),
        ),
        const Height(AppDimensions.small),
        Center(
          child: Text(
            book.volumeInfo?.title ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const Height(AppDimensions.small),
        if (book.volumeInfo!.authors != null)
          AuthorsWidget(authors: book.volumeInfo!.authors!),
        const Height(AppDimensions.small),
        if (book.volumeInfo?.publisher != null)
          Text(
            AppLocalizations.of(context)!.bookPublisher(
              book.volumeInfo?.publisher ?? "",
            ),
            softWrap: true,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        const Height(AppDimensions.small),
        if (book.volumeInfo?.categories != null)
          CategoriesWidget(categories: book.volumeInfo!.categories!),
        const Height(AppDimensions.small),
        // if (book.volumeInfo?.publishedDate != null)
        //   Text(
        //     "Publicação: ${AppUtils.formatDate(book.volumeInfo!.publishedDate!)}",
        //     softWrap: true,
        //     maxLines: 3,
        //     overflow: TextOverflow.ellipsis,
        //   ),
        const Height(AppDimensions.small),
        if (book.volumeInfo?.description != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.bookDescription),
              Html(data: book.volumeInfo?.description!),
            ],
          ),
        if (book.saleInfo?.buyLink != null)
          Center(
            child: ElevatedButton(
              onPressed: () {
                onBuyTap.call(book);
              },
              child: Text(AppLocalizations.of(context)!.bookBuyNow),
            ),
          ),
      ],
    );
  }
}

class AuthorsWidget extends StatelessWidget {
  final Authors authors;
  const AuthorsWidget({super.key, required this.authors});

  @override
  Widget build(BuildContext context) {
    String temp = "";
    for (var element in authors.authors) {
      temp = "$element / $temp";
    }
    if (temp.isEmpty) {
      return Container();
    }
    return Text(
      AppLocalizations.of(context)!.bookAuthors(
        temp.substring(0, temp.length - 3),
      ),
    );
  }
}

class CategoriesWidget extends StatelessWidget {
  final Categories categories;
  const CategoriesWidget({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    String temp = "";
    for (var element in categories.categories) {
      temp = "$element / $temp";
    }
    return Text(
      AppLocalizations.of(context)!.bookCategories(
        temp.substring(0, temp.length - 3),
      ),
    );
  }
}
