import 'package:lonewolf_new/utils/xml/replace_typographic_tags.dart';
import 'package:test/test.dart';

void main() {
  group('Util - replaceTypographicTags()', () {
    void testChString(String chTag, String chReplacement) {
      test('Replaces "$chTag" with "$chReplacement"', () {
        expect(replaceTypographicTags('A test a $chTag tag.'), equals('A test a $chReplacement tag.'));
      });
    }

    chTags.forEach((chTag, chReplacement) {
      testChString(chTag, chReplacement);
    });
  });
}
