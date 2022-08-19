import 'package:lonewolf_new/xml/content_parser.dart';
import 'package:test/test.dart';
import 'package:xml/xml.dart';

void main() {
  group('ContentParser()', () {
    test('Parser works', () {
      const xml =
          '''<data><choice idref="sect275">If <ch.copy/>you wish to follow the left track, <link-text>turn to 275</link-text>.</choice></data>''';
      final document = XmlDocument.parse(xml);
      final data = document.getElement('data')!;
      final parser = ContentParser();
      final content = parser.toJson(data);
      //print(jsonEncode(content.toString()));

      expect(
          content,
          equals({
            "data": {
              "content": [
                {
                  "choice": {
                    "attrs": {"idref": "sect275"},
                    "content": [
                      "If ",
                      {"ch.copy": {}},
                      "you wish to follow the left track, ",
                      {
                        "link-text": {
                          "content": ["turn to 275"]
                        }
                      },
                      "."
                    ]
                  }
                }
              ]
            }
          }));
    });
  });
}
