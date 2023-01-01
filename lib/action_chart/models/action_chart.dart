import 'collectables/backpack_item.dart';
import 'collectables/special_item.dart';
import 'collectables/weapon.dart';
import 'countables/countables.dart';

class ActionChart {
  final List<Weapon> weapons = [];
  final List<SpecialItem> specialItems = [];
  final List<BackpackItem> backpackItems = [];
  final countables = Countables();

  ActionChart();
}
