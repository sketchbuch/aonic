import 'package:lonewolf_new/models/book/content/plain_list_tag.dart';
import 'package:lonewolf_new/models/book/content/section_tag.dart';
import 'package:lonewolf_new/models/book/content/subcontent/toc_item.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';
import '../../../types.dart';
import 'subcontent/plain_list_item_test.dart';

const plainListUlXml = '''<ul class="unbulleted">
  $plainListItemXml
  <li>Illustration II (<a idref="sect23">Section 23</a>)</li>
  <li><a idref="equipmnt">Equipment</a></li>
  <li><a idref="discplnz">Kai Disciplines</a></li>
</ul>''';
final plainListUlJson = {
  "items": [
    plainListItemJson,
    {
      "depth": 1,
      "texts": [
        {
          "attrs": {},
          "displayType": "plain",
          "parentType": "none",
          "subelements": [],
          "text": "Illustration II (",
        },
        {
          "attrs": {"idref": "sect23"},
          "displayType": "link",
          "parentType": "none",
          "subelements": [],
          "text": "Section 23"
        },
        {
          "attrs": {},
          "displayType": "plain",
          "parentType": "none",
          "subelements": [],
          "text": ")",
        }
      ]
    },
    {
      "depth": 1,
      "texts": [
        {
          "attrs": {"idref": "equipmnt"},
          "displayType": "link",
          "parentType": "none",
          "subelements": [],
          "text": "Equipment",
        }
      ]
    },
    {
      "depth": 1,
      "texts": [
        {
          "attrs": {"idref": "discplnz"},
          "displayType": "link",
          "parentType": "none",
          "subelements": [],
          "text": "Kai Disciplines",
        }
      ]
    }
  ],
  "listType": "ul",
  "type": "unbulleted",
};

const plainListOlXml = '''<ol class="unbulleted">$plainListItemXml</ol>''';
final plainListOlJson = {
  "items": [
    plainListItemJson,
  ],
  "listType": "ol",
  "type": "unbulleted",
};

void main() {
  group('Model - PlainListTag.fromXml()', () {
    final TestIterationData plainLists = {
      "ul": {"xml": plainListUlXml, "json": plainListUlJson},
      "ol": {"xml": plainListOlXml, "json": plainListOlJson},
    };

    void testListType(String type, String xml, Object json) {
      group(type, () {
        final tag = PlainListTag.fromXml(getRootXmlElement(xml));

        test('Returns expected JSON', () {
          expect(tag.toJson(), equals(json));
        });

        test('Returns expected string', () {
          expect(tag.toString(), equals(json.toString()));
        });
      });
    }

    plainLists.forEach((type, data) {
      testListType(type, data['xml']!.toString(), data['json']!);
    });

    test('Returns expected tagType', () {
      final tag = PlainListTag.fromXml(getRootXmlElement(plainListUlXml));
      expect(tag.tagType(), equals('PlainListTag'));
    });
  });

  group('Model - PlainListTag.fromTocIndexSections()', () {
    final indexSection = SectionTag.fromXml(getRootXmlElement(plainListSectionXml));
    final indexSections = [TocItem(indexSection, 1)];
    final tag = PlainListTag.fromTocItems(indexSections);

    final expectedJson = {
      "items": [plainListSectionJson],
      "listType": "ul",
      "type": "toc"
    };

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(expectedJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(expectedJson.toString()));
    });
  });
}
