import 'package:xml/xml.dart';

import '../../../types/types.dart';
import '../../../utils/xml/helpers.dart';
import 'tag.dart';

const defaultAttrValue = 1;

class CombatTagModel extends TagModel {
  late final int combatskill;
  late final int endurance;
  late final BookText enemy;

  // ignore: unused_element
  CombatTagModel._();

  CombatTagModel.fromXml(XmlElement xml) {
    enemy = getValue('enemy', xml);

    final enemyAttributes = xml.findElements('enemy-attribute');

    combatskill = _getEnemyAttribute('combatskill', enemyAttributes);
    endurance = _getEnemyAttribute('endurance', enemyAttributes);
  }

  int _getEnemyAttribute(
      String attrName, Iterable<XmlElement> enemyAttributes) {
    if (enemyAttributes.isNotEmpty) {
      for (var enemyAttribute in enemyAttributes) {
        final attrs = getAttributes(enemyAttribute);

        if (attrs.isNotEmpty) {
          for (var key in attrs.keys) {
            if (key == 'class' && attrs[key] == attrName) {
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
