import '../../../types/types.dart';
import 'collectable_element_model.dart';

class CollectableItemModel {
  final int maxElements;
  final List<CollectableElementModel> elements = [];
  final String key;

  CollectableItemModel(this.key, this.maxElements);

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
    elements.add(CollectableElementModel(key, name, description));
  }

  void remove(String key) {
    elements.removeWhere((element) => element.key == key);
  }
}
