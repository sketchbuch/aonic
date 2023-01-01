import '../../../types/types.dart';

class LevelItem {
  final String key;
  final int level;

  LevelItem(this.key, this.level);

  Json toJson() => {
        "key": key,
        "level": level,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
