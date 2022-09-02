import 'package:lonewolf_new/models/book/content/illustration_tag.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';

void main() {
  group('Model - IllustrationTag():', () {
    const xml = '''<illustration class="inline">
        <meta>
         <creator>Gary Chalk</creator>
         <description>This is the image description</description>
        </meta>
        <instance class="html" src="small1.png" width="386" height="150"  mime-type="image/png"/>
        <instance class="html-compatible" src="small1.gif" width="386" height="150"  mime-type="image/gif"/>
        <instance class="pdf" src="small1.pdf" width="386" height="150" />
       </illustration>''';
    final tag = IllustrationTag.fromXml(getRootXmlElement(xml));

    final expected = {
      "creator": "Gary Chalk",
      "description": "This is the image description",
      "instances": [
        {
          "fileName": "small1.png",
          "height": 150,
          "mimeType": "image/png",
          "type": "html",
          "width": 386,
        },
        {
          "fileName": "small1.gif",
          "height": 150,
          "mimeType": "image/gif",
          "type": "html-compatible",
          "width": 386,
        },
        {
          "fileName": "small1.pdf",
          "height": 150,
          "mimeType": "none",
          "type": "pdf",
          "width": 386,
        }
      ],
      "isRealIllustration": true,
      "type": "inline",
    };

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(expected));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(expected.toString()));
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
