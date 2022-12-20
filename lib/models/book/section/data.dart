import 'package:xml/xml.dart';

import '../../../exceptions/xml.dart';
import '../../../types/types.dart';
import '../content/blockquote.dart';
import '../content/choice_tag.dart';
import '../content/combat_tag.dart';
import '../content/deadend_tag.dart';
import '../content/description_list_tag.dart';
import '../content/illustration_tag.dart';
import '../content/paragraph_tag.dart';
import '../content/plain_list_tag.dart';
import '../content/section_tag.dart';
import '../content/signpost_tag.dart';
import '../content/tag.dart';

class Data {
  final List<Tag> content = [];

  // ignore: unused_element
  Data._();

  Data.fromXml(XmlElement xml) {
    if (xml.childElements.isNotEmpty) {
      for (var child in xml.childElements) {
        final childName = child.name.toString();

        if (childName == 'blockquote') {
          content.add(BlockquoteTag.fromXml(child));
        } else if (childName == 'choice') {
          content.add(ChoiceTag.fromXml(child));
        } else if (childName == 'combat') {
          content.add(CombatTag.fromXml(child));
        } else if (childName == 'deadend') {
          content.add(DeadendTag.fromXml(child));
        } else if (childName == 'dl') {
          content.add(DescriptionListTag.fromXml(child));
        } else if (childName == 'illustration') {
          content.add(IllustrationTag.fromXml(child));
        } else if (childName == 'ol' || childName == 'ul') {
          content.add(PlainListTag.fromXml(child));
        } else if (childName == 'p') {
          content.add(ParagraphTag.fromXml(child));
        } else if (childName == 'section') {
          content.add(SectionTag.fromXml(child));
        } else if (childName == 'signpost') {
          content.add(SignpostTag.fromXml(child));
        } else {
          print('Unknown child name: "$childName"');
          throw ContentXmlException('Unknown child name: "$childName"');
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
