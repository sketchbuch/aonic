import 'package:lonewolf_new/models/book/content/section_tag.dart';
import 'package:lonewolf_new/models/book/content/subcontent/plain_list_item.dart';
import 'package:lonewolf_new/models/book/content/subcontent/toc_item.dart';
import 'package:test/test.dart';

import '../../../../helpers.dart';

const plainListItemXml = '<li>Illustration I (<a idref="sect7">Section 7</a>)</li>';
const plainListItemJson = {
  "content": [
    {
      "texts": [
        {
          "attrs": {},
          "displayType": "plain",
          "parentType": "none",
          "subelements": [],
          "text": "Illustration I (",
        },
        {
          "attrs": {"idref": "sect7"},
          "displayType": "link",
          "parentType": "none",
          "subelements": [],
          "text": "Section 7"
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
  "content": [
    {
      "texts": [
        {
          "attrs": {"idref": plainListSectionId},
          "displayType": "link",
          "parentType": "none",
          "subelements": [],
          "text": plainListSectionMetaTitle
        }
      ]
    }
  ],
  "depth": 1
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

    group('Subcontent - Single node (!isRenderableNode)', () {
      const xml = '<li><a idref="sect7">Section 7</a></li>';
      final tag = PlainListItem.fromXml(getRootXmlElement(xml), 1);
      final expectedJson = {
        "content": [
          {
            "texts": [
              {
                "attrs": {"idref": "sect7"},
                "displayType": "link",
                "parentType": "none",
                "subelements": [],
                "text": "Section 7"
              }
            ]
          }
        ],
        "depth": 1
      };

      test('Returns expected JSON', () {
        expect(tag.toJson(), equals(expectedJson));
      });

      test('Returns expected string', () {
        expect(tag.toString(), equals(expectedJson.toString()));
      });
    });

    group('Subcontent - Single node (isRenderableNode)', () {
      const xml = '<li>Go to <p>Section 7</p></li>';
      final tag = PlainListItem.fromXml(getRootXmlElement(xml), 1);
      final expectedJson = {
        "content": [
          {
            "texts": [
              {
                "attrs": {},
                "displayType": "plain",
                "parentType": "none",
                "subelements": [],
                "text": "Go to ",
              },
              {
                "attrs": {},
                "displayType": "plain",
                "parentType": "none",
                "subelements": [],
                "text": "Section 7",
              }
            ]
          }
        ],
        "depth": 1
      };

      test('Returns expected JSON', () {
        expect(tag.toJson(), equals(expectedJson));
      });

      test('Returns expected string', () {
        expect(tag.toString(), equals(expectedJson.toString()));
      });
    });

    group('Subcontent - Multiple nodes', () {
      const xml = '''<li>
        <blockquote>
          <p>Viveka is seated at one end of the table, with a wary expression on her face. One arm is on the table near a large mug of ale, with her finger tapping the edge. As usual, she is dressed in battle gear.</p>
        </blockquote>
        <choice idref="sect141">If you wish to use your Kai Discipline of Sixth Sense, <link-text>turn to 141</link-text>.</choice>
        <combat><enemy>Kraan</enemy><enemy-attribute class="combatskill">16</enemy-attribute><enemy-attribute class="endurance">24</enemy-attribute></combat> 
        <deadend>Your mission ends here.</deadend>
        <dl>
          <dt>Transcription</dt>
          <dd>Ryan Landek</dd>
        </dl>
        <illustration>
          <meta>
            <creator>JC Alvarez</creator>
          </meta>
          <instance class="html" src="tssf.png" width="386" height="300"  mime-type="image/png"/>
        </illustration>
        <ol class="paragraphed">
          <li><p>Add any extra points gained through your Kai Disciplines to your current <typ class="attribute">COMBAT SKILL</typ> total.</p></li>
        </ol>
        <ul class="unbulleted">
          <li>0 = Dagger</li>
        </ul>
        <p>Section 7</p>
        <section>
          <meta>
            <creator>7</creator>
          </meta>
          <data/>
        </section>
        <signpost>Royal Court<ch.emdash/>1 Mile</signpost>
      </li>''';
      final tag = PlainListItem.fromXml(getRootXmlElement(xml), 1);
      final expectedJson = {
        "content": [
          {
            "texts": [
              {
                "attrs": {},
                "displayType": "plain",
                "parentType": "none",
                "subelements": [],
                "text":
                    "Viveka is seated at one end of the table, with a wary expression on her face. One arm is on the table near a large mug of ale, with her finger tapping the edge. As usual, she is dressed in battle gear."
              }
            ]
          },
          {
            "idref": "sect141",
            "linkTextIndex": 1,
            "texts": [
              {
                "attrs": {},
                "displayType": "plain",
                "parentType": "none",
                "subelements": [],
                "text": "If you wish to use your Kai Discipline of Sixth Sense, "
              },
              {
                "attrs": {},
                "displayType": "link",
                "parentType": "none",
                "subelements": [],
                "text": "turn to 141",
              },
              {
                "attrs": {},
                "displayType": "plain",
                "parentType": "none",
                "subelements": [],
                "text": ".",
              }
            ]
          },
          {
            "combatskill": 16,
            "endurance": 24,
            "enemy": "Kraan",
          },
          {"text": "Your mission ends here."},
          {
            "items": [
              {
                "displayAsLines": false,
                "texts": [
                  {
                    "attrs": {},
                    "displayType": "plain",
                    "parentType": "none",
                    "subelements": [],
                    "text": "Transcription",
                  }
                ],
                "type": "dt"
              },
              {
                "displayAsLines": false,
                "texts": [
                  {
                    "attrs": {},
                    "displayType": "plain",
                    "parentType": "none",
                    "subelements": [],
                    "text": "Ryan Landek",
                  }
                ],
                "type": "dd"
              }
            ]
          },
          {
            "creator": "JC Alvarez",
            "description": "",
            "instances": [
              {
                "fileName": "tssf.png",
                "height": 300,
                "mimeType": "image/png",
                "type": "html",
                "width": 386,
              }
            ],
            "type": "none"
          },
          {
            "items": [
              {
                "content": [
                  {
                    "texts": [
                      {
                        "attrs": {},
                        "displayType": "plain",
                        "parentType": "none",
                        "subelements": [],
                        "text": "Add any extra points gained through your Kai Disciplines to your current "
                      },
                      {
                        "attrs": {"class": "attribute"},
                        "displayType": "typ",
                        "parentType": "none",
                        "subelements": [],
                        "text": "COMBAT SKILL"
                      },
                      {
                        "attrs": {},
                        "displayType": "plain",
                        "parentType": "none",
                        "subelements": [],
                        "text": " total.",
                      }
                    ]
                  }
                ],
                "depth": 1
              }
            ],
            "listType": "ol",
            "type": "paragraphed"
          },
          {
            "items": [
              {
                "content": [
                  {
                    "texts": [
                      {
                        "attrs": {},
                        "displayType": "plain",
                        "parentType": "none",
                        "subelements": [],
                        "text": "0 = Dagger",
                      }
                    ]
                  }
                ],
                "depth": 1
              }
            ],
            "listType": "ul",
            "type": "unbulleted"
          },
          {
            "texts": [
              {
                "attrs": {},
                "displayType": "plain",
                "parentType": "none",
                "subelements": [],
                "text": "Section 7",
              }
            ]
          },
          {
            "data": {"content": []},
            "footnotes": [],
            "id": "",
            "meta": {"links": [], "title": ""},
            "type": "none"
          },
          {
            "texts": [
              {
                "attrs": {},
                "displayType": "plain",
                "parentType": "none",
                "subelements": [],
                "text": "Royal Court—1 Mile",
              }
            ]
          }
        ],
        "depth": 1
      };

      test('Returns expected JSON', () {
        expect(tag.toJson(), equals(expectedJson));
      });

      test('Returns expected string', () {
        expect(tag.toString(), equals(expectedJson.toString()));
      });
    });
  });

  group('Model - PlainListItem.fromTocItem()', () {
    final section = SectionTag.fromXml(getRootXmlElement(plainListSectionXml));
    final tocSection = TocItem(section, 1);
    final tag = PlainListItem.fromTocItem(tocSection);

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(plainListSectionJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(plainListSectionJson.toString()));
    });
  });
}
