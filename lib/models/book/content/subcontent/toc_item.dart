import '../../../../types/types.dart';
import '../section_tag.dart';

class TocItem {
  late final BookText title;
  late final int depth;
  late final String id;

  TocItem(SectionTag section, this.depth) {
    id = section.id;
    title = section.meta.title;
  }

  Json toJson() => {
        'depth': depth,
        'id': id,
        'title': title,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
