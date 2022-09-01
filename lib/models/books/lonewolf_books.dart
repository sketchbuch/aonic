import '../../i18n/_generated_/translations.g.dart';
import '../../types/types.dart';
import 'book_item.dart';

class LoneWolfBooks {
  late final List<BookItem> _books;
  final List<int> _supportedBooks = [1, 2];

  LoneWolfBooks(List<dynamic> bookTranslations, String language) {
    int bookNumber = 1;

    _books = [];

    for (var book in t.booksLonewolf.books) {
      _books.add(BookItem(book.title, book.code, bookNumber, language, _supportedBooks));
      bookNumber += 1;
    }
  }

  List<BookItem> getBooks() {
    return _books;
  }

  Json toJson() => {'books': _books.map((book) => book.toJson()).toList()};

  @override
  String toString() {
    return toJson().toString();
  }
}
