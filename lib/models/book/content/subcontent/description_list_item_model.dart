import 'package:xml/xml.dart';

import '../../../../types/types.dart';
import '../../../../utils/xml/helpers.dart';
import 'text_element_model.dart';

enum DescriptionItemType {
  dt,
  dd,
}

class DescriptionListItemModel {
  final TextElements texts = [];
  late final bool displayAsLines;
  late final DescriptionItemType type;

  // ignore: unused_element
  DescriptionListItemModel._();

  DescriptionListItemModel.fromXml(XmlElement xml) {
    final typeName = xml.name.toString();

    if (typeName == 'dt') {
      type = DescriptionItemType.dt;
    } else {
      type = DescriptionItemType.dd;
    }

    texts.addAll(getTextElementList(xml));
    displayAsLines = type == DescriptionItemType.dd &&
        xml.children.toString().contains("<line>");
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
