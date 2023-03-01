import 'package:aonic/models/book/content/subcontent/illustration_instance_model.dart';
import 'package:test/test.dart';

import '../../../../helpers.dart';
import '../../../../types.dart';

const pngInstanceXml =
    '<instance class="html" src="small1.png" width="386" height="150"  mime-type="image/png"/>';
const pngInstanceJson = {
  "fileName": "small1.png",
  "height": 150,
  "mimeType": "image/png",
  "type": "html",
  "width": 386,
};

const gifInstanceXml =
    '<instance class="html-compatible" src="small1.gif" width="386" height="150"  mime-type="image/gif"/>';
const gifInstanceJson = {
  "fileName": "small1.gif",
  "height": 150,
  "mimeType": "image/gif",
  "type": "html-compatible",
  "width": 386,
};

const pdfInstanceXml =
    '<instance class="pdf" src="small1.pdf" width="386" height="150" />';
const pdfInstanceJson = {
  "fileName": "small1.pdf",
  "height": 150,
  "mimeType": "none",
  "type": "pdf",
  "width": 386,
};

const textInstanceXml = '<instance class="text"></instance>';
const textInstanceJson = {
  "fileName": "",
  "height": 0,
  "mimeType": "none",
  "type": "text",
  "width": 0,
};

const textWithAttrsInstanceXml =
    '<instance class="text" src="none" width="none" height="none"></instance>';
const textWithAttrsInstanceJson = {
  "fileName": "",
  "height": 0,
  "mimeType": "none",
  "type": "text",
  "width": 0,
};

void main() {
  group('Model - IllustrationInstanceModel()', () {
    final TestIterationData instances = {
      "png": {"xml": pngInstanceXml, "json": pngInstanceJson},
      "gif": {"xml": gifInstanceXml, "json": gifInstanceJson},
      "pdf": {"xml": pdfInstanceXml, "json": pdfInstanceJson},
      "text": {"xml": textInstanceXml, "json": textInstanceJson},
      "text with attrs": {
        "xml": textWithAttrsInstanceXml,
        "json": textWithAttrsInstanceJson
      },
    };

    void testInstanceType(String type, String xml, Object json) {
      group('$type', () {
        final tag = IllustrationInstanceModel.fromXml(getRootXmlElement(xml));

        test('Returns expected JSON', () {
          expect(tag.toJson(), equals(json));
        });

        test('Returns expected string', () {
          expect(tag.toString(), equals(json.toString()));
        });
      });
    }

    instances.forEach((type, data) {
      testInstanceType(type, data['xml']!.toString(), data['json']!);
    });

    test('Type is unknown, if class is not an expected value', () {
      const xml =
          '<instance class="something" src="small1.png" width="386" height="150"  mime-type="image/png"/>';
      final tag = IllustrationInstanceModel.fromXml(getRootXmlElement(xml));
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
      const xml =
          '<instance src="small1.png" width="386" height="150"  mime-type="image/png"/>';
      final tag = IllustrationInstanceModel.fromXml(getRootXmlElement(xml));
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
