import 'package:flutter/material.dart';

import '../../../models/book/content/plain_list_tag.dart';
import '../../../types/types.dart';
import '../layout/content_container.dart';
import 'list/bullet_list_item.dart';
import 'list/numbered_list_item.dart';

class PlainList extends StatelessWidget {
  final OnNavigate onNavigate;
  final PlainListTag tag;

  const PlainList(this.tag, this.onNavigate, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int itemIndex = 0;

    return ContentContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: tag.items.map((item) {
          itemIndex += 1;

          if (tag.listType == PlainListTagType.ol) {
            return NumberedListItem(item, onNavigate, item.depth, tag.items.length, itemIndex);
          }

          return BulletListItem(item, onNavigate, item.depth);
        }).toList(),
      ),
    );
  }
}
