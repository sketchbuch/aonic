import 'package:lonewolf_new/models/book/content/section_tag.dart';
import 'package:lonewolf_new/models/book/content/subcontent/toc_item.dart';
import 'package:test/test.dart';

import '../../../../helpers.dart';
import '../../section/footnote_test.dart';
import '../../section/section_meta_test.dart';
import '../section_test.dart';

const tocDepth = 2;

final tocJson = {
  'depth': tocDepth,
  'id': footnoteSectionId,
  'title': sectionMetaTitle,
};

void main() {
  group('Model - BookSectionItem()', () {
    final section = SectionTag.fromXml(getRootXmlElement(sectionXml));
    final tocSection = TocItem(section, tocDepth);

    test('Returns expected JSON', () {
      expect(tocSection.toJson(), equals(tocJson));
    });

    test('Returns expected string', () {
      expect(tocSection.toString(), equals(tocJson.toString()));
    });
  });
}
