import '../../types/types.dart';

class BookItem {
  final int number;
  final String code;
  final String title;
  late final bool isSupported;
  late final String xmlPath;

  BookItem(this.title, this.code, this.number, String language, List<int> supportedBooks) {
    isSupported = supportedBooks.contains(number);
    xmlPath = 'https://www.projectaon.org/data/trunk/$language/xml/${code}.xml';
  }

  Json toJson() => {
        'code': code,
        'isSupported': isSupported,
        'number': number,
        'title': title,
        'xmlPath': xmlPath,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
