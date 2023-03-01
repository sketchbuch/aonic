import 'package:aonic/models/book/content/section_tag_model.dart';
import 'package:aonic/models/book/helpers/section_cache.dart';
import 'package:test/test.dart';

import '../../../helpers.dart';
import '../content/section_model_test.dart';

void main() {
  final tag = SectionTagModel.fromXml(getRootXmlElement(sectionXml));
  const cachKey1 = 'cache-key-1';
  const cachKey2 = 'cache-key-2';

  group('Model Helper - SectionCache()', () {
    test('Can set and get data as expected', () {
      final cache = SectionCache();

      expect(cache.contains(cachKey1), equals(false));
      expect(cache.get(cachKey1), equals(null));

      cache.set(cachKey1, tag);
      expect(cache.contains(cachKey1), equals(true));

      expect(cache.get(cachKey1), equals(tag));
    });

    test('Can remove all keys from the cache', () {
      final cache = SectionCache();

      expect(cache.contains(cachKey1), equals(false));
      expect(cache.contains(cachKey2), equals(false));

      cache.set(cachKey1, tag);
      cache.set(cachKey2, tag);

      expect(cache.contains(cachKey1), equals(true));
      expect(cache.contains(cachKey2), equals(true));

      cache.deleteAll();

      expect(cache.contains(cachKey1), equals(false));
      expect(cache.contains(cachKey2), equals(false));
    });

    test('Can remove a single key from the cache', () {
      final cache = SectionCache();

      expect(cache.contains(cachKey1), equals(false));
      expect(cache.contains(cachKey2), equals(false));

      cache.set(cachKey1, tag);
      cache.set(cachKey2, tag);

      expect(cache.contains(cachKey1), equals(true));
      expect(cache.contains(cachKey2), equals(true));

      cache.deleteOne(cachKey1);

      expect(cache.contains(cachKey1), equals(false));
      expect(cache.contains(cachKey2), equals(true));
    });
  });
}
