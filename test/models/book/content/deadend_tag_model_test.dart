import 'package:aonic/models/book/content/deadend_tag_model.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';

const deadendXml = '<deadend>Your life and your mission end here.</deadend>';
const deadendJson = {
  "text": "Your life and your mission end here.",
};

void main() {
  group('Model - DeadendTagModel()', () {
    final tag = DeadendTagModel.fromXml(getRootXmlElement(deadendXml));

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(deadendJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(deadendJson.toString()));
    });

    test('Returns expected tagType', () {
      expect(tag.tagType(), equals('DeadendTagModel'));
    });
  });
}
