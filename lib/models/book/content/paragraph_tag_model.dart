import 'package:xml/xml.dart';

import '../../../types/types.dart';
import '../../../utils/xml/helpers.dart';
import 'subcontent/text_element_model.dart';
import 'tag.dart';

class ParagraphTagModel extends TagModel {
  // ignore: unused_element
  ParagraphTagModel._();

  ParagraphTagModel.fromNode(XmlNode node) {
    final nodeXml = XmlDocument.parse(node.outerXml).rootElement;
    final String className = getAttribute('class', nodeXml);
    texts.addAll(getTextElementList(nodeXml, _getType(className)));
  }

  ParagraphTagModel.fromTxt(String text,
      {Attrs? attributes, DisplayType? parentDisplayType, DisplayType? type}) {
    texts.add(TextElementModel.fromTxt(
      text,
      attributes: attributes,
      parentDisplayType: parentDisplayType,
      type: type,
    ));
  }

  ParagraphTagModel.fromXml(XmlElement xml) {
    final String className = getAttribute('class', xml);
    texts.addAll(getTextElementList(xml, _getType(className)));
  }

  DisplayType? _getType(String className) {
    if (className == 'dedication') {
      return DisplayType.italic;
    }

    return null;
  }

  @override
  Json toJson() => {
        'texts': texts.map((text) => text.toJson()).toList(),
      };
}
