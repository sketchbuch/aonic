import 'package:flutter/material.dart';

import '../models/book.dart';
import '../models/section.dart';
import '../models/section/data.dart';
import 'choice.dart';
import 'paragraph.dart';

class BookDisplay extends StatelessWidget {
  final Book book;

  const BookDisplay(this.book, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int index = 0;
    Section section = book.numbered.elementAt(index);
    Data data = section.data;

    print(data.toJson());

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: data.content.map<Widget>((tag) {
        final tagType = tag.tagType();

        switch (tagType) {
          case 'ChoiceTag':
            return Choice(tag);
          case 'ParagraphTag':
            return Paragraph(tag);
          default:
            return Text('Unsupported Tag: "$tagType"');
        }
      }).toList(),
    );

    /* return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('Book:'),
        const Text('==='),
        Text('Title: ${book.title}'),
        Text('Language: ${book.lang}'),
        Text('Version: ${book.version}'),
        const Text('--------'),
        const Text('Section:'),
        const Text('==='),
        Text('ID: ${section.id}'),
        Text('Type: ${section.type.value}'),
        Text('Title: ${section.meta.title}'),
      ],
    ); */
  }
}
