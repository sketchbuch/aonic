import 'package:lonewolf_new/models/book/meta/right.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';

void main() {
  group('Model - Right()', () {
    const type = 'licenseNotification';

    const xml = '''<rights class="$type">
    <p>
      <line>Text copyright <ch.copy/> 1984 Joe Dever.</line>
      <line>Illustrations copyright <ch.copy/> 1984 Gary Chalk.</line>
      <line>Distribution of this Internet Edition is restricted under the terms of the <a idref="license">Project Aon License</a>.</line>
    </p>
    </rights>''';
    final tag = Right.fromXml(getRootXmlElement(xml));

    final expected = {
      'text':
          'Text copyright © 1984 Joe Dever.Illustrations copyright © 1984 Gary Chalk.Distribution of this Internet Edition is restricted under the terms of the Project Aon License.',
      'type': type,
    };

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(expected));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(expected.toString()));
    });
  });
}
