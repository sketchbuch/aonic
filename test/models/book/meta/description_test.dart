import 'package:lonewolf_new/models/book/meta/description.dart' as model;
import 'package:test/test.dart';

import '../../../helpers.dart';

void main() {
  group('Model - Description()', () {
    const type = 'publication';

    const xml = '''<description class="$type">
      <p>You are Lone Wolf. In a devastating attack the Darklords have destroyed the monastery where you were learning the skills of the Kai Lords. You are the sole survivor.</p>
      <p>In <strong><cite>Flight from the Dark</cite></strong>, you swear revenge. But first you must reach Holmgard to warn the King of the gathering evil. Relentlessly the servants of darkness hunt you across your country and every turn of the page presents a new challenge. Choose your skills and your weapons carefully<ch.emdash/>for they can help you succeed in the most fantastic and terrifying journey of your life.</p>
    </description>''';
    final tag = model.Description.fromXml(getRootXmlElement(xml));

    final expected = {
      "texts": [
        [
          {
            "attrs": {},
            "displayType": "plain",
            "text":
                "You are Lone Wolf. In a devastating attack the Darklords have destroyed the monastery where you were learning the skills of the Kai Lords. You are the sole survivor."
          }
        ],
        [
          {"attrs": {}, "displayType": "plain", "text": "In "},
          {"attrs": {}, "displayType": "bold", "text": "Flight from the Dark"},
          {
            "attrs": {},
            "displayType": "plain",
            "text":
                ", you swear revenge. But first you must reach Holmgard to warn the King of the gathering evil. Relentlessly the servants of darkness hunt you across your country and every turn of the page presents a new challenge. Choose your skills and your weapons carefully—for they can help you succeed in the most fantastic and terrifying journey of your life."
          }
        ]
      ],
      "type": type,
    };

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(expected));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(expected.toString()));
    });
  });
}
