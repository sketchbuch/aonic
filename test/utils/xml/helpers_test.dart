import 'package:aonic/models/book/content/subcontent/text_element.dart';
import 'package:aonic/utils/xml/helpers.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('Util - Helpers', () {
    const attrClass = 'lone';
    const attrId = 'wolf';
    const bValue = 'paragraph';
    const fallbackValue = 'kai';
    const xmlString = '<p class="$attrClass" id="$attrId">This is a <b>$bValue</b></p>';

    group('cleanXmlString()', () {
      test('Removes newlines, white space between tags, trims and replaces <ch...> tags', () {
        const xml = '''   <data>   <choice idref="sect275">If <ch.copy/>
you wish to follow the <quote>left track</quote>, <link-text>turn to 275</link-text>.</choice>    
        </data> ''';
        final cleanedXml = cleanXmlString(xml, {});

        expect(
          cleanedXml,
          equals(
              '''<data><choice idref="sect275">If ©you wish to follow the ‘left track’, <link-text>turn to 275</link-text>.</choice></data>'''),
        );
      });

      test('Removes html comments', () {
        const xml = '''   <data>   <choice idref="sect275">If <!-- <ch.copy/> -->
you wish to follow the <quote>left track</quote>, <link-text>turn to 275</link-text>. <!-- this
 is a multiline 
 comment -->
</choice>    
        </data> ''';
        final cleanedXml = cleanXmlString(xml, {});

        expect(
          cleanedXml,
          equals(
              '''<data><choice idref="sect275">If you wish to follow the ‘left track’, <link-text>turn to 275</link-text>. </choice></data>'''),
        );
      });
    });

    group('getAttribute()', () {
      test('Returns attribute', () {
        final xml = getRootXmlElement(xmlString);

        expect(
          getAttribute('class', xml),
          equals(attrClass),
        );
      });

      test('Returns fallback if attribute not found', () {
        final xml = getRootXmlElement(xmlString);

        expect(
          getAttribute('aria-label', xml, fallbackValue),
          equals(fallbackValue),
        );
      });
    });

    group('getAttributes()', () {
      test('Returns attributes if the xml node has any', () {
        final xml = getRootXmlElement(xmlString);

        expect(
          getAttributes(xml),
          equals({"class": attrClass, "id": attrId}),
        );
      });
    });

    group('getDate()', () {
      const day = 22;
      const month = 12;
      const year = 2022;

      test('Returns date object with correct date', () {
        final dateObj = getDate(year.toString(), month.toString(), day.toString());

        expect(dateObj.day, equals(day));
        expect(dateObj.month, equals(month));
        expect(dateObj.year, equals(year));
      });

      test('Returns date object with correct date even with single digit day/month', () {
        const day2 = 2;
        const month2 = 8;

        final dateObj = getDate(year.toString(), month2.toString(), day2.toString());

        expect(dateObj.day, equals(day2));
        expect(dateObj.month, equals(month2));
        expect(dateObj.year, equals(year));
      });
    });

    group('getTextElementList()', () {
      test('Returns the expected array of TextElements', () {
        final xml = getRootXmlElement(xmlString);
        final elements = getTextElementList(xml);

        expect(elements.length, equals(2));
        expect(
          elements.first.toJson(),
          equals({
            "attrs": {},
            "displayType": "plain",
            "parentType": "none",
            "subelements": [],
            "text": "This is a ",
          }),
        );
        expect(
          elements.last.toJson(),
          equals({
            "attrs": {},
            "displayType": "bold",
            "parentType": "none",
            "subelements": [],
            "text": "paragraph",
          }),
        );
      });

      test('Uses type, if provided', () {
        final xml = getRootXmlElement(xmlString);
        final elements = getTextElementList(xml, DisplayType.italic);

        expect(elements.length, equals(2));
        expect(
          elements.first.toJson(),
          equals({
            "attrs": {},
            "displayType": "italic",
            "parentType": "none",
            "subelements": [],
            "text": "This is a ",
          }),
        );
        expect(
          elements.last.toJson(),
          equals({
            "attrs": {},
            "displayType": "italic",
            "parentType": "none",
            "subelements": [],
            "text": "paragraph",
          }),
        );
      });
    });

    group('getValue()', () {
      test('Returns the text value of the element', () {
        final xml = getRootXmlElement(xmlString);

        expect(
          getValue('b', xml),
          equals(bValue),
        );
      });

      test('Returns the fallack value if the element is not found', () {
        final xml = getRootXmlElement(xmlString);

        expect(
          getValue('strong', xml, fallbackValue),
          equals(fallbackValue),
        );
      });
    });
  });
}
