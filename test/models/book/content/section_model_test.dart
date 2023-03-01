import 'package:aonic/models/book/content/section_tag_model.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';
import 'blockquote_tag_model_test.dart';
import 'choice_tag_model_test.dart';
import '../section/data_model_test.dart';
import '../section/footnote_model_test.dart';
import '../section/section_meta_model_test.dart';

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

  String getSectionXmlWithSubsections(String type, String id) {
    return '''
          <section class="$type" id="$id">
            $sectionMetaXml
            <data>
              $blockquoteXml
              <section class="$frontmatter" id="$frontmatter-1">
                <meta><title>$frontmatter</title></meta>
                <data />
              </section>
              <section class="$frontmatterSep" id="$frontmatterSep-1">
                <meta><title>$frontmatterSep</title></meta>
                <data />
              </section>
              <section class="$backmatter" id="$backmatter-1">
                <meta><title>$backmatter</title></meta>
                <data />
              </section>
              <section class="$numbered" id="sect1">
                <meta><title>$numbered</title></meta>
                <data />
              </section>
              $choiceXml
            </data>
          </section>
        ''';
  }

  final frontmatterSecXml = getSectionXml(frontmatter, 'kaiwisdm');
  final frontmatterSepSecXml = getSectionXml(frontmatterSep, 'cmbtrulz');
  final backmatterSecXml = getSectionXml(backmatter, 'action');
  final numberedSecXml = getSectionXml(numbered, 'sect141');

  group('Model - SectionModel()', () {
    test('Returns expected JSON', () {
      final tag = SectionTagModel.fromXml(getRootXmlElement(sectionXml));
      expect(tag.toJson(), equals(sectionJson));
    });

    test('Returns expected string', () {
      final tag = SectionTagModel.fromXml(getRootXmlElement(sectionXml));
      expect(tag.toString(), equals(sectionJson.toString()));
    });

    test('Returns expected tagType', () {
      final tag = SectionTagModel.fromXml(getRootXmlElement(sectionXml));
      expect(tag.tagType(), equals('SectionTag'));
    });

    group('isNumbered()', () {
      isNumberedTest(data) {
        test('Returns ${data['result']} for a ${data['type']} section', () {
          final tag = SectionTagModel.fromXml(getRootXmlElement(data['xml']));
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

    group('isFrontmatterSeperate()', () {
      isFrontmatterSeperateTest(data) {
        test('Returns ${data['result']} for a ${data['type']}section', () {
          final tag = SectionTagModel.fromXml(getRootXmlElement(data['xml']));
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

    group('isFrontmatter()', () {
      isFrontmatterTest(data) {
        test('Returns ${data['result']} for a ${data['type']} section', () {
          final tag = SectionTagModel.fromXml(getRootXmlElement(data['xml']));
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

    group('isBackmatter()', () {
      isBackmatterTest(data) {
        test('Returns ${data['result']} for a ${data['type']} section', () {
          final tag = SectionTagModel.fromXml(getRootXmlElement(data['xml']));
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

    group('canAddToIndex()', () {
      canAddToIndexTest(data) {
        String labelSuffix = data['isSub'] == true
            ? 'that is a subsection'
            : 'that is NOT a subsection';

        test(
            'Returns ${data['result']} for a ${data['type']} section $labelSuffix',
            () {
          final tag = SectionTagModel.fromXml(getRootXmlElement(data['xml']));
          expect(tag.canAddToIndex(data['isSub']), equals(data['result']));
        });
      }

      [
        {
          "result": false,
          "type": numbered,
          "xml": numberedSecXml,
          "isSub": false
        },
        {
          "result": true,
          "type": frontmatter,
          "xml": frontmatterSecXml,
          "isSub": false
        },
        {
          "result": false,
          "type": frontmatterSep,
          "xml": frontmatterSepSecXml,
          "isSub": false
        },
        {
          "result": true,
          "type": backmatter,
          "xml": backmatterSecXml,
          "isSub": false
        },
      ].forEach(canAddToIndexTest);

      [
        {
          "result": false,
          "type": numbered,
          "xml": numberedSecXml,
          "isSub": true
        },
        {
          "result": false,
          "type": frontmatter,
          "xml": frontmatterSecXml,
          "isSub": true
        },
        {
          "result": true,
          "type": frontmatterSep,
          "xml": frontmatterSepSecXml,
          "isSub": true
        },
        {
          "result": false,
          "type": backmatter,
          "xml": backmatterSecXml,
          "isSub": true
        },
      ].forEach(canAddToIndexTest);
    });

    group('hasSubsections()', () {
      final xml = getSectionXmlWithSubsections(numbered, 'sect141');

      test('Returns true for a section with subsections', () {
        final tag = SectionTagModel.fromXml(getRootXmlElement(xml));
        expect(tag.hasSubsections(), equals(true));
      });

      test('Returns false for a section without subsections', () {
        final tag =
            SectionTagModel.fromXml(getRootXmlElement(frontmatterSecXml));
        expect(tag.hasSubsections(), equals(false));
      });
    });

    group('getSubsections()', () {
      final xml = getSectionXmlWithSubsections(numbered, 'sect141');

      test('Returns an array of just the subsections from section data', () {
        final tag = SectionTagModel.fromXml(getRootXmlElement(xml));
        final subsections = tag.getSubsections();
        expect(subsections.length, equals(4));
      });
    });

    group('getVisibleSubsections()', () {
      final xml = getSectionXmlWithSubsections(numbered, 'sect141');

      test(
          'Returns an array of just the non-frontmatter-separate subsections from section data',
          () {
        final tag = SectionTagModel.fromXml(getRootXmlElement(xml));
        final subsections = tag.getVisibleSubsections();
        expect(subsections.length, equals(3));
      });
    });
  });
}
