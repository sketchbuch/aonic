import 'package:xml/xml.dart';

import '../../../types/types.dart';
import '../../../utils/xml/helpers.dart';
import 'tag.dart';

class SignpostTagModel extends TagModel {
  // ignore: unused_element
  SignpostTagModel._();

  SignpostTagModel.fromXml(XmlElement xml) {
    texts.addAll(getTextElementList(xml));
  }

  @override
  Json toJson() => {
        'texts': texts.map((text) => text.toJson()).toList(),
      };
}
