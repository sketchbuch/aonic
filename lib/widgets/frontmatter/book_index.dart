import 'package:flutter/material.dart';

import '../../i18n/_generated_/translations.g.dart';
import '../../models/book/book.dart';
import '../../types/types.dart';
import 'index_item.dart';

class BookIndex extends StatelessWidget {
  final transBook = t.book;
  final Book book;
  final OnNavigate onNavigate;

  BookIndex(this.book, this.onNavigate, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookIndex = book.getBookIndex();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: bookIndex.map<Widget>((item) {
        return IndexItem(item, onNavigate);
      }).toList(),
    );
  }
}
