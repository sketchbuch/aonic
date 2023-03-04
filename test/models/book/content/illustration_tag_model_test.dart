import 'package:aonic/models/book/content/illustration_tag_model.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';
import 'subcontent/illustration_instance_model_test.dart';

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
  "type": "inline",
};

void main() {
  group('Model - IllustrationTagModel()', () {
    final tag = IllustrationTagModel.fromXml(getRootXmlElement(illustrationXml));

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(illustrationJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(illustrationJson.toString()));
    });

    test('Type is unknown, if class is not an expected value', () {
      const xml = '<illustration class="somethig"></illustration>';
      final tag = IllustrationTagModel.fromXml(getRootXmlElement(xml));
      final expected = {
        "creator": "",
        "description": "",
        "instances": [],
        "type": "unknown",
      };

      expect(tag.toJson(), equals(expected));
    });

    test('Type is none, if no class', () {
      const xml = '<illustration></illustration>';
      final tag = IllustrationTagModel.fromXml(getRootXmlElement(xml));
      final expected = {
        "creator": "",
        "description": "",
        "instances": [],
        "type": "none",
      };

      expect(tag.toJson(), equals(expected));
    });

    test('Returns expected tagType', () {
      expect(tag.tagType(), equals('IllustrationTagModel'));
    });
  });
}
