import 'package:xml/xml.dart';

import '../../../exceptions/xml.dart';
import '../../../types/types.dart';
import '../content/blockquote_model.dart';
import '../content/choice_tag_model.dart';
import '../content/combat_tag_model.dart';
import '../content/deadend_tag_model.dart';
import '../content/description_list_tag_model.dart';
import '../content/illustration_tag_model.dart';
import '../content/paragraph_tag_model.dart';
import '../content/plain_list_tag_model.dart';
import '../content/section_tag_model.dart';
import '../content/signpost_tag_model.dart';
import '../content/tag.dart';

class DataModel {
  final List<TagModel> content = [];

  // ignore: unused_element
  DataModel._();

  DataModel.fromXml(XmlElement xml, bool addSubcontent) {
    if (addSubcontent && xml.childElements.isNotEmpty) {
      for (var child in xml.childElements) {
        final childName = child.name.toString();

        if (childName == 'blockquote') {
          content.add(BlockquoteTagModel.fromXml(child));
        } else if (childName == 'choice') {
          content.add(ChoiceTagModel.fromXml(child));
        } else if (childName == 'combat') {
          content.add(CombatTagModel.fromXml(child));
        } else if (childName == 'deadend') {
          content.add(DeadendTagModel.fromXml(child));
        } else if (childName == 'dl') {
          content.add(DescriptionListTagModel.fromXml(child));
        } else if (childName == 'illustration') {
          content.add(IllustrationTagModel.fromXml(child));
        } else if (childName == 'ol' || childName == 'ul') {
          content.add(PlainListTagModel.fromXml(child));
        } else if (childName == 'p') {
          content.add(ParagraphTagModel.fromXml(child));
        } else if (childName == 'section') {
          content.add(SectionTagModel.fromXml(child));
        } else if (childName == 'signpost') {
          content.add(SignpostTagModel.fromXml(child));
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
