import 'package:lonewolf_new/models/book/content/blockquote.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';
import '../../../types.dart';

const blockquoteXml = '''<blockquote>
      <p>If you lose, restore your <typ class="attribute">ENDURANCE</typ> points to the same total that you had before the contest, and <a idref="sect192">turn to 192</a>.</p>
    </blockquote>''';
final blockquoteJson = {
  "texts": [
    {"attrs": {}, "displayType": "plain", "text": "If you lose, restore your "},
    {
      "attrs": {"class": "attribute"},
      "displayType": "typ",
      "text": "ENDURANCE"
    },
    {"attrs": {}, "displayType": "plain", "text": " points to the same total that you had before the contest, and "},
    {
      "attrs": {"idref": "sect192"},
      "displayType": "link",
      "text": "turn to 192"
    },
    {"attrs": {}, "displayType": "plain", "text": "."}
  ]
};

const blockquoteTextXml =
    '<blockquote>The others are all seated at a large table waiting your appearance.</blockquote>';
final blockquoteTextJson = {
  'texts': [
    {
      'attrs': {},
      'displayType': 'plain',
      'text': 'The others are all seated at a large table waiting your appearance.'
    },
  ]
};

void main() {
  group('Model - BlockquoteTag():', () {
    final TestIterationData blockquotes = {
      "Paragraph": {"xml": blockquoteXml, "json": blockquoteJson},
      "Text": {"xml": blockquoteTextXml, "json": blockquoteTextJson},
    };

    void testListType(String type, String xml, Object json) {
      group('$type:', () {
        final tag = BlockquoteTag.fromXml(getRootXmlElement(blockquoteXml));

        test('Returns expected JSON', () {
          expect(tag.toJson(), equals(json));
        });

        test('Returns expected string', () {
          expect(tag.toString(), equals(json.toString()));
        });
      });
    }

    blockquotes.forEach((type, data) {
      testListType(type, data['xml']!.toString(), data['json']!);
    });
  });
}
