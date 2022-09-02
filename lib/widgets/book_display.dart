import 'package:flutter/material.dart';

import '../models/book/book.dart';
import '../models/book/content/choice_tag.dart';
import '../models/book/content/combat_tag.dart';
import '../models/book/content/deadend_tag.dart';
import '../models/book/content/illustration_tag.dart';
import '../models/book/content/paragraph_tag.dart';
import '../models/book/section.dart';
import '../models/book/section/data.dart';
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
    int index = 16;
    Section section = book.numbered.elementAt(index);
    Data data = section.data;

    //print(data.toJson());

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: data.content
          .map<Widget>((tag) {
            final tagType = tag.tagType();

            switch (tagType) {
              case 'ChoiceTag':
                return Choice(tag as ChoiceTag);

              case 'CombatTag':
                return Combat(tag as CombatTag);

              case 'DeadendTag':
                return Deadend(tag as DeadendTag);

              case 'IllustrationTag':
                final illy = tag as IllustrationTag;
                return illy.isRealIllustration ? Illustration(illy) : const SizedBox();

              case 'ParagraphTag':
                return Paragraph(tag as ParagraphTag);

              default:
                return Text('Unsupported Tag: "$tagType"');
            }
          })
          .where((Widget widget) => widget.runtimeType.toString() != 'SizedBox')
          .toList(),
    );
  }
}
