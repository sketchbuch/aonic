import 'package:aonic/models/book/content/subcontent/numbered_section_item_model.dart';
import 'package:test/test.dart';

const nsiId = "dedicate";
const nsiTitle = "Dedication";

final nsiJson = {
  'id': nsiId,
  'title': nsiTitle,
};

void main() {
  group('Model - NumberedSectionItemModel()', () {
    final numberedSectionItem = NumberedSectionItemModel(nsiTitle, nsiId);

    test('Returns expected JSON', () {
      expect(numberedSectionItem.toJson(), equals(nsiJson));
    });

    test('Returns expected string', () {
      expect(numberedSectionItem.toString(), equals(nsiJson.toString()));
    });
  });
}
