import 'package:lonewolf_new/models/book/content/subcontent/plain_list_item.dart';
import 'package:test/test.dart';

import '../../../../helpers.dart';

const plainListItemXml = '<li>Illustration I (<a idref="sect7">Section 7</a>)</li>';
const plainListItemJson = {
  "texts": [
    {"attrs": {}, "displayType": "plain", "text": "Illustration I ("},
    {
      "attrs": {"idref": "sect7"},
      "displayType": "link",
      "text": "Section 7"
    },
    {"attrs": {}, "displayType": "plain", "text": ")"}
  ]
};

void main() {
  group('Model - ListItem()', () {
    final tag = PlainListItem.fromXml(getRootXmlElement(plainListItemXml), 1);

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(plainListItemJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(plainListItemJson.toString()));
    });
  });
}
