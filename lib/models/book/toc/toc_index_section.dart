import '../../../types/types.dart';
import '../content/section_tag.dart';

typedef TocIndexSections = List<TocIndexSection>;

class TocIndexSection {
  late final int depth;
  late final SectionTag section;

  TocIndexSection(this.section, this.depth);

  Json toJson() => {
        'depth': depth,
        'section': section.toJson(),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
