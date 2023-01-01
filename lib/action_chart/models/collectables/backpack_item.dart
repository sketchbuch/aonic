import '../../../types/types.dart';

class BackpackItem {
  String description;
  String name;

  BackpackItem(this.name, this.description);

  Json toJson() => {
        'description': description,
        'name': name,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
