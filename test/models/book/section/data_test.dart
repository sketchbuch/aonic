import 'package:lonewolf_new/models/book/section/data.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';

void main() {
  group('Model - Data()', () {
    const xml = '<data><p class="dedication">To Mel and Yin</p></data>';
    final tag = Data.fromXml(getRootXmlElement(xml));

    final expected = {
      "content": [
        {
          "texts": [
            {"attrs": {}, "displayType": "plain", "text": "To Mel and Yin"}
          ]
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
