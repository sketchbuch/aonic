import 'package:lonewolf_new/models/book/meta.dart';
import 'package:test/test.dart';

import '../../helpers.dart';
import 'meta/creator_test.dart';
import 'meta/description_test.dart';
import 'meta/right_test.dart';

const metaPublisher = 'Project Aon';
const metaTitle = 'Flight from the Dark';
const metaXml = '''<meta>
  <title>$metaTitle</title>
  $creatorXml
  <publisher>$metaPublisher</publisher>
  <date class="publication"><year>2018</year><month>2</month><day>15</day></date>
  $descriptionXml
  $rightXml
</meta>''';
const metaJson = {
  "creators": [creatorJson],
  "descriptions": [descriptionjson],
  "publicationDate": "15-02-2018",
  "publisher": metaPublisher,
  "rights": [rightJson],
  "title": metaTitle
};

void main() {
  group('Model - Meta()', () {
    final tag = Meta.fromXml(getRootXmlElement(metaXml));

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(metaJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(metaJson.toString()));
    });
  });
}
