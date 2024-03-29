import 'package:aonic/models/book/meta/description.dart' as model;
import 'package:test/test.dart';

import '../../../helpers.dart';

const descriptionType = 'publication';
const descriptionXml = '''<description class="$descriptionType">
  <p>You are Lone Wolf. In a devastating attack the Darklords have destroyed the monastery where you were learning the skills of the Kai Lords. You are the sole survivor.</p>
  <p>In <strong><cite>Flight from the Dark</cite></strong>, you swear revenge. But first you must reach Holmgard to warn the King of the gathering evil. Relentlessly the servants of darkness hunt you across your country and every turn of the page presents a new challenge. Choose your skills and your weapons carefully<ch.emdash/>for they can help you succeed in the most fantastic and terrifying journey of your life.</p>
</description>''';
const descriptionjson = {
  "paragraphs": [
    {
      "texts": [
        {
          "attrs": {},
          "displayType": "plain",
          "parentType": "none",
          "subelements": [],
          "text":
              "You are Lone Wolf. In a devastating attack the Darklords have destroyed the monastery where you were learning the skills of the Kai Lords. You are the sole survivor.",
        }
      ]
    },
    {
      "texts": [
        {
          "attrs": {},
          "displayType": "plain",
          "parentType": "none",
          "subelements": [],
          "text": "In ",
        },
        {
          "attrs": {},
          "displayType": "bold",
          "parentType": "none",
          "subelements": [
            {
              "attrs": {},
              "displayType": "cite",
              "parentType": "bold",
              "subelements": [],
              "text": "Flight from the Dark",
            },
          ],
          "text": "",
        },
        {
          "attrs": {},
          "displayType": "plain",
          "parentType": "none",
          "subelements": [],
          "text":
              ", you swear revenge. But first you must reach Holmgard to warn the King of the gathering evil. Relentlessly the servants of darkness hunt you across your country and every turn of the page presents a new challenge. Choose your skills and your weapons carefully—for they can help you succeed in the most fantastic and terrifying journey of your life.",
        }
      ]
    }
  ],
  "type": "publication"
};

void main() {
  group('Model - Description()', () {
    final tag = model.Description.fromXml(getRootXmlElement(descriptionXml));

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(descriptionjson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(descriptionjson.toString()));
    });
  });
}
