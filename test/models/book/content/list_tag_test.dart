import 'package:lonewolf_new/models/book/content/list_tag.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';
import 'subcontent/list_item_test.dart';

const listXml = '''<ul class="unbulleted">
  $listItemXml
  <li>Illustration II (<a idref="sect23">Section 23</a>)</li>
  <li><a idref="equipmnt">Equipment</a></li>
  <li><a idref="discplnz">Kai Disciplines</a></li>
</ul>''';
final listExpected = {
  "items": [
    listItemExpected,
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

void main() {
  group('Model - ListTag():', () {
    final tag = ListTag.fromXml(getRootXmlElement(listXml));

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(listExpected));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(listExpected.toString()));
    });
  });
}
