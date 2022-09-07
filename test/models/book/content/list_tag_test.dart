import 'package:lonewolf_new/models/book/content/list_tag.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';
import '../../../types.dart';
import 'subcontent/list_item_test.dart';

const listUlXml = '''<ul class="unbulleted">
  $listItemXml
  <li>Illustration II (<a idref="sect23">Section 23</a>)</li>
  <li><a idref="equipmnt">Equipment</a></li>
  <li><a idref="discplnz">Kai Disciplines</a></li>
</ul>''';
final listUlJson = {
  "items": [
    listItemJson,
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
  "listType": "ul",
  "type": "unbulleted",
};

const lisOlXml = '''<ol class="unbulleted">$listItemXml</ol>''';
final listOlJson = {
  "items": [
    listItemJson,
  ],
  "listType": "ol",
  "type": "unbulleted",
};

void main() {
  group('Model - ListTag():', () {
    final TestIterationData lists = {
      "ul": {"xml": listUlXml, "json": listUlJson},
      "ol": {"xml": lisOlXml, "json": listOlJson},
    };

    void testListType(String type, String xml, Object json) {
      group('$type:', () {
        final tag = ListTag.fromXml(getRootXmlElement(xml));

        test('Returns expected JSON', () {
          expect(tag.toJson(), equals(json));
        });

        test('Returns expected string', () {
          expect(tag.toString(), equals(json.toString()));
        });
      });
    }

    lists.forEach((type, data) {
      testListType(type, data['xml']!.toString(), data['json']!);
    });
  });
}
