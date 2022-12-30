import 'package:xml/xml.dart';

import '../../../../types/types.dart';
import '../../../../utils/xml/helpers.dart';
import 'text_element.dart';
import 'toc_item.dart';

class PlainListItem {
  late final int depth;
  final TextElements texts = [];

  // ignore: unused_element
  PlainListItem._();

  PlainListItem.fromXml(XmlElement xml, int itemDepth) {
    depth = itemDepth;
    texts.addAll(getTextElementList(xml));
  }

  PlainListItem.fromTocItem(TocItem tocItem) {
    depth = tocItem.depth;

    texts.add(
      TextElement.fromTxt(
        tocItem.title,
        type: DisplayType.link,
        attributes: {
          "idref": tocItem.id,
        },
      ),
    );
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
