import 'package:lonewolf_new/models/book/book.dart';
import 'package:test/test.dart';

import '../../helpers.dart';
import 'meta_test.dart';
import 'section_test.dart';

const lang = 'en-UK';
const title = 'Flight from the Dark';
const version = '0.12';
const bookXml = '''<gamebook xml:lang="$lang" version="$version">
  $metaXml
  $sectionXml
</gamebook>''';
final bookJson = {
  "backmatter": [],
  "frontmatter": [sectionJson],
  "lang": lang,
  "meta": metaJson,
  "numbered": [],
  "title": title,
  "version": version
};

void main() {
  group('Model - Book()', () {
    final tag = Book.fromXml(getRootXmlElement(bookXml));

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(bookJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(bookJson.toString()));
    });
  });
}
