import 'package:flutter/material.dart';

import '../../models/book/content/blockquote.dart';
import '../../models/book/content/choice_tag.dart';
import '../../models/book/content/combat_tag.dart';
import '../../models/book/content/deadend_tag.dart';
import '../../models/book/content/description_list_tag.dart';
import '../../models/book/content/illustration_tag.dart';
import '../../models/book/content/paragraph_tag.dart';
import '../../models/book/content/plain_list_tag.dart';
import '../../models/book/content/tag.dart';
import '../../models/book/section/section_tag.dart';
import '../../types/types.dart';
import '../content/tags/blockquote.dart';
import '../content/tags/choice.dart';
import '../content/tags/combat.dart';
import '../content/tags/deadend.dart';
import '../content/tags/description_list.dart';
import '../content/tags/illustration.dart';
import '../content/tags/paragraph.dart';
import '../content/tags/plain_list.dart';
import '../content/tags/section.dart';

List<Widget> getTagList(List<Tag> tagList, OnNavigate onNavigate) {
  final List<Widget> sectionContent = [];

  for (var tag in tagList) {
    final tagType = tag.tagType();

    switch (tagType) {
      case 'BlockquoteTag':
        sectionContent.add(Blockquote(tag as BlockquoteTag));
        break;

      case 'ChoiceTag':
        sectionContent.add(Choice(tag as ChoiceTag, onNavigate));
        break;

      case 'CombatTag':
        sectionContent.add(Combat(tag as CombatTag));
        break;

      case 'DeadendTag':
        sectionContent.add(Deadend(tag as DeadendTag));
        break;

      case 'DescriptionListTag':
        sectionContent.add(DescriptionList(tag as DescriptionListTag));
        break;

      case 'PlainListTag':
        sectionContent.add(PlainList(tag as PlainListTag));
        break;

      case 'IllustrationTag':
        final illy = tag as IllustrationTag;

        if (illy.isRealIllustration) {
          sectionContent.add(Illustration(illy));
        }

        break;

      case 'ListTag':
        sectionContent.add(PlainList(tag as PlainListTag));
        break;

      case 'ParagraphTag':
        sectionContent.add(Paragraph(tag as ParagraphTag, onNavigate));
        break;

      case 'SectionTag':
        final sec = tag as SectionTag;

        if (!sec.isFrontmatterSeperate()) {
          sectionContent.add(Section(sec, onNavigate));
        }

        break;

      case 'SignpostTag':
        sectionContent.add(Blockquote(tag as BlockquoteTag));
        break;

      default:
        print('Unsupported Tag: "$tagType"');
        sectionContent.add(Text('Unsupported Tag: "$tagType"'));
        break;
    }
  }
  return sectionContent;
}
