import 'package:lonewolf_new/models/book/section/meta_link.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';

void main() {
  group('Model - MetaLink()', () {
    const idRef = 'title';
    const type = 'prev';

    const xml = '<link class="$type" idref="$idRef" />';
    final tag = MetaLink.fromXml(getRootXmlElement(xml));

    final expected = {
      "idRef": idRef,
      "type": type,
    };

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(expected));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(expected.toString()));
    });
  });
}
