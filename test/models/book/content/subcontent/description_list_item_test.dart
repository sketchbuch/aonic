import 'package:lonewolf_new/models/book/content/subcontent/description_list_item.dart';
import 'package:test/test.dart';

import '../../../../helpers.dart';

const dtXml = '<dt>Illustration Transcription</dt>';
const dtExpected = {
  "displayAsLines": false,
  "texts": [
    {"attrs": {}, "displayType": "plain", "text": "Illustration Transcription"}
  ],
  "type": "dt"
};

const ddLinexXml = '''<dd>
  <line>Jonathan Blake</line>
  <line>Pedro Almeida, Jan Charv<ch.aacute/>t, Christian Cognigni, Tony Lenzo, Dewi Morgan, Laurence O<ch.apos/>Toole, Timothy Pederick</line>
</dd>''';
final ddLinexExpected = {
  "displayAsLines": true,
  "texts": [
    {"attrs": {}, "displayType": "plain", "text": "Jonathan Blake"},
    {
      "attrs": {},
      "displayType": "plain",
      "text":
          "Pedro Almeida, Jan Charvát, Christian Cognigni, Tony Lenzo, Dewi Morgan, Laurence O’Toole, Timothy Pederick"
    }
  ],
  "type": "dd"
};

const ddXml =
    '''<dd>Pedro Almeida, Jan Charv<ch.aacute/>t, Christian Cognigni, Tony Lenzo, Dewi Morgan, Laurence O<ch.apos/>Toole, Timothy Pederick</dd>''';
final ddExpected = {
  "displayAsLines": false,
  "texts": [
    {
      "attrs": {},
      "displayType": "plain",
      "text":
          "Pedro Almeida, Jan Charvát, Christian Cognigni, Tony Lenzo, Dewi Morgan, Laurence O’Toole, Timothy Pederick"
    }
  ],
  "type": "dd"
};

void main() {
  group('Model - DescriptionListItem()', () {
    final Map<String, Map<String, Object>> descriptionListItems = {
      "<dt>": {"xml": dtXml, "expected": dtExpected},
      "<dd> lines": {"xml": ddLinexXml, "expected": ddLinexExpected},
      "<dd> non-lines": {"xml": ddXml, "expected": ddExpected},
    };

    void testDescriptionListItemType(String instanceType, String xml, Object expected) {
      group(instanceType, () {
        final tag = DescriptionListItem.fromXml(getRootXmlElement(xml));

        test('Returns expected JSON', () {
          expect(tag.toJson(), equals(expected));
        });

        test('Returns expected string', () {
          expect(tag.toString(), equals(expected.toString()));
        });
      });
    }

    descriptionListItems.forEach((instanceType, instanceData) {
      testDescriptionListItemType(instanceType, instanceData['xml']!.toString(), instanceData['expected']!);
    });
  });
}
