import '../../../../types/types.dart';
import '../section_tag.dart';

typedef BookSectionItems = List<BookSectionItem>;

class BookSectionItem {
  late final int depth;
  late final SectionTag section;

  BookSectionItem(this.section, this.depth);

  Json toJson() => {
        'depth': depth,
        'section': section.toJson(),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
