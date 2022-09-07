import 'package:lonewolf_new/action_chart/special_item.dart';
import 'package:lonewolf_new/action_chart/weapon.dart';

class ActionChart {
  int _combatSkill;
  int _endurance;
  int _initialCombatSkill;
  int _initialEndurance;
  int _kaiRank;
  List<Weapon> _weapons;
  int _beltPouch;
  int _meals;
  List<SpecialItem> _specialItems;

  ActionChart(
    this._initialCombatSkill,
    this._initialEndurance,
    this._kaiRank,
    this._weapons,
    this._beltPouch,
    this._meals,
    this._specialItems,
  )   : _combatSkill = _initialCombatSkill,
        _endurance = _initialEndurance;
}
