import '../../../types/types.dart';
import 'subcontent/text_element_model.dart';

abstract class TagModel {
  final TextElements texts = [];

  TagModel();

  Json toJson() => {};

  String tagType() => runtimeType.toString();

  @override
  String toString() {
    return toJson().toString();
  }
}
