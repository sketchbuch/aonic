import 'package:xml/xml.dart';

import '../../../types/types.dart';
import '../../../utils/xml/helpers.dart';
import 'text_element.dart';

enum DescriptionIemType {
  dt,
  dd,
}

class DescriptionListItem {
  late final bool displayAsLines;
  late final DescriptionIemType type;
  late final List<TextElement> texts;

  DescriptionListItem._();

  DescriptionListItem.fromXml(XmlElement xml) {
    final typeName = xml.name.toString();

    if (typeName == 'dt') {
      type = DescriptionIemType.dt;
    } else {
      type = DescriptionIemType.dd;
    }

    texts = getTextElementList(xml);
    displayAsLines = type == DescriptionIemType.dd && xml.children.toString().contains("<line>");
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
