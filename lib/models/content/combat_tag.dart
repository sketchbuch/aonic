import 'package:xml/xml.dart';

import '../../types/types.dart';
import '../../utils/xml/helpers.dart';
import 'tag.dart';

const defaultAttrValue = 1;

class CombatTag extends Tag {
  late final int combatskill;
  late final int endurance;
  late final String enemy;

  CombatTag(this.enemy, this.combatskill, this.endurance);

  CombatTag.fromXml(XmlElement xml) {
    enemy = getValue('enemy', xml);

    final enemyAttributes = xml.findElements('enemy-attribute');

    combatskill = _getEnemyAttribute('combatskill', enemyAttributes);
    endurance = _getEnemyAttribute('endurance', enemyAttributes);
  }

  int _getEnemyAttribute(String attrName, Iterable<XmlElement> enemyAttributes) {
    if (enemyAttributes.isNotEmpty) {
      for (var enemyAttribute in enemyAttributes) {
        final attrs = enemyAttribute.attributes;

        if (attrs.isNotEmpty) {
          for (var attr in attrs) {
            if (attr.name.toString() == 'class' && attr.value == attrName) {
              return int.parse(enemyAttribute.text);
            }
          }
        }
      }
    }

    return defaultAttrValue;
  }

  @override
  Json toJson() => {
        'combatskill': combatskill,
        'endurance': endurance,
        'enemy': enemy,
      };
}