import 'package:lonewolf_new/models/book/content/subcontent/description_list_item.dart';
import 'package:test/test.dart';

import '../../../../helpers.dart';
import '../../../../types.dart';

const dtXml = '<dt>Illustration Transcription</dt>';
const dtJson = {
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
final ddLinexJson = {
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
final ddJson = {
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
    final TestIterationData descriptionListItems = {
      "<dt>": {"xml": dtXml, "json": dtJson},
      "<dd> lines": {"xml": ddLinexXml, "json": ddLinexJson},
      "<dd> non-lines": {"xml": ddXml, "json": ddJson},
    };

    void testDescriptionListItemType(String type, String xml, Object json) {
      group('$type:', () {
        final tag = DescriptionListItem.fromXml(getRootXmlElement(xml));

        test('Returns expected JSON', () {
          expect(tag.toJson(), equals(json));
        });

        test('Returns expected string', () {
          expect(tag.toString(), equals(json.toString()));
        });
      });
    }

    descriptionListItems.forEach((type, data) {
      testDescriptionListItemType(type, data['xml']!.toString(), data['json']!);
    });
  });
}
