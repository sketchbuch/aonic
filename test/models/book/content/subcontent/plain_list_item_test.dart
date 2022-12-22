import 'package:lonewolf_new/models/book/content/section_tag.dart';
import 'package:lonewolf_new/models/book/content/subcontent/plain_list_item.dart';
import 'package:lonewolf_new/models/book/toc/toc_index_section.dart';
import 'package:test/test.dart';

import '../../../../helpers.dart';

const plainListItemXml = '<li>Illustration I (<a idref="sect7">Section 7</a>)</li>';
const plainListItemJson = {
  "depth": 1,
  "texts": [
    {"attrs": {}, "displayType": "plain", "text": "Illustration I ("},
    {
      "attrs": {"idref": "sect7"},
      "displayType": "link",
      "text": "Section 7"
    },
    {"attrs": {}, "displayType": "plain", "text": ")"}
  ]
};

const plainListSectionMetaTitle = 'Dedication';
const plainListSectionMetaXml = '''<meta>
  <title>$plainListSectionMetaTitle</title>
</meta>''';

const plainListSectionId = 'dedicate';
const plainListSectionText = 'To Mel and Yin';
const plainListSectionType = 'frontmatter';
const plainListSectionXml = '''<section class="$plainListSectionType" id="$plainListSectionId">
  $plainListSectionMetaXml
  <data>
    <ul>
      $plainListItemXml
    </ul>
  </data>
</section>''';
final plainListSectionJson = {
  "depth": 1,
  "texts": [
    {
      "attrs": {"idref": "dedicate"},
      "displayType": "link",
      "text": "Dedication"
    }
  ]
};

void main() {
  group('Model - PlainListItem.fromXml()', () {
    final tag = PlainListItem.fromXml(getRootXmlElement(plainListItemXml), 1);

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(plainListItemJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(plainListItemJson.toString()));
    });
  });

  group('Model - PlainListItem.fromTocIndexSection()', () {
    final section = SectionTag.fromXml(getRootXmlElement(plainListSectionXml));
    final tocSection = TocIndexSection(section, 1);
    final tag = PlainListItem.fromTocIndexSection(tocSection);

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(plainListSectionJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(plainListSectionJson.toString()));
    });
  });
}
