import 'package:xml/xml.dart';

import '../../types/types.dart';
import '../../utils/xml/helpers.dart';
import 'subcontent/list_item.dart';
import 'tag.dart';

const defaultAttrValue = 1;

enum ListTagType {
  ol,
  ul,
}

enum ListType {
  none,
  paragraphed,
  unbulleted,
  unknown,
}

class ListTag extends Tag {
  late final List<ListItem> items;
  late final ListTagType listType;
  late final ListType type;

  ListTag(this.listType, this.type, this.items);

  ListTag.fromXml(XmlElement xml) {
    final typeName = xml.name.toString();

    if (typeName == 'ul') {
      listType = ListTagType.ul;
    } else {
      listType = ListTagType.ol;
    }

    try {
      final typeName = getAttribute('class', xml);

      if (typeName.isEmpty) {
        type = ListType.none;
      } else {
        type = ListType.values.byName(typeName);
      }
    } on ArgumentError {
      type = ListType.unknown;
    }

    items = xml.findElements('li').map((li) => ListItem.fromXml(li)).toList();
  }

  @override
  Json toJson() => {
        'items': items.map((item) => item.toJson()).toList(),
        'listType': listType.name,
        'type': type.name,
      };
}
