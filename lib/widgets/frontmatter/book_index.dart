import 'package:flutter/material.dart';

import '../../i18n/_generated_/translations.g.dart';
import '../../models/book/book.dart';

class BookIndex extends StatelessWidget {
  final transBook = t.book;
  final Book book;

  BookIndex(this.book, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookIndex = book.getBookIndex();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: bookIndex.map((item) {
        if (item.isSubItem == true) {
          return Text(' ----- ${item.label}');
        }

        return Text(item.label);
      }).toList(),
    );
  }
}
