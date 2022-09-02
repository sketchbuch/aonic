import 'package:lonewolf_new/models/book/meta/right.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';

void main() {
  group('Model - Right()', () {
    const xml = '''<rights class="licenseNotification">
    <p>
      <line>Text copyright <ch.copy/> 1984 Joe Dever.</line>
      <line>Illustrations copyright <ch.copy/> 1984 Gary Chalk.</line>
      <line>Distribution of this Internet Edition is restricted under the terms of the <a idref="license">Project Aon License</a>.</line>
    </p>
    </rights>''';
    final tag = Right.fromXml(getRootXmlElement(xml));

    final expected = {
      "texts": [
        [
          {"attrs": {}, "displayType": "plain", "text": "Text copyright © 1984 Joe Dever."}
        ],
        [
          {"attrs": {}, "displayType": "plain", "text": "Illustrations copyright © 1984 Gary Chalk."}
        ],
        [
          {
            "attrs": {},
            "displayType": "plain",
            "text": "Distribution of this Internet Edition is restricted under the terms of the "
          },
          {
            "attrs": {"idref": "license"},
            "displayType": "link",
            "text": "Project Aon License"
          },
          {"attrs": {}, "displayType": "plain", "text": "."}
        ]
      ],
      "type": 'license-notification',
    };

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(expected));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(expected.toString()));
    });
  });
}
