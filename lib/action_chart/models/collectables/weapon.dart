import '../../../types/types.dart';

class Weapon {
  String name;

  Weapon(this.name);

  Json toJson() => {
        'name': name,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
