import '../../../../types/types.dart';

class NumberedSectionItemModel {
  final BookText title;
  final String id;

  NumberedSectionItemModel(this.title, this.id);

  Json toJson() => {
        'id': id,
        'title': title,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
