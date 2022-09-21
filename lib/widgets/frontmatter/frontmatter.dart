import 'package:flutter/material.dart';

import '../../models/book/book.dart';
import 'title_page.dart';

class Frontmatter extends StatelessWidget {
  final Book book;

  const Frontmatter(this.book, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitlePage(book.meta);
  }
}
