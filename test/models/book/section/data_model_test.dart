import 'package:aonic/exceptions/xml.dart';
import 'package:aonic/models/book/section/data_model.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';
import '../content/blockquote_tag_model_test.dart';
import '../content/choice_tag_model_test.dart';
import '../content/combat_tag_model_test.dart';
import '../content/deadend_tag_model_test.dart';
import '../content/description_list_tag_model_test.dart';
import '../content/illustration_tag_model_test.dart';
import '../content/paragraph_tag_model_test.dart';
import '../content/plain_list_tag_model_test.dart';
import '../content/signpost_tag_model_test.dart';

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
  group('Model - DataModel()', () {
    final tag = DataModel.fromXml(getRootXmlElement(dataXml), true);

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(dataJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(dataJson.toString()));
    });

    test('Empty data does not throw', () {
      const emptyXml = '<data></data>';
      final emptyTag = DataModel.fromXml(getRootXmlElement(emptyXml), true);

      expect(emptyTag.toJson(), equals({"content": []}));
    });

    test('Uknown tags should throw', () {
      const throwXml = '<data><uknown-tag>Lone Wolf</uknown-tag></data>';

      expect(() => DataModel.fromXml(getRootXmlElement(throwXml), true),
          throwsA(isA<ContentXmlException>()));
    });

    test('Ignores subcontent if addSubcontent is false', () {
      final tag = DataModel.fromXml(getRootXmlElement(dataXml), false);
      expect(tag.toJson(), equals({"content": []}));
    });
  });
}
