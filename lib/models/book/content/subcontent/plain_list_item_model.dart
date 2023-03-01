import 'package:xml/xml.dart';

import '../../../../types/types.dart';
import '../../../../utils/rendering/is_renderable_node.dart';
import '../blockquote_model.dart';
import '../choice_tag_model.dart';
import '../combat_tag_model.dart';
import '../deadend_tag_model.dart';
import '../description_list_tag_model.dart';
import '../illustration_tag_model.dart';
import '../paragraph_tag_model.dart';
import '../plain_list_tag_model.dart';
import '../section_tag_model.dart';
import '../signpost_tag_model.dart';
import '../tag.dart';
import 'text_element_model.dart';
import 'toc_item_model.dart';

class PlainListItemModel {
  final List<TagModel> content = [];
  late final int depth;

  // ignore: unused_element
  PlainListItemModel._();

  PlainListItemModel.fromTocItem(TocItemModel tocItem) {
    depth = tocItem.depth;
    content.add(ParagraphTagModel.fromTxt(
      tocItem.title,
      attributes: {
        "idref": tocItem.id,
      },
      type: DisplayType.link,
    ));
  }

  PlainListItemModel.fromXml(XmlElement xml, int itemDepth) {
    depth = itemDepth;

    final childNodes = [...xml.childElements];

    if (xml.children.isNotEmpty) {
      if (xml.children.length == 1 &&
          xml.childElements.length == 1 &&
          !isRenderableNode(xml)) {
        content.add(ParagraphTagModel.fromXml(xml));
      } else if (xml.children.length > xml.childElements.length) {
        content.add(ParagraphTagModel.fromXml(xml));
      } else {
        for (var child in xml.children) {
          if (child.nodeType == XmlNodeType.ELEMENT) {
            try {
              final child = childNodes.removeAt(0);
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
                content.add(ParagraphTagModel.fromNode(child));
              }
            } on RangeError {
              content.add(ParagraphTagModel.fromNode(child));
            }
          } else {
            content.add(ParagraphTagModel.fromTxt(child.text));
          }
        }
      }
    }
  }

  Json toJson() => {
        'content': content.map((tag) => tag.toJson()).toList(),
        'depth': depth,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
