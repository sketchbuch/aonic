import 'package:lonewolf_new/models/book/book.dart';
import 'package:lonewolf_new/models/book/section/meta_link.dart';
import 'package:test/test.dart';

import '../../helpers.dart';
import 'content/section_test.dart';
import 'meta/meta_test.dart';

const lang = 'en-UK';
const titlePageId = 'title';
const titlePageMetaId = 'dedicate';
final titlePageMetaType = MetaLinkType.next.name;
const titlePageTitle = 'Title Page';
const numberedPageId = 'numbered';
const numberedPageTitle = 'Numbered Sections';
const title = 'Flight from the Dark';
const version = '0.12';

final titleSectionJson = {
  "data": {"content": []},
  "footnotes": [],
  "id": titlePageId,
  "meta": {
    'links': [
      {
        'idRef': titlePageMetaId,
        'type': titlePageMetaType,
      }
    ],
    'title': titlePageTitle,
  },
  "subsections": [],
  "type": sectionType
};

final numberedSectionJson = {
  "data": {"content": []},
  "footnotes": [],
  "id": numberedPageId,
  "meta": {
    'links': [],
    'title': numberedPageTitle,
  },
  "subsections": [],
  "type": sectionType
};

final bookXml = '''<gamebook xml:lang="$lang" version="$version">
  $metaXml
  <section id="$titlePageId">
    <meta>
      <title>$titlePageTitle</title>
      <link class="$titlePageMetaType" idref="$titlePageMetaId" />
    </meta>
  
    <data>
      $sectionXml
      <section class="numbered" id="$numberedPageId">
        <meta><title>$numberedPageTitle</title></meta>

        <data>
        </data>
      </section>
    </data>
  </section>
</gamebook>''';
final bookJson = {
  "lang": lang,
  "meta": metaJson,
  "sections": [titleSectionJson, sectionJson, numberedSectionJson],
  "title": title,
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
