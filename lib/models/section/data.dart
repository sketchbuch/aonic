import 'package:xml/xml.dart';

import '../../exceptions/xml.dart';
import '../../types/types.dart';
import '../content/choice_tag.dart';
import '../content/combat_tag.dart';
import '../content/illustration_tag.dart';
import '../content/paragraph_tag.dart';
import '../content/tag.dart';

class Data {
  late final List<Tag> content;

  Data(this.content);

  Data.fromXml(XmlElement xml) {
    content = [];

    if (xml.childElements.isNotEmpty) {
      for (var child in xml.childElements) {
        final childName = child.name.toString();

        if (childName == 'choice') {
          content.add(ChoiceTag.fromXml(child));
        } else if (childName == 'combat') {
          content.add(CombatTag.fromXml(child));
        } else if (childName == 'illustration') {
          content.add(IllustrationTag.fromXml(child));
        } else if (childName == 'p') {
          content.add(ParagraphTag.fromXml(child));
        } else {
          throw ContentXmlException('Unknown child name: $childName');
        }
      }
    }
  }

  Json toJson() => {'content': content.map((tag) => tag.toJson()).toList()};

  @override
  String toString() {
    return toJson().toString();
  }
}