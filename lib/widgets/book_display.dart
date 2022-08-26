import 'package:flutter/material.dart';

import '../models/book.dart';
import '../models/section.dart';
import '../models/section/data.dart';

class BookDisplay extends StatelessWidget {
  final Book book;

  const BookDisplay(this.book, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int index = 2;
    Section section = book.backmatter.elementAt(index);
    Data data = section.data;

    print(data.toJson());

    return const Text('test');
  }
}
