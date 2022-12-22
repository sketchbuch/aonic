import 'package:lonewolf_new/models/book/meta/meta.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';
import 'creator_test.dart';
import 'description_test.dart';
import 'right_test.dart';

const metaPublisher = 'Project Aon';
const metaTitle = 'Flight from the Dark';
const metaDay = '15';
const metaMonth = '02';
const metaYear = '2018';
const metaXml = '''<meta>
  <title>$metaTitle</title>
  $creatorXml
  <publisher>$metaPublisher</publisher>
  <date class="publication"><year>$metaYear</year><month>$metaMonth</month><day>$metaDay</day></date>
  $descriptionXml
  $rightXml
</meta>''';
const metaJson = {
  "creators": [creatorJson],
  "descriptions": [descriptionjson],
  "publicationDate": "$metaDay-$metaMonth-$metaYear",
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
