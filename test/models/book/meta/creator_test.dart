import 'package:lonewolf_new/models/book/meta/creator.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';

const creatorSortText = 'Dever, Joe';
const creatorText = 'Joe Dever';
const creatorType = 'author';
const creatorXml = '<creator class="$creatorType" sort-name="$creatorSortText">$creatorText</creator>';
const creatorJson = {
  "text": creatorText,
  "type": creatorType,
  "sortText": creatorSortText,
};

void main() {
  group('Model - Creator()', () {
    final tag = Creator.fromXml(getRootXmlElement(creatorXml));

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(creatorJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(creatorJson.toString()));
    });
  });
}
