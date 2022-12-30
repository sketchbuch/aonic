import 'package:lonewolf_new/models/book/content/subcontent/text_element.dart';
import 'package:test/test.dart';

import '../../../../helpers.dart';

void main() {
  group('fromXml() - TextElement()', () {
    test('Returns expected JSON', () {
      const xmlString = '<p>If you <b>would rather</b> press on, </p>';
      final tag = TextElement.fromXml(getRootXmlElement(xmlString));
      final expectedJson = {
        "attrs": {},
        "displayType": "plain",
        "subelements": [
          {
            "attrs": {},
            "displayType": "plain",
            "subelements": [],
            "text": "If you ",
          },
          {
            "attrs": {},
            "displayType": "bold",
            "subelements": [],
            "text": "would rather",
          },
          {
            "attrs": {},
            "displayType": "plain",
            "subelements": [],
            "text": " press on, ",
          },
        ],
        "text": "",
      };

      expect(tag.toJson(), equals(expectedJson));
    });

    test('fromTxt() - Returns expected JSON', () {
      final tag = TextElement.fromTxt('If you would rather press on, ');
      final expectedJson = {
        "attrs": {},
        "displayType": "plain",
        "subelements": [],
        "text": "If you would rather press on, ",
      };

      expect(tag.toJson(), equals(expectedJson));
    });
  });
}
