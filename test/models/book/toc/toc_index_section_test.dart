import 'package:lonewolf_new/models/book/content/section_tag.dart';
import 'package:lonewolf_new/models/book/toc/toc_index_section.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';
import '../content/section_test.dart';

const tocDepth = 2;

final tocJson = {
  "depth": tocDepth,
  "section": sectionJson,
};

void main() {
  group('Model - TocIndexSections()', () {
    final section = SectionTag.fromXml(getRootXmlElement(sectionXml));
    final tocSection = TocIndexSection(section, tocDepth);

    test('Returns expected JSON', () {
      expect(tocSection.toJson(), equals(tocJson));
    });

    test('Returns expected string', () {
      expect(tocSection.toString(), equals(tocJson.toString()));
    });
  });
}
