import '../../../types/types.dart';
import '../section/section.dart';

class BookIndexItem {
  late final BookText label;
  late final bool isSubItem;
  late final SectionType type;
  late final String id;

  BookIndexItem(this.label, this.id, this.type, this.isSubItem);

  BookIndexItem.fromSection(Section section, [bool isSubsection = false]) {
    id = section.id;
    isSubItem = isSubsection;
    label = section.meta.title;
    type = section.type;
  }

  Json toJson() => {
        'id': id,
        'isSubItem': isSubItem,
        'label': label,
        'type': type.name,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
