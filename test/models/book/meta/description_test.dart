import 'package:lonewolf_new/models/book/meta/description.dart' as model;
import 'package:test/test.dart';

import '../../../helpers.dart';

void main() {
  group('Model - Description()', () {
    const text =
        'Internet Edition published by Project Aon. This edition is intended to reflect the complete text of the original version. Where we have made minor corrections, they will be noted in the Errata.';
    const type = 'publication';

    const xml =
        '<description class="$type"><p>Internet Edition published by <a href="&link.project.website;">Project Aon</a>. This edition is intended to reflect the complete text of the original version. Where we have made minor corrections, they will be noted in the <a idref="errata">Errata</a>.</p></description>';
    final tag = model.Description.fromXml(getRootXmlElement(xml));

    final expected = {
      "text": text,
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
