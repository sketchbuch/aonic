import 'package:lonewolf_new/models/book/book.dart';
import 'package:test/test.dart';

import '../../helpers.dart';
import 'meta/meta_test.dart';
import 'section/section_test.dart';

const lang = 'en-UK';
const titlePage = 'Title Page';
const numberedPage = 'Numbered Sections';
const title = 'Flight from the Dark';
const version = '0.12';
const bookXml = '''<gamebook xml:lang="$lang" version="$version">
  $metaXml
  <section id="title">
    <meta>
    <title>$titlePage</title>
    <link class="next" idref="dedicate" />
    </meta>
  
    <data>
      $sectionXml
      <section class="numbered" id="numbered">
        <meta><title>$numberedPage</title></meta>

        <data>
        </data>
      </section>
    </data>
  </section>
</gamebook>''';
final bookJson = {
  "backmatter": [],
  "frontmatter": [sectionJson],
  "lang": lang,
  "meta": metaJson,
  "numbered": [],
  "numberedPageTitle": numberedPage,
  "title": title,
  "titlePageTitle": titlePage,
  "version": version,
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
