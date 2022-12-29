import 'package:flutter/material.dart';

import '../../../models/book/content/description_list_tag.dart';
import '../../../models/book/content/subcontent/description_list_item.dart';
import '../layout/content_container.dart';
import '../mixins/content_renderer.dart';
import 'list/description_detail_list_item.dart';
import 'list/description_detail_text_list_item.dart';
import 'list/description_term_list_item.dart';

class DescriptionList extends StatelessWidget with ContentRenderer {
  final DescriptionListTag tag;

  const DescriptionList(this.tag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> listItems = [];
    bool isFirstTerm = true;

    for (var item in tag.items) {
      if (item.type == DescriptionItemType.dt) {
        listItems.add(DescriptionTermListItem(item, isFirstTerm));
        isFirstTerm = false;
      } else {
        if (item.displayAsLines) {
          for (var text in item.texts) {
            listItems.add(DescriptionDetailTextListItem(text));
          }
        } else {
          listItems.add(DescriptionDetailListItem(item));
        }
      }
    }

    return ContentContainer(
      child: Column(
        children: listItems,
      ),
    );
  }
}
