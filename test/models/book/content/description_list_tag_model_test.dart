import 'package:aonic/models/book/content/description_list_tag_model.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';
import '../../../types.dart';
import 'subcontent/description_list_item_model_test.dart';

const dlXml = '''<dl>
    $dtXml
    $ddXml
</dl>''';
final dlJson = {
  "items": [
    dtJson,
    ddJson,
  ]
};

const dlLinesXml = '''<dl>
    $dtXml
    $ddLineXml
</dl>''';
final dlLinesJson = {
  "items": [
    dtJson,
    ddLinexJson,
  ]
};

void main() {
  group('Model - DescriptionListTagModel()', () {
    final TestIterationData descriptionLists = {
      "Without lines": {"xml": dlXml, "json": dlJson},
      "With lines": {"xml": dlLinesXml, "json": dlLinesJson},
    };

    void testDescriptionListType(String type, String xml, Object json) {
      group(type, () {
        final tag = DescriptionListTagModel.fromXml(getRootXmlElement(xml));

        test('Returns expected JSON', () {
          expect(tag.toJson(), equals(json));
        });

        test('Returns expected string', () {
          expect(tag.toString(), equals(json.toString()));
        });
      });
    }

    descriptionLists.forEach((type, data) {
      testDescriptionListType(type, data['xml']!.toString(), data['json']!);
    });

    test('Returns expected tagType', () {
      final tag = DescriptionListTagModel.fromXml(getRootXmlElement(dlXml));
      expect(tag.tagType(), equals('DescriptionListTagModel'));
    });
  });
}
