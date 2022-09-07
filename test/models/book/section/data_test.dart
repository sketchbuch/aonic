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
import '../content/list_tag_test.dart';
import '../content/paragraph_tag_test.dart';
import '../content/signpost_tag_test.dart';

const dataXml = '''<data>
  $blockquoteXml
  $choiceXml
  $combatXml
  $deadendXml
  $dlXml
  $dlLinesXml
  $illustrationXml
  $listUlXml
  $lisOlXml
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
    listUlJson,
    listOlJson,
    paragraphJson,
    signpostJson,
  ]
};

void main() {
  group('Model - Data()', () {
    final tag = Data.fromXml(getRootXmlElement(dataXml));

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(dataJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(dataJson.toString()));
    });

    test('Empty data does not throw', () {
      const emptyXml = '<data></data>';
      final emptyTag = Data.fromXml(getRootXmlElement(emptyXml));

      expect(emptyTag.toJson(), equals({"content": []}));
    });

    test('Uknown tags should throw', () {
      const throwXml = '<data><uknown-tag>Lone Wolf</uknown-tag></data>';

      expect(() => Data.fromXml(getRootXmlElement(throwXml)), throwsA(isA<ContentXmlException>()));
    });
  });
}
