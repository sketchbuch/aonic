import 'package:aonic/models/book/content/deadend_tag.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';

const deadendXml = '<deadend>Your life and your mission end here.</deadend>';
const deadendJson = {
  "text": "Your life and your mission end here.",
};

void main() {
  group('Model - DeadendTag()', () {
    final tag = DeadendTag.fromXml(getRootXmlElement(deadendXml));

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(deadendJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(deadendJson.toString()));
    });

    test('Returns expected tagType', () {
      expect(tag.tagType(), equals('DeadendTag'));
    });
  });
}
