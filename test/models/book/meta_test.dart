import 'package:lonewolf_new/models/book/meta.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('Model - Meta()', () {
    const author = 'Joe Dever';
    const descriptionType = 'publication';
    const publisher = 'Project Aon';
    const rightType = 'licenseNotification';
    const sortText = 'Dever, Joe';
    const title = 'Flight from the Dark';
    const type = 'author';

    const xml = '''<meta>
      <title>$title</title>
      <creator class="$type" sort-name="$sortText">$author</creator>
      <publisher>$publisher</publisher>
      <date class="publication"><year>2018</year><month>2</month><day>15</day></date>
      <description class="$descriptionType">
        <p>Internet Edition published by <a href="&link.project.website;">Project Aon</a>. This edition is intended to reflect the complete text of the original version. Where we have made minor corrections, they will be noted in the <a idref="errata">Errata</a>.</p>
      </description>
      <rights class="$rightType">
        <p>
          <line>Text copyright <ch.copy/> 1984 Joe Dever.</line>
          <line>Illustrations copyright <ch.copy/> 1984 Gary Chalk.</line>
          <line>Distribution of this Internet Edition is restricted under the terms of the <a idref="license">Project Aon License</a>.</line>
        </p>
      </rights>
    </meta>''';
    final tag = Meta.fromXml(getRootXmlElement(xml));

    final expected = {
      "creators": [
        {"text": author, "type": type, "sortText": sortText}
      ],
      "descriptions": [
        {
          "text":
              "Internet Edition published by Project Aon. This edition is intended to reflect the complete text of the original version. Where we have made minor corrections, they will be noted in the Errata.",
          "type": descriptionType
        }
      ],
      "publicationDate": '15-02-2018',
      "publisher": publisher,
      "rights": [
        {
          "text":
              "Text copyright © 1984 Joe Dever.Illustrations copyright © 1984 Gary Chalk.Distribution of this Internet Edition is restricted under the terms of the Project Aon License.",
          "type": rightType
        }
      ],
      "title": title
    };

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(expected));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(expected.toString()));
    });
  });
}
