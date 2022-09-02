import 'package:lonewolf_new/models/book/book.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('Model - Book()', () {
    const author = 'Joe Dever';
    const descriptionType = 'publication';
    const idRef1 = 'title';
    const idRef2 = 'acknwldg';
    const lang = 'en-UK';
    const publisher = 'Project Aon';
    const sectionId = 'dedicate';
    const sectionTitle = 'Dedication';
    const sectionType = 'frontmatter';
    const sortText = 'Dever, Joe';
    const text = 'To Mel and Yin';
    const title = 'Flight from the Dark';
    const type = 'author';
    const type1 = 'prev';
    const type2 = 'next';
    const version = '0.12';

    const xml = '''<gamebook xml:lang="$lang" version="$version">
      <meta>
        <title>$title</title>
        <creator class="$type" sort-name="$sortText">$author</creator>
        <publisher>$publisher</publisher>
        <date class="publication"><year>2018</year><month>2</month><day>15</day></date>
        <description class="$descriptionType">
          <p>Internet Edition published by <a href="&link.project.website;">Project Aon</a>. This edition is intended to reflect the complete text of the original version. Where we have made minor corrections, they will be noted in the <a idref="errata">Errata</a>.</p>
        </description>
        <rights class="license-notification">
          <p>
            <line>Text copyright <ch.copy/> 1984 Joe Dever.</line>
            <line>Illustrations copyright <ch.copy/> 1984 Gary Chalk.</line>
            <line>Distribution of this Internet Edition is restricted under the terms of the <a idref="license">Project Aon License</a>.</line>
          </p>
        </rights>
      </meta>

      <section class="$sectionType" id="$sectionId">
        <meta>
          <title>$sectionTitle</title>
          <link class="$type1" idref="$idRef1" />
          <link class="$type2" idref="$idRef2" />
        </meta>
    
        <data>
          <p class="dedication">$text</p>
        </data>
      </section>
    </gamebook>''';
    final tag = Book.fromXml(getRootXmlElement(xml));

    final expected = {
      "backmatter": [],
      "frontmatter": [
        {
          "data": {
            "content": [
              {
                "texts": [
                  {"attrs": {}, "displayType": "plain", "text": text}
                ]
              }
            ]
          },
          "footnotes": [],
          "id": sectionId,
          "meta": {
            "links": [
              {"idRef": idRef1, "type": type1},
              {"idRef": idRef2, "type": type2}
            ],
            "title": sectionTitle
          },
          "type": sectionType
        }
      ],
      "lang": lang,
      "meta": {
        "creators": [
          {"text": author, "type": type, "sortText": sortText}
        ],
        "descriptions": [
          {
            "texts": [
              [
                {"attrs": {}, "displayType": "plain", "text": "Internet Edition published by "},
                {
                  "attrs": {"href": "&link.project.website;"},
                  "displayType": "link",
                  "text": "Project Aon"
                },
                {
                  "attrs": {},
                  "displayType": "plain",
                  "text":
                      ". This edition is intended to reflect the complete text of the original version. Where we have made minor corrections, they will be noted in the "
                },
                {
                  "attrs": {"idref": "errata"},
                  "displayType": "link",
                  "text": "Errata"
                },
                {"attrs": {}, "displayType": "plain", "text": "."}
              ]
            ],
            "type": descriptionType
          }
        ],
        "publicationDate": "15-02-2018",
        "publisher": publisher,
        "rights": [
          {
            "texts": [
              [
                {"attrs": {}, "displayType": "plain", "text": "Text copyright © 1984 Joe Dever."}
              ],
              [
                {"attrs": {}, "displayType": "plain", "text": "Illustrations copyright © 1984 Gary Chalk."}
              ],
              [
                {
                  "attrs": {},
                  "displayType": "plain",
                  "text": "Distribution of this Internet Edition is restricted under the terms of the "
                },
                {
                  "attrs": {"idref": "license"},
                  "displayType": "link",
                  "text": "Project Aon License"
                },
                {"attrs": {}, "displayType": "plain", "text": "."}
              ]
            ],
            "type": 'license-notification'
          }
        ],
        "title": title
      },
      "numbered": [],
      "title": title,
      "version": version
    };

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(expected));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(expected.toString()));
    });
  });
}
