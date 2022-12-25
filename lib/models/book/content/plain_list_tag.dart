import 'package:lonewolf_new/models/book/content/subcontent/numbered_section_item.dart';
import 'package:xml/xml.dart';

import '../../../types/types.dart';
import '../../../utils/xml/helpers.dart';
import 'subcontent/plain_list_item.dart';
import 'subcontent/toc_item.dart';
import 'tag.dart';

enum PlainListTagType {
  ol,
  ul,
}

enum PlainListType {
  none,
  paragraphed,
  unbulleted,
  toc,
  unknown,
}

class PlainListTag extends Tag {
  final List<PlainListItem> items = [];
  late final PlainListTagType listType;
  late final PlainListType type;

  // ignore: unused_element
  PlainListTag._();

  PlainListTag.fromXml(XmlElement xml) {
    final typeName = xml.name.toString();

    if (typeName == 'ul') {
      listType = PlainListTagType.ul;
    } else {
      listType = PlainListTagType.ol;
    }

    try {
      final typeName = getAttribute('class', xml);

      if (typeName.isEmpty) {
        type = PlainListType.none;
      } else {
        type = PlainListType.values.byName(typeName);
      }
    } on ArgumentError {
      type = PlainListType.unknown;
    }

    xml.findElements('li').forEach((li) {
      items.add(PlainListItem.fromXml(li, 1));
    });
  }

  PlainListTag.fromTocItems(List<TocItem> bookSectionItems) {
    listType = PlainListTagType.ul;
    type = PlainListType.toc;

    for (var bookSectionItem in bookSectionItems) {
      items.add(PlainListItem.fromTocItem(bookSectionItem));
    }
  }

  PlainListTag.fromNumberedSectionItems(List<NumberedSectionItem> numberedSectionItems) {
    listType = PlainListTagType.ul;
    type = PlainListType.none;

    for (var numberedSectionItem in numberedSectionItems) {
      items.add(PlainListItem.fromNumberedSectionItem(numberedSectionItem));
    }
  }

  @override
  Json toJson() => {
        'items': items.map((item) => item.toJson()).toList(),
        'listType': listType.name,
        'type': type.name,
      };
}
