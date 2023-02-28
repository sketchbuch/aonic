import '../../../types/types.dart';

class CollectableElementModel {
  final String description;
  final String key;
  final String name;

  CollectableElementModel(this.key, this.name, this.description);

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
