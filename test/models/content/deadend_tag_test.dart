import 'package:lonewolf_new/models/content/deadend_tag.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('Model - DeadendTag():', () {
    const xml = '<deadend>Your life and your mission end here.</deadend>';
    final tag = DeadendTag.fromXml(getRootXmlElement(xml));
    final expected = {
      "text": "Your life and your mission end here.",
    };

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(expected));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(expected.toString()));
    });
  });
}
