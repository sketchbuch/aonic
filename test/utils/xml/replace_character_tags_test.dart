import 'package:lonewolf_new/utils/xml/replace_typographic_tags.dart';
import 'package:test/test.dart';

void main() {
  group('Util - replaceTypographicTags()', () {
    const Map<String, String> testChTags = {
      'aacute': 'á',
      'ampersand': '&',
      'apos': '’',
      'auml': 'ä',
      'blankline': '_______',
      'copy': '©',
      'eacute': 'é',
      'ellips': '…',
      'emdash': '—',
      'endash': '–',
      'lellips': '…',
      'minus': '−',
      'ouml': 'ö',
      'plus': '+',
      'uuml': 'ü',
    };

    void testChString(String chTag, String chReplacement) {
      test('Replaces "$chTag" with "$chReplacement"', () {
        expect(replaceTypographicTags('A test a <ch.$chTag/> tag.'), equals('A test a $chReplacement tag.'));
      });
    }

    testChTags.forEach((chTag, chReplacement) {
      testChString(chTag, chReplacement);
    });
  });
}
