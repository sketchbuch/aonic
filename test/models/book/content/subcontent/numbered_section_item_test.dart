import 'package:aonic/models/book/content/subcontent/numbered_section_item.dart';
import 'package:test/test.dart';

const nsiId = "dedicate";
const nsiTitle = "Dedication";

final nsiJson = {
  'id': nsiId,
  'title': nsiTitle,
};

void main() {
  group('Model - NumberedSectionItem()', () {
    final numberedSectionItem = NumberedSectionItem(nsiTitle, nsiId);

    test('Returns expected JSON', () {
      expect(numberedSectionItem.toJson(), equals(nsiJson));
    });

    test('Returns expected string', () {
      expect(numberedSectionItem.toString(), equals(nsiJson.toString()));
    });
  });
}
