import 'package:lonewolf_new/models/book/content/paragraph_tag.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';

const paragraphXml =
    '<p>Each Meal of Laumspur may be consumed when prompted for a Meal, in which case it fulfils the Meal requirement in addition to restoring 3 <typ class="attribute">ENDURANCE</typ> points. Laumspur may also be consumed at any other time to restore <typ class="attribute">ENDURANCE</typ> without having any significance as a Meal.</p>';
final paragraphJson = {
  "texts": [
    {
      "attrs": {},
      "displayType": "plain",
      "text":
          "Each Meal of Laumspur may be consumed when prompted for a Meal, in which case it fulfils the Meal requirement in addition to restoring 3 "
    },
    {
      "attrs": {"class": "attribute"},
      "displayType": "typ",
      "text": "ENDURANCE"
    },
    {
      "attrs": {},
      "displayType": "plain",
      "text": " points. Laumspur may also be consumed at any other time to restore "
    },
    {
      "attrs": {"class": "attribute"},
      "displayType": "typ",
      "text": "ENDURANCE"
    },
    {"attrs": {}, "displayType": "plain", "text": " without having any significance as a Meal."}
  ]
};

void main() {
  group('Model - ParagraphTag():', () {
    final tag = ParagraphTag.fromXml(getRootXmlElement(paragraphXml));

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(paragraphJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(paragraphJson.toString()));
    });
  });
}
