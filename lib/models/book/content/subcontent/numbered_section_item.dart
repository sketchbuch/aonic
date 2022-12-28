import '../../../../types/types.dart';

class NumberedSectionItem {
  final BookText title;
  final String id;

  NumberedSectionItem(this.title, this.id);

  Json toJson() => {
        'id': id,
        'title': title,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
