import '../../types/types.dart';

class BooklistItemModel {
  final int number;
  final TranslatedText code;
  final TranslatedText title;
  final String language;
  final List<int> _supportedBooks;

  BooklistItemModel(
    this.title,
    this.code,
    this.number,
    this.language,
    this._supportedBooks,
  );

  String getXmlPath() =>
      'https://www.projectaon.org/data/trunk/$language/xml/$code.xml';
  bool isSupported() => _supportedBooks.contains(number);

  Json toJson() => {
        'code': code,
        'isSupported': isSupported(),
        'number': number,
        'title': title,
        'xmlPath': getXmlPath(),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
