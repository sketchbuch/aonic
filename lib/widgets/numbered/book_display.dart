import 'package:flutter/material.dart';

import '../../models/book/book.dart';
import '../../models/book/content/blockquote.dart';
import '../../models/book/content/choice_tag.dart';
import '../../models/book/content/combat_tag.dart';
import '../../models/book/content/deadend_tag.dart';
import '../../models/book/content/illustration_tag.dart';
import '../../models/book/content/paragraph_tag.dart';
import '../../models/book/content/signpost_tag.dart';
import '../../models/book/section.dart';
import '../../models/book/section/data.dart';
import 'blockquote.dart';
import 'choice.dart';
import 'combat.dart';
import 'deadend.dart';
import 'illustration.dart';
import 'paragraph.dart';
import 'signpost.dart';

class BookDisplay extends StatelessWidget {
  final Book _book;
  final int _pageNumber;

  const BookDisplay(this._book, this._pageNumber, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      Section section = _book.numbered.elementAt(_pageNumber);
      Data data = section.data;

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(section.meta.title),
          ...data.content
              .map<Widget>((tag) {
                final tagType = tag.tagType();

                switch (tagType) {
                  case 'BlockquoteTag':
                    return Blockquote(tag as BlockquoteTag);

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

                  case 'SignpostTag':
                    return Signpost(tag as SignpostTag);

                  default:
                    print('Unsupported Tag: "$tagType"');
                    return Text('Unsupported Tag: "$tagType"');
                }
              })
              .where((Widget widget) => widget.runtimeType.toString() != 'SizedBox')
              .toList()
        ],
      );
    } catch (error) {
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('An error occured whilst displaying book'),
        Text(error.toString()),
      ]);
    }
  }
}
