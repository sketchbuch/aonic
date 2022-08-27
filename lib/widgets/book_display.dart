import 'package:flutter/material.dart';

import '../models/book.dart';
import '../models/content/choice_tag.dart';
import '../models/content/combat_tag.dart';
import '../models/content/deadend_tag.dart';
import '../models/content/illustration_tag.dart';
import '../models/content/paragraph_tag.dart';
import '../models/section.dart';
import '../models/section/data.dart';
import 'choice.dart';
import 'combat.dart';
import 'deadend.dart';
import 'illustration.dart';
import 'paragraph.dart';

class BookDisplay extends StatelessWidget {
  final Book book;

  const BookDisplay(this.book, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int index = 52;
    Section section = book.numbered.elementAt(index);
    Data data = section.data;

    print(data.toJson());

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: data.content.map<Widget>((tag) {
        final tagType = tag.tagType();

        switch (tagType) {
          case 'ChoiceTag':
            return Choice(tag as ChoiceTag);
          case 'CombatTag':
            return Combat(tag as CombatTag);
          case 'DeadendTag':
            return Deadend(tag as DeadendTag);
          case 'IllustrationTag':
            final illustration = tag as IllustrationTag;

            if (illustration.isRealIllustration) {
              return Illustration(tag);
            } else {
              return Text('Stand-in image by "${illustration.creator}" not rendered');
            }
          case 'ParagraphTag':
            return Paragraph(tag as ParagraphTag);
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
