import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../models/book/content/plain_list_tag.dart';
import '../../../types/types.dart';
import '../../config/book_config.dart';
import '../../config/config.dart';
import '../../constants/layout.dart';
import '../../models/book/content/blockquote.dart';
import '../../models/book/content/choice_tag.dart';
import '../../models/book/content/combat_tag.dart';
import '../../models/book/content/deadend_tag.dart';
import '../../models/book/content/description_list_tag.dart';
import '../../models/book/content/illustration_tag.dart';
import '../../models/book/content/paragraph_tag.dart';
import '../../models/book/content/section_tag.dart';
import '../../models/book/content/subcontent/plain_list_item.dart';
import '../../store/models/app_state.dart';
import '../layout/content_container.dart';
import 'blockquote.dart';
import 'choice.dart';
import 'combat.dart';
import 'deadend.dart';
import 'description_list.dart';
import 'illustration.dart';
import 'list/bullet_list_item.dart';
import 'list/numbered_list_item.dart';
import 'paragraph.dart';
import 'section.dart';
import 'section_view_model.dart';

class PlainList extends StatefulWidget {
  final double bottomPadding;
  final OnNavigate onNavigate;
  final PlainListTag tag;

  const PlainList(this.tag, this.onNavigate, {Key? key, this.bottomPadding = paddingLarge}) : super(key: key);

  @override
  State<PlainList> createState() => _PlainListState();
}

class _PlainListState extends State<PlainList> {
  List<Widget> getItemContent(PlainListItem item, int itemIndex, BookConfig? bookConfig) {
    final itemPadding = widget.tag.type == PlainListType.paragraphed ? paddingLarge : sizeZero;

    final List<Widget> contentWidgets = [];
    for (var tag in item.content) {
      final tagType = tag.tagType();

      switch (tagType) {
        case 'BlockquoteTag':
          contentWidgets.add(Blockquote(
            tag as BlockquoteTag,
            bottomPadding: itemPadding,
          ));
          break;

        case 'ChoiceTag':
          contentWidgets.add(Choice(
            tag as ChoiceTag,
            widget.onNavigate,
            bottomPadding: itemPadding,
          ));
          break;

        case 'CombatTag':
          contentWidgets.add(Combat(
            tag as CombatTag,
            bottomPadding: itemPadding,
          ));
          break;

        case 'DeadendTag':
          contentWidgets.add(Deadend(
            tag as DeadendTag,
            bottomPadding: itemPadding,
          ));
          break;

        case 'DescriptionListTag':
          contentWidgets.add(DescriptionList(
            tag as DescriptionListTag,
            bottomPadding: itemPadding,
          ));
          break;

        case 'PlainListTag':
          contentWidgets.add(PlainList(
            tag as PlainListTag,
            widget.onNavigate,
            bottomPadding: itemPadding,
          ));
          break;

        case 'IllustrationTag':
          final illy = tag as IllustrationTag;
          final List<String> realIllustrators = bookConfig == null ? [] : bookConfig.useIllustrators.split(':');
          var isRealIllustration = false;

          for (var illustrator in realIllustrators) {
            if (illy.creator.toLowerCase() == illustrator.toLowerCase()) {
              isRealIllustration = true;
              break;
            }
          }

          if (isRealIllustration && illy.getHtmlInstance() != null) {
            contentWidgets.add(Illustration(illy));
          }

          break;

        case 'ListTag':
          contentWidgets.add(PlainList(
            tag as PlainListTag,
            widget.onNavigate,
            bottomPadding: itemPadding,
          ));
          break;

        case 'ParagraphTag':
          contentWidgets.add(Paragraph(
            tag as ParagraphTag,
            widget.onNavigate,
            bottomPadding: itemPadding,
          ));
          break;

        case 'SectionTag':
          final sec = tag as SectionTag;

          if (!sec.isFrontmatterSeperate()) {
            contentWidgets.add(Section(
              sec,
              widget.onNavigate,
              itemIndex + 1,
            ));
          }

          break;

        case 'SignpostTag':
          contentWidgets.add(Blockquote(
            tag as BlockquoteTag,
            bottomPadding: itemPadding,
          ));
          break;

        default:
          print('Unsupported Tag: "$tagType"');
          contentWidgets.add(Text('Unsupported Tag: "$tagType"'));
          break;
      }
    }

    return contentWidgets;
  }

  @override
  Widget build(BuildContext context) {
    int itemIndex = 0;

    return StoreConnector<AppState, SectionViewModel>(
      converter: (store) => SectionViewModel.create(store),
      builder: (BuildContext context, SectionViewModel viewModel) {
        final bookConfig = config.getBookByCode(viewModel.bookCode);

        return ContentContainer(
          bottomPadding: widget.bottomPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: widget.tag.items.map((item) {
              itemIndex += 1;

              final content = getItemContent(item, itemIndex, bookConfig);

              if (widget.tag.listType == PlainListTagType.ol) {
                return NumberedListItem(content, widget.onNavigate, item.depth, widget.tag.items.length, itemIndex);
              }

              return BulletListItem(content, widget.onNavigate, item.depth);
            }).toList(),
          ),
        );
      },
    );
  }
}
