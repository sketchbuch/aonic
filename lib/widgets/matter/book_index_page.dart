import 'package:flutter/material.dart';

import '../../i18n/_generated_/translations.g.dart';
import '../../models/book/book.dart';
import '../../types/types.dart';
import '../typography/headline.dart';
import 'index_item.dart';

class BookIndexPage extends StatelessWidget {
  final transBook = t.book;
  final BookIndex bookIndex;
  final OnNavigate onNavigate;

  BookIndexPage(this.bookIndex, this.onNavigate, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Headline(transBook.pageTtles.tableOfContents),
        ...bookIndex.map<Widget>((item) {
          return IndexItem(item, onNavigate);
        }).toList()
      ],
    );
  }
}
