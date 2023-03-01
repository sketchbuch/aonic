import 'package:xml/xml.dart';

import '../../../types/types.dart';
import '../../../utils/xml/helpers.dart';
import 'subcontent/text_element_model.dart';
import 'tag.dart';

class ChoiceTagModel extends TagModel {
  late final int linkTextIndex;
  late final String idref;

  // ignore: unused_element
  ChoiceTagModel._();

  ChoiceTagModel.fromXml(XmlElement xml) {
    idref = getAttribute('idref', xml);

    int elementCount = 0;

    for (var index = 0; index < xml.children.length; index++) {
      final child = xml.children.elementAt(index);

      if (child.nodeType == XmlNodeType.ELEMENT) {
        try {
          final childElement = xml.childElements.elementAt(elementCount);
          texts.add(TextElementModel.fromXml(childElement));

          if (childElement.name.toString() == 'link-text') {
            linkTextIndex = index;
          }
        } on RangeError {
          texts.add(TextElementModel.fromTxt(child.text));
        }

        elementCount += 1;
      } else {
        texts.add(TextElementModel.fromTxt(child.text));
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
