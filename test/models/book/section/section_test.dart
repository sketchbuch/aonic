import 'package:lonewolf_new/models/book/section/section.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';
import 'data_test.dart';
import 'footnote_test.dart';
import 'section_meta_test.dart';

const sectionId = 'dedicate';
const sectionText = 'To Mel and Yin';
const sectionType = 'frontmatter';
const sectionXml = '''<section class="$sectionType" id="$sectionId">
  $sectionMetaXml
  <footnotes>
    $footnoteXml
  </footnotes>
  $dataXml
</section>''';
final sectionJson = {
  "data": dataJson,
  "footnotes": [footnoteJson],
  "id": sectionId,
  "meta": sectionMetaJson,
  "sections": [],
  "type": sectionType
};

void main() {
  group('Model - Section()', () {
    final tag = Section.fromXml(getRootXmlElement(sectionXml));

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(sectionJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(sectionJson.toString()));
    });
  });
}
