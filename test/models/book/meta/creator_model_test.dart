import 'package:aonic/models/book/meta/creator_model.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';

const creatorSortText = 'Dever, Joe';
const creatorText = 'Joe Dever';
const creatorType = 'author';
const creatorXml =
    '<creator class="$creatorType" sort-name="$creatorSortText">$creatorText</creator>';
const creatorJson = {
  "text": creatorText,
  "type": creatorType,
  "sortText": creatorSortText,
};

void main() {
  group('Model - CreatorModel()', () {
    final tag = CreatorModel.fromXml(getRootXmlElement(creatorXml));

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(creatorJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(creatorJson.toString()));
    });
  });
}
