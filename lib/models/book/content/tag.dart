import '../../../types/types.dart';

abstract class Tag {
  Tag();

  Json toJson() => {};

  String tagType() => runtimeType.toString();

  @override
  String toString() {
    return toJson().toString();
  }
}
