import 'package:lonewolf_new/models/book/content/description_list_tag.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';

void main() {
  group('Model - DescriptionListTag():', () {
    const xml = '''<dl>
        <dt>Transcription</dt>
          <dd>Ryan Landek</dd>
        <dt>Illustration Transcription</dt>
          <dd>
            <line>Jonathan Blake</line>
            <line>Paul Haskell</line>
            <line>Simon Osborne</line>
            <line>Daniel Strong</line>
          </dd>
    </dl>''';
    final tag = DescriptionListTag.fromXml(getRootXmlElement(xml));

    final expected = {
      "items": [
        {
          "displayAsLines": false,
          "texts": [
            {"attrs": {}, "displayType": "plain", "text": "Transcription"}
          ],
          "type": "dt"
        },
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
            {"attrs": {}, "displayType": "plain", "text": "Illustration Transcription"}
          ],
          "type": "dt"
        },
        {
          "displayAsLines": true,
          "texts": [
            {"attrs": {}, "displayType": "plain", "text": "Jonathan Blake"},
            {"attrs": {}, "displayType": "plain", "text": "Paul Haskell"},
            {"attrs": {}, "displayType": "plain", "text": "Simon Osborne"},
            {"attrs": {}, "displayType": "plain", "text": "Daniel Strong"}
          ],
          "type": "dd"
        }
      ]
    };

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(expected));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(expected.toString()));
    });
  });
}
