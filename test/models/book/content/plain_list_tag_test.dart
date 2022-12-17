import 'package:lonewolf_new/models/book/content/plain_list_tag.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';
import '../../../types.dart';
import 'subcontent/plain_list_item_test.dart';

const plainListUlXml = '''<ul class="unbulleted">
  $plainListItemXml
  <li>Illustration II (<a idref="sect23">Section 23</a>)</li>
  <li><a idref="equipmnt">Equipment</a></li>
  <li><a idref="discplnz">Kai Disciplines</a></li>
</ul>''';
final plainListUlJson = {
  "items": [
    plainListItemJson,
    {
      "texts": [
        {"attrs": {}, "displayType": "plain", "text": "Illustration II ("},
        {
          "attrs": {"idref": "sect23"},
          "displayType": "link",
          "text": "Section 23"
        },
        {"attrs": {}, "displayType": "plain", "text": ")"}
      ]
    },
    {
      "texts": [
        {
          "attrs": {"idref": "equipmnt"},
          "displayType": "link",
          "text": "Equipment"
        }
      ]
    },
    {
      "texts": [
        {
          "attrs": {"idref": "discplnz"},
          "displayType": "link",
          "text": "Kai Disciplines"
        }
      ]
    }
  ],
  "plainListType": "ul",
  "type": "unbulleted",
};

const plainListOlXml = '''<ol class="unbulleted">$plainListItemXml</ol>''';
final plainListOlJson = {
  "items": [
    plainListItemJson,
  ],
  "plainListType": "ol",
  "type": "unbulleted",
};

void main() {
  group('Model - ListTag():', () {
    final TestIterationData plainLists = {
      "ul": {"xml": plainListUlXml, "json": plainListUlJson},
      "ol": {"xml": plainListOlXml, "json": plainListOlJson},
    };

    void testListType(String type, String xml, Object json) {
      group('$type:', () {
        final tag = PlainListTag.fromXml(getRootXmlElement(xml));

        test('Returns expected JSON', () {
          expect(tag.toJson(), equals(json));
        });

        test('Returns expected string', () {
          expect(tag.toString(), equals(json.toString()));
        });
      });
    }

    plainLists.forEach((type, data) {
      testListType(type, data['xml']!.toString(), data['json']!);
    });
  });
}
