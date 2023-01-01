import '../../types/types.dart';
import 'collectables/backpack_item.dart';
import 'collectables/special_item.dart';
import 'collectables/weapon.dart';
import 'countables/countables.dart';

class ActionChart {
  final countables = Countables();
  final List<BackpackItem> backpackItems = [];
  final List<SpecialItem> specialItems = [];
  final List<Weapon> weapons = [];

  ActionChart();

  Json toJson() => {
        'backpackItems': backpackItems.map((backpackItem) => backpackItem.toJson()).toList(),
        'countables': countables.toJson(),
        'specialItems': specialItems.map((specialItem) => specialItem.toJson()).toList(),
        'weapons': weapons.map((weapon) => weapon.toJson()).toList(),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
