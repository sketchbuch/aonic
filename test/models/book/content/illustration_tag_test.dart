import 'package:lonewolf_new/models/book/content/illustration_tag.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';
import 'subcontent/illustration_instance_test.dart';

const illustrationXml = '''<illustration class="inline">
  <meta>
    <creator>Gary Chalk</creator>
    <description>This is the image description</description>
  </meta>
  $pngInstanceXml
  $gifInstanceXml
  $pdfInstanceXml
</illustration>''';
final illustrationJson = {
  "creator": "Gary Chalk",
  "description": "This is the image description",
  "instances": [
    pngInstanceJson,
    gifInstanceJson,
    pdfInstanceJson,
  ],
  "isRealIllustration": true,
  "type": "inline",
};

void main() {
  group('Model - IllustrationTag():', () {
    final tag = IllustrationTag.fromXml(getRootXmlElement(illustrationXml));

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(illustrationJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(illustrationJson.toString()));
    });

    test('Type is unknown, if class is not an expected value', () {
      const xml = '<illustration class="somethig"></illustration>';
      final tag = IllustrationTag.fromXml(getRootXmlElement(xml));
      final expected = {
        "creator": "",
        "description": "",
        "instances": [],
        "isRealIllustration": false,
        "type": "unknown",
      };

      expect(tag.toJson(), equals(expected));
    });

    test('Type is none, if no class', () {
      const xml = '<illustration></illustration>';
      final tag = IllustrationTag.fromXml(getRootXmlElement(xml));
      final expected = {
        "creator": "",
        "description": "",
        "instances": [],
        "isRealIllustration": false,
        "type": "none",
      };

      expect(tag.toJson(), equals(expected));
    });

    test('isRealIllustration is true, if author is Gary Chalk', () {
      const xml = '<illustration class="inline"><meta><creator>Gary Chalk</creator></meta></illustration>';
      final tag = IllustrationTag.fromXml(getRootXmlElement(xml));
      final expected = {
        "creator": "Gary Chalk",
        "description": "",
        "instances": [],
        "isRealIllustration": true,
        "type": "inline",
      };

      expect(tag.toJson(), equals(expected));
    });

    test('isRealIllustration is false, if author is NOT Gary Chalk', () {
      const xml = '<illustration class="inline"><meta><creator>JC Alvarez</creator></meta></illustration>';
      final tag = IllustrationTag.fromXml(getRootXmlElement(xml));
      final expected = {
        "creator": "JC Alvarez",
        "description": "",
        "instances": [],
        "isRealIllustration": false,
        "type": "inline",
      };

      expect(tag.toJson(), equals(expected));
    });
  });
}
