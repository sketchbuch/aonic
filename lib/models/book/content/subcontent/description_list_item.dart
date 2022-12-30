import 'package:xml/xml.dart';

import '../../../../types/types.dart';
import '../../../../utils/xml/helpers.dart';
import 'text_element.dart';

enum DescriptionItemType {
  dt,
  dd,
}

class DescriptionListItem {
  final TextElements texts = [];
  late final bool displayAsLines;
  late final DescriptionItemType type;

  // ignore: unused_element
  DescriptionListItem._();

  DescriptionListItem.fromXml(XmlElement xml) {
    final typeName = xml.name.toString();

    if (typeName == 'dt') {
      type = DescriptionItemType.dt;
    } else {
      type = DescriptionItemType.dd;
    }

    texts.addAll(getTextElementList(xml));
    displayAsLines = type == DescriptionItemType.dd && xml.children.toString().contains("<line>");
  }

  Json toJson() => {
        'displayAsLines': displayAsLines,
        'texts': texts.map((text) => text.toJson()).toList(),
        'type': type.name,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
