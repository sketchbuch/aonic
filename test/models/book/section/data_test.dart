import 'package:lonewolf_new/models/book/section/data.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';

const dataXml = '<data><p class="dedication">To Mel and Yin</p></data>';
const dataJson = {
  "content": [
    {
      "texts": [
        {"attrs": {}, "displayType": "plain", "text": "To Mel and Yin"}
      ]
    }
  ]
};

// TODO - Expand tests to use different content types
void main() {
  group('Model - Data()', () {
    final tag = Data.fromXml(getRootXmlElement(dataXml));

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(dataJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(dataJson.toString()));
    });
  });
}
