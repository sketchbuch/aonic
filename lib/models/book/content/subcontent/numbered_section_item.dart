import '../../../../types/types.dart';
import '../section_tag.dart';
import 'text_element.dart';

class NumberedSectionItem {
  final List<TextElement> texts = [];
  final String block;

  NumberedSectionItem(List<SectionTag> blockSections, this.block) {
    texts.add(TextElement.fromTxt(block));

    for (var section in blockSections) {
      texts.add(
        TextElement.fromTxt(
          section.meta.title,
          type: DisplayType.link,
          attributes: {'idref': section.id},
        ),
      );
    }
  }

  Json toJson() => {
        'block': block,
        'texts': texts.map((text) => text.toJson()).toList(),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
