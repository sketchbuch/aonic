import 'package:aonic/models/book/content/paragraph_tag_model.dart';
import 'package:aonic/models/book/content/subcontent/text_element_model.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';

const paragraphText =
    'Each Meal of Laumspur may be consumed when prompted for a Meal, in which case it fulfils the Meal requirement in addition to restoring 3 <typ class="attribute">ENDURANCE</typ> points. Laumspur may also be consumed at any other time to restore <typ class="attribute">ENDURANCE</typ> without having any significance as a Meal.';
const paragraphXml = '<p>$paragraphText</p>';
final paragraphJson = {
  "texts": [
    {
      "attrs": {},
      "displayType": "plain",
      "parentType": "none",
      "subelements": [],
      "text":
          "Each Meal of Laumspur may be consumed when prompted for a Meal, in which case it fulfils the Meal requirement in addition to restoring 3 ",
    },
    {
      "attrs": {"class": "attribute"},
      "displayType": "typ",
      "parentType": "none",
      "subelements": [],
      "text": "ENDURANCE",
    },
    {
      "attrs": {},
      "displayType": "plain",
      "parentType": "none",
      "subelements": [],
      "text":
          " points. Laumspur may also be consumed at any other time to restore ",
    },
    {
      "attrs": {"class": "attribute"},
      "displayType": "typ",
      "parentType": "none",
      "subelements": [],
      "text": "ENDURANCE"
    },
    {
      "attrs": {},
      "displayType": "plain",
      "parentType": "none",
      "subelements": [],
      "text": " without having any significance as a Meal.",
    }
  ]
};
const paragraphDedicationXml =
    '<p class="dedication">Each Meal of Laumspur may be consumed...</p>';
final paragraphDedicationJson = {
  "texts": [
    {
      "attrs": {},
      "displayType": "italic",
      "parentType": "none",
      "subelements": [],
      "text": "Each Meal of Laumspur may be consumed...",
    }
  ]
};

void main() {
  group('Model - ParagraphTagModel.fromXml()', () {
    final tag = ParagraphTagModel.fromXml(getRootXmlElement(paragraphXml));

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(paragraphJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(paragraphJson.toString()));
    });

    test('Returns expected tagType', () {
      expect(tag.tagType(), equals('ParagraphTag'));
    });

    group('With dedication class', () {
      final tag =
          ParagraphTagModel.fromXml(getRootXmlElement(paragraphDedicationXml));

      test('Returns expected JSON', () {
        expect(tag.toJson(), equals(paragraphDedicationJson));
      });

      test('Returns expected string', () {
        expect(tag.toString(), equals(paragraphDedicationJson.toString()));
      });
    });
  });

  group('Model - ParagraphTagModel.fromTxt()', () {
    final tag = ParagraphTagModel.fromTxt(paragraphText);
    final textJson = {
      "texts": [
        {
          "attrs": {},
          "displayType": "plain",
          "parentType": "none",
          "subelements": [],
          "text":
              'Each Meal of Laumspur may be consumed when prompted for a Meal, in which case it fulfils the Meal requirement in addition to restoring 3 <typ class="attribute">ENDURANCE</typ> points. Laumspur may also be consumed at any other time to restore <typ class="attribute">ENDURANCE</typ> without having any significance as a Meal.',
        }
      ]
    };
    const optionalParentType = DisplayType.italic;
    const optionalType = DisplayType.bookref;
    const optionalAttrs = {"lone": "wolf"};
    final optionalTag = ParagraphTagModel.fromTxt(
      paragraphText,
      attributes: optionalAttrs,
      parentDisplayType: optionalParentType,
      type: optionalType,
    );
    final optionalJson = {
      "texts": [
        {
          "attrs": optionalAttrs,
          "displayType": optionalType.name,
          "parentType": optionalParentType.name,
          "subelements": [],
          "text":
              'Each Meal of Laumspur may be consumed when prompted for a Meal, in which case it fulfils the Meal requirement in addition to restoring 3 <typ class="attribute">ENDURANCE</typ> points. Laumspur may also be consumed at any other time to restore <typ class="attribute">ENDURANCE</typ> without having any significance as a Meal.',
        }
      ]
    };

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(textJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(textJson.toString()));
    });

    test('Optional params returns expected JSON', () {
      expect(optionalTag.toJson(), equals(optionalJson));
    });

    test('Optional params returns expected string', () {
      expect(optionalTag.toString(), equals(optionalJson.toString()));
    });
  });

  group('Model - ParagraphTagModel.fromNode()', () {
    final xml = getRootXmlElement(paragraphXml);
    final tag = ParagraphTagModel.fromNode(xml.childElements.elementAt(0));
    final nodeJson = {
      "texts": [
        {
          "attrs": {},
          "displayType": "plain",
          "parentType": "none",
          "subelements": [],
          "text": "ENDURANCE",
        }
      ]
    };

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(nodeJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(nodeJson.toString()));
    });
  });
}
