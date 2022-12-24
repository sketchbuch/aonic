import 'package:xml/xml.dart';

import '../../../types/types.dart';
import '../../../utils/xml/helpers.dart';
import 'subcontent/book_section_item.dart';
import 'subcontent/plain_list_item.dart';
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

  PlainListTag.fromBookSectionItems(BookSectionItems bookSectionItems) {
    listType = PlainListTagType.ul;
    type = PlainListType.toc;

    for (var bookSectionItem in bookSectionItems) {
      items.add(PlainListItem.fromBookSectionItem(bookSectionItem));
    }
  }

  @override
  Json toJson() => {
        'items': items.map((item) => item.toJson()).toList(),
        'listType': listType.name,
        'type': type.name,
      };
}
