import 'package:lonewolf_new/exceptions/xml.dart';
import 'package:lonewolf_new/models/book/section/data.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';
import '../content/blockquote_tag_test.dart';
import '../content/choice_tag_test.dart';
import '../content/combat_tag_test.dart';
import '../content/deadend_tag_test.dart';
import '../content/description_list_tag_test.dart';
import '../content/illustration_tag_test.dart';
import '../content/paragraph_tag_test.dart';
import '../content/plain_list_tag_test.dart';
import '../content/signpost_tag_test.dart';

const dataXml = '''<data>
  $blockquoteXml
  $choiceXml
  $combatXml
  $deadendXml
  $dlXml
  $dlLinesXml
  $illustrationXml
  $plainListUlXml
  $plainListOlXml
  $paragraphXml
  $signpostXml
</data>''';
final dataJson = {
  "content": [
    blockquoteJson,
    choiceJson,
    combatJson,
    deadendJson,
    dlJson,
    dlLinesJson,
    illustrationJson,
    plainListUlJson,
    plainListOlJson,
    paragraphJson,
    signpostJson,
  ]
};

void main() {
  group('Model - Data()', () {
    final tag = Data.fromXml(getRootXmlElement(dataXml), true);

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(dataJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(dataJson.toString()));
    });

    test('Empty data does not throw', () {
      const emptyXml = '<data></data>';
      final emptyTag = Data.fromXml(getRootXmlElement(emptyXml), true);

      expect(emptyTag.toJson(), equals({"content": []}));
    });

    test('Uknown tags should throw', () {
      const throwXml = '<data><uknown-tag>Lone Wolf</uknown-tag></data>';

      expect(() => Data.fromXml(getRootXmlElement(throwXml), true), throwsA(isA<ContentXmlException>()));
    });

    test('Ignores subcontent if addSubcontent is false', () {
      final tag = Data.fromXml(getRootXmlElement(dataXml), false);
      expect(tag.toJson(), equals({"content": []}));
    });
  });
}
