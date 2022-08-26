import 'package:lonewolf_new/models/content/description_list_tag.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

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
        {"attrs": {}, "displayType": "dt", "text": "Transcription"},
        {"attrs": {}, "displayType": "dd", "text": "Ryan Landek"},
        {"attrs": {}, "displayType": "dt", "text": "Illustration Transcription"},
        {"attrs": {}, "displayType": "dd", "text": "Jonathan BlakePaul HaskellSimon OsborneDaniel Strong"}
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
