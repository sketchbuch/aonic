import '../../../types/types.dart';
import 'subcontent/text_element.dart';

abstract class Tag {
  final TextElements texts = [];

  Tag();

  Json toJson() => {};

  String tagType() => runtimeType.toString();

  @override
  String toString() {
    return toJson().toString();
  }
}
