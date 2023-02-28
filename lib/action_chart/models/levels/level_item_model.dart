import '../../../types/types.dart';

class LevelItemModel {
  final String key;
  final int level;

  LevelItemModel(this.key, this.level);

  Json toJson() => {
        "key": key,
        "level": level,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
