import 'package:lonewolf_new/models/book/index/book_index_item.dart';
import 'package:lonewolf_new/models/book/section/section.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';

const biiId = 'tssf';
const biiIsSubItem = false;
const biiLabel = 'The Story So Far…';
const biiType = SectionType.frontmatter;

const biiSectionXml = '''<section class="frontmatter" id="$biiId">
  <meta>
    <title>$biiLabel</title>
  </meta>
  <data />
</section>''';
final biiSection = Section.fromXml(getRootXmlElement(biiSectionXml));

final biiJson = {
  'id': biiId,
  'isSubItem': false,
  'label': biiLabel,
  'type': biiType.name,
};

final biiSectionJson = {
  'id': biiId,
  'isSubItem': true,
  'label': biiLabel,
  'type': biiType.name,
};

void main() {
  group('Model - BookIndexItem()', () {
    final tag = BookIndexItem(biiLabel, biiId, biiType, biiIsSubItem);

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(biiJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(biiJson.toString()));
    });
  });

  group('Model - BookIndexItem.fromSection()', () {
    final tag = BookIndexItem.fromSection(biiSection, true);

    test('Returns expected JSON', () {
      expect(tag.toJson(), equals(biiSectionJson));
    });

    test('Returns expected string', () {
      expect(tag.toString(), equals(biiSectionJson.toString()));
    });
  });
}
