import 'package:flutter/material.dart';

import '../../models/book/content/blockquote.dart';
import '../../models/book/content/choice_tag.dart';
import '../../models/book/content/combat_tag.dart';
import '../../models/book/content/deadend_tag.dart';
import '../../models/book/content/illustration_tag.dart';
import '../../models/book/content/paragraph_tag.dart';
import '../../models/book/section/section.dart';
import '../../types/types.dart';
import '../content/tags/blockquote.dart';
import '../content/tags/choice.dart';
import '../content/tags/combat.dart';
import '../content/tags/deadend.dart';
import '../content/tags/illustration.dart';
import '../content/tags/paragraph.dart';

class SectionDisplay extends StatelessWidget {
  final OnNavigate onNavigate;
  final Section section;

  const SectionDisplay(this.section, this.onNavigate, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> sectionContent = [];
    final List<Widget> subsectionContent = [];

    for (var tag in section.data.content) {
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

        case 'IllustrationTag':
          final illy = tag as IllustrationTag;

          if (illy.isRealIllustration) {
            sectionContent.add(Illustration(illy));
          }

          break;

        case 'ParagraphTag':
          sectionContent.add(Paragraph(tag as ParagraphTag, onNavigate));
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

    final subSections = section.getVisibleSubsections();

    for (var subSection in subSections) {
      if (subSection.type != SectionType.frontmatterSeparate) {
        for (var tag in subSection.data.content) {
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

            case 'IllustrationTag':
              final illy = tag as IllustrationTag;

              if (illy.isRealIllustration) {
                sectionContent.add(Illustration(illy));
              }

              break;

            case 'ParagraphTag':
              sectionContent.add(Paragraph(tag as ParagraphTag, onNavigate));
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
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(section.meta.title),
        ...sectionContent,
        ...subsectionContent,
      ],
    );
  }
}
