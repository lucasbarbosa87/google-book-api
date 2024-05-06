import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../theme/theme.dart';
import '../../../data/models/authors.dart';
import '../../../data/models/item.dart';

class ListBookWidget extends StatelessWidget {
  final List<Item> books;
  final Function(Item book) onSetFav;
  const ListBookWidget({
    super.key,
    required this.books,
    required this.onSetFav,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => ListBookItemWidget(
              book: books[index],
              onSetFav: onSetFav,
            ),
        separatorBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(AppDimensions.medium),
            ),
        itemCount: books.length);
  }
}

class ListBookItemWidget extends StatelessWidget {
  final Item book;
  final Function(Item book) onSetFav;
  const ListBookItemWidget({
    super.key,
    required this.book,
    required this.onSetFav,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Modular.to.pushNamed("/detail", arguments: book.id);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.small),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.small),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                height: 64,
                width: 64,
                placeholder: (context, url) =>
                    LoadingAnimationWidget.threeArchedCircle(
                        color: Theme.of(context).colorScheme.secondary,
                        size: AppDimensions.major),
                imageUrl: book.volumeInfo?.imageLinks?.smallThumbnail ?? "",
              ),
              const Width(AppDimensions.small),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.bookTitle(
                        book.volumeInfo?.title ?? "",
                      ),
                      softWrap: true,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (book.volumeInfo?.publisher != null)
                      Text(
                        AppLocalizations.of(context)!.bookPublisher(
                          book.volumeInfo?.publisher ?? "",
                        ),
                        softWrap: true,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (book.volumeInfo!.authors != null)
                      AuthorsWidget(authors: book.volumeInfo!.authors!),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  onSetFav.call(book);
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
