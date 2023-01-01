import 'package:aonic/models/book/meta/right.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';

const rightXml = '''<rights class="licenseNotification">
  <p>
    <line>Text copyright <ch.copy/> 1984 Joe Dever.</line>
    <line>Illustrations copyright <ch.copy/> 1984 Gary Chalk.</line>
    <line>Distribution of this Internet Edition is restricted under the terms of the <a idref="license">Project Aon License</a>.</line>
  </p>
</rights>''';
const rightJson = {
  "paragraphs": [
    {
      "texts": [
        {
          "attrs": {},
          "displayType": "plain",
          "parentType": "none",
          "subelements": [],
          "text": "Text copyright © 1984 Joe Dever.",
        }
      ]
    },
    {
      "texts": [
        {
          "attrs": {},
          "displayType": "plain",
          "parentType": "none",
          "subelements": [],
          "text": "Illustrations copyright © 1984 Gary Chalk.",
        }
      ]
    },
    {
      "texts": [
        {
          "attrs": {},
          "displayType": "plain",
          "parentType": "none",
          "subelements": [],
          "text": "Distribution of this Internet Edition is restricted under the terms of the ",
        },
        {
          "attrs": {"idref": "license"},
          "displayType": "link",
          "parentType": "none",
          "subelements": [],
          "text": "Project Aon License"
        },
        {
          "attrs": {},
          "displayType": "plain",
          "parentType": "none",
          "subelements": [],
          "text": ".",
        },
      ]
    }
  ],
  "type": "license-notification"
};

void main() {
  group('Model - Right()', () {
    final tag = Right.fromXml(getRootXmlElement(rightXml));

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(rightJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(rightJson.toString()));
    });
  });
}
