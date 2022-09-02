import 'package:lonewolf_new/models/book/section.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('Model - Section()', () {
    const idRef1 = 'title';
    const idRef2 = 'acknwldg';
    const sectionId = 'dedicate';
    const sectionType = 'frontmatter';
    const text = 'To Mel and Yin';
    const title = 'Dedication';
    const type1 = 'prev';
    const type2 = 'next';

    const xml = '''<section class="$sectionType" id="$sectionId">
      <meta>
        <title>$title</title>
        <link class="$type1" idref="$idRef1" />
        <link class="$type2" idref="$idRef2" />
      </meta>
  
      <data>
        <p class="dedication">$text</p>
      </data>
    </section>''';
    final tag = Section.fromXml(getRootXmlElement(xml));

    final expected = {
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
        "title": title
      },
      "type": sectionType
    };

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(expected));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(expected.toString()));
    });
  });
}
