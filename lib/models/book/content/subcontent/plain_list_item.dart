import 'package:xml/xml.dart';

import '../../../../types/types.dart';
import '../../../../utils/xml/helpers.dart';
import '../../toc/toc_index_section.dart';
import 'text_element.dart';

class PlainListItem {
  late final int depth;
  final List<TextElement> texts = [];

  // ignore: unused_element
  PlainListItem._();

  PlainListItem.fromXml(XmlElement xml, int itemDepth) {
    depth = itemDepth;
    texts.addAll(getTextElementList(xml));
  }

  PlainListItem.fromTocIndexSection(TocIndexSection tocIndexSection) {
    depth = tocIndexSection.depth;
    texts.add(TextElement.fromTxt(tocIndexSection.section.meta.title,
        type: DisplayType.link, attributes: {"idref": tocIndexSection.section.id}));
  }

  Json toJson() => {
        'depth': depth,
        'texts': texts.map((text) => text.toJson()).toList(),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
