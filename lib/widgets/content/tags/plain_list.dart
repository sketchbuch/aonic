import 'package:flutter/material.dart';

import '../../../models/book/content/plain_list_tag.dart';
import '../content_container.dart';
import '../list/bullet_list_item.dart';
import '../list/numbered_list_item.dart';

class PlainList extends StatelessWidget {
  final PlainListTag tag;

  const PlainList(this.tag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int itemIndex = 0;

    return ContentContainer(
      child: Column(
        children: tag.items.map((item) {
          itemIndex += 1;

          if (tag.listType == PlainListTagType.ol) {
            return NumberedListItem(item, tag.items.length, itemIndex);
          }

          return BulletListItem(item, tag.items.length);
        }).toList(),
      ),
    );
  }
}
