import 'package:lonewolf_new/models/book/meta/creator.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';

void main() {
  group('Model - Creator()', () {
    const sortText = 'Dever, Joe';
    const text = 'Joe Dever';
    const type = 'author';

    const xml = '<creator class="$type" sort-name="$sortText">$text</creator>';
    final tag = Creator.fromXml(getRootXmlElement(xml));

    final expected = {
      "text": text,
      "type": type,
      "sortText": sortText,
    };

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(expected));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(expected.toString()));
    });
  });
}
