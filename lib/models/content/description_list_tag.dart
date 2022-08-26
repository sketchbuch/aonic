import 'package:xml/xml.dart';

import '../../types/types.dart';
import 'subcontent/description_list_item.dart';
import 'tag.dart';

class DescriptionListTag extends Tag {
  late final List<DescriptionListItem> items;

  DescriptionListTag._() {}

  DescriptionListTag.fromXml(XmlElement xml) {
    items = xml.childElements.map((child) => DescriptionListItem.fromXml(child)).toList();
  }

  @override
  Json toJson() => {
        'items': items.map((item) => item.toJson()).toList(),
      };
}
