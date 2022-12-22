import 'package:lonewolf_new/models/book/content/section_tag.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';
import '../section/data_test.dart';
import '../section/footnote_test.dart';
import '../section/section_meta_test.dart';

const sectionText = 'To Mel and Yin';
const sectionType = 'frontmatter';
const sectionXml = '''<section class="$sectionType" id="$footnoteSectionId">
  $sectionMetaXml
  <footnotes>
    $footnoteXml
  </footnotes>
  $dataXml
</section>''';
final sectionJson = {
  "data": dataJson,
  "footnotes": [footnoteJson],
  "id": footnoteSectionId,
  "meta": sectionMetaJson,
  "type": sectionType
};

void main() {
  group('Model - Section():', () {
    final tag = SectionTag.fromXml(getRootXmlElement(sectionXml));

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(sectionJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(sectionJson.toString()));
    });

    group('Public Methods:', () {
      const String frontmatter = 'frontmatter';
      const String frontmatterSep = 'frontmatter-separate';
      const String backmatter = 'backmatter';
      const String numbered = 'numbered';

      String getSectionXml(String type, String id) {
        return '''
          <section class="$type" id="$id">
            $sectionMetaXml
            <footnotes>
              $footnoteXml
            </footnotes>
            $dataXml
          </section>
        ''';
      }

      final frontmatterSecXml = getSectionXml(frontmatter, 'kaiwisdm');
      final frontmatterSepSecXml = getSectionXml(frontmatterSep, 'cmbtrulz');
      final backmatterSecXml = getSectionXml(backmatter, 'action');
      final numberedSecXml = getSectionXml(numbered, 'sect141');

      group('isNumbered():', () {
        isNumberedTest(data) {
          test('Returns ${data['result']} for a ${data['type']} section', () {
            final tag = SectionTag.fromXml(getRootXmlElement(data['xml']));
            expect(tag.isNumbered(), equals(data['result']));
          });
        }

        [
          {"result": true, "type": numbered, "xml": numberedSecXml},
          {"result": false, "type": frontmatter, "xml": frontmatterSecXml},
          {"result": false, "type": frontmatterSep, "xml": frontmatterSepSecXml},
          {"result": false, "type": backmatter, "xml": backmatterSecXml},
        ].forEach(isNumberedTest);
      });

      group('isFrontmatterSeperate():', () {
        isFrontmatterSeperateTest(data) {
          test('Returns ${data['result']} for a ${data['type']}section', () {
            final tag = SectionTag.fromXml(getRootXmlElement(data['xml']));
            expect(tag.isFrontmatterSeperate(), equals(data['result']));
          });
        }

        [
          {"result": false, "type": numbered, "xml": numberedSecXml},
          {"result": false, "type": frontmatter, "xml": frontmatterSecXml},
          {"result": true, "type": frontmatterSep, "xml": frontmatterSepSecXml},
          {"result": false, "type": backmatter, "xml": backmatterSecXml},
        ].forEach(isFrontmatterSeperateTest);
      });

      group('isFrontmatter():', () {
        isFrontmatterTest(data) {
          test('Returns ${data['result']} for a ${data['type']} section', () {
            final tag = SectionTag.fromXml(getRootXmlElement(data['xml']));
            expect(tag.isFrontmatter(), equals(data['result']));
          });
        }

        [
          {"result": false, "type": numbered, "xml": numberedSecXml},
          {"result": true, "type": frontmatter, "xml": frontmatterSecXml},
          {"result": false, "type": frontmatterSep, "xml": frontmatterSepSecXml},
          {"result": false, "type": backmatter, "xml": backmatterSecXml},
        ].forEach(isFrontmatterTest);
      });

      group('isBackmatter():', () {
        isBackmatterTest(data) {
          test('Returns ${data['result']} for a ${data['type']} section', () {
            final tag = SectionTag.fromXml(getRootXmlElement(data['xml']));
            expect(tag.isBackmatter(), equals(data['result']));
          });
        }

        [
          {"result": false, "type": numbered, "xml": numberedSecXml},
          {"result": false, "type": frontmatter, "xml": frontmatterSecXml},
          {"result": false, "type": frontmatterSep, "xml": frontmatterSepSecXml},
          {"result": true, "type": backmatter, "xml": backmatterSecXml},
        ].forEach(isBackmatterTest);
      });

      group('canAddToIndex():', () {
        canAddToIndexTest(data) {
          String labelSuffix = data['isSub'] == true ? 'that is a subsection' : 'that is NOT a subsection';

          test('Returns ${data['result']} for a ${data['type']} section $labelSuffix', () {
            final tag = SectionTag.fromXml(getRootXmlElement(data['xml']));
            expect(tag.canAddToIndex(data['isSub']), equals(data['result']));
          });
        }

        [
          {"result": false, "type": numbered, "xml": numberedSecXml, "isSub": false},
          {"result": true, "type": frontmatter, "xml": frontmatterSecXml, "isSub": false},
          {"result": false, "type": frontmatterSep, "xml": frontmatterSepSecXml, "isSub": false},
          {"result": true, "type": backmatter, "xml": backmatterSecXml, "isSub": false},
        ].forEach(canAddToIndexTest);

        [
          {"result": false, "type": numbered, "xml": numberedSecXml, "isSub": true},
          {"result": false, "type": frontmatter, "xml": frontmatterSecXml, "isSub": true},
          {"result": true, "type": frontmatterSep, "xml": frontmatterSepSecXml, "isSub": true},
          {"result": false, "type": backmatter, "xml": backmatterSecXml, "isSub": true},
        ].forEach(canAddToIndexTest);
      });
    });
  });
}
