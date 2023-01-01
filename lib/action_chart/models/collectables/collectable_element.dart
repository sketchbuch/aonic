import '../../../types/types.dart';

class CollectableElement {
  final String description;
  final String key;
  final String name;

  CollectableElement(this.key, this.name, this.description);

  Json toJson() => {
        'description': description,
        'key': key,
        'name': name,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
