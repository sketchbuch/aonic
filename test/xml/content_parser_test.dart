import 'package:lonewolf_new/types/types.dart';
import 'package:lonewolf_new/xml/content_parser.dart';
import 'package:test/test.dart';
import 'package:xml/xml.dart';

void main() {
  Json getContent(String xml) {
    final document = XmlDocument.parse(xml);
    final data = document.getElement('data')!;
    final parser = ContentParser();
    return parser.toJson(data);
  }

  group('ContentParser()', () {
    test('Parser works with simple structure', () {
      const xml =
          '''<data><choice idref="sect275">If <ch.copy/>you wish to follow the left track, <link-text>turn to 275</link-text>.</choice></data>''';
      final content = getContent(xml);

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

    test('Parser works with a real structure', () {
      const xml =
          '''<data><p>The ghoulish creatures thrust their spears at you and attack. Fight these creatures as a single enemy.</p><combat><enemy>Giaks</enemy><enemy-attribute class="combatskill">15</enemy-attribute><enemy-attribute class="endurance">13</enemy-attribute></combat> <choice idref="sect148">If you win, you can run to the safety of the farmhouse by <link-text>turning to 148</link-text>.</choice><choice idref="sect320">Or you can return to the woods by <link-text>turning to 320</link-text>.</choice></data>''';
      final content = getContent(xml);

      expect(
          content,
          equals({
            "data": {
              "content": [
                {
                  "p": {
                    "content": [
                      "The ghoulish creatures thrust their spears at you and attack. Fight these creatures as a single enemy."
                    ]
                  }
                },
                {
                  "combat": {
                    "content": [
                      {
                        "enemy": {
                          "content": ["Giaks"]
                        }
                      },
                      {
                        "enemy-attribute": {
                          "attrs": {"class": "combatskill"},
                          "content": ["15"]
                        }
                      },
                      {
                        "enemy-attribute": {
                          "attrs": {"class": "endurance"},
                          "content": ["13"]
                        }
                      }
                    ]
                  }
                },
                " ",
                {
                  "choice": {
                    "attrs": {"idref": "sect148"},
                    "content": [
                      "If you win, you can run to the safety of the farmhouse by ",
                      {
                        "link-text": {
                          "content": ["turning to 148"]
                        }
                      },
                      "."
                    ]
                  }
                },
                {
                  "choice": {
                    "attrs": {"idref": "sect320"},
                    "content": [
                      "Or you can return to the woods by ",
                      {
                        "link-text": {
                          "content": ["turning to 320"]
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
