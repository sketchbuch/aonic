import 'package:lonewolf_new/models/content/subcontent/illustration_instance.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';

void main() {
  group('Model - IllustrationInstance()', () {
    group('.png:', () {
      const xml = '<instance class="html" src="small1.png" width="386" height="150"  mime-type="image/png"/>';
      final tag = IllustrationInstance.fromXml(getRootXmlElement(xml));
      final expected = {
        "fileName": "small1.png",
        "height": 150,
        "mimeType": "image/png",
        "type": "html",
        "width": 386,
      };

      test('Returns expected JSON', () {
        expect(tag.toJson(), equals(expected));
      });

      test('Returns expected string', () {
        expect(tag.toString(), equals(expected.toString()));
      });
    });

    group('.gif:', () {
      const xml =
          '<instance class="html-compatible" src="small1.gif" width="386" height="150"  mime-type="image/gif"/>';
      final tag = IllustrationInstance.fromXml(getRootXmlElement(xml));
      final expected = {
        "fileName": "small1.gif",
        "height": 150,
        "mimeType": "image/gif",
        "type": "html-compatible",
        "width": 386,
      };

      test('Returns expected JSON', () {
        expect(tag.toJson(), equals(expected));
      });

      test('Returns expected string', () {
        expect(tag.toString(), equals(expected.toString()));
      });
    });

    group('.pdf:', () {
      const xml = '<instance class="pdf" src="small1.pdf" width="386" height="150" />';
      final tag = IllustrationInstance.fromXml(getRootXmlElement(xml));
      final expected = {
        "fileName": "small1.pdf",
        "height": 150,
        "mimeType": "unknown",
        "type": "pdf",
        "width": 386,
      };

      test('Returns expected JSON', () {
        expect(tag.toJson(), equals(expected));
      });

      test('Returns expected string', () {
        expect(tag.toString(), equals(expected.toString()));
      });
    });

    test('Type is unknown, if class is not an expected value', () {
      const xml = '<instance class="something" src="small1.png" width="386" height="150"  mime-type="image/png"/>';
      final tag = IllustrationInstance.fromXml(getRootXmlElement(xml));
      final expected = {
        "fileName": "small1.png",
        "height": 150,
        "mimeType": "image/png",
        "type": "unknown",
        "width": 386,
      };

      expect(tag.toJson(), equals(expected));
    });

    test('Type is unknown, if no class', () {
      const xml = '<instance src="small1.png" width="386" height="150"  mime-type="image/png"/>';
      final tag = IllustrationInstance.fromXml(getRootXmlElement(xml));
      final expected = {
        "fileName": "small1.png",
        "height": 150,
        "mimeType": "image/png",
        "type": "unknown",
        "width": 386,
      };

      expect(tag.toJson(), equals(expected));
    });
  });
}
