import 'package:aonic/utils/i18n/split_translation.dart';
import 'package:test/test.dart';

void main() {
  group('Util - splitTranslation()', () {
    test('Returns an empty array if empty string', () {
      expect(splitTranslation(''), equals([]));
    });

    test('Returns an array with one element if no seperator', () {
      expect(splitTranslation('Lone'), equals(['Lone']));
    });

    test('Returns an array of correct length if there is a seperator', () {
      expect(splitTranslation('Lone|Wolf'), equals(['Lone', 'Wolf']));
    });
  });
}
