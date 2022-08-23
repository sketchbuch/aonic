import 'package:flutter/material.dart';

import '../models/book.dart';
import '../models/section.dart';
import '../models/section/data.dart';
import 'content_element.dart';

class BookDisplay extends StatelessWidget {
  final Book book;

  const BookDisplay(this.book, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int index = 3;
    Section section = book.frontmatter.elementAt(index);
    Data data = section.data;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[ContentElement(data.html)],
    );
  }
}
