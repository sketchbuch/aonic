import '../../../types/types.dart';

class SpecialItem {
  String description;
  String name;

  SpecialItem(this.name, this.description);

  Json toJson() => {
        'description': description,
        'name': name,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
