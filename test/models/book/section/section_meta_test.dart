import 'package:aonic/models/book/section/section_meta.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';
import 'meta_link_test.dart';

const sectionMetaTitle = 'Dedication';
const sectionMetaIdRef2 = 'acknwldg';
const sectionMetaType2 = 'next';
const sectionMetaXml = '''<meta>
  <title>$sectionMetaTitle</title>
  $metaLinkXml
  <link class="$sectionMetaType2" idref="$sectionMetaIdRef2" />
</meta>''';
final sectionMetaJson = {
  "links": [
    metaLinkJson,
    {
      "idRef": sectionMetaIdRef2,
      "type": sectionMetaType2,
    },
  ],
  "title": sectionMetaTitle,
};

void main() {
  group('Model - SectionMeta()', () {
    final tag = SectionMeta.fromXml(getRootXmlElement(sectionMetaXml));

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(sectionMetaJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(sectionMetaJson.toString()));
    });
  });
}
