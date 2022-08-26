import 'package:lonewolf_new/models/content/subcontent/list_item.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';

void main() {
  group('Model - ListItem()', () {
    const xml = '<li>Illustration I (<a idref="sect7">Section 7</a>)</li>';
    final tag = ListItem.fromXml(getRootXmlElement(xml));
    final expected = {
      'texts': [
        {'attrs': {}, 'displayType': 'plain', 'text': 'Illustration I ('},
        {
          'attrs': {'idref': 'sect7'},
          'displayType': 'link',
          'text': 'Section 7'
        },
        {'attrs': {}, 'displayType': 'plain', 'text': ')'}
      ]
    };

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(expected));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(expected.toString()));
    });
  });
}
