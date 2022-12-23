import 'package:lonewolf_new/models/book/content/combat_tag.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';

const combatXml =
    '<combat><enemy>Kraan</enemy><enemy-attribute class="combatskill">16</enemy-attribute><enemy-attribute class="endurance">24</enemy-attribute></combat>';
const combatJson = {
  "combatskill": 16,
  "endurance": 24,
  "enemy": "Kraan",
};

void main() {
  group('Model - CombatTag()', () {
    final tag = CombatTag.fromXml(getRootXmlElement(combatXml));

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(combatJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(combatJson.toString()));
    });

    test('Returns expected tagType', () {
      expect(tag.tagType(), equals('CombatTag'));
    });
  });
}
