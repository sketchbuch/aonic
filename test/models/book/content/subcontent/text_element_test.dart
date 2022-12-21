import 'package:lonewolf_new/models/book/content/subcontent/text_element.dart';
import 'package:test/test.dart';

import '../../../../helpers.dart';

void main() {
  group('Model - TextElement()', () {
    // TODO - Add test forboldCite
    const tags = [
      {'type': 'bold', 'tag': 'b'},
      {'type': 'bold', 'tag': 'strong'},
      {'type': 'bookref', 'tag': 'bookref'},
      {'type': 'cite', 'tag': 'cite'},
      {'type': 'italic', 'tag': 'em'},
      {'type': 'italic', 'tag': 'i'},
      {'type': 'link', 'tag': 'a'},
      {'type': 'link', 'tag': 'link-text'},
      {'type': 'plain', 'tag': 'unknown-tag'},
      {'type': 'typ', 'tag': 'typ'},
    ];

    void testElement(String displayType, String tagName, String testType) {
      test('Returns expected $testType with displayType "$displayType" when the tag is "$tagName"', () {
        final xml = '<$tagName>If you would rather press on, </$tagName>';
        final tag = TextElement.fromXml(getRootXmlElement(xml));

        final expectedJson = {
          "attrs": {},
          "displayType": displayType,
          "text": "If you would rather press on, ",
        };

        if (testType == 'JSON') {
          expect(tag.toJson(), equals(expectedJson));
        } else {
          expect(tag.toString(), equals(expectedJson.toString()));
        }
      });
    }

    group('fromXml() toJson()', () {
      for (var tag in tags) {
        testElement(tag['type']!, tag['tag']!, 'JSON');
      }
    });
    group('fromXml() toString()', () {
      for (var tag in tags) {
        testElement(tag['type']!, tag['tag']!, 'string');
      }
    });

    group('fromTxt() - Text only:', () {
      final tag = TextElement.fromTxt('If you would rather press on, ');

      final expectedJson = {
        "attrs": {},
        "displayType": "plain",
        "text": "If you would rather press on, ",
      };

      test('Returns expected JSON', () {
        expect(tag.toJson(), equals(expectedJson));
      });

      test('Returns expected string', () {
        expect(tag.toString(), equals(expectedJson.toString()));
      });
    });

    group('fromTxt() - Text, type, and attrs:', () {
      final tag = TextElement.fromTxt(
        'If you would rather press on, ',
        type: DisplayType.italic,
        attributes: {"idref": "test-id"},
      );

      final expectedJson = {
        "attrs": {"idref": "test-id"},
        "displayType": "italic",
        "text": "If you would rather press on, ",
      };

      test('Returns expected JSON', () {
        expect(tag.toJson(), equals(expectedJson));
      });

      test('Returns expected string', () {
        expect(tag.toString(), equals(expectedJson.toString()));
      });
    });
  });
}
