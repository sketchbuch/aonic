import 'package:aonic/models/book/content/choice_tag_model.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';

const choiceXml =
    '<choice idref="sect213">If you would rather press on, <link-text class="attr-test">turn to 213</link-text>.</choice>';
const choiceJson = {
  "idref": "sect213",
  "linkTextIndex": 1,
  "texts": [
    {
      "attrs": {},
      "displayType": "plain",
      "parentType": "none",
      "subelements": [],
      "text": "If you would rather press on, ",
    },
    {
      "attrs": {"class": "attr-test"},
      "displayType": "link",
      "parentType": "none",
      "subelements": [],
      "text": "turn to 213",
    },
    {
      "attrs": {},
      "displayType": "plain",
      "parentType": "none",
      "subelements": [],
      "text": ".",
    },
  ],
};

void main() {
  group('Model - ChoiceTagModel()', () {
    final tag = ChoiceTagModel.fromXml(getRootXmlElement(choiceXml));

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(choiceJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(choiceJson.toString()));
    });

    test('Returns expected tagType', () {
      expect(tag.tagType(), equals('ChoiceTag'));
    });
  });
}
