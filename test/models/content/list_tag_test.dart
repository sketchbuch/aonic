import 'package:lonewolf_new/models/content/list_tag.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('Model - ListTag():', () {
    const xml = '''<ul class="unbulleted">
      <li>Illustration I (<a idref="sect7">Section 7</a>)</li>
      <li>Illustration II (<a idref="sect23">Section 23</a>)</li>
      <li><a idref="equipmnt">Equipment</a></li>
      <li><a idref="discplnz">Kai Disciplines</a></li>
    </ul>''';
    final tag = ListTag.fromXml(getRootXmlElement(xml));
    final expected = {
      "items": [
        {
          "texts": [
            {"attrs": {}, "displayType": "plain", "text": "Illustration I ("},
            {
              "attrs": {"idref": "sect7"},
              "displayType": "link",
              "text": "Section 7"
            },
            {"attrs": {}, "displayType": "plain", "text": ")"}
          ]
        },
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

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(expected));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(expected.toString()));
    });
  });
}
