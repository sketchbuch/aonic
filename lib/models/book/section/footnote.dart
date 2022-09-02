import 'package:xml/xml.dart';

import '../../../types/types.dart';
import '../../../utils/xml/helpers.dart';
import '../content/subcontent/text_element.dart';

class Footnote {
  late final List<TextElement> texts;
  late String id = '';
  late String idRef = '';

  // ignore: unused_element
  Footnote._();

  Footnote.fromXml(XmlElement xml) {
    id = getAttribute('id', xml);
    idRef = getAttribute('idref', xml);

    final textXml = xml.getElement('p');

    if (textXml != null) {
      texts = getTextElementList(textXml);
    } else {
      texts = [];
    }
  }

  Json toJson() => {
        'id': id,
        'idRef': idRef,
        'texts': texts.map((text) => text.toJson()).toList(),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
