import 'package:lonewolf_new/models/book/content/subcontent/illustration_instance.dart';
import 'package:test/test.dart';

import '../../../../helpers.dart';

const pngInstanceXml = '<instance class="html" src="small1.png" width="386" height="150"  mime-type="image/png"/>';
const pngInstanceExpected = {
  "fileName": "small1.png",
  "height": 150,
  "mimeType": "image/png",
  "type": "html",
  "width": 386,
};

const gifInstanceXml =
    '<instance class="html-compatible" src="small1.gif" width="386" height="150"  mime-type="image/gif"/>';
const gifInstanceExpected = {
  "fileName": "small1.gif",
  "height": 150,
  "mimeType": "image/gif",
  "type": "html-compatible",
  "width": 386,
};

const pdfInstanceXml = '<instance class="pdf" src="small1.pdf" width="386" height="150" />';
const pdfInstanceExpected = {
  "fileName": "small1.pdf",
  "height": 150,
  "mimeType": "none",
  "type": "pdf",
  "width": 386,
};

void main() {
  group('Model - IllustrationInstance()', () {
    final Map<String, Map<String, Object>> instances = {
      "png": {"xml": pngInstanceXml, "expected": pngInstanceExpected},
      "gif": {"xml": gifInstanceXml, "expected": gifInstanceExpected},
      "pdf": {"xml": pdfInstanceXml, "expected": pdfInstanceExpected},
    };

    void testInstanceType(String instanceType, String xml, Object expected) {
      group('.$instanceType:', () {
        final tag = IllustrationInstance.fromXml(getRootXmlElement(xml));

        test('Returns expected JSON', () {
          expect(tag.toJson(), equals(expected));
        });

        test('Returns expected string', () {
          expect(tag.toString(), equals(expected.toString()));
        });
      });
    }

    instances.forEach((instanceType, instanceData) {
      testInstanceType(instanceType, instanceData['xml']!.toString(), instanceData['expected']!);
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

    test('Type is none, if no class', () {
      const xml = '<instance src="small1.png" width="386" height="150"  mime-type="image/png"/>';
      final tag = IllustrationInstance.fromXml(getRootXmlElement(xml));
      final expected = {
        "fileName": "small1.png",
        "height": 150,
        "mimeType": "image/png",
        "type": "none",
        "width": 386,
      };

      expect(tag.toJson(), equals(expected));
    });
  });
}
