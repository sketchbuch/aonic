import '../content/section_tag_model.dart';

class SectionCache {
  Map<String, SectionTagModel> _cache = {};

  SectionCache();

  void deleteAll() {
    _cache = {};
  }

  void deleteOne(String key) {
    if (contains(key)) {
      _cache.remove(key);
    }
  }

  SectionTagModel? get(String key) {
    return _cache[key];
  }

  bool contains(String key) {
    return _cache.containsKey(key);
  }

  void set(String key, SectionTagModel section) {
    _cache[key] = section;
  }
}
