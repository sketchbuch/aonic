import 'package:lonewolf_new/utils/xml/helpers.dart';
import 'package:test/test.dart';

void main() {
  group('Util - cleanXmlString():', () {
    test('Removes newlines, white space between tags, trims and replaces <ch...> tags', () {
      const xml = '''   <data>   <choice idref="sect275">If <ch.copy/>
you wish to follow the left track, <link-text>turn to 275</link-text>.</choice>    
        </data> ''';
      final cleanedXml = cleanXmlString(xml);

      expect(
          cleanedXml,
          equals(
              '''<data><choice idref="sect275">If ©you wish to follow the left track, <link-text>turn to 275</link-text>.</choice></data>'''));
    });
  });
}
