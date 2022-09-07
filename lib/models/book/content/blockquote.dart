import 'package:lonewolf_new/models/book/content/subcontent/text_element.dart';
import 'package:xml/xml.dart';

import '../../../types/types.dart';
import '../../../utils/xml/helpers.dart';
import 'tag.dart';

class BlockquoteTag extends Tag {
  final List<TextElement> texts = [];

  // ignore: unused_element
  BlockquoteTag._();

  BlockquoteTag.fromXml(XmlElement xml) {
    final paragraphXml = xml.getElement('p');

    if (paragraphXml != null) {
      texts.addAll(getTextElementList(paragraphXml));
    } else {
      texts.addAll(getTextElementList(xml));
    }
  }

  @override
  Json toJson() => {
        'texts': texts.map((text) => text.toJson()).toList(),
      };
}
