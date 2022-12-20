import '../content/section_tag.dart';

class SectionCache {
  Map<String, SectionTag> _cache = {};

  SectionCache();

  void deleteAll() {
    _cache = {};
  }

  void deleteOne(String key) {
    if (contains(key)) {
      _cache.remove(key);
    }
  }

  SectionTag? get(String key) {
    return _cache[key];
  }

  bool contains(String key) {
    return _cache.containsKey(key);
  }

  void set(String key, SectionTag section) {
    _cache[key] = section;
  }
}
