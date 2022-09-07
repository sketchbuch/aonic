import 'package:lonewolf_new/models/book/content/subcontent/list_item.dart';
import 'package:test/test.dart';

import '../../../../helpers.dart';

const listItemXml = '<li>Illustration I (<a idref="sect7">Section 7</a>)</li>';
const listItemJson = {
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
    final tag = ListItem.fromXml(getRootXmlElement(listItemXml));

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(listItemJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(listItemJson.toString()));
    });
  });
}
