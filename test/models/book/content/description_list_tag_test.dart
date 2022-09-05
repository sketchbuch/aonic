import 'package:lonewolf_new/models/book/content/description_list_tag.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';
import 'subcontent/description_list_item_test.dart';

const dlXml = '''<dl>
    $dtXml
      <dd>Ryan Landek</dd>
    <dt>DD Without lines</dt>
      $ddXml
    <dt>DD With lines</dt>
      $ddLinexXml
</dl>''';
final dlExpected = {
  "items": [
    dtExpected,
    {
      "displayAsLines": false,
      "texts": [
        {"attrs": {}, "displayType": "plain", "text": "Ryan Landek"}
      ],
      "type": "dd"
    },
    {
      "displayAsLines": false,
      "texts": [
        {"attrs": {}, "displayType": "plain", "text": "DD Without lines"}
      ],
      "type": "dt"
    },
    ddExpected,
    {
      "displayAsLines": false,
      "texts": [
        {"attrs": {}, "displayType": "plain", "text": "DD With lines"}
      ],
      "type": "dt"
    },
    ddLinexExpected
  ]
};

void main() {
  group('Model - DescriptionListTag():', () {
    final tag = DescriptionListTag.fromXml(getRootXmlElement(dlXml));

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(dlExpected));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(dlExpected.toString()));
    });
  });
}
