import 'package:xml/xml.dart';

import '../../../../types/types.dart';
import '../../../../utils/xml/helpers.dart';
import '../blockquote.dart';
import '../choice_tag.dart';
import '../combat_tag.dart';
import '../deadend_tag.dart';
import '../description_list_tag.dart';
import '../illustration_tag.dart';
import '../paragraph_tag.dart';
import '../plain_list_tag.dart';
import '../section_tag.dart';
import '../signpost_tag.dart';
import '../tag.dart';
import 'text_element.dart';
import 'toc_item.dart';

class PlainListItem {
  final List<Tag> content = [];
  final TextElements texts = [];
  late final int depth;

  // ignore: unused_element
  PlainListItem._();

  PlainListItem.fromTocItem(TocItem tocItem) {
    depth = tocItem.depth;
    content.add(ParagraphTag.fromTxt(
      tocItem.title,
      attributes: {
        "idref": tocItem.id,
      },
      type: DisplayType.link,
    ));
  }

  bool isRenderableNode(XmlElement xml) {
    final nodeName = xml.childElements.elementAt(0).name.toString();

    switch (nodeName) {
      case "blockquote":
      case "choice":
      case "combat":
      case "deadend":
      case "dl":
      case "illustration":
      case "ol":
      case "ul":
      case "p":
      case "section":
      case "signpost":
        return true;

      default:
        return false;
    }
  }

  PlainListItem.fromXml(XmlElement xml, int itemDepth) {
    depth = itemDepth;
    texts.addAll(getTextElementList(xml));

    final childNodes = [...xml.childElements];

    if (xml.children.isNotEmpty) {
      if (xml.children.length == 1 && xml.childElements.length == 1 && !isRenderableNode(xml)) {
        content.add(ParagraphTag.fromXml(xml));
      } else if (xml.children.length > xml.childElements.length) {
        content.add(ParagraphTag.fromXml(xml));
      } else {
        for (var child in xml.children) {
          if (child.nodeType == XmlNodeType.ELEMENT) {
            try {
              final child = childNodes.removeAt(0);
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
                content.add(ParagraphTag.fromNode(child));
              }
            } on RangeError {
              content.add(ParagraphTag.fromNode(child));
            }
          } else {
            content.add(ParagraphTag.fromTxt(child.text));
          }
        }
      }
    }
  }

  Json toJson() => {
        'content': content.map((tag) => tag.toJson()).toList(),
        'depth': depth,
        'texts': texts.map((text) => text.toJson()).toList(),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
