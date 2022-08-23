import 'package:flutter/material.dart';

import '../models/book.dart';
import '../models/section.dart';
import '../models/section/data.dart';

class BookDisplay extends StatelessWidget {
  final Book book;

  const BookDisplay(this.book, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int index = 3;
    Section section = book.frontmatter.elementAt(index);
    Data data = section.data;

    print(data.html.content.toString());

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(book.title),
        Text(book.version),
        Text(book.lang),
        Text(section.id),
        Text(section.type.name),
        Text(section.meta.title),
        Text(data.html.toString()),
      ],
    );
  }
}
