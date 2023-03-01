import 'package:aonic/models/book/content/section_tag_model.dart';
import 'package:aonic/models/book/content/subcontent/toc_item_model.dart';
import 'package:test/test.dart';

import '../../../../helpers.dart';
import '../../section/footnote_model_test.dart';
import '../../section/section_meta_model_test.dart';
import '../section_model_test.dart';

const tocDepth = 2;

final tocJson = {
  'depth': tocDepth,
  'id': footnoteSectionId,
  'title': sectionMetaTitle,
};

void main() {
  group('Model - BookSectionItemModel()', () {
    final section = SectionTagModel.fromXml(getRootXmlElement(sectionXml));
    final tocSection = TocItemModel(section, tocDepth);

    test('Returns expected JSON', () {
      expect(tocSection.toJson(), equals(tocJson));
    });

    test('Returns expected string', () {
      expect(tocSection.toString(), equals(tocJson.toString()));
    });
  });
}
