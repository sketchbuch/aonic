import 'package:xml/xml.dart';

import '../../../types/types.dart';
import '../../../utils/xml/helpers.dart';
import 'tag.dart';

class BlockquoteTagModel extends TagModel {
  // ignore: unused_element
  BlockquoteTagModel._();

  BlockquoteTagModel.fromXml(XmlElement xml) {
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
