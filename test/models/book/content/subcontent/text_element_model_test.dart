import 'package:aonic/models/book/content/subcontent/text_element_model.dart';
import 'package:test/test.dart';

import '../../../../helpers.dart';

void main() {
  group('Model - TextElementModel.fromXml()', () {
    const xmlString = '<p>If you <b>would rather</b> press on, </p>';
    final tag = TextElementModel.fromXml(getRootXmlElement(xmlString));
    final expectedJson = {
      "attrs": {},
      "displayType": "plain",
      'parentType': 'none',
      "subelements": [
        {
          "attrs": {},
          "displayType": "plain",
          'parentType': 'plain',
          "subelements": [],
          "text": "If you ",
        },
        {
          "attrs": {},
          "displayType": "bold",
          'parentType': 'plain',
          "subelements": [],
          "text": "would rather",
        },
        {
          "attrs": {},
          "displayType": "plain",
          'parentType': 'plain',
          "subelements": [],
          "text": " press on, ",
        },
      ],
      "text": "",
    };

    final optionalTag = TextElementModel.fromXml(
      getRootXmlElement(xmlString),
      type: DisplayType.cite,
      parentDisplayType: DisplayType.italic,
      attributes: {"lone": "wolf"},
    );
    final optionalExpectedJson = {
      "attrs": {"lone": "wolf"},
      "displayType": "cite",
      'parentType': 'italic',
      "subelements": [
        {
          "attrs": {},
          "displayType": "plain",
          'parentType': 'cite',
          "subelements": [],
          "text": "If you ",
        },
        {
          "attrs": {},
          "displayType": "bold",
          'parentType': 'cite',
          "subelements": [],
          "text": "would rather",
        },
        {
          "attrs": {},
          "displayType": "plain",
          'parentType': 'cite',
          "subelements": [],
          "text": " press on, ",
        },
      ],
      "text": "",
    };

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(expectedJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(expectedJson.toString()));
    });

    test('Optional params returns expected JSON', () {
      expect(optionalTag.toJson(), equals(optionalExpectedJson));
    });

    test('Optional params returns expected string', () {
      expect(optionalTag.toString(), equals(optionalExpectedJson.toString()));
    });

    group('isNode()', () {
      test('Returns true for element subelements and no text', () {
        const xmlString = '<p>If you <b>would rather</b> press on, </p>';
        final tag = TextElementModel.fromXml(getRootXmlElement(xmlString));
        expect(tag.isNode(), equals(true));
      });

      test('Returns false for element without subelements and text', () {
        const xmlString = '<p>If you would rather press on, </p>';
        final tag = TextElementModel.fromXml(getRootXmlElement(xmlString));
        expect(tag.isNode(), equals(false));
      });
    });
  });

  group('Model - TextElementModel.fromXml() complex XML', () {
    const xmlString =
        '''<choice idref="sect347">If you <i>wish <b>to head</b> northeast</i>, <link-text>turn to 347</link-text>.</choice>''';
    final tag = TextElementModel.fromXml(getRootXmlElement(xmlString));
    final expectedJson = {
      "attrs": {"idref": "sect347"},
      "displayType": "plain",
      "parentType": "none",
      "subelements": [
        {
          "attrs": {},
          "displayType": "plain",
          "parentType": "plain",
          "subelements": [],
          "text": "If you ",
        },
        {
          "attrs": {},
          "displayType": "italic",
          "parentType": "plain",
          "subelements": [
            {
              "attrs": {},
              "displayType": "plain",
              "parentType": "italic",
              "subelements": [],
              "text": "wish ",
            },
            {
              "attrs": {},
              "displayType": "bold",
              "parentType": "italic",
              "subelements": [],
              "text": "to head",
            },
            {
              "attrs": {},
              "displayType": "plain",
              "parentType": "italic",
              "subelements": [],
              "text": " northeast",
            }
          ],
          "text": ""
        },
        {
          "attrs": {},
          "displayType": "plain",
          "parentType": "plain",
          "subelements": [],
          "text": ", ",
        },
        {
          "attrs": {},
          "displayType": "link",
          "parentType": "plain",
          "subelements": [],
          "text": "turn to 347",
        },
        {
          "attrs": {},
          "displayType": "plain",
          "parentType": "plain",
          "subelements": [],
          "text": ".",
        }
      ],
      "text": ""
    };

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(expectedJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(expectedJson.toString()));
    });
  });

  group('Model - TextElementModel.fromTxt()', () {
    final tag = TextElementModel.fromTxt('If you would rather press on, ');
    final expectedJson = {
      "attrs": {},
      "displayType": "plain",
      'parentType': 'none',
      "subelements": [],
      "text": "If you would rather press on, ",
    };

    final optionalTag = TextElementModel.fromTxt(
      'If you would rather press on, ',
      type: DisplayType.cite,
      parentDisplayType: DisplayType.bold,
      attributes: {"lone": "wolf"},
    );
    final optionalExpectedJson = {
      "attrs": {"lone": "wolf"},
      "displayType": "cite",
      'parentType': 'bold',
      "subelements": [],
      "text": "If you would rather press on, ",
    };

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(expectedJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(expectedJson.toString()));
    });

    test('Optional params returns expected JSON', () {
      expect(optionalTag.toJson(), equals(optionalExpectedJson));
    });

    test('Optional params returns expected string', () {
      expect(optionalTag.toString(), equals(optionalExpectedJson.toString()));
    });
  });
}
