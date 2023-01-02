import 'package:aonic/action_chart/models/collectables/collectable_element.dart';
import 'package:flutter_test/flutter_test.dart';

const collectableElementKey = 'weapons';
const collectableElementName = 'Sommerswerd';
const collectableElementDescription = '+2 CS';
final collectableElementJson = {
  'description': collectableElementDescription,
  'key': collectableElementKey,
  'name': collectableElementName,
};

void main() {
  group('Action Chart Model - CollectableElement()', () {
    late CollectableElement collectableElement;

    setUp(() {
      collectableElement = CollectableElement(
        collectableElementKey,
        collectableElementName,
        collectableElementDescription,
      );
    });

    test('Returns expected JSON', () {
      expect(collectableElement.toJson(), equals(collectableElementJson));
    });

    test('Returns expected string', () {
      expect(collectableElement.toString(), collectableElementJson.toString());
    });
  });
}
