import 'package:xml/xml.dart';

import '../../types/types.dart';
import '../../utils/xml/helpers.dart';
import 'subcontent/text_element.dart';
import 'tag.dart';

class ChoiceTag extends Tag {
  late final String idref;
  late final int linkTextIndex;
  late final List<TextElement> texts;

  ChoiceTag(this.texts, this.linkTextIndex, this.idref);

  ChoiceTag.fromXml(XmlElement xml) {
    idref = getAttribute('idref', xml);
    texts = [];

    var elementCount = 0;

    for (var index = 0; index < xml.children.length; index++) {
      final child = xml.children.elementAt(index);

      if (child.nodeType == XmlNodeType.ELEMENT) {
        final childElement = xml.childElements.elementAt(elementCount);
        texts.add(TextElement.fromXml(childElement));
        elementCount += 1;

        if (childElement.name.toString() == 'link-text') {
          linkTextIndex = index;
        }
      } else {
        texts.add(TextElement.fromTxt(child.text));
      }
    }
  }

  @override
  Json toJson() => {
        'idref': idref,
        'linkTextIndex': linkTextIndex,
        'texts': texts.map((text) => text.toJson()).toList(),
      };
}
