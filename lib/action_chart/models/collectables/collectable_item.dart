import '../../../types/types.dart';
import 'collectable_element.dart';

class CollectableItem {
  final int maxElements;
  final List<CollectableElement> elements = [];
  final String key;

  CollectableItem(this.key, this.maxElements);

  Json toJson() => {
        'elements': elements.map((element) => element.toJson()).toList(),
        'key': key,
        'maxElements': maxElements,
      };

  @override
  String toString() {
    return toJson().toString();
  }

  void add(String key, String name, String description) {
    elements.add(CollectableElement(key, name, description));
  }

  void remove(String key) {
    elements.removeWhere((element) => element.key == key);
  }
}
