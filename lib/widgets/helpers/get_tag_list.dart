import 'package:flutter/material.dart';

import '../../config/models/book_config.dart';
import '../../models/book/content/blockquote_model.dart';
import '../../models/book/content/choice_tag_model.dart';
import '../../models/book/content/combat_tag_model.dart';
import '../../models/book/content/deadend_tag_model.dart';
import '../../models/book/content/description_list_tag_model.dart';
import '../../models/book/content/illustration_tag_model.dart';
import '../../models/book/content/paragraph_tag_model.dart';
import '../../models/book/content/plain_list_tag_model.dart';
import '../../models/book/content/section_tag_model.dart';
import '../../models/book/content/tag.dart';
import '../../types/types.dart';
import '../content/blockquote.dart';
import '../content/choice.dart';
import '../content/combat.dart';
import '../content/deadend.dart';
import '../content/description_list.dart';
import '../content/illustration.dart';
import '../content/paragraph.dart';
import '../content/plain_list.dart';
import '../content/section.dart';

List<Widget> getTagList(SectionTagModel section, OnNavigate onNavigate,
    int level, BookConfig? bookConfig) {
  List<TagModel> tagList = section.data.content;
  final List<Widget> sectionContent = [];

  for (var tag in tagList) {
    final tagType = tag.tagType();

    switch (tagType) {
      case 'BlockquoteTagModel':
        sectionContent.add(Blockquote(tag as BlockquoteTagModel));
        break;

      case 'ChoiceTagModel':
        sectionContent.add(Choice(tag as ChoiceTagModel, onNavigate));
        break;

      case 'CombatTagModel':
        sectionContent.add(Combat(tag as CombatTagModel));
        break;

      case 'DeadendTagModel':
        sectionContent.add(Deadend(tag as DeadendTagModel));
        break;

      case 'DescriptionListTagModel':
        sectionContent.add(DescriptionList(tag as DescriptionListTagModel));
        break;

      case 'PlainListTagModel':
        sectionContent.add(PlainList(tag as PlainListTagModel, onNavigate));
        break;

      case 'IllustrationTagModel':
        final illy = tag as IllustrationTagModel;
        final List<String> realIllustrators =
            bookConfig == null ? [] : bookConfig.useIllustrators.split(':');
        var isRealIllustration = false;

        for (var illustrator in realIllustrators) {
          if (illy.creator.toLowerCase() == illustrator.toLowerCase()) {
            isRealIllustration = true;
            break;
          }
        }

        if ((!section.isNumbered() || isRealIllustration) &&
            illy.getHtmlInstance() != null) {
          sectionContent.add(Illustration(illy));
        }

        break;

      case 'ListTagModel':
        sectionContent.add(PlainList(tag as PlainListTagModel, onNavigate));
        break;

      case 'ParagraphTagModel':
        sectionContent.add(Paragraph(tag as ParagraphTagModel, onNavigate));
        break;

      case 'SectionTagModel':
        final sec = tag as SectionTagModel;

        if (!sec.isFrontmatterSeperate()) {
          sectionContent.add(Section(
            sec,
            onNavigate,
            level + 1,
          ));
        }

        break;

      case 'SignpostTagModel':
        sectionContent.add(Blockquote(tag as BlockquoteTagModel));
        break;

      default:
        print('Unsupported Tag: "$tagType"');
        sectionContent.add(Text('Unsupported Tag: "$tagType"'));
        break;
    }
  }
  return sectionContent;
}
