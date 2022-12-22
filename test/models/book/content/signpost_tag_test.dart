import 'package:lonewolf_new/models/book/content/signpost_tag.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';

const signpostXml = '<signpost>Port Bax<ch.emdash/>3 Miles</signpost>';
final signpostJson = {
  "texts": [
    {"attrs": {}, "displayType": "plain", "text": "Port Bax—3 Miles"}
  ]
};

void main() {
  group('Model - SignpostTag()', () {
    final tag = SignpostTag.fromXml(getRootXmlElement(signpostXml));

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(signpostJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(signpostJson.toString()));
    });
  });
}
