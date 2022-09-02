import 'package:lonewolf_new/models/book/section/meta.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';

void main() {
  group('Model - Meta()', () {
    const title = 'Dedication';
    const idRef1 = 'title';
    const type1 = 'prev';
    const idRef2 = 'acknwldg';
    const type2 = 'next';

    const xml =
        '<meta><title>$title</title><link class="$type1" idref="$idRef1" /><link class="$type2" idref="$idRef2" /></meta>';
    final tag = Meta.fromXml(getRootXmlElement(xml));

    final expected = {
      "links": [
        {
          "idRef": idRef1,
          "type": type1,
        },
        {
          "idRef": idRef2,
          "type": type2,
        },
      ],
      "title": title,
    };

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(expected));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(expected.toString()));
    });
  });
}
