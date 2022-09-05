import 'package:lonewolf_new/models/book/content/choice_tag.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';

const choiceXml =
    '<choice idref="sect213">If you would rather press on, <link-text class="attr-test">turn to 213</link-text>.</choice>';
const choiceExpected = {
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

void main() {
  group('Model - ChoiceTag():', () {
    final tag = ChoiceTag.fromXml(getRootXmlElement(choiceXml));

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(choiceExpected));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(choiceExpected.toString()));
    });
  });
}
