import 'package:aonic/models/book/content/plain_list_tag_model.dart';
import 'package:aonic/models/book/content/section_tag_model.dart';
import 'package:aonic/models/book/content/subcontent/toc_item_model.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';
import '../../../types.dart';
import 'subcontent/plain_list_item_model_test.dart';

const plainListUlXml = '''<ul class="unbulleted">
  $plainListItemXml
  <li>Illustration II (<a idref="sect23">Section 23</a>)</li>
  <li><a idref="equipmnt">Equipment</a></li>
  <li>The <a idref="discplnz">Kai Disciplines</a> List</li>
</ul>''';
final plainListUlJson = {
  "items": [
    plainListItemJson,
    {
      "content": [
        {
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
        }
      ],
      "depth": 1
    },
    {
      "content": [
        {
          "texts": [
            {
              "attrs": {"idref": "equipmnt"},
              "displayType": "link",
              "parentType": "none",
              "subelements": [],
              "text": "Equipment"
            }
          ]
        }
      ],
      "depth": 1
    },
    {
      "content": [
        {
          "texts": [
            {
              "attrs": {},
              "displayType": "plain",
              "parentType": "none",
              "subelements": [],
              "text": "The ",
            },
            {
              "attrs": {"idref": "discplnz"},
              "displayType": "link",
              "parentType": "none",
              "subelements": [],
              "text": "Kai Disciplines"
            },
            {
              "attrs": {},
              "displayType": "plain",
              "parentType": "none",
              "subelements": [],
              "text": " List",
            }
          ]
        }
      ],
      "depth": 1
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
  group('Model - PlainListTagModel.fromXml()', () {
    final TestIterationData plainLists = {
      "ul": {"xml": plainListUlXml, "json": plainListUlJson},
      "ol": {"xml": plainListOlXml, "json": plainListOlJson},
    };

    void testListType(String type, String xml, Object json) {
      group(type, () {
        final tag = PlainListTagModel.fromXml(getRootXmlElement(xml));

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
      final tag = PlainListTagModel.fromXml(getRootXmlElement(plainListUlXml));
      expect(tag.tagType(), equals('PlainListTagModel'));
    });
  });

  group('Model - PlainListTag.fromTocIndexSections()', () {
    final indexSection = SectionTagModel.fromXml(getRootXmlElement(plainListSectionXml));
    final indexSections = [TocItemModel(indexSection, 1)];
    final tag = PlainListTagModel.fromTocItems(indexSections);

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
