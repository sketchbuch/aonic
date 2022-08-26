import 'package:lonewolf_new/models/content/choice_tag.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('Model - ChoiceTag():', () {
    const xml =
        '<choice idref="sect213">If you would rather press on, <link-text class="attr-test">turn to 213</link-text>.</choice>';
    final tag = ChoiceTag.fromXml(getRootXmlElement(xml));
    final expected = {
      "idref": "sect213",
      "linkTextIndex": 1,
      "texts": [
        {
          "attrs": {},
          "displayType": "plain",
          "text": "If you would rather press on, ",
        },
        {
          "attrs": {"class": "attr-test"},
          "displayType": "link",
          "text": "turn to 213",
        },
        {
          "attrs": {},
          "displayType": "plain",
          "text": ".",
        },
      ],
    };

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(expected));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(expected.toString()));
    });
  });
}
