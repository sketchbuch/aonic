import 'package:lonewolf_new/models/book/content/combat_tag.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';

void main() {
  group('Model - CombatTag():', () {
    const xml =
        '<combat><enemy>Kraan</enemy><enemy-attribute class="combatskill">16</enemy-attribute><enemy-attribute class="endurance">24</enemy-attribute></combat>';
    final tag = CombatTag.fromXml(getRootXmlElement(xml));
    final expected = {
      "combatskill": 16,
      "endurance": 24,
      "enemy": "Kraan",
    };

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(expected));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(expected.toString()));
    });
  });
}
