import 'package:lonewolf_new/models/book/content/subcontent/text_element.dart';
import 'package:lonewolf_new/types/types.dart';
import 'package:test/test.dart';

import '../../../../helpers.dart';

void main() {
  const Attrs defaultAttrs = {};
  const Attrs bookRefAttrs = {
    'series': 'lw',
    'book': '02fotw',
    'href': 'https://www.projectaon.org/en/xhtml/lw/02fotw/title.htm'
  };

  String getAttrStr(Attrs attrs) {
    final attrKeys = attrs.keys;
    var attrStr = '';

    if (attrKeys.isNotEmpty) {
      for (var attrKey in attrKeys) {
        attrStr += ' $attrKey="${attrs[attrKey]}"';
      }
    }

    return attrStr;
  }

  String getXmlString(Map<String, Object> testTag, String attrStr) {
    var content = 'If you would rather press on, ';

    if (testTag['type'] == 'boldCite') {
      content = '<cite>$content</cite>';
    } else if (testTag['type'] == 'citeBookref') {
      content = '<bookref${getAttrStr(testTag['attrs'] as Attrs)}>$content</bookref>';
    }

    return '<${testTag['tag']}$attrStr>$content</${testTag['tag']}>';
  }

  group('Model - TextElement()', () {
    final tags = [
      {'type': 'bold', 'tag': 'b', 'attrs': defaultAttrs},
      {'type': 'bold', 'tag': 'strong', 'attrs': defaultAttrs},
      {'type': 'boldCite', 'tag': 'b', 'attrs': defaultAttrs},
      {'type': 'boldCite', 'tag': 'strong', 'attrs': defaultAttrs},
      {'type': 'bookref', 'tag': 'bookref', 'attrs': bookRefAttrs},
      {'type': 'cite', 'tag': 'cite', 'attrs': defaultAttrs},
      {'type': 'citeBookref', 'tag': 'cite', 'attrs': bookRefAttrs},
      {'type': 'italic', 'tag': 'em', 'attrs': defaultAttrs},
      {'type': 'italic', 'tag': 'i', 'attrs': defaultAttrs},
      {'type': 'link', 'tag': 'a', 'attrs': defaultAttrs},
      {'type': 'link', 'tag': 'link-text', 'attrs': defaultAttrs},
      {'type': 'plain', 'tag': 'unknown-tag', 'attrs': defaultAttrs},
      {'type': 'typ', 'tag': 'typ', 'attrs': defaultAttrs},
    ];

    void testElement(Map<String, Object> testTag, String testType) {
      test('Returns expected $testType with displayType "${testTag['type']}" when the tag is "${testTag['tag']}"', () {
        final attrStr = getAttrStr(testTag['attrs'] as Attrs);
        final xml = getXmlString(testTag, attrStr);
        final tag = TextElement.fromXml(getRootXmlElement(xml));

        final expectedJson = {
          "attrs": testTag['attrs'],
          "displayType": testTag['type'],
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
        testElement(tag, 'JSON');
      }
    });
    group('fromXml() toString()', () {
      for (var tag in tags) {
        testElement(tag, 'string');
      }
    });

    group('fromTxt() - Text only', () {
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

    group('fromTxt() - Text, type, and attrs', () {
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
