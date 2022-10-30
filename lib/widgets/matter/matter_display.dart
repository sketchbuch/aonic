import 'package:flutter/material.dart';

import '../../models/book/content/blockquote.dart';
import '../../models/book/content/choice_tag.dart';
import '../../models/book/content/combat_tag.dart';
import '../../models/book/content/deadend_tag.dart';
import '../../models/book/content/illustration_tag.dart';
import '../../models/book/content/paragraph_tag.dart';
import '../../models/book/content/signpost_tag.dart';
import '../../models/book/section/section.dart';
import '../../types/types.dart';
import '../content/tags/blockquote.dart';
import '../content/tags/choice.dart';
import '../content/tags/combat.dart';
import '../content/tags/deadend.dart';
import '../content/tags/illustration.dart';
import '../content/tags/paragraph.dart';
import '../content/tags/signpost.dart';

class MatterDisplay extends StatelessWidget {
  final OnNavigate onNavigate;
  final Section section;

  const MatterDisplay(this.section, this.onNavigate, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(section.meta.title),
        ...section.data.content
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
                  return Paragraph(tag as ParagraphTag, onNavigate);

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
  }
}
