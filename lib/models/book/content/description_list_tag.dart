import 'package:xml/xml.dart';

import '../../../types/types.dart';
import 'subcontent/description_list_item.dart';
import 'tag.dart';

class DescriptionListTag extends Tag {
  final List<DescriptionListItem> items = [];

  // ignore: unused_element
  DescriptionListTag._();

  DescriptionListTag.fromXml(XmlElement xml) {
    for (var child in xml.childElements) {
      items.add(DescriptionListItem.fromXml(child));
    }
  }

  @override
  Json toJson() => {
        'items': items.map((item) => item.toJson()).toList(),
      };
}
